<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Staff.aspx.cs" Inherits="Assignment6.Staff" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Staff</title>
    <style>
        .welcome-header { font-size: 24px; font-weight: 700;}
        .container { width: min-content;
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
        .cta { 
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
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <div class="nav-left">
                <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Default.aspx" Text="Home" />
            </div>
        </div>
        <div>
        <asp:Label ID="lblWelcomeMember" runat="server" class="welcome-header"/>
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
                <asp:Button ID="btnLogOut" runat="server" Text="Log out" CssClass="btn cta" PostBackUrl="~/Logout.aspx"/>
            </div>
        </div>

        <h3>Registered Members</h3>
        <asp:GridView ID="gvMembers" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="Username" HeaderText="Username" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Role" HeaderText="Role" />
            </Columns>
        </asp:GridView>
        <h3>Application State</h3>
        <asp:Label ID="lblStaffAppState" runat="server" />

        <h3>Cookie Info</h3>
        <asp:Label ID="lblStaffCookieInfo" runat="server" />

        </div>
    </form>
</body>
</html>
