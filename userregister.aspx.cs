using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userregister : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["returnUrl"] != null)
            {
                Session["ReturnUrl"] = Request.QueryString["returnUrl"];
            }
        }
    }

    protected void btnSendOtp_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string otp = new Random().Next(100000, 999999).ToString(); // 6 digit OTP

        Session["OTP"] = otp;
        Session["Email"] = email;
        Session["Password"] = txtPassword.Text.Trim();

        SendOtpEmail(email, otp);

        pnlRegister.Visible = false;
        pnlOtp.Visible = true;
    }

    private void SendOtpEmail(string toEmail, string otp)
    {
        string fromEmail = "cybervishu055@gmail.com";
        string fromPassword = "qbxgunyvtwdiczjk"; // Gmail App Password

        MailMessage mm = new MailMessage(fromEmail, toEmail);
        mm.Subject = "Your OTP Code";
        mm.Body = "Your OTP is: " + otp;
        mm.IsBodyHtml = true;

        SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
        smtp.Credentials = new NetworkCredential(fromEmail, fromPassword);
        smtp.EnableSsl = true;
        smtp.Send(mm);
    }

    protected void btnVerifyOtp_Click(object sender, EventArgs e)
    {
        if (Session["OTP"] != null && txtOtp.Text == Session["OTP"].ToString())
        {
            string email = Session["Email"].ToString();
            string password = Session["Password"].ToString();

            // ✅ HASH password before save
            string hashPassword = HashPassword(password);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();

                string checkQuery = "SELECT UserID FROM dbo.Users WHERE Email=@Email";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@Email", email);

                object result = checkCmd.ExecuteScalar();
                int userId = 0;

                if (result != null)
                {
                    userId = Convert.ToInt32(result);
                }
                else
                {
                    string insertQuery = @"
                        INSERT INTO dbo.Users (Email, PasswordHash, IsVerified, CreatedAt) 
                        OUTPUT INSERTED.UserID
                        VALUES (@Email, @PasswordHash, 1, GETDATE())";

                    SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                    insertCmd.Parameters.AddWithValue("@Email", email);
                    insertCmd.Parameters.AddWithValue("@PasswordHash", hashPassword);

                    userId = Convert.ToInt32(insertCmd.ExecuteScalar());
                }

                Session["UserID"] = userId;
                Session["Email"] = email;

                con.Close();
            }

          
            Response.Redirect("index.aspx");
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid OTP.');", true);
        }
    }

    // ✅ Secure Hash Function
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
