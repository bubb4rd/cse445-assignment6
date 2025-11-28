using System;
using System.Collections.Generic;
using System.Linq;
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
                lblWelcomeStaff.Text = "Welcome, " + username + " (Staff)";

                if (Application["TotalVisitors"] != null &&
                    Application["CurrentUsers"] != null &&
                    Application["ApplicationStartTime"] != null)
                {
                    int totalVisitors = (int)Application["TotalVisitors"];
                    int currentUsers = (int)Application["CurrentUsers"];
                    DateTime startTime = (DateTime)Application["ApplicationStartTime"];

                    lblStaffAppState.Text =
                        "Total Visitors: " + totalVisitors +
                        "<br/>Current Users: " + currentUsers +
                        "<br/>Application Start: " + startTime;
                }
            }
        }

    }
}