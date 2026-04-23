using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class productdetails : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["id"] != null)
            {
                int productId = Convert.ToInt32(Request.QueryString["id"]);

                LoadProduct(productId);  // ✅ MUST BE FIRST TO DATABIND UI
                LoadProductCategory(productId);
                LoadProducttech(productId);
                LoadColors(productId);
                LoadReviews(productId); // ✅ After databind Stars count will show correctly
            }
            else
            {
                Response.Redirect("shop.aspx");
            }

            liShop.Visible = (Request.QueryString["from"] == "shop");
        }

        LoadTopSellingProducts();
    }

    private void LoadProductCategory(int productId)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = "SELECT CategoryName FROM Products WHERE ProductID = @ProductID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ProductID", productId);
            con.Open();
            lblCategory.Text = Convert.ToString(cmd.ExecuteScalar());
        }
    }

    private void LoadProduct(int productId)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"
SELECT TOP 1 
    P.ProductID, P.Name, P.CategoryName, P.Price, P.OldPrice,
    P.Description, P.SKU, P.StockQuantity, P.Image1, P.Image2, P.Image3, P.Image4,
    (SELECT ISNULL(AVG(Rating), 0) FROM Reviews WHERE ProductID = P.ProductID) AS AverageRating,
    (SELECT COUNT(*) FROM Reviews WHERE ProductID = P.ProductID) AS TotalReviews
FROM Products P
WHERE P.ProductID=@ProductID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ProductID", productId);
            con.Open();

            SqlDataReader dr = cmd.ExecuteReader();
            rptProduct.DataSource = dr;
            rptProduct.DataBind();
        }
    }

    private void LoadColors(int productId)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = "SELECT Color FROM Products WHERE ProductID = @ProductID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ProductID", productId);
            con.Open();

            object colorObj = cmd.ExecuteScalar();
            if (colorObj == null) return;

            foreach (RepeaterItem item in rptProduct.Items)
            {
                DropDownList ddlColor = (DropDownList)item.FindControl("ddlColor");
                if (ddlColor != null)
                {
                    ddlColor.Items.Clear();
                    string[] colors = colorObj.ToString().Split(',');
                    foreach (string c in colors)
                        ddlColor.Items.Add(c.Trim());
                }
            }
        }
    }

    private void LoadProducttech(int productId)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Products WHERE ProductID=@id", con);
            cmd.Parameters.AddWithValue("@id", productId);
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                lblProductName.Text = dr["Name"].ToString();
                lblRAM.Text = dr["RAM"].ToString();
                lblSimType.Text = dr["SimType"].ToString();
                lblTouchScreen.Text = dr["TouchScreen"].ToString();
                lblColor.Text = dr["Color"].ToString();
                lblSize.Text = dr["Size"].ToString();
                lblResolution.Text = dr["Resolution"].ToString();
                lblNetworkType.Text = dr["NetworkType"].ToString();
            }
            dr.Close();
        }
    }

    protected void btnAddToCart_Command(object sender, CommandEventArgs e)
    {
        int productId = Convert.ToInt32(e.CommandArgument);

        if (Session["UserID"] == null)
        {
            Response.Redirect("userlogin.aspx");
            return;
        }

        int userId = Convert.ToInt32(Session["UserID"]);
        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();
            string checkQuery = "SELECT COUNT(*) FROM Cart WHERE UserID=@UserID AND ProductID=@ProductID";
            SqlCommand checkCmd = new SqlCommand(checkQuery, con);
            checkCmd.Parameters.AddWithValue("@UserID", userId);
            checkCmd.Parameters.AddWithValue("@ProductID", productId);

            int exists = Convert.ToInt32(checkCmd.ExecuteScalar());

            if (exists == 0)
            {
                SqlCommand insertCmd = new SqlCommand("INSERT INTO Cart (UserID, ProductID, Quantity) VALUES (@UserID, @ProductID, 1)", con);
                insertCmd.Parameters.AddWithValue("@UserID", userId);
                insertCmd.Parameters.AddWithValue("@ProductID", productId);
                insertCmd.ExecuteNonQuery();
            }
            else
            {
                SqlCommand updateCmd = new SqlCommand("UPDATE Cart SET Quantity = Quantity + 1 WHERE UserID=@UserID AND ProductID=@ProductID", con);
                updateCmd.Parameters.AddWithValue("@UserID", userId);
                updateCmd.Parameters.AddWithValue("@ProductID", productId);
                updateCmd.ExecuteNonQuery();
            }
        }
        Response.Redirect("cart.aspx");
    }

    // ================ REVIEWS SECTION ================
    private void LoadReviews(int productId)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"
SELECT r.ReviewID, r.Rating, r.ReviewTitle, r.ReviewText, r.CreatedAt, u.Email AS FullName
FROM Reviews r
INNER JOIN Users u ON r.UserID = u.UserID
WHERE r.ProductID=@ProductID
ORDER BY r.CreatedAt DESC";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ProductID", productId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptReviews.DataSource = dt;
            rptReviews.DataBind();

            int totalReviews = dt.Rows.Count;
            lblTotalReviews.Text = totalReviews.ToString();

            if (totalReviews > 0)
            {
                double avg = dt.AsEnumerable().Average(r => Convert.ToDouble(r["Rating"]));
                lblAverageScore.Text = avg.ToString("0.0");
                litStars.Text = GetStarsHTML((int)Math.Round(avg));
            }
            else
            {
                lblAverageScore.Text = "0.0";
                litStars.Text = GetStarsHTML(0);
            }
        }
    }

    public string GetStarsHTML(double rating)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        for (int i = 1; i <= 5; i++)
        {
            if (rating >= i)
                sb.Append("<i class='fa fa-star'></i>");
            else
                sb.Append("<i class='fa fa-star' style='color:#ccc'></i>");
        }
        return sb.ToString();
    }

    protected void btnAddReview_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("userregister.aspx");
            return;
        }

        int userId = Convert.ToInt32(Session["UserID"]);
        int productId = Convert.ToInt32(Request.QueryString["id"]);
        int rating = Convert.ToInt32(hfRating.Value);
        string title = txtReviewTitle.Text.Trim();
        string text = txtReviewText.Text.Trim();

        if (rating < 1) rating = 1;

        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(@"
INSERT INTO Reviews (ProductID, UserID, Rating, ReviewTitle, ReviewText, CreatedAt) 
VALUES (@ProductID,@UserID,@Rating,@Title,@Text,GETDATE())", con);

            cmd.Parameters.AddWithValue("@ProductID", productId);
            cmd.Parameters.AddWithValue("@UserID", userId);
            cmd.Parameters.AddWithValue("@Rating", rating);
            cmd.Parameters.AddWithValue("@Title", (object)title ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@Text", text);

            con.Open();
            cmd.ExecuteNonQuery();
        }

        txtReviewTitle.Text = txtReviewText.Text = "";
        hfRating.Value = "0";

        LoadReviews(productId);
    }

    private void LoadTopSellingProducts()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"SELECT TOP 10 ProductID, Name, CategoryName, Price, OldPrice, Image1 
                             FROM Products 
                             WHERE IsTopSelling = 1 AND Status = 1 
                             ORDER BY CreatedAt DESC";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();

            rptTopSelling.DataSource = cmd.ExecuteReader();
            rptTopSelling.DataBind();
        }
    }
}
