using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class about : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTestimonialStats();
            LoadTestimonials();
        }
    }

    protected void btnSubmitReview_Click(object sender, EventArgs e)
    {
        string name = txtName.Text.Trim();
        string email = txtEmail.Text.Trim();
        string comment = txtComment.Text.Trim();
        int rating = int.Parse(hfRating.Value);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = "INSERT INTO Testimonials (Name, Comment, Rating, IsApproved) VALUES (@Name, @Comment, @Rating, 0)";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Comment", comment);
                cmd.Parameters.AddWithValue("@Rating", rating);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        // Reset form and show confirmation
        txtName.Text = txtEmail.Text = txtComment.Text = "";
        hfRating.Value = "0";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Your testimonial has been submitted for admin approval!');", true);
    }

    private void LoadTestimonialStats()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) as TotalTestimonials, ISNULL(AVG(CAST(Rating AS FLOAT)),0) as AvgRating FROM Testimonials WHERE IsApproved=1", con);
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                lblReviewCount.Text = dr["TotalTestimonials"].ToString();
                double average = Convert.ToDouble(dr["AvgRating"]);
                lblAverageScore.Text = average.ToString("0.0");
                DisplayAverageStars(average);
            }
            dr.Close();
        }
    }

    private void DisplayAverageStars(double average)
    {
        string starsHtml = "";
        for (int i = 1; i <= 5; i++)
        {
            if (average >= i)
                starsHtml += "<i class='fa fa-star' style='color:gold'></i>"; // full star
            else if (average > i - 1 && average < i)
                starsHtml += "<i class='fa fa-star-half-o' style='color:gold'></i>"; // half star
            else
                starsHtml += "<i class='fa fa-star-o' style='color:gray'></i>"; // empty star
        }
        litStars.Text = starsHtml;
    }

    private void LoadTestimonials()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = "SELECT TOP 6 Name, Comment, ImageUrl, ISNULL(Rating,0) AS Rating " +
                           "FROM Testimonials WHERE IsApproved = 1 ORDER BY CreatedAt DESC";
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                rptTestimonials.DataSource = dt;
                rptTestimonials.DataBind();
                rptTestimonials.Visible = true;
                lblNoTestimonials.Visible = false;
            }
            else
            {
                rptTestimonials.Visible = false;
                lblNoTestimonials.Visible = true;
            }
        }
    }


    public string GetStarsHtml(object ratingObj)
    {
        double rating = 0;
        if (ratingObj != null)
            double.TryParse(ratingObj.ToString(), out rating);

        string starsHtml = "";
        for (int i = 1; i <= 5; i++)
        {
            if (rating >= i)
                starsHtml += "<i class='fa fa-star' style='color:gold'></i>"; // full star
            else if (rating > i - 1 && rating < i)
                starsHtml += "<i class='fa fa-star-half-alt' style='color:gold'></i>"; // half star
            else
                starsHtml += "<i class='fa fa-star' style='color:gray'></i>"; // empty star
        }
        return starsHtml;
    }

}
