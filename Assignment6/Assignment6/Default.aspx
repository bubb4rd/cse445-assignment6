<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Assignment6._Default" %>

<!DOCTYPE html>
<html>
<head>
    <title>Assignment 6 - CSE 445</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { border-collapse: collapse; width: 100%; margin: 20px 0; }
        th, td { border: 1px solid black; padding: 8px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        .section { margin: 30px 0; padding: 20px; background-color: #f9f9f9; border-radius: 5px; }
        h1 { color: #333; }
        h2 { color: #4CAF50; }
        h3 { color: #555; }
        .navbar {
            padding: 10px 20px;
            color: #000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar a { text-decoration: none; margin-left: 10px; }
        .nav-left a { font-weight: bold; }
        .role-label { text-transform: uppercase; color: #00000050; font-weight: 500; font-size: 12px;}
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
        <div class="navbar">
            <div class="nav-left">
                <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Default.aspx" Text="Home" />
            </div>
            <div class="nav-right">
                <!-- Anonymous user links -->
                <asp:Panel ID="pnlAnonNav" runat="server">
                    <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="~/Login.aspx" Text="Login" class="cta"/>
                    &nbsp;
                    <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="~/Register.aspx" Text="Register" />
                </asp:Panel>

                <!-- Logged-in user links -->
                <asp:Panel ID="pnlAuthNav" runat="server" Visible="false">
                    <asp:Label ID="lblNavUser" runat="server" />
                    <asp:Label ID="lblUserRole" runat="server" class="role-label"/>
                    &nbsp;|&nbsp;
                    <asp:HyperLink ID="lnkProfile" runat="server" Text="Profile" />
                    &nbsp;|&nbsp;
                    <asp:HyperLink ID="lnkLogout" runat="server" NavigateUrl="~/Logout.aspx" Text="Logout" />
                </asp:Panel>
            </div>
        </div>

        <hr />
        <div>
            <h1>CSE 445 Assignment 6</h1>
            <h2>Team Members: Bo Hubbard, Wyatt Belscher, Jon Kruja</h2>
            <h3>Deployment Site: webstrar45.fulton.asu.edu/pagex/</h3>
            
            <hr />
            
            <!-- Application and Components Summary Table -->
            <h2>Application and Components Summary Table</h2>
            <table>
                <thead>
                    <tr>
                        <th>Provider</th>
                        <th>Component Type</th>
                        <th>Description</th>
                        <th>Operations/Methods</th>
                        <th>Input/Output</th>
                        <th>TryIt</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Bo Hubbard</td>
                        <td>Global.asax (Local)</td>
                        <td>Application and session event handlers for state management</td>
                        <td>Application_Start, Session_Start, Session_End</td>
                        <td>No input. Output: Application["TotalVisitors"], Application["CurrentUsers"]</td>
                        <td>See "Global.asax Testing" below</td>
                    </tr>
                    <tr>
                        <td>Bo Hubbard</td>
                        <td>Cookie Manager (DLL/Class)</td>
                        <td>Manages HTTP cookies for user preferences and visit tracking</td>
                        <td>SetUserPreference(), GetUserPreference(), TrackVisit(), DeleteCookie()</td>
                        <td>Input: username (string), preference (string). Output: Cookie values (string)</td>
                        <td>See "Cookie Testing" below</td>
                    </tr>
                    <tr>
                        <td>Bo Hubbard</td>
                        <td>Web Service (Remote)</td>
                        <td>Validation and utility service for user input and calculations</td>
                        <td>GetServerTime(), ValidateUsername(), ValidatePassword(), CalculateBMI()</td>
                        <td>Various: string, bool, double</td>
                        <td><asp:HyperLink ID="lnkService" runat="server" NavigateUrl="~/SimpleService.asmx" Text="Service Link" Target="_blank" /></td>
                    </tr>
                    <tr>
                        <td>Wyatt Belscher</td>
                        <td>Hashing Function (DLL/Class)</td>
                        <td>Takes a string and computes the hashed value</td>
                        <td>ComputeHash()</td>
                        <td>Input: str (string), Output: hashed str (string)</td>
                        <td>See "Hash Testing" below</td>
                    </tr>
                    <tr>
                        <td>Wyatt Belscher</td>
                        <td>Web Service (Remote)</td>
                        <td>Word Filter Service to filter stop words and other meaningless words</td>
                        <td>WordFilter()</td>
                        <td>Input: str (string), Output: Filtered str (string)</td>
                        <td><asp:HyperLink ID="lnkService2" runat="server" NavigateUrl="http://webstrar45.fulton.asu.edu/Page2/Service1.svc" Text="Service Link" Target="_blank" /></td>
                    </tr>
                    <tr>
                        <td>Wyatt Belscher</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Jon Kruja</td>
                        <td>WebForms Pages (Local)</td>
                        <td>Login, Register, Member, and Staff pages for user authentication and role-based navigation.</td>
                        <td>Login, Register, ViewMember, ViewStaff</td>
                        <td>Input: username/password; Output: authenticated user & role-based content</td>
                        <td>Login.aspx, Register.aspx, Member.aspx, Staff.aspx</td>
                    </tr>
                    <tr>
                        <td>Jon Kruja</td>
                        <td>Remote WCF Service</td>
                        <td>Word Count Service that returns the number of words in the input text.</td>
                        <td>CountWords(string text)</td>
                        <td>Input: text (string); Output: wordCount (int)</td>
                        <td>See "Word Count Service TryIt (Jon)" below</td>
                    </tr>
                    <tr>
                        <td>Jon Kruja</td>
                        <td>Integration Component</td>
                        <td>Default.aspx integration of authentication nav and Word Count TryIt with remote services.</td>
                        <td>Navbar links, btnWordCountService_Click()</td>
                        <td>Input: user actions; Output: navigation & service results</td>
                        <td>Default.aspx</td>
                    </tr>

                </tbody>
            </table>
            
            <hr />
            
            <!-- Global.asax TryIt Section -->
            <div class="section">
                <h2>Global.asax Testing</h2>
                <p><strong>Description:</strong> This demonstrates Application state management via Global.asax event handlers.</p>
                
                <asp:Button ID="btnShowAppState" runat="server" Text="Show Application State" 
                            OnClick="btnShowAppState_Click" />
                <br /><br />
                <asp:Label ID="lblAppState" runat="server" ForeColor="Blue"></asp:Label>
            </div>
            
            <hr />
            
            <!-- Cookie TryIt Section -->
            <div class="section">
                <h2>Cookie Testing</h2>
                <p><strong>Description:</strong> This demonstrates cookie creation, reading, and deletion using CookieManager class.</p>
                
                <asp:Label ID="Label1" runat="server" Text="Username: "></asp:Label>
                <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                <br /><br />
                
                <asp:Label ID="Label2" runat="server" Text="Preference: "></asp:Label>
                <asp:TextBox ID="txtPreference" runat="server"></asp:TextBox>
                <br /><br />
                
                <asp:Button ID="btnSetCookie" runat="server" Text="Set Cookie" 
                            OnClick="btnSetCookie_Click" />
                <asp:Button ID="btnReadCookie" runat="server" Text="Read Cookie" 
                            OnClick="btnReadCookie_Click" />
                <asp:Button ID="btnDeleteCookie" runat="server" Text="Delete Cookie" 
                            OnClick="btnDeleteCookie_Click" />
                <br /><br />
                
                <asp:Label ID="lblCookieOutput" runat="server" ForeColor="Green"></asp:Label>
            </div>
            
            <hr />
            
            <!-- Session State TryIt -->
            <div class="section">
                <h2>Session State Testing</h2>
                <p><strong>Description:</strong> This demonstrates session state tracking initialized by Global.asax Session_Start.</p>
                
                <asp:Button ID="btnSessionDemo" runat="server" Text="Show Session Info" 
                            OnClick="btnSessionDemo_Click" />
                <br /><br />
                <asp:Label ID="lblSessionOutput" runat="server" ForeColor="Purple"></asp:Label>
            </div>
            
            <hr />
            
            <!-- Web Service TryIt -->
            <div class="section">
                <h2>Web Service Testing</h2>
                <p><strong>Description:</strong> This tests the SimpleService web service methods.</p>
                
                <h3>Test GetServerTime()</h3>
                <asp:Button ID="btnTestServerTime" runat="server" Text="Get Server Time" 
                            OnClick="btnTestServerTime_Click" />
                <br />
                <asp:Label ID="lblServerTime" runat="server"></asp:Label>
                <br /><br />
                
                <h3>Test ValidateUsername()</h3>
                <asp:Label ID="Label3" runat="server" Text="Username: "></asp:Label>
                <asp:TextBox ID="txtTestUsername" runat="server"></asp:TextBox>
                <asp:Button ID="btnTestUsername" runat="server" Text="Validate" 
                            OnClick="btnTestUsername_Click" />
                <br />
                <asp:Label ID="lblUsernameResult" runat="server"></asp:Label>
                <br /><br />
                
                <h3>Test CalculateBMI()</h3>
                <asp:Label ID="Label4" runat="server" Text="Height (inches): "></asp:Label>
                <asp:TextBox ID="txtHeight" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="Label5" runat="server" Text="Weight (lbs): "></asp:Label>
                <asp:TextBox ID="txtWeight" runat="server"></asp:TextBox>
                <br />
                <asp:Button ID="btnTestBMI" runat="server" Text="Calculate BMI" 
                            OnClick="btnTestBMI_Click" />
                <br />
                <asp:Label ID="lblBMIResult" runat="server"></asp:Label>
                <br /><br />

                <h3>Test Word Filter Function</h3>
                <asp:Label ID="Label6" runat="server" Text="Enter String: "></asp:Label>
                <asp:TextBox ID="txtInputString" runat="server"></asp:TextBox>
                <asp:Button ID="btnTestWordFilter" runat="server" Text="Filter" 
                            OnClick="btnTestWordFilter_Click" />
                <br />
                <asp:Label ID="Label7" runat="server" Text="Result: "></asp:Label>
                <asp:Label ID="lblWordFilterResult" runat="server"></asp:Label>
                <br /><br />
            </div>
            
            <!-- DLL Service TryIt -->
            <div class="section">
                <h2>Hashing Function Testing</h2>
                <p><strong>Description:</strong> This tests the ComputeHash method from the Hashing Function DLL.</p>
                
                <asp:Label ID="Label8" runat="server" Text="Input String: "></asp:Label>
                <asp:TextBox ID="txtHashInput" runat="server"></asp:TextBox>
                <br /><br />
                
                <asp:Button ID="btnComputeHash" runat="server" Text="Compute Hash" 
                            OnClick="btnComputeHash_Click" />
                <br /><br />
                
                <asp:Label ID="lblHashOutput" runat="server" ForeColor="Brown"></asp:Label>
            </div>
                        <!-- Jon's Word Count Service TryIt -->
            <div class="section">
                <h2>Word Count Service TryIt (Jon)</h2>
                <p>
                    <strong>Description:</strong> This TryIt calls Jon's remote WCF Word Count Service.
                    It sends the text you enter to the service and displays the number of words returned.
                </p>

                <asp:Label ID="lblWordCountInput" runat="server"
                           Text="Enter text to count words:" />
                <br />
                <asp:TextBox ID="txtWordCountInput" runat="server"
                             TextMode="MultiLine" Rows="4" Columns="70" />
                <br /><br />

                <asp:Button ID="btnWordCountService" runat="server"
                            Text="Call Word Count Service"
                            OnClick="btnWordCountService_Click" />
                <br /><br />

                <asp:Label ID="lblWordCountResult" runat="server" ForeColor="Blue" />
            </div>

            <!-- User Control Service TryIt -->
        </div>
    </form>
</body>
</html>
