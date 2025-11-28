<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Assignment6.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
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
            <h1>Log in</h1>
            
            <div class="row justify-around">
                <div class="col">
                    <label for="txtUsername">Username</label>
                    <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                </div>
                <div class="col">
                    <label for="txtPassword">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
                </div>
            </div>

            <div class="buttons">
                <asp:Button CssClass="btn cta" ID="btnLogin" runat="server" Text="Log in" OnClick="btnLogin_Click" />
                <asp:Button CssClass="btn return" ID="btnRegister" runat="server" Text="Register" PostBackUrl="~/Register.aspx" />
            </div>
        </div>
    </form>
</body>
</html>
