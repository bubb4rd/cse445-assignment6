using System;
using System.Web;
using System.Web.Security;
using System.Web.UI;

namespace Assignment6
{
    public partial class Logout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Sign out of Forms Authentication
            FormsAuthentication.SignOut();

            // Clear session
            Session.Clear();
            Session.Abandon();

            // Clear your user cookie
            CookieManager.DeleteCookie("UserPreference");
            CookieManager.DeleteCookie("VisitTracker"); // if you use this

            // Optionally clear the auth cookie explicitly
            if (Request.Cookies[FormsAuthentication.FormsCookieName] != null)
            {
                HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, "");
                authCookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(authCookie);
            }

            // Redirect to Login or Default
            Response.Redirect("~/Login.aspx");
        }
    }
}
