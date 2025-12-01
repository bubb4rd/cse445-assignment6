using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web.UI;
namespace Assignment6
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)

        {
            if (!IsPostBack)
            {
                SetupNavbar();
                try
                {
                    CookieManager.TrackVisit("Default.aspx");
                }
                catch { }
            }
        }

        private void SetupNavbar()
        {
            if (User.Identity.IsAuthenticated)
            {
                // Authenticated: show profile + logout
                pnlAnonNav.Visible = false;
                pnlAuthNav.Visible = true;

                string username = Session["Username"] as string ?? User.Identity.Name;
                string role = Session["Role"] as string ?? "";

                lblNavUser.Text = "Hello, " + username;
                lblUserRole.Text = role;
                // Set Profile link based on role
                if (role.Equals("Staff", StringComparison.OrdinalIgnoreCase))
                    lnkProfile.NavigateUrl = "~/Staff.aspx";
                else
                    lnkProfile.NavigateUrl = "~/Member.aspx";  // default for Member/unknown
            }
            else
            {
                // Anonymous: show login/register, hide profile/logout
                pnlAnonNav.Visible = true;
                pnlAuthNav.Visible = false;
            }
        }

        protected void btnShowAppState_Click(object sender, EventArgs e)
        {
            if (Application["TotalVisitors"] == null)
            {
                lblAppState.Text = "<strong style='color:red;'>ERROR: Global.asax has not initialized Application state.</strong>";
                return;
            }

            int totalVisitors = (int)Application["TotalVisitors"];
            int currentUsers = (int)Application["CurrentUsers"];
            DateTime startTime = (DateTime)Application["ApplicationStartTime"];

            string output = "<strong>Application State (Global.asax):</strong><br/>" +
                           "Application Start Time: " + startTime.ToString() + "<br/>" +
                           "Total Visitors: " + totalVisitors.ToString() + "<br/>" +
                           "Current Active Users: " + currentUsers.ToString() + "<br/>" +
                           "Uptime: " + (DateTime.Now - startTime).ToString();

            lblAppState.Text = output;
        }

        protected void btnSetCookie_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string preference = txtPreference.Text.Trim();

            if (!string.IsNullOrEmpty(username) && !string.IsNullOrEmpty(preference))
            {
                CookieManager.SetUserPreference(username, preference);
                lblCookieOutput.Text = "Cookie created!<br/>Username: " + username +
                                      "<br/>Preference: " + preference;
                lblCookieOutput.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblCookieOutput.Text = "Please enter both username and preference.";
                lblCookieOutput.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnReadCookie_Click(object sender, EventArgs e)
        {
            string username = CookieManager.GetUserPreference("Username");
            string preference = CookieManager.GetUserPreference("Preference");
            string lastVisit = CookieManager.GetUserPreference("LastVisit");
            int visitCount = CookieManager.GetVisitCount();

            if (username != null)
            {
                lblCookieOutput.Text = "<strong>Cookie Data:</strong><br/>" +
                                      "Username: " + username + "<br/>" +
                                      "Preference: " + preference + "<br/>" +
                                      "Last Visit: " + lastVisit + "<br/>" +
                                      "Visit Count: " + visitCount.ToString();
                lblCookieOutput.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblCookieOutput.Text = "No cookie found. Please create one first.";
                lblCookieOutput.ForeColor = System.Drawing.Color.Orange;
            }
        }

        protected void btnDeleteCookie_Click(object sender, EventArgs e)
        {
            CookieManager.DeleteCookie("UserPreference");
            CookieManager.DeleteCookie("VisitTracker");
            lblCookieOutput.Text = "Cookies deleted successfully!";
            lblCookieOutput.ForeColor = System.Drawing.Color.Red;
        }

        protected void btnSessionDemo_Click(object sender, EventArgs e)
        {
            if (Session["SessionStartTime"] != null)
            {
                DateTime sessionStart = (DateTime)Session["SessionStartTime"];
                TimeSpan sessionDuration = DateTime.Now - sessionStart;

                lblSessionOutput.Text = "<strong>Session Information:</strong><br/>" +
                                       "Session ID: " + Session.SessionID + "<br/>" +
                                       "Started: " + sessionStart.ToString() + "<br/>" +
                                       "Duration: " + sessionDuration.Minutes.ToString() + " min " +
                                       sessionDuration.Seconds.ToString() + " sec<br/>" +
                                       "Timeout: " + Session.Timeout.ToString() + " minutes";
            }
            else
            {
                lblSessionOutput.Text = "Session not available.";
            }
        }

        protected void btnComputeHash_Click(object sender, EventArgs e)
        {
            String str = txtHashInput.Text;
            if (!string.IsNullOrEmpty(str))
            {
                string hash = HashCalculator.ComputeHash(str);
                lblHashOutput.Text = hash;
                lblHashOutput.ForeColor = System.Drawing.Color.Blue;
            }
            else
            {
                lblHashOutput.Text = "Please enter a string to hash.";
                lblHashOutput.ForeColor = System.Drawing.Color.Red;
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

        protected void btnTestWordFilter_Click(object sender, EventArgs e)
        {
            string inputText = txtInputString.Text;
            string filteredText = WordFilter(inputText);
            lblWordFilterResult.Text = filteredText;
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
        private string WordFilter(string str)
        {
            //remove XML tags
            str = Regex.Replace(str, "<.*?>", string.Empty);
            //remove punctuation and spaces
            str = Regex.Replace(str, "[^a-zA-Z0-9' ]+", " ").ToLower();
            str = Regex.Replace(str, @"\s+", " ").Trim();

            //add stop words to filter list
            string[] stopWords = { "a", "an", "and", "in", "on", "that", "the", "this", "is", "are", "am", "but", "or", "with", "to", "was", "not", "at", "did", "where", "when", "why", "there", "so", "them", "go" };

            //filter out stop words
            List<string> words = str.Split(' ').ToList();
            words = words.Where(word => !stopWords.Contains(word.ToLower())).ToList();

            //only remove meaningless words if there are more than 30 words
            if (words.Count > 30)
            {
                //count word occurrences
                Dictionary<string, int> wordCounts = new Dictionary<string, int>();
                wordCounts = words.GroupBy(w => w.ToLower())
                                        .ToDictionary(g => g.Key, g => g.Count());

                //remove meaningless words
                int meaninglessThreshold = 1;
                words = wordCounts.Where(kv => kv.Value > meaninglessThreshold)
                                .Select(kv => kv.Key)
                                .ToList();
            }
            //join words back into a string
            str = string.Join(" ", words);

            return str;
        }
    }

}