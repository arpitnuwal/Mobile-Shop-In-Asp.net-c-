using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddFeatures : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"INSERT INTO Features (FeatureName, Url, Status) 
                             VALUES (@FeatureName, @Url, @Status)";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@FeatureName", txtFeatureName.Text);
            cmd.Parameters.AddWithValue("@Url", string.IsNullOrEmpty(txtUrl.Text) ? (object)DBNull.Value : txtUrl.Text);
            cmd.Parameters.AddWithValue("@Status", chkActive.Checked ? 1 : 0);

            con.Open();
            cmd.ExecuteNonQuery();
            lblMessage.Text = "✅ Feature added successfully!";
        }

        // Clear fields
        txtFeatureName.Text = "";
        txtUrl.Text = "";
        chkActive.Checked = true;
    }
}