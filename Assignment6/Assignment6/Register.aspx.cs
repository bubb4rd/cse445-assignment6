using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Linq;
using System.IO;

namespace Assignment6
{
    public partial class Register : System.Web.UI.Page
    {
        private const int CaptchaLength = 5;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (User.Identity.IsAuthenticated)
                {
                    string role = Session["Role"] as string;

                    if (String.Equals(role, "Staff", StringComparison.OrdinalIgnoreCase))
                    {
                        Response.Redirect("~/Staff.aspx");
                        return;
                    }
                    else if (String.Equals(role, "Member", StringComparison.OrdinalIgnoreCase))
                    {
                        Response.Redirect("~/Member.aspx");
                        return;
                    }

                    // Fallback if Session lost but auth cookie exists:
                    // send them to a default page
                    Response.Redirect("~/Default.aspx");
                    return;
                }
                else GenerateCaptcha();
            }
        }

        protected void btnRefreshCaptcha_Click(object sender, EventArgs e)
        {
            GenerateCaptcha();
            lblMessage.Text = "";
        }

        // Dummy CAPTCHA logic
        private void GenerateCaptcha()
        {
            string chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
            Random rand = new Random();
            char[] code = new char[CaptchaLength];

            for (int i = 0; i < CaptchaLength; i++)
            {
                code[i] = chars[rand.Next(chars.Length)];
            }

            string captcha = new string(code);
            Session["Captcha"] = captcha;
            lblCaptcha.Text = captcha;
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            lblMessage.ForeColor = System.Drawing.Color.Red;

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();
            string email = txtEmail.Text.Trim();
            string captchaInput = txtCaptcha.Text.Trim();

            // 1. Basic validation
            if (string.IsNullOrEmpty(username) ||
                string.IsNullOrEmpty(password) ||
                string.IsNullOrEmpty(confirmPassword) ||
                string.IsNullOrEmpty(email))
            {
                lblMessage.Text = "All fields are required.";
                return;
            }

            if (!password.Equals(confirmPassword))
            {
                lblMessage.Text = "Passwords do not match.";
                return;
            }

            // 2. Captcha validation
            if (Session["Captcha"] == null ||
                !captchaInput.Equals(Session["Captcha"].ToString(), StringComparison.OrdinalIgnoreCase))
            {
                lblMessage.Text = "Verification code is incorrect.";
                GenerateCaptcha();
                return;
            }

            try
            {
                // 3. Load or create Member.xml
                string xmlPath = Server.MapPath("~/App_Data/Member.xml");
                XDocument doc;

                if (File.Exists(xmlPath))
                    doc = XDocument.Load(xmlPath);
                else
                    doc = new XDocument(new XElement("Users"));

                // 4. Check for existing username in Member list
                bool userExists = doc.Root
                    .Elements("User")
                    .Any(u => (string)u.Element("Username") == username);

                if (userExists)
                {
                    lblMessage.Text = "Username already exists. Please choose another.";
                    return;
                }

                // TODO; implement password hashing
                // 5. Hash password (stub or real DLL)
                // string hashedPassword = SecurityHelper.HashPassword(password); // or a placeholder for now
                string hashedPassword = password; // Placeholder: store plain text (NOT recommended in real apps)
                // 6. Append new member user
                XElement newUser = new XElement("User",
                    new XElement("Username", username),
                    new XElement("Password", hashedPassword),
                    new XElement("Role", "Member"),
                    new XElement("Email", email),
                    new XElement("DateCreated", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"))
                );

                doc.Root.Add(newUser);
                doc.Save(xmlPath);

                // 7. Success
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Registration successful. You can now log in.";

                txtUsername.Text = "";
                txtPassword.Text = "";
                txtConfirmPassword.Text = "";
                txtEmail.Text = "";
                txtCaptcha.Text = "";
                GenerateCaptcha();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error during registration: " + ex.Message;
            }
        }
    }
}