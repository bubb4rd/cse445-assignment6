<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Assignment6.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Member Registration - Assignment 6</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { width: 500px; margin: 0 auto; padding: 20px; border: 1px solid #ccc; border-radius: 6px; background-color: #f9f9f9; }
        h1 { text-align: center; color: #333; }
        .row { margin-bottom: 10px; }
        label { display: inline-block; width: 150px; }
        input[type="text"], input[type="password"], input[type="email"] { width: 250px; }
        .captcha-box { font-weight: bold; font-size: 18px; letter-spacing: 3px; padding: 5px 10px; background-color: #eee; display: inline-block; }
        .buttons { margin-top: 15px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Member Registration</h1>

            <div class="row">
                <label for="txtUsername">Username:</label>
                <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
            </div>

            <div class="row">
                <label for="txtPassword">Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
            </div>

            <div class="row">
                <label for="txtConfirmPassword">Confirm Password:</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
            </div>

            <div class="row">
                <label for="txtEmail">Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>
            </div>

            <hr />

            <div class="row">
                <label>Verification Code:</label>
                <asp:Label ID="lblCaptcha" runat="server" CssClass="captcha-box"></asp:Label>
                <asp:Button ID="btnRefreshCaptcha" runat="server" Text="Refresh" OnClick="btnRefreshCaptcha_Click" />
            </div>

            <div class="row">
                <label for="txtCaptcha">Enter Code:</label>
                <asp:TextBox ID="txtCaptcha" runat="server"></asp:TextBox>
            </div>

            <div class="buttons">
                <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" />
                <asp:Button ID="btnBackToLogin" runat="server" Text="Back to Login" PostBackUrl="~/Login.aspx" />
            </div>

            <div class="row" style="margin-top:15px;">
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
