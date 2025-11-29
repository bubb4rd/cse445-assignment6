using System;
using System.Linq;
using System.Web.UI;
using System.Xml.Linq;

namespace Assignment6
{
    public partial class Member : System.Web.UI.Page
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
                lblWelcomeMember.Text = "Welcome, " + username;

                string xmlPath = Server.MapPath("~/App_Data/Member.xml");
                XDocument doc = XDocument.Load(xmlPath);

                var userElement = doc.Root
                    .Elements("User")
                    .FirstOrDefault(u => (string)u.Element("Username") == username);

                string email = userElement != null
                    ? (string)userElement.Element("Email")
                    : null;

                // Read cookie values
                string cookieUser = CookieManager.GetUserPreference("Username");
                string cookieRole = CookieManager.GetUserPreference("Role");
                string lastLogin  = CookieManager.GetUserPreference("LastLogin");
                string settings   = CookieManager.GetUserPreference("Settings");

                lblUsername.Text = username;
                lblRole.Text = role;
                lblEmail.Text = email;
                // if (Application["TotalVisitors"] != null &&
                //     Application["CurrentUsers"] != null &&
                //     Application["ApplicationStartTime"] != null)
                // {
                //     int totalVisitors = (int)Application["TotalVisitors"];
                //     int currentUsers = (int)Application["CurrentUsers"];
                //     DateTime startTime = (DateTime)Application["ApplicationStartTime"];

                //     lblMemberAppState.Text =
                //         "Total Visitors: " + totalVisitors +
                //         "<br/>Current Users: " + currentUsers +
                //         "<br/>Application Start: " + startTime;
                // }
            }
        }
        // WEB SERVICE TESTING METHODS
        protected void btnTestServerTime_Click(object sender, EventArgs e)
        {
            // Call the web method directly (service is in same project)
            string time = GetServerTimeLocal();
            lblServerTime.Text = "<strong>Server Time:</strong> " + time;
            lblServerTime.ForeColor = System.Drawing.Color.Blue;
        }

        protected void btnTestUsername_Click(object sender, EventArgs e)
        {
            string username = txtTestUsername.Text.Trim();
            bool isValid = ValidateUsernameLocal(username);

            lblUsernameResult.Text = "<strong>Validation Result:</strong> " +
                                    (isValid ? "Valid username (3+ characters)" : "Invalid - must be 3+ characters");
            lblUsernameResult.ForeColor = isValid ? System.Drawing.Color.Green : System.Drawing.Color.Red;
        }

        protected void btnTestBMI_Click(object sender, EventArgs e)
        {
            double height, weight;

            if (double.TryParse(txtHeight.Text, out height) && double.TryParse(txtWeight.Text, out weight))
            {
                double bmi = CalculateBMILocal(height, weight);
                lblBMIResult.Text = "<strong>BMI Result:</strong> " + bmi.ToString("F2");
                lblBMIResult.ForeColor = System.Drawing.Color.Blue;
            }
            else
            {
                lblBMIResult.Text = "Please enter valid numbers for height and weight.";
                lblBMIResult.ForeColor = System.Drawing.Color.Red;
            }
        }

        // Helper methods that replicate service logic
        private string GetServerTimeLocal()
        {
            return DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        }

        private bool ValidateUsernameLocal(string username)
        {
            if (string.IsNullOrEmpty(username))
                return false;
            return username.Length >= 3;
        }

        private double CalculateBMILocal(double heightInches, double weightLbs)
        {
            if (heightInches <= 0 || weightLbs <= 0)
                return 0;

            return (weightLbs * 703) / (heightInches * heightInches);
        }
    }   
}