using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddTestimonial : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadPendingTestimonials();
        }
    }

    private void LoadPendingTestimonials()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = "SELECT * FROM Testimonials WHERE IsApproved = 0 ORDER BY CreatedAt DESC";
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvTestimonials.DataSource = dt;
            gvTestimonials.DataBind();
        }
    }

    protected void gvTestimonials_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Approve" || e.CommandName == "Reject")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);

            if (rowIndex >= 0 && rowIndex < gvTestimonials.DataKeys.Count)
            {
                int testimonialID = Convert.ToInt32(gvTestimonials.DataKeys[rowIndex].Value);
                int newStatus = e.CommandName == "Approve" ? 1 : 2; // 1 = approved, 2 = rejected

                using (SqlConnection con = new SqlConnection(conStr))
                {
                    string query = "UPDATE Testimonials SET IsApproved=@Status WHERE TestimonialID=@TestimonialID";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Status", newStatus);
                        cmd.Parameters.AddWithValue("@TestimonialID", testimonialID);
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }

                // Refresh GridView
                LoadPendingTestimonials();
            }
        }
    }
}
