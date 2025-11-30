<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Member.aspx.cs" Inherits="Assignment6.Member" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        body { margin: 20px;}
        .welcome-header { font-size: 24px; font-weight: 700;}
        .container { width: min-content;
                     height: min-content;
                     padding: 20px; 
                     border: 1px solid #ccc; 
                     border-radius: 6px; 
                     background-color: #f9f9f9; }
        h1 { text-align: center; color: #333; }
        .row { display: flex; flex-direction: row; margin-bottom: 10px; }
        .justify-around { justify-content: space-around; }
        .justify-center { justify-content: center; }
        .align-center { align-items: center; }
        .flex-col { display: flex; flex-direction: column; gap: 8px; }
        .text-center { text-align: center; }
        .col { display: block; margin: 8px 0; width: min-content; }
        .mt-md { margin-top: 12px; }
        .gap-lg { gap: 32px; }
        .item-label { color: #00000050; text-transform: uppercase;}
        .item-sublabel { color: #000000; font-weight: 600; }
        .btn {
            width: 150px;
        }
        .return { cursor: pointer; 
                      outline: 0; 
                      color: #000; 
                      border: none; 
                      background-color: transparent; }
        .cta-red { 
                    cursor: pointer;
                    outline: 0;
                    color: #fff;
                    background-color: #fd0d0d;
                    border-color: #be0b0b;
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
        .cta-blue { 
                    cursor: pointer;
                    outline: 0;
                    color: #fff;
                    background-color: #0d39fd;
                    border-color: #0b35be;
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
            .navbar {
                    padding: 10px 20px;
                    color: #000;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
            }
            .navbar a { text-decoration: none; margin-left: 10px; }
            .nav-left a { font-weight: bold; }
    </style>
    <title>Profile</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <div class="nav-left">
                <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Default.aspx" Text="Home" />
            </div>
        </div>
        </hr>
        <asp:Label ID="lblWelcomeMember" runat="server" class="welcome-header"/>
        <div class="row justify-center align-center" style="margin-top: 12px; flex-direction: row-reverse; gap: 42px;">
            <div class="container">
            <h3>Profile Settings</h3>
            <div class="flex-col">
                <div class="col">
                    <span class="item-label">Username</span>
                    <asp:Label ID="lblUsername" runat="server" class="item-sublabel"/>
                </div>
                <div class="col">
                    <span class="item-label">Role</span>
                    <asp:Label ID="lblRole" runat="server" class="item-sublabel"/>
                </div>
                <div class="col">
                    <span class="item-label">Email</span>
                    <asp:Label ID="lblEmail" runat="server" class="item-sublabel"/>
                </div>
                <asp:Button ID="btnLogOut" runat="server" Text="Log out" CssClass="btn cta-red" PostBackUrl="~/Logout.aspx"/>
            </div>
        </div>
        <!-- Web Service TryIt -->
            <div class="section">
                <h2 style="text-align: center;">Member Services</h2>
                <div class="flex-col" style="gap: 12px;">
                    
                <div class="flex-col" style="gap: 6px;">
                    <h3 style="text-align: center;">Test GetServerTime()</h3>
                    <asp:Button ID="btnTestServerTime" runat="server" Text="Get Server Time" OnClick="btnTestServerTime_Click" class="cta-blue"/>
                    <asp:Label ID="lblServerTime" runat="server" style="text-align: center;"></asp:Label>
                </div>

                <div class="flex-col" style="gap: 6px;">
                    <h3 style="text-align: center;">Test ValidateUsername()</h3>
                    <asp:Label ID="Label3" runat="server" Text="Username"></asp:Label>
                    <asp:TextBox ID="txtTestUsername" runat="server"></asp:TextBox>
                    <asp:Button ID="btnTestUsername" runat="server" Text="Validate" OnClick="btnTestUsername_Click" class="cta-blue"/>
                    <asp:Label ID="lblUsernameResult" runat="server" style="text-align: center;"></asp:Label>
                </div>

                <div class="flex-col" style="gap: 6px;">
                    <h3 style="text-align: center;">Test CalculateBMI()</h3>
                    <asp:Label ID="Label4" runat="server" Text="Height (inches): "></asp:Label>
                    <asp:TextBox ID="txtHeight" runat="server"></asp:TextBox>
                    <asp:Label ID="Label5" runat="server" Text="Weight (lbs): "></asp:Label>
                    <asp:TextBox ID="txtWeight" runat="server"></asp:TextBox>

                    <asp:Button ID="btnTestBMI" runat="server" Text="Calculate BMI" OnClick="btnTestBMI_Click" class="cta-blue"/>
                    <asp:Label ID="lblBMIResult" runat="server" style="text-align: center;"></asp:Label>
                </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
