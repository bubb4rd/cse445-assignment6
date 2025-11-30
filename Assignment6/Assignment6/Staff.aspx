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
            /* Container */
            .staff-container {
                max-width: 960px;
                margin: 20px auto;
                padding: 20px;
                background: #ffffff;
                border-radius: 10px;
                box-shadow: 0 10px 25px rgba(15, 23, 42, 0.12);
            }

            .staff-container h2,
            .staff-container h3 {
                margin-top: 0;
                font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            }

            /* Base table */
            .user-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
                font-size: 14px;
                color: #1f2933;
                margin-top: 10px;
                background-color: #ffffff;
                border-radius: 8px;
                overflow: hidden; /* rounded corners */
            }

            /* Header */
            .user-table-header {
                background: linear-gradient(90deg, #0f766e, #2563eb);
                color: #ffffff;
                text-align: left;
                font-weight: 600;
                letter-spacing: 0.03em;
                text-transform: uppercase;
                font-size: 12px;
            }

            .user-table-header th {
                padding: 12px 16px !important;
            }

            /* Rows */
            .user-table-row td,
            .user-table-row-alt td {
                padding: 10px 16px !important;
                border-bottom: 1px solid #e5e7eb;
                vertical-align: middle;
            }

            .user-table-row {
                background-color: #ffffff;
            }

            .user-table-row-alt {
                background-color: #f9fafb;
            }

            /* Hover state for better UX */
            .user-table-row:hover,
            .user-table-row-alt:hover {
                background-color: #eef2ff;
                transition: background-color 0.15s ease-in-out;
            }

            /* Selected row (if you ever use selection) */
            .user-table-row-selected td {
                background-color: #e0f2fe !important;
                font-weight: 600;
            }

            /* Subtle pill styles for Role and Source columns */
            .user-table td:nth-child(3), /* Role */
            .user-table td:nth-child(4)  /* Source */ {
                white-space: nowrap;
            }

            .user-table td:nth-child(3) span,
            .user-table td:nth-child(4) span {
                display: inline-block;
                padding: 2px 8px;
                border-radius: 999px;
                font-size: 11px;
                font-weight: 600;
            }

            /* You can wrap Role/Source values in spans in RowDataBound if you want pills,
            but even without that, the table will look good. */

            /* Responsive tweak: scroll on small screens */
            @media (max-width: 640px) {
                .staff-container {
                    margin: 10px;
                    padding: 12px;
                }

                .user-table {
                    display: block;
                    overflow-x: auto;
                    white-space: nowrap;
                }
            }
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

        <h3>All Users (Members + Staff)</h3>
        <asp:GridView ID="gvUsers" runat="server"
            AutoGenerateColumns="False"
            CssClass="user-table"
            HeaderStyle-CssClass="user-table-header"
            RowStyle-CssClass="user-table-row"
            AlternatingRowStyle-CssClass="user-table-row-alt"
            SelectedRowStyle-CssClass="user-table-row-selected"
            GridLines="None"
            CellPadding="12"
            CellSpacing="0">
            <Columns>
                <asp:BoundField DataField="Username" HeaderText="Username" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Role" HeaderText="Role" />
                <asp:BoundField DataField="DateCreated" HeaderText="Date Created" />
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
