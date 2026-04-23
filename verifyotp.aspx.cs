using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class verifyotp : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnVerify_Click(object sender, EventArgs e)
    {
        if (Session["OTP"] == null || Session["ResetUserID"] == null)
        {
            lblError.Text = "Session expired! Please try again.";
            return;
        }

        if (txtOTP.Text == Session["OTP"].ToString())
        {
            string hashedPassword = HashPassword(txtNewPass.Text.Trim());

            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("UPDATE Users SET PasswordHash=@Pwd WHERE UserID=@UID", con);
                cmd.Parameters.AddWithValue("@Pwd", hashedPassword);
                cmd.Parameters.AddWithValue("@UID", Session["ResetUserID"]);
                cmd.ExecuteNonQuery();
            }

            Session.Remove("OTP");
            Session.Remove("ResetUserID");

            Response.Redirect("userlogin.aspx?reset=success");
        }
        else
        {
            lblError.Text = "Invalid OTP! Try again.";
        }
    }

    private string HashPassword(string password)
    {
        using (var sha256 = System.Security.Cryptography.SHA256.Create())
        {
            byte[] bytes = System.Text.Encoding.UTF8.GetBytes(password);
            byte[] hashBytes = sha256.ComputeHash(bytes);
            return Convert.ToBase64String(hashBytes); // ✅ Base64 (same as Signup)
        }
    }


}