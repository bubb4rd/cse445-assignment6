using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Assignment6
{
    public class Member : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            string role = Session["Role"] as string;
            if (!String.Equals(role, "Member", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string username = Session["Username"] as string ?? User.Identity.Name;
                lblWelcomeMember.Text = "Welcome, " + username + " (Member)";

                if (Application["TotalVisitors"] != null &&
                    Application["CurrentUsers"] != null &&
                    Application["ApplicationStartTime"] != null)
                {
                    int totalVisitors = (int)Application["TotalVisitors"];
                    int currentUsers = (int)Application["CurrentUsers"];
                    DateTime startTime = (DateTime)Application["ApplicationStartTime"];

                    lblMemberAppState.Text =
                        "Total Visitors: " + totalVisitors +
                        "<br/>Current Users: " + currentUsers +
                        "<br/>Application Start: " + startTime;
                }
            }
        }

    }
}