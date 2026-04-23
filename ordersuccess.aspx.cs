using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ordersuccess : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("userregister.aspx");
            return;
        }

        if (!IsPostBack)
        {
            if (Session["OrderSuccess"] != null && (bool)Session["OrderSuccess"])
            {
                string orderId = Request.QueryString["orderId"];
                if (!string.IsNullOrEmpty(orderId))
                {
                    LoadOrderDetails(orderId);
                    Session["OrderSuccess"] = false; // Reset the flag
                }
                else
                {
                    ShowError("Order ID not found.");
                }
            }
            else
            {
                // If coming directly without going through checkout, try to get latest order
                string orderId = Request.QueryString["orderId"];
                if (!string.IsNullOrEmpty(orderId))
                {
                    LoadOrderDetails(orderId);
                }
                else
                {
                    Response.Redirect("index.aspx");
                }
            }
        }

    }

    private void LoadOrderDetails(string orderId)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                // Get order details
                string orderQuery = @"SELECT o.OrderID, o.TotalPrice, o.PaymentMethod, o.ShippingAddress, o.BillingAddress, o.CreatedAt
                                      FROM Orders o
                                      WHERE o.OrderID = @OrderID AND o.UserID = @UserID";

                SqlCommand cmd = new SqlCommand(orderQuery, con);
                cmd.Parameters.AddWithValue("@OrderID", orderId);
                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // Display order information
                    lblOrderID.Text = reader["OrderID"].ToString();
                    lblOrderDate.Text = Convert.ToDateTime(reader["CreatedAt"]).ToString("MMMM dd, yyyy");
                    lblTotalAmount.Text = "₹" + Convert.ToDecimal(reader["TotalPrice"]).ToString("0.00");

                    lblPaymentMethod.Text = reader["PaymentMethod"].ToString();
                    lblShippingAddress.Text = reader["ShippingAddress"].ToString();

                    pnlOrderDetails.Visible = true;
                    reader.Close();

                    // Load order items
                    LoadOrderItems(orderId);
                }
                else
                {
                    reader.Close();
                    ShowError("Order not found or you don't have permission to view this order.");
                }
            }
        }
        catch (Exception ex)
        {
            ShowError("Error loading order details: " + ex.Message);
        }
    }

    private void LoadOrderItems(string orderId)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string itemsQuery = @"SELECT p.Name AS ProductName, oi.Quantity, oi.Price, oi.Total
                                  FROM OrderItems oi
                                  INNER JOIN Products p ON oi.ProductID = p.ProductID
                                  WHERE oi.OrderID = @OrderID";

            SqlDataAdapter da = new SqlDataAdapter(itemsQuery, con);
            da.SelectCommand.Parameters.AddWithValue("@OrderID", orderId);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvOrderItems.DataSource = dt;
            gvOrderItems.DataBind();
        }
    }

    private void ShowError(string message)
    {
        pnlError.Visible = true;
        lblError.Text = message;
        pnlOrderDetails.Visible = false;
    }

    protected void btnContinueShopping_Click(object sender, EventArgs e)
    {
        Response.Redirect("shop.aspx");
    }

    protected void btnViewOrders_Click(object sender, EventArgs e)
    {
        Response.Redirect("myorders.aspx");
    }

    protected void btnPrintInvoice_Click(object sender, EventArgs e)
    {
        string orderId = lblOrderID.Text;
        if (!string.IsNullOrEmpty(orderId))
        {
            // Open print-friendly version or generate PDF
            Response.Write("<script>window.print();</script>");

            // Alternatively, you can redirect to a print-friendly page:
            // Response.Redirect("PrintInvoice.aspx?orderId=" + orderId);
        }
    }

    protected void gvOrderItems_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            // Add CSS classes to header
            e.Row.CssClass = "table-header";
        }
        else if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // Add CSS classes to data rows
            e.Row.CssClass = "table-row";
        }
    }


}