using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

public partial class blog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadBlogPosts();
        }
    }

    private void LoadBlogPosts()
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT * FROM BlogPosts ORDER BY PostDate DESC";
            SqlCommand cmd = new SqlCommand(query, con);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            rptBlogs.DataSource = dr;
            rptBlogs.DataBind();
            con.Close();
        }
    }
}
