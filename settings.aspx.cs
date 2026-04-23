using System;
using System.Configuration;
using System.Data.SqlClient;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class settings : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("userlogin.aspx");
        }

        if (!IsPostBack)
        {
            LoadUserDetails();
        }
    }

    private void LoadUserDetails()
    {
        int userId = Convert.ToInt32(Session["UserID"]);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            // Step 1: Get Email from Users
            SqlCommand cmdUser = new SqlCommand("SELECT Email FROM Users WHERE UserID = @UserID", con);
            cmdUser.Parameters.AddWithValue("@UserID", userId);
            string email = Convert.ToString(cmdUser.ExecuteScalar());

            // Step 2: Try to get Billing Address from Orders table
            SqlCommand cmdOrder = new SqlCommand(@"
                SELECT TOP 1 BillingAddress 
                FROM Orders 
                WHERE UserID = @UserID 
                ORDER BY CreatedAt DESC", con);
            cmdOrder.Parameters.AddWithValue("@UserID", userId);
            string billingAddress = Convert.ToString(cmdOrder.ExecuteScalar());

            string name = "";
            if (!string.IsNullOrEmpty(billingAddress))
            {
                // assuming billing address format: "Name, Phone, Address..."
                string[] parts = billingAddress.Split(',');
                if (parts.Length > 0)
                    name = parts[0].Trim();
            }

            // Step 3: Fallback if no name found
            if (string.IsNullOrEmpty(name))
            {
                name = GetNameFromEmail(email);
            }

            // Step 4: Bind data
            lblNameSide.Text = name;
            lblEmailSide.Text = email;
            lblUserName.Text = name;
        }
    }

    // Helper: Generate name from email
    private string GetNameFromEmail(string email)
    {
        if (string.IsNullOrEmpty(email))
            return "User";

        string beforeAt = email.Split('@')[0];
        string[] parts = beforeAt.Split(new char[] { '.', '_', '-' }, StringSplitOptions.RemoveEmptyEntries);

        for (int i = 0; i < parts.Length; i++)
        {
            if (parts[i].Length > 0)
                parts[i] = char.ToUpper(parts[i][0]) + parts[i].Substring(1);
        }

        return string.Join(" ", parts);
    }

    protected void btnDeleteAccount_Click(object sender, EventArgs e)
{
    if (Session["UserID"] == null)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Session expired. Please login again.'); window.location='userlogin.aspx';", true);
        return;
    }

    int userId = Convert.ToInt32(Session["UserID"]);

    try
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            // Delete the user from Users table
            SqlCommand cmd = new SqlCommand("DELETE FROM Users WHERE UserID = @UserID", con);
            cmd.Parameters.AddWithValue("@UserID", userId);
            int rows = cmd.ExecuteNonQuery();

            if (rows > 0)
            {
                // Clear session and redirect
                Session.Clear();
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Your account has been permanently deleted.'); window.location='userlogin.aspx';", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error deleting your account. Please try again later.');", true);
            }
        }
    }
    catch (Exception ex)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error: {ex.Message}');", true);
    }
}

}
