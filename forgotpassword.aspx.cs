using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class forgotpassword : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSendOTP_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT UserID FROM Users WHERE Email=@Email", con);
            cmd.Parameters.AddWithValue("@Email", txtResetEmail.Text.Trim());

            object result = cmd.ExecuteScalar();
            if (result == null)
            {
                lblMsg.Text = "Email not registered!";
                return;
            }

            int userId = Convert.ToInt32(result);
            Random rnd = new Random();
            int otp = rnd.Next(100000, 999999);

            Session["ResetUserID"] = userId;
            Session["OTP"] = otp;

            SendOTPEmail(txtResetEmail.Text.Trim(), otp);

            Response.Redirect("verifyotp.aspx");
        }
    }

    private void SendOTPEmail(string email, int otp)
    {
        MailMessage msg = new MailMessage();
        msg.To.Add(email);
        msg.Subject = "MobileNest - Password Reset OTP";
        msg.Body = "Your OTP to reset password is: " + otp + "\nDon't share with anyone.";
        msg.From = new MailAddress("cybervishu055@gmail.com");

        SmtpClient smtp = new SmtpClient("smtp.gmail.com");
        smtp.Port = 587;
        smtp.EnableSsl = true;
        smtp.Credentials = new System.Net.NetworkCredential("cybervishu055@gmail.com", "qbxgunyvtwdiczjk");
        smtp.Send(msg);
    }

}