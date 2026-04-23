using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class BlogDetails : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;
    protected string MetaDescription = "";
    protected string MetaKeywords = "";
    protected string MetaImage = "";
    protected string MetaDate = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string postId = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(postId))
            {
                LoadBlogPost(postId);
            }
        }
    }

    private void LoadBlogPost(string postId)
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT TOP 1 * FROM BlogPosts WHERE PostID = @PostID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@PostID", postId);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                // Display Blog Details
                lblTitle.Text = dr["Title"].ToString();
                lblDate.Text = Convert.ToDateTime(dr["PostDate"]).ToString("MMMM dd, yyyy");
                lblComments.Text = dr["CommentsCount"].ToString();
                lblDescription.Text = dr["Description"].ToString();
                imgBlog.ImageUrl = "~/" + dr["ImageUrl"].ToString();

                // SEO Meta
                Page.Title = dr["Title"].ToString();
              
                MetaKeywords = "Mobile Nest Blog, Bhilwara mobiles, " + dr["Title"].ToString();
                MetaImage = "https://yourwebsite.com/" + dr["ImageUrl"].ToString();
                MetaDate = Convert.ToDateTime(dr["PostDate"]).ToString("yyyy-MM-dd");
            }
            con.Close();
        }
    }
}
