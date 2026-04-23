using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Globalization;

public partial class myaccount : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserID"] != null)
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                LoadUserProfile(userId);
            }
            else
            {
                Response.Redirect("UserLogin.aspx");
            }
        }
    }

    private void LoadUserProfile(int userId)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            try
            {
                con.Open();

                // 1️⃣ Get Email from Users
                SqlCommand cmdUser = new SqlCommand("SELECT Email FROM Users WHERE UserID = @UserID", con);
                cmdUser.Parameters.AddWithValue("@UserID", userId);
                string email = Convert.ToString(cmdUser.ExecuteScalar());

                // 2️⃣ Get latest Order shipping info
                SqlCommand cmdOrder = new SqlCommand(@"
                    SELECT TOP 1 ShippingAddress 
                    FROM Orders 
                    WHERE UserID = @UserID 
                    ORDER BY CreatedAt DESC", con);
                cmdOrder.Parameters.AddWithValue("@UserID", userId);
                string shippingAddress = Convert.ToString(cmdOrder.ExecuteScalar());

                string name = "—";
                string phone = "—";

                // 3️⃣ Extract Name & Phone if order exists
                if (!string.IsNullOrEmpty(shippingAddress))
                {
                    string[] parts = shippingAddress.Split(',');
                    if (parts.Length >= 2)
                    {
                        name = parts[0].Trim();
                        phone = parts[1].Trim();
                    }
                    else
                    {
                        name = parts[0].Trim();
                    }
                }
                else
                {
                    // 4️⃣ No order? Extract name from Gmail
                    name = GetNameFromEmail(email);
                }

                // 5️⃣ Bind data to labels
                lblName.Text = name;
                lblEmail.Text = email;
                lblPhone.Text = phone;

                lblNameSide.Text = name;
                lblEmailSide.Text = email;

                imgProfile.ImageUrl = "~/images/user.png";
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }
    }

    private string GetNameFromEmail(string email)
    {
        if (string.IsNullOrEmpty(email))
            return "User";

        try
        {
            // Split before @
            string prefix = email.Split('@')[0];
            prefix = prefix.Replace('.', ' ').Replace('_', ' ');
            prefix = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(prefix.ToLower());
            return prefix;
        }
        catch
        {
            return "User";
        }
    }
}
