using System;
using System.Web;
using System.Web.UI;

namespace Assignment6
{
    public partial class Error : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Option 1: show last error from Application (if you store it in Global.asax)
                object lastError = Application["LastError"];

                // Option 2: also support error passed via querystring or context
                Exception ex = Server.GetLastError();

                string message = "";

                if (lastError != null)
                {
                    message += "Application[\"LastError\"]: " + lastError.ToString() + Environment.NewLine;
                }

                if (ex != null)
                {
                    message += "Server.GetLastError(): " + ex.Message + Environment.NewLine;
                    if (ex.StackTrace != null)
                        message += ex.StackTrace;
                }

                if (!String.IsNullOrWhiteSpace(message))
                {
                    pnlDetails.Visible = true;
                    litErrorDetails.Text = HttpUtility.HtmlEncode(message);
                }
                else
                {
                    pnlDetails.Visible = false;
                }
            }
        }
    }
}
