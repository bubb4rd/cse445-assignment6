using System;
using System.Collections.Generic;
using System.Web;
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
            
        }

        // helper function
        private bool ValidateUser(string username, string password, string selectedRole, out string role)
        {
            role = null;

            try
            {
                if (selectedRole == "Staff")
                {
                    // Check Staff.xml
                    string staffPath = Server.MapPath("~/App_Data/Staff.xml");
                    XDocument staffDoc = XDocument.Load(staffPath);

                    var user = staffDoc.Root
                        .Elements("User")
                        .FirstOrDefault(u => (string)u.Element("Username") == username);

                    if (user != null)
                    {
                        // TODO: link hashing implementation
                        // string storedHash = (string)user.Element("Password");
                        // if (SecurityHelper.VerifyPassword(password, storedHash))
                        // {
                        //     role = "Staff";
                        //     return true;
                        // }
                    }
                }
                else if (selectedRole == "Member")
                {
                    // Check Member.xml
                    string memberPath = Server.MapPath("~/App_Data/Member.xml");
                    XDocument memberDoc = XDocument.Load(memberPath);

                    var user = memberDoc.Root
                        .Elements("User")
                        .FirstOrDefault(u => (string)u.Element("Username") == username);

                    if (user != null)
                    {
                        // TODO: link hashing implementation
                        // string storedHash = (string)user.Element("Password");
                        // if (SecurityHelper.VerifyPassword(password, storedHash))
                        // {
                        //     role = "Member";
                        //     return true;
                        // }
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
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter username and password.";
                return;
            }
            
            string selectedRole;

            if (memberRadio.Checked) selectedRole = "Member";
            else if (staffRadio.Checked) selectedRole = "Staff";
            else selectedRole = "Member"; // fallback, should not happen with GroupName + default
        }
    }
}