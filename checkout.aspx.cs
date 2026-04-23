using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class checkout : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("userregister.aspx?returnUrl=Checkout.aspx");
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
            string query = @"SELECT p.ProductID, p.Name AS ProductName, p.Price, c.Quantity, (p.Price * c.Quantity) AS Total
                             FROM Cart c
                             INNER JOIN Products p ON c.ProductID = p.ProductID
                             WHERE c.UserID = @UserID";

            SqlDataAdapter da = new SqlDataAdapter(query, con);
            da.SelectCommand.Parameters.AddWithValue("@UserID", Session["UserID"]);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvCart.DataSource = dt;
            gvCart.DataBind();

            decimal subTotal = 0;
            foreach (DataRow dr in dt.Rows)
            {
                subTotal += Convert.ToDecimal(dr["Total"]);
            }

            // show rupee sign
            lblSubTotal.Text = "₹" + subTotal.ToString("0.00");

            // Always free shipping now
            decimal shipping = 0.00m;
            lblGrandTotal.Text = "₹" + (subTotal + shipping).ToString("0.00");
        }
    }

    private void UpdateTotals()
    {
        decimal subTotal = 0;
        string subText = (lblSubTotal.Text ?? "0").Replace("₹", "").Trim();
        decimal.TryParse(subText, out subTotal);

        // free shipping only
        decimal shipping = 0.00m;
        lblGrandTotal.Text = "₹" + (subTotal + shipping).ToString("0.00");
    }

    protected void btnPlaceOrder_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtFirstName.Text.Trim()) ||
            string.IsNullOrEmpty(txtLastName.Text.Trim()) ||
            string.IsNullOrEmpty(txtEmail.Text.Trim()) ||
            string.IsNullOrEmpty(txtPhone.Text.Trim()) ||
            string.IsNullOrEmpty(txtAddress.Text.Trim()) ||
            string.IsNullOrEmpty(txtCity.Text.Trim()) ||
            string.IsNullOrEmpty(txtZip.Text.Trim()))
        {
            Response.Write("<script>alert('Please fill all required fields');</script>");
            return;
        }

        if (txtPhone.Text.Trim().Length > 10)
        {
            Response.Write("<script>alert('Phone number cannot be more than 10 digits');</script>");
            return;
        }

        if (!chkTerms.Checked)
        {
            Response.Write("<script>alert('Please accept the terms and conditions');</script>");
            return;
        }

        int userId = Convert.ToInt32(Session["UserID"]);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();
            SqlTransaction tran = con.BeginTransaction();

            try
            {
                string paymentMethod = "Check Payments";
                if (rbCOD.Checked)
                    paymentMethod = "Cash on Delivery";

                string nameWithPhone = string.Format("{0} {1}, {2}",
                    txtFirstName.Text.Trim(), txtLastName.Text.Trim(), txtPhone.Text.Trim());

                string billingAddress = string.Format("{0}, {1}, {2}, {3}, {4}, {5}",
                    nameWithPhone, txtAddress.Text.Trim(), txtCity.Text.Trim(),
                    txtState.Text.Trim(), txtZip.Text.Trim(), ddlCountry.SelectedValue);

                string shippingAddress = billingAddress;

                string orderQuery = @"INSERT INTO Orders(UserID, TotalPrice, PaymentMethod, ShippingAddress, BillingAddress, CreatedAt)
                                      OUTPUT INSERTED.OrderID
                                      VALUES(@UserID, @TotalPrice, @PaymentMethod, @ShippingAddress, @BillingAddress, GETDATE())";

                SqlCommand cmdOrder = new SqlCommand(orderQuery, con, tran);
                cmdOrder.Parameters.AddWithValue("@UserID", userId);

                string grandText = (lblGrandTotal.Text ?? "0").Replace("₹", "").Trim();
                decimal grandTotal = 0;
                decimal.TryParse(grandText, out grandTotal);

                cmdOrder.Parameters.AddWithValue("@TotalPrice", grandTotal);
                cmdOrder.Parameters.AddWithValue("@PaymentMethod", paymentMethod);
                cmdOrder.Parameters.AddWithValue("@ShippingAddress", shippingAddress);
                cmdOrder.Parameters.AddWithValue("@BillingAddress", billingAddress);

                int orderId = Convert.ToInt32(cmdOrder.ExecuteScalar());

                DataTable cartItems = GetCartItems(userId);
                foreach (DataRow row in cartItems.Rows)
                {
                    int productId = Convert.ToInt32(row["ProductID"]);
                    decimal price = Convert.ToDecimal(row["Price"]);
                    int quantity = Convert.ToInt32(row["Quantity"]);
                    decimal total = price * quantity;

                    string itemQuery = @"INSERT INTO OrderItems(OrderID, ProductID, Quantity, Price, Total)
                                         VALUES(@ORDERID, @ProductID, @Quantity, @Price, @Total)";

                    SqlCommand cmdItem = new SqlCommand(itemQuery, con, tran);
                    cmdItem.Parameters.AddWithValue("@ORDERID", orderId);
                    cmdItem.Parameters.AddWithValue("@ProductID", productId);
                    cmdItem.Parameters.AddWithValue("@Quantity", quantity);
                    cmdItem.Parameters.AddWithValue("@Price", price);
                    cmdItem.Parameters.AddWithValue("@Total", total);
                    cmdItem.ExecuteNonQuery();
                }

                string clearCart = "DELETE FROM Cart WHERE UserID = @UserID";
                SqlCommand cmdClear = new SqlCommand(clearCart, con, tran);
                cmdClear.Parameters.AddWithValue("@UserID", userId);
                cmdClear.ExecuteNonQuery();

                tran.Commit();

                Session["OrderSuccess"] = true;
                Session["OrderID"] = orderId;
                Response.Redirect("ordersuccess.aspx?orderId=" + orderId);
            }
            catch (Exception ex)
            {
                tran.Rollback();
                Response.Write("<script>alert('Error while placing order: " + ex.Message + "');</script>");
            }
        }
    }

    private DataTable GetCartItems(int userId)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"SELECT p.ProductID, p.Price, c.Quantity
                             FROM Cart c
                             INNER JOIN Products p ON c.ProductID = p.ProductID
                             WHERE c.UserID = @UserID";

            SqlDataAdapter da = new SqlDataAdapter(query, con);
            da.SelectCommand.Parameters.AddWithValue("@UserID", userId);
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }
    }

    protected void gvCart_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblPrice = e.Row.FindControl("lblPrice") as Label;
            Label lblTotal = e.Row.FindControl("lblTotal") as Label;

            if (lblPrice != null)
            {
                decimal price = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Price"));
                lblPrice.Text = "₹" + price.ToString("0.00");
            }

            if (lblTotal != null)
            {
                decimal total = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Total"));
                lblTotal.Text = "₹" + total.ToString("0.00");
            }
        }
    }
}
