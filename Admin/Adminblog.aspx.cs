using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

public partial class Adminblog : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadBlogPosts();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            string fileName = "";
            string folderPath = Server.MapPath("~/images/blog/");

            // Create folder if not exists
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            // Upload file if selected
            if (fileImage.HasFile)
            {
                fileName = DateTime.Now.ToString("yyyyMMddHHmmss") + Path.GetExtension(fileImage.FileName);
                fileImage.SaveAs(Path.Combine(folderPath, fileName));
            }
            else
            {
                lblMsg.Text = "⚠️ Please select an image to upload.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Insert into DB
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"INSERT INTO BlogPosts (Title, ImageUrl, Description, PostDate, CommentsCount)
                                 VALUES (@Title, @ImageUrl, @Description, @PostDate, @CommentsCount)";
                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@ImageUrl", "images/blog/" + fileName); // relative path
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@PostDate", Convert.ToDateTime(txtDate.Text));
                cmd.Parameters.AddWithValue("@CommentsCount", Convert.ToInt32(txtComments.Text));

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            lblMsg.Text = "✅ Blog post added successfully!";
            lblMsg.ForeColor = System.Drawing.Color.Green;

            ClearFields();
            LoadBlogPosts();
        }
        catch (Exception ex)
        {
            lblMsg.Text = "❌ Error: " + ex.Message;
            lblMsg.ForeColor = System.Drawing.Color.Red;
        }
    }

    private void LoadBlogPosts()
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT * FROM BlogPosts ORDER BY PostDate DESC";
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }

    private void ClearFields()
    {
        txtTitle.Text = "";
        txtDescription.Text = "";
        txtDate.Text = "";
        txtComments.Text = "";
    }
}
