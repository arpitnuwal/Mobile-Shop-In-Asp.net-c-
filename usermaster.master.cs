using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class usermaster : System.Web.UI.MasterPage
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

  

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCategories();
            LoadFeatures();
            LoadFooterCategories();
        }
    }

    private void LoadCategories()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = "SELECT CategoryID, CategoryName FROM Categories ORDER BY CategoryName";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlCategory.Items.Clear();
                ddlCategory.Items.Add(new ListItem("All Category", ""));

                while (reader.Read())
                {
                    ddlCategory.Items.Add(new ListItem(
                        reader["CategoryName"].ToString(),
                        reader["CategoryID"].ToString()
                    ));
                }

                reader.Close();
            }
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string category = ddlCategory.SelectedValue;
        string searchTerm = txtSearch.Text.Trim();

        string url = string.Format("Shop.aspx?category={0}&search={1}",
            category,
            Server.UrlEncode(searchTerm)
        );

        Response.Redirect(url);
    }

    private void LoadFeatures()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = "SELECT FeatureID, FeatureName FROM Features WHERE Status = 1 ORDER BY FeatureName";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                rptFeatures.DataSource = reader;
                rptFeatures.DataBind();
                reader.Close();
            }
        }
    }

    private void LoadFooterCategories()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = "SELECT TOP 7 CategoryID, CategoryName FROM Categories ORDER BY CategoryID DESC";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            rptFooterCategories.DataSource = dr;
            rptFooterCategories.DataBind();
            dr.Close();
        }
    }
}
