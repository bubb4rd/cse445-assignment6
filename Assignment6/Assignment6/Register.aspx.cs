using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
        }
    }
}