using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Linq;

namespace Assignment6
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // If already authenticated, redirect based on role
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
            }
        }

        // helper function
        private bool ValidateUser(string username, string password, string selectedRole, out string role)
        {
            role = null;

            try
            {
                string incomingHash = HashCalculator.ComputeHash(password);

                if (selectedRole == "Staff")
                {
                    string staffPath = Server.MapPath("~/App_Data/Staff.xml");
                    XDocument staffDoc = XDocument.Load(staffPath);

                    var user = staffDoc.Root
                        .Elements("User")
                        .FirstOrDefault(u => (string)u.Element("Username") == username);

                    if (user != null)
                    {
                        string storedHash = (string)user.Element("Password");
                        if (incomingHash == storedHash)
                        {
                            role = "Staff";
                            return true;
                        }
                    }
                }
                else if (selectedRole == "Member")
                {
                    string memberPath = Server.MapPath("~/App_Data/Member.xml");
                    XDocument memberDoc = XDocument.Load(memberPath);

                    var user = memberDoc.Root
                        .Elements("User")
                        .FirstOrDefault(u => (string)u.Element("Username") == username);

                    if (user != null)
                    {
                        // For debugging:
                        // lblMessage.Text = username + " found!";

                        string storedHash = (string)user.Element("Password");
                        if (incomingHash == storedHash)
                        {
                            role = "Member";
                            return true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Login error: " + ex.Message;
            }

            return false;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            string username = txtUsername.Text.Trim().ToLower();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter username and password.";
                return;
            }

            string selectedRole;
            if (memberRadio.Checked)
                selectedRole = "Member";
            else if (staffRadio.Checked)
                selectedRole = "Staff";
            else
                selectedRole = "Member"; // fallback

            string role;
            if (!ValidateUser(username, password, selectedRole, out role))
            {
                lblMessage.Text = "Invalid username/password for selected role.";
                return;
            }

            // At this point: user exists and role is "Member" or "Staff"
            FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
                1,                      // version
                username,               // name
                DateTime.Now,           // issueDate
                DateTime.Now.AddMinutes(30), // expiration
                false,                  // isPersistent; or chkRemember.Checked
                role,                   // userData (store role here)
                FormsAuthentication.FormsCookiePath
            );

            string encTicket = FormsAuthentication.Encrypt(ticket);
            HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encTicket);
            Response.Cookies.Add(authCookie);

            // Set Session too (optional but helpful)
            Session["Username"] = username;
            Session["Role"] = role;

            try
            {
                string extra = "PreferredHomePage=" + role;
                CookieManager.SetUserPreference(username, role, extra);
            }
            catch
            {
                // ignore cookie errors
            }

            if (role == "Staff")
                Response.Redirect("~/Staff.aspx");
            else
                Response.Redirect("~/Member.aspx");
        }

    }
}