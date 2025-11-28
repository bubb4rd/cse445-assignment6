<%@ Application Language="C#" %>

<script runat="server">
    void Application_Start(object sender, EventArgs e)
    {
        // Track app stats
        Application["TotalVisitors"] = 0;
        Application["CurrentUsers"] = 0;
        Application["ApplicationStartTime"] = DateTime.Now;
    }

    void Session_Start(object sender, EventArgs e)
    {
        // Visitor Counter
        Application.Lock();
        Application["TotalVisitors"] = (int)Application["TotalVisitors"] + 1;
        Application["CurrentUsers"] = (int)Application["CurrentUsers"] + 1;
        Application.UnLock();
        
        // Session timeout (20 mins)
        Session.Timeout = 20;
        Session["SessionStartTime"] = DateTime.Now;
    }

    void Session_End(object sender, EventArgs e)
    {
        // Session over = Remove a viewer
        Application.Lock();
        Application["CurrentUsers"] = (int)Application["CurrentUsers"] - 1;
        Application.UnLock();
    }

    void Application_Error(object sender, EventArgs e)
    {
        // Log errors to application state
        Exception ex = Server.GetLastError();
        Application["LastError"] = ex.Message + " - " + DateTime.Now.ToString();
    }

    void Application_End(object sender, EventArgs e)
    {
        // Cleanup code when application ends
    }
</script>
