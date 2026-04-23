using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddCategory : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;


    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrWhiteSpace(txtCategoryName.Text))
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = "INSERT INTO Categories (CategoryName) VALUES (@CategoryName)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CategoryName", txtCategoryName.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();

                lblMessage.Text = "✅ Category added successfully!";
                txtCategoryName.Text = "";
            }
        }
        else
        {
            lblMessage.Text = "⚠️ Please enter a category name.";
        }
    }

}