using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment6
{
    public partial class Staff : System.Web.UI.Page
    {
       protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            string role = Session["Role"] as string;
            if (!String.Equals(role, "Staff", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string username = Session["Username"] as string ?? User.Identity.Name;
                lblWelcomeMember.Text = "Welcome, " + username;

                string xmlPath = Server.MapPath("~/App_Data/Staff.xml");
                XDocument doc = XDocument.Load(xmlPath);

                var userElement = doc.Root
                    .Elements("User")
                    .FirstOrDefault(u => (string)u.Element("Username") == username);

                string email = userElement != null
                    ? (string)userElement.Element("Email")
                    : null;

                lblUsername.Text = username;
                lblRole.Text = role;
                lblEmail.Text = email;

                LoadMemberList();
                ShowAppState();
                ShowCookieInfo();
            }
        }

        private void LoadMemberList()
        {
            try
            {
                string xmlPath = Server.MapPath("~/App_Data/Member.xml");
                XDocument doc = XDocument.Load(xmlPath);

                var members = doc.Root.Elements("User")
                    .Select(u => new
                    {
                        Username = (string)u.Element("Username"),
                        Email = (string)u.Element("Email"),
                        Role = (string)u.Element("Role"),
                    })
                    .ToList();

                gvMembers.DataSource = members;
                gvMembers.DataBind();
            }
            catch (Exception ex)
            {
                lblStaffAppState.Text = "Error loading members: " + ex.Message;
            }
        }

        private void ShowAppState()
        {
            if (Application["TotalVisitors"] != null &&
                Application["CurrentUsers"] != null &&
                Application["ApplicationStartTime"] != null)
            {
                int total = (int)Application["TotalVisitors"];
                int current = (int)Application["CurrentUsers"];
                DateTime start = (DateTime)Application["ApplicationStartTime"];

                lblStaffAppState.Text =
                    "Total Visitors: " + total +
                    "<br/>Current Users: " + current +
                    "<br/>Application Start: " + start;
            }
            else
            {
                lblStaffAppState.Text = "Application state not initialized.";
            }
        }

        private void ShowCookieInfo()
        {
            string cookieUser = CookieManager.GetUserPreference("Username");
            string cookieRole = CookieManager.GetUserPreference("Role");
            string lastLogin  = CookieManager.GetUserPreference("LastLogin");
            string settings   = CookieManager.GetUserPreference("Settings");

            lblStaffCookieInfo.Text =
                "Cookie Username: " + (cookieUser ?? "(none)") + "<br/>" +
                "Cookie Role: " + (cookieRole ?? "(none)") + "<br/>" +
                "Last Login: " + (lastLogin ?? "(unknown)") + "<br/>" +
                "Settings: " + (settings ?? "(none)");
        }
    }
}
