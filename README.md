# Assignment 6 — Member & Staff Login System

## TODO
- [ ] Default
  - [ ] Add Wyatt's component component summary + tryit 
  - [ ] Add Jon's component component summary + tryit 
- [ ] Register
  - [x] Register.aspx UI
  - [ ] Register.aspx.cs core logic (connect hash service)
  - [ ] Add member to Member.xml
- [ ] Login
  - [x] Login.aspx UI
  - [ ] Login.aspx.cs core logic
- [x] Member
  - [x] Add member service (BMI/server time)
- [ ] Staff
  - [ ] Display members
- [x] Logout
- [ ] Error

## Overview
This assignment implements an authentication and access-control system for a web app with two user types:
- Members (registered users stored in `Member.xml`)
- Staff (accounts stored in `Staff.xml`, must include a TA account)

You will add login/registration flows, enforce page-level access control, and integrate your existing components (Global.asax, cookies/session handling, web service, and any DLL/class you already created).

---

## Goals (High level)
- Add Member and Staff login system with:
  - Member registration (GUI + CAPTCHA) using `Member.xml`
  - Staff accounts stored in `Staff.xml` (TA account required)
- Enforce access control:
  - Members can only access Member pages
  - Staff can only access Staff pages
- Integrate your existing components (Global.asax, cookies, web service, DLL/class) into the full app

---

## Required Pages
Create at least the following pages in your web application (brief purpose for each):

- `Default.aspx`
  - Keep Component Summary and TryIts page(s) already present in the project.
- `Login.aspx`
  - Shared login screen for both members and staff.
  - Should authenticate against `Member.xml` (members) or `Staff.xml` (staff) depending on selection or credentials.
- `Register.aspx`
  - Member sign-up page with an image/captcha verification step.
  - On successful registration, add new member data to `Member.xml`.
- `Member.aspx`
  - Page accessible only to authenticated Members.
  - Provide some member-only functionality (e.g., profile, member-only TryIts, favorite items).
- `Staff.aspx`
  - Page accessible only to authenticated Staff accounts.
  - Provide admin/test features (e.g., view member list, simple admin tools).
- `Logout.aspx`
  - Sign out user, clear cookies and session state, and redirect to `Default.aspx` or `Login.aspx`.
- `Error.aspx` (optional but recommended)
  - Friendly error handling and access-denied messages.

---

## Functional Requirements (Detailed)
- Authentication
  - Support two user domains: Members and Staff.
  - Use `Member.xml` to store members and `Staff.xml` to store staff.
  - Staff XML must include a TA account (instructor-provided requirement).

- Registration
  - `Register.aspx` should present a form for new members.
  - Include a CAPTCHA (image verification) to avoid bot registrations.
  - Validate input and write new member record into `Member.xml`.

- Login
  - `Login.aspx` should accept credentials and authenticate the user.
  - On success, set appropriate authentication markers (cookie + server session recommended).
  - Record whether the logged-in user is `Member` or `Staff` to enforce access rules.

- Access Control
  - Members must not access `Staff.aspx` content; Staff must not access `Member.aspx` content.
  - Redirect unauthorized users to `Login.aspx` or `Error.aspx` with a clear message.
  - Implement checks in `Global.asax` (or a common base/master page) to verify session/cookie and role for each request.

- Integration
  - Reuse your existing components (Global.asax, web services, DLLs, and cookie/session handling) so behavior is consistent with earlier work.

---

## Data & File Notes
- `Member.xml`
  - Should contain member records with fields such as `id`, `email`, `passwordHash` (or password), `createdAt`, and any other profile data.
  - Update this file on successful registration.

- `Staff.xml`
  - Contains staff accounts. At minimum include the TA account required by the assignment.
  - Consider storing hashed passwords or clear instructions for how the class will authenticate.

Security note: Storing plaintext passwords in XML is not secure; prefer a hashed password field or clearly document the expected password storage approach for testing.

---

## Implementation Guidance
Here are practical suggestions and snippets to make development easier and more consistent.

### Session & Cookies
- Use a secure session cookie to mark authenticated users. Example (pseudo-code):

```csharp
// After successful login
Session["UserType"] = "Member"; // or "Staff"
Session["UserId"] = userId;
// set a persistent cookie if "Remember me" is required
Response.Cookies.Add(new HttpCookie("auth", token) { HttpOnly = true, Secure = Request.IsSecureConnection });
```

- In `Global.asax` or a base page, check session/cookie on `BeginRequest` or `AcquireRequestState` and redirect if unauthorized.

### Global Access Check (pseudo)
```csharp
protected void Application_BeginRequest(object sender, EventArgs e)
{
    var path = HttpContext.Current.Request.Path.ToLower();
    var userType = Session["UserType"] as string;

    if (path.EndsWith("/member.aspx") && userType != "Member")
    {
        Response.Redirect("/Login.aspx?returnUrl=" + HttpUtility.UrlEncode(path));
    }
    if (path.EndsWith("/staff.aspx") && userType != "Staff")
    {
        Response.Redirect("/Login.aspx?returnUrl=" + HttpUtility.UrlEncode(path));
    }
}
```

### XML Helper (reading/writing)
- Encapsulate XML access in a helper class (or your existing DLL). Example methods:
  - `GetMemberByEmail(email)`
  - `CreateMember(memberObj)` (appends to `Member.xml`)
  - `GetStaffByUsername(username)`

Make sure XML writes are done with proper locking or synchronization if your app runs concurrently.

---

## UI / UX Requirements
- `Login.aspx` should clearly allow selecting member vs staff or detect based on credentials.
- `Register.aspx` should include validation and CAPTCHA image.
- `Member.aspx` and `Staff.aspx` should show a greeting (e.g., "Welcome, <Name>") and a logout link.
- After `Logout.aspx`, ensure cookies and session state are cleared.

---

## Testing Checklist
- [ ] Register a new member via `Register.aspx` and verify the record was added to `Member.xml`.
- [ ] Confirm CAPTCHA blocks simple automated submissions.
- [ ] Log in as the new member and access `Member.aspx` successfully.
- [ ] Attempt to access `Staff.aspx` as a member — ensure redirection/denial.
- [ ] Log in as a staff account (including TA) and access `Staff.aspx` successfully.
- [ ] Attempt to access `Member.aspx` as staff if that’s restricted by your spec — ensure appropriate behavior.
- [ ] Log out and verify session/cookie cleared and protected pages are no longer accessible.

---

## Deliverables
- Working pages: `Default.aspx`, `Login.aspx`, `Register.aspx`, `Member.aspx`, `Staff.aspx`, `Logout.aspx`, (optional `Error.aspx`).
- Updated `Member.xml` and `Staff.xml` with test accounts (TA must be present in staff list).
- Any helper DLLs or classes used for XML handling or authentication.
- Short README in the project root describing how to test the login and registration flows.

---

## Grading / Evaluation Notes (suggested)
- Correctness: pages behave as specified and access control is enforced.
- Security: password handling, cookie/session best practices, and CAPTCHA usage.
- Code organization: reuse of existing components, clean separation of XML helpers and page logic.
- UX: clear flows, error messages, and redirects.

---

## Troubleshooting & Tips
- If writes to `Member.xml` appear missing, check file permissions and file path (use Server.MapPath to ensure correct path).
- For CAPTCHA, you can generate an image in an HTTP handler (`.ashx`) or use a simple math question if image generation is difficult.
- Log authentication attempts to a diagnostic file while testing to track issues.

---

