using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userlogin : System.Web.UI.Page
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

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string password = txtPassword.Text.Trim(); // Hashing recommended

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Users WHERE Email=@Email AND PasswordHash=@PasswordHash", con);
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@PasswordHash", HashPassword(txtPassword.Text.Trim()));

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                // Login success -> session set
                Session["UserID"] = dr["UserID"];
                Session["Email"] = dr["Email"];

                string returnUrl = Session["ReturnUrl"] != null ? Session["ReturnUrl"].ToString() : "index.aspx";
                Response.Redirect(returnUrl );
            }
            else
            {
                // Invalid credentials
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid Email or Password');", true);
            }
            con.Close();
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