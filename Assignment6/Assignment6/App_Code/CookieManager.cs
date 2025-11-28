using System;
using System.Web;

/// <summary>
/// Helper class for managing cookies
/// </summary>

namespace Assignment6
{
    public static class CookieManager
    {
        /// <summary>
        /// Create a user preference cookie
        /// </summary>
        public static void SetUserPreference(string username, string role, string extraSettings = null)
        {
            HttpCookie userCookie = new HttpCookie("UserPreference");
            userCookie["Username"] = username;
            userCookie["Role"] = role;
            userCookie["LastVisit"] = DateTime.Now.ToString();

            if (!string.IsNullOrEmpty(extraSettings)) userCookie["Settings"] = extraSettings;

            userCookie.Expires = DateTime.Now.AddDays(30);
            HttpContext.Current.Response.Cookies.Add(userCookie);
        }

        /// <summary>
        /// Read user preference from cookie
        /// </summary>
        public static string GetUserPreference(string key)
        {
            if (HttpContext.Current.Request.Cookies["UserPreference"] != null)
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies["UserPreference"];
                return cookie[key];
            }
            return null;
        }

        /// <summary>
        /// Create a visit tracking cookie
        /// </summary>
        public static void TrackVisit(string pageName)
        {
            HttpCookie visitCookie = new HttpCookie("VisitTracker");
            visitCookie["PageName"] = pageName;
            visitCookie["VisitTime"] = DateTime.Now.ToString();
            visitCookie["VisitCount"] = GetVisitCount().ToString();
            visitCookie.Expires = DateTime.Now.AddDays(7);
            HttpContext.Current.Response.Cookies.Add(visitCookie);
        }

        /// <summary>
        /// Get total visit count from cookie
        /// </summary>
        public static int GetVisitCount()
        {
            if (HttpContext.Current.Request.Cookies["VisitTracker"] != null)
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies["VisitTracker"];
                int count;
                if (int.TryParse(cookie["VisitCount"], out count)) return count + 1;
            }
            return 1;
        }

        /// <summary>
        /// Delete a cookie
        /// </summary>
        public static void DeleteCookie(string cookieName)
        {
            if (HttpContext.Current.Request.Cookies[cookieName] != null)
            {
                HttpCookie cookie = new HttpCookie(cookieName);
                cookie.Expires = DateTime.Now.AddDays(-1);
                HttpContext.Current.Response.Cookies.Add(cookie);
            }
        }
    }

}