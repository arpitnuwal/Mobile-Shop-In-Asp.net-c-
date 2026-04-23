using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

public partial class changepassword : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("userlogin.aspx");
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Session expired. Please login again.'); window.location='userlogin.aspx';", true);
            return;
        }

        int userId;
        if (!int.TryParse(Session["UserID"].ToString(), out userId))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid session. Please login again.'); window.location='userlogin.aspx';", true);
            return;
        }

        string currentPassword = txtCurrentPassword.Text.Trim();
        string newPassword = txtNewPassword.Text.Trim();
        string confirmPassword = txtConfirmPassword.Text.Trim();

        if (string.IsNullOrWhiteSpace(currentPassword) ||
            string.IsNullOrWhiteSpace(newPassword) ||
            string.IsNullOrWhiteSpace(confirmPassword))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please fill all fields.');", true);
            return;
        }

        if (newPassword != confirmPassword)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('New password and confirm password do not match.');", true);
            return;
        }

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            // ✅ Adjust column name if your DB uses 'Password' instead of 'PasswordHash'
            SqlCommand cmd = new SqlCommand("SELECT PasswordHash FROM Users WHERE UserID = @UserID", con);
            cmd.Parameters.AddWithValue("@UserID", userId);
            object result = cmd.ExecuteScalar();

            if (result == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('User not found.');", true);
                return;
            }

            string dbHash = result.ToString();

            // ✅ Check both hashed and plain for backward compatibility
            if (dbHash != HashPassword(currentPassword) && dbHash != currentPassword)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Current password is incorrect.');", true);
                return;
            }

            // ✅ Update new password hash
            SqlCommand cmdUpdate = new SqlCommand("UPDATE Users SET PasswordHash = @NewHash WHERE UserID = @UserID", con);
            cmdUpdate.Parameters.AddWithValue("@UserID", userId);
            cmdUpdate.Parameters.AddWithValue("@NewHash", HashPassword(newPassword));
            cmdUpdate.ExecuteNonQuery();

            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Password updated successfully.'); window.location='myaccount.aspx';", true);
        }
    }

    private string HashPassword(string password)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
            StringBuilder sb = new StringBuilder();
            foreach (byte b in bytes)
            {
                sb.Append(b.ToString("x2"));
            }
            return sb.ToString();
        }
    }
}
