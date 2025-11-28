<%@ WebService Language="C#" Class="SimpleService" %>

using System;
using System.Web.Services;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.ComponentModel.ToolboxItem(false)]
public class SimpleService : System.Web.Services.WebService
{
    [WebMethod(Description = "Returns current server date and time")]
    public string GetServerTime()
    {
        return DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
    }
    
    [WebMethod(Description = "Validates if username meets requirements (3+ characters)")]
    public bool ValidateUsername(string username)
    {
        if (string.IsNullOrEmpty(username))
            return false;
        return username.Length >= 3;
    }
    
    [WebMethod(Description = "Validates if password meets requirements (8+ chars, upper, lower, digit)")]
    public bool ValidatePassword(string password)
    {
        if (string.IsNullOrEmpty(password))
            return false;
        
        bool hasUpper = false;
        bool hasLower = false;
        bool hasDigit = false;
        
        foreach (char c in password)
        {
            if (char.IsUpper(c)) hasUpper = true;
            if (char.IsLower(c)) hasLower = true;
            if (char.IsDigit(c)) hasDigit = true;
        }
        
        return password.Length >= 8 && hasUpper && hasLower && hasDigit;
    }
    
    [WebMethod(Description = "Calculates BMI from height (inches) and weight (lbs)")]
    public double CalculateBMI(double heightInches, double weightLbs)
    {
        if (heightInches <= 0 || weightLbs <= 0)
            return 0;
        
        // BMI formula: (weight in lbs * 703) / (height in inches)^2
        return (weightLbs * 703) / (heightInches * heightInches);
    }
}
