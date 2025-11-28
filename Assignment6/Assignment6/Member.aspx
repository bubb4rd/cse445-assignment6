<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Member.aspx.cs" Inherits="Assignment6.Member" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Member Page</h2>

        <p>
            <asp:Label ID="lblWelcomeMember" runat="server" ForeColor="Green" />
        </p>

        <h3>Application State</h3>
        <asp:Label ID="lblMemberAppState" runat="server" />
    </form>
</body>
</html>
