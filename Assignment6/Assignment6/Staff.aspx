<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Staff.aspx.cs" Inherits="Assignment6.Staff" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Staff Page</h2>
            <p>
                <asp:Label ID="lblWelcomeStaff" runat="server" ForeColor="Green" />
            </p>

            <h3>Application State</h3>
            <asp:Label ID="lblStaffAppState" runat="server" />

        </div>
    </form>
</body>
</html>
