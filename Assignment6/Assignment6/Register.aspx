<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Assignment6.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { width: 500px; 
                     margin: 0 auto; 
                     padding: 20px; 
                     border: 1px solid #ccc; 
                     border-radius: 6px; 
                     background-color: #f9f9f9; }
        h1 { text-align: center; color: #333; }
        .row { display: flex; flex-direction: row; margin-bottom: 10px; }
        .justify-around { justify-content: space-around; }
        .align-center { align-items: center; }
        .flex-col { display: flex; flex-direction: column; gap: 8px; }
        .text-center { text-align: center; }
        .col { display: block; margin: 8px 0; width: min-content; }
        .mt-md { margin-top: 12px; }
        .gap-lg { gap: 32px; }
        label { display: inline-block; width: 150px; margin-bottom: 4px; }
        input[type="text"], 
        input[type="password"], 
        input[type="email"] { height: 25px; 
                              width: 200px; 
                              border-radius: 5px;
                              border-color: #00000025;
                              background-color: #00000005;
        }
        .captcha-box { font-weight: bold; 
                       font-size: 18px; 
                       letter-spacing: 3px; 
                       padding: 5px 10px; 
                       background-color: #eee; display: inline-block; }
        .buttons { margin-top: 15px;
                   display: flex;
                   flex-direction: column;
                   gap: 16px;
                   align-items: center;
        }
        .btn {
            width: 150px;
        }
        .return { cursor: pointer; 
                      outline: 0; 
                      color: #000; 
                      border: none; 
                      background-color: transparent; }
        .cta { 
                    cursor: pointer;
                    outline: 0;
                    color: #fff;
                    background-color: #0d6efd;
                    border-color: #0d6efd;
                    display: inline-block;
                    font-weight: 400;
                    line-height: 1.5;
                    text-align: center;
                    border: 1px solid transparent;
                    padding: 6px 12px;
                    font-size: 16px;
                    border-radius: .25rem;
                    transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
                    :hover {
                        color: #fff;
                        background-color: #0b5ed7;
                        border-color: #0a58ca;
                    }
                }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Sign up</h1>

            <div class="row justify-around gap-lg">
                <div class="col">
                    <div class="col">
                        <label for="txtUsername">Username</label>
                        <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                    </div>

                    <div class="col">
                        <label for="txtPassword">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                    </div>
                </div>

                <div class="col">
                    <div class="col">
                        <label for="txtEmail">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>
                    </div>

                    <div class="col">
                        <label for="txtConfirmPassword">Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                    </div>
                </div>
            </div>

            <hr />

            <div class=" mt-md row justify-around">
                <div class="flex-col align-center">
                    <label class="text-center">Verification Code</label>
                    <asp:Label ID="lblCaptcha" runat="server" CssClass="captcha-box"></asp:Label>
                    <asp:Button ID="btnRefreshCaptcha" runat="server" Text="Refresh" OnClick="btnRefreshCaptcha_Click" />
                </div>

                <div class="col">
                    <label for="txtCaptcha">Enter Code</label>
                    <asp:TextBox ID="txtCaptcha" runat="server"></asp:TextBox>
                </div>
            </div>

            <div class="buttons">
                <asp:Button CssClass="btn cta" ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" />
                <asp:Button CssClass="btn return" ID="btnBackToLogin" runat="server" Text="Back to Login" PostBackUrl="~/Login.aspx" />
            </div>

            <div class="row" style="margin-top:15px;">
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
