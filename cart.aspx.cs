using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class cart : System.Web.UI.Page

{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("userlogin.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl));
        }

        if (!IsPostBack)
        {
            LoadCart();
        }
    }

    private void LoadCart()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"SELECT c.CartID, c.Quantity, p.ProductID, p.Name, p.Price, p.Image1 AS ImagePath
                             FROM Cart c
                             INNER JOIN Products p ON c.ProductID = p.ProductID
                             WHERE c.UserID = @UserID";

            SqlDataAdapter da = new SqlDataAdapter(query, con);
            da.SelectCommand.Parameters.AddWithValue("@UserID", Session["UserID"]);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptCart.DataSource = dt;
            rptCart.DataBind();

            // Calculate totals
            decimal subtotal = 0;
            foreach (DataRow row in dt.Rows)
            {
                subtotal += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
            }

            lblSubtotal.Text = subtotal.ToString("0.00");
            lblTotal.Text = subtotal.ToString("0.00"); // (Add shipping if needed)
        }
    }

    protected void rptCart_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            if (e.CommandName == "DeleteItem")
            {
                string deleteQuery = "DELETE FROM Cart WHERE CartID=@CartID";
                SqlCommand cmd = new SqlCommand(deleteQuery, con);
                cmd.Parameters.AddWithValue("@CartID", e.CommandArgument);
                cmd.ExecuteNonQuery();
            }
            else if (e.CommandName == "UpdateQty")
            {
                TextBox txtQty = (TextBox)e.Item.FindControl("txtQuantity");
                int qty = Convert.ToInt32(txtQty.Text);

                string updateQuery = "UPDATE Cart SET Quantity=@Qty WHERE CartID=@CartID";
                SqlCommand cmd = new SqlCommand(updateQuery, con);
                cmd.Parameters.AddWithValue("@Qty", qty);
                cmd.Parameters.AddWithValue("@CartID", e.CommandArgument);
                cmd.ExecuteNonQuery();
            }

            con.Close();
        }

        LoadCart();
    }
    protected void btnCheckout_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            // Redirect to login/register page
            Response.Redirect("userlogin.aspx?returnUrl=Cart.aspx");
            return;
        }

        // User is logged in -> go to checkout page
        Response.Redirect("checkout.aspx");
    }
}