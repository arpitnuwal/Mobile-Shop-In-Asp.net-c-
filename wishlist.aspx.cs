using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class wishlist : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("userlogin.aspx");
            return;
        }

        string q = Request.QueryString["productId"];
        if (!string.IsNullOrEmpty(q))
        {
            int pid = 0;
            if (int.TryParse(q, out pid) && pid > 0)
            {
                AddToWishlist(pid);
                BindWishlist();
                Response.Redirect("wishlist.aspx", false);
                return;
            }

        }

        if (!IsPostBack)
        {
            BindWishlist();
        }
    }

    private void BindWishlist()
    {
        int userId = Convert.ToInt32(Session["UserID"]);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();
            string sql = @"SELECT w.WishlistID, p.ProductID, p.Name AS ProductName, 
                           p.Price, p.StockQuantity, p.Image1
                           FROM Wishlist w
                           INNER JOIN Products p ON w.ProductID = p.ProductID
                           WHERE w.UserID=@uid AND w.Status=1";

            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            da.SelectCommand.Parameters.AddWithValue("@uid", userId);

            DataTable dt = new DataTable();
            da.Fill(dt);

            rptWishlist.DataSource = dt;
            rptWishlist.DataBind();

            rptWishlistMobile.DataSource = dt;
            rptWishlistMobile.DataBind();
        }
    }

    private void AddToWishlist(int productId)
    {
        int userId = Convert.ToInt32(Session["UserID"]);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();
            string checkSql = "SELECT COUNT(*) FROM Wishlist WHERE UserID=@uid AND ProductID=@pid AND Status=1";
            SqlCommand checkCmd = new SqlCommand(checkSql, con);
            checkCmd.Parameters.AddWithValue("@uid", userId);
            checkCmd.Parameters.AddWithValue("@pid", productId);

            int exists = (int)checkCmd.ExecuteScalar();
            if (exists > 0) return;

            string insertSql = "INSERT INTO Wishlist(UserID, ProductID, Status) VALUES(@uid, @pid, 1)";
            SqlCommand insertCmd = new SqlCommand(insertSql, con);
            insertCmd.Parameters.AddWithValue("@uid", userId);
            insertCmd.Parameters.AddWithValue("@pid", productId);
            insertCmd.ExecuteNonQuery();
        }
    }

    protected void rptWishlist_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "DeleteItem")
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("UPDATE Wishlist SET Status=0 WHERE WishlistID=@id", con);
                cmd.Parameters.AddWithValue("@id", e.CommandArgument);
                cmd.ExecuteNonQuery();
            }
            BindWishlist();
        }
        else if (e.CommandName == "AddToCart")
        {
            AddToCart(Convert.ToInt32(e.CommandArgument));
        }
    }

    private void AddToCart(int productId)
    {
        int userId = Convert.ToInt32(Session["UserID"]);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            SqlCommand chk = new SqlCommand("SELECT COUNT(*) FROM Cart WHERE UserID=@uid AND ProductID=@pid", con);
            chk.Parameters.AddWithValue("@uid", userId);
            chk.Parameters.AddWithValue("@pid", productId);

            if ((int)chk.ExecuteScalar() == 0)
            {
                SqlCommand ins = new SqlCommand("INSERT INTO Cart(UserID, ProductID, Quantity) VALUES(@uid, @pid, 1)", con);
                ins.Parameters.AddWithValue("@uid", userId);
                ins.Parameters.AddWithValue("@pid", productId);
                ins.ExecuteNonQuery();
            }
            else
            {
                SqlCommand up = new SqlCommand("UPDATE Cart SET Quantity = Quantity + 1 WHERE UserID=@uid AND ProductID=@pid", con);
                up.Parameters.AddWithValue("@uid", userId);
                up.Parameters.AddWithValue("@pid", productId);
                up.ExecuteNonQuery();
            }
        }

        Response.Redirect("cart.aspx");
    }
}
