using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_Adminlogin : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Clear old session if any
            Session.Clear();
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string username = txtUsername.Text.Trim();
        string password = txtPassword.Text.Trim();

        if (username == "" || password == "")
        {
            ShowAlert("Please enter both username and password.");
            return;
        }

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT * FROM Admin WHERE Username=@Username AND Password=@Password";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Username", username);
            cmd.Parameters.AddWithValue("@Password", password);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                // Store admin info in session
                Session["AdminUsername"] = dt.Rows[0]["Username"].ToString();

                // Redirect to dashboard
                Response.Redirect("AddProduct.aspx");
            }
            else
            {
                ShowAlert("Invalid username or password. Please try again.");
            }
        }
    }



    private void ShowAlert(string message)
    {
        string script = "<script>alert('{message}');</script>";
        ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
    }
}
