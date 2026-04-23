using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindSliders();
            LoadBanners();
            LoadCarousel();
            LoadSpecialOffers();
            LoadTopSellingProducts();
            
        }
    }

    private void BindSliders()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"SELECT SliderID, Title, SubTitle, Description, Price, OldPrice, ImagePath 
                             FROM Sliders WHERE Status = 1 ORDER BY CreatedAt DESC";
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptSliders.DataSource = dt;
            rptSliders.DataBind();
        }
    }

    private void LoadBanners()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = "SELECT TOP 3 BannerTitle, BannerImage FROM Banners ORDER BY CreatedDate DESC";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            rptBanners.DataSource = dr;
            rptBanners.DataBind();
        }
    }

    private void LoadCarousel()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"SELECT TOP 10 ProductID, Name AS ProductName, CategoryName, Price, OldPrice, Image1 
                             FROM Products 
                             WHERE Status = 1 
                             ORDER BY CreatedAt DESC";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            rptCarousel.DataSource = cmd.ExecuteReader();
            rptCarousel.DataBind();
        }
    }

    private void LoadSpecialOffers()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"SELECT TOP 3 
                            ProductID,
                            Name AS ProductName,
                            OfferTitle,
                            Description,
                            Price,
                            OldPrice,
                            DiscountLabel,
                            Image2,
                            OfferExpiryDate AS ExpiryDate
                         FROM Products
                         WHERE IsSpecialOffer = 1
                         ORDER BY CreatedAt DESC";

            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            rptSpecialOffers.DataSource = cmd.ExecuteReader();
            rptSpecialOffers.DataBind();
        }
    }


    private void LoadTopSellingProducts()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"SELECT TOP 10 
                                ProductID, 
                                Name AS ProductName,
                                CategoryName, 
                                Price, 
                                OldPrice, 
                                Image1 
                             FROM Products 
                             WHERE IsTopSelling = 1 AND Status = 1 
                             ORDER BY CreatedAt DESC";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();

            rptTopSelling.DataSource = cmd.ExecuteReader();
            rptTopSelling.DataBind();
        }
    }

    protected void btnAddToCart_Command(object sender, CommandEventArgs e)
    {
        int productId = Convert.ToInt32(e.CommandArgument);
        if (Session["UserID"] == null)
        {
            Response.Redirect("userregister.aspx");
            return;
        }

        int userId = Convert.ToInt32(Session["UserID"]);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            // check if already exists
            string checkQuery = "SELECT COUNT(1) FROM Cart WHERE UserID=@UserID AND ProductID=@ProductID";
            SqlCommand checkCmd = new SqlCommand(checkQuery, con);
            checkCmd.Parameters.AddWithValue("@UserID", userId);
            checkCmd.Parameters.AddWithValue("@ProductID", productId);
            int exists = Convert.ToInt32(checkCmd.ExecuteScalar());

            if (exists == 0)
            {
                string insertQuery = "INSERT INTO Cart (UserID, ProductID, Quantity) VALUES (@UserID, @ProductID, 1)";
                SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                insertCmd.Parameters.AddWithValue("@UserID", userId);
                insertCmd.Parameters.AddWithValue("@ProductID", productId);
                insertCmd.ExecuteNonQuery();
            }
            else
            {
                string updateQuery = "UPDATE Cart SET Quantity = Quantity + 1 WHERE UserID=@UserID AND ProductID=@ProductID";
                SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                updateCmd.Parameters.AddWithValue("@UserID", userId);
                updateCmd.Parameters.AddWithValue("@ProductID", productId);
                updateCmd.ExecuteNonQuery();
            }
        }

        // redirect to cart page after adding
        Response.Redirect("cart.aspx");
    }

    protected bool IsInWishlist(object productIdObj)
    {
        try
        {
            if (productIdObj == null) return false;
            int productId = Convert.ToInt32(productIdObj);
            if (Session["UserID"] == null) return false;
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                string sql = "SELECT COUNT(1) FROM Wishlist WHERE ProductID=@PID AND UserID=@UID AND Status=1";
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@PID", productId);
                cmd.Parameters.AddWithValue("@UID", userId);

                con.Open();
                return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
            }
        }
        catch { return false; }
    }

}
