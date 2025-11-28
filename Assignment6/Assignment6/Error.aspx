<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="Assignment6.Error" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Error - Assignment 6</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f5f5f5; }
        .container { max-width: 600px; margin: 0 auto; padding: 25px; background: white; border-radius: 6px; border: 1px solid #ccc; }
        h1 { color: #c0392b; }
        pre { background-color: #fafafa; padding: 10px; border-radius: 4px; border: 1px solid #eee; white-space: pre-wrap; word-wrap: break-word; }
        a { color: #2980b9; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container">
        <h1>Oops, something went wrong.</h1>
        <p>
            An unexpected error occurred while processing your request.
        </p>

        <asp:Panel ID="pnlDetails" runat="server" Visible="false">
            <h3>Error Details (for debugging only):</h3>
            <pre><asp:Literal ID="litErrorDetails" runat="server" /></pre>
        </asp:Panel>

        <p>
            <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Default.aspx">
                Return to Home Page
            </asp:HyperLink>
        </p>
    </div>
    </form>
</body>
</html>
