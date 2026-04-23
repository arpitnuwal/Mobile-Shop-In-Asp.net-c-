using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class myorders : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("userlogin.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            BindOrders(userId);
        }
    }

    private void BindOrders(int userId)
    {
        SqlConnection con = new SqlConnection(connStr);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Orders WHERE UserID=@UserID ORDER BY CreatedAt DESC", con);
            cmd.Parameters.AddWithValue("@UserID", userId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dtOrders = new DataTable();
            da.Fill(dtOrders);

            List<OrderModel> orderList = new List<OrderModel>();

            foreach (DataRow dr in dtOrders.Rows)
            {
                int orderId = Convert.ToInt32(dr["OrderID"]);

                OrderModel order = new OrderModel();
                order.OrderID = orderId;
                order.Status = dr["Status"].ToString();
                order.TotalPrice = Convert.ToDecimal(dr["TotalPrice"]);
                order.OrderItems = GetOrderItems(orderId);

                orderList.Add(order);
            }

            rptOrders.DataSource = orderList;
            rptOrders.DataBind();
        }
        finally
        {
            con.Close();
        }
    }

    private List<OrderItemModel> GetOrderItems(int orderId)
    {
        List<OrderItemModel> items = new List<OrderItemModel>();
        SqlConnection con = new SqlConnection(connStr);

        try
        {
            con.Open();

            string query = "SELECT p.Name, p.Image1, oi.Quantity, oi.Price " +
                           "FROM OrderItems oi " +
                           "INNER JOIN Products p ON oi.ProductID = p.ProductID " +
                           "WHERE oi.OrderID = @OrderID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@OrderID", orderId);

            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                OrderItemModel item = new OrderItemModel();
                item.name = reader["Name"].ToString();
                item.image1 = reader["Image1"].ToString();
                item.Quantity = Convert.ToInt32(reader["Quantity"]);
                item.Price = Convert.ToDecimal(reader["Price"]);
                items.Add(item);
            }
        }
        finally
        {
            con.Close();
        }

        return items;
    }

    protected void btnCancelOrder_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int orderId = Convert.ToInt32(btn.CommandArgument);

        using (SqlConnection con = new SqlConnection(connStr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("UPDATE Orders SET Status='Cancelled' WHERE OrderID=@OrderID AND (Status='Pending' OR Status='Shipped')", con);
            cmd.Parameters.AddWithValue("@OrderID", orderId);
            cmd.ExecuteNonQuery();
        }

        Response.Write("<script>alert('Your order has been cancelled successfully.');</script>");
        int userId = Convert.ToInt32(Session["UserID"]);
        BindOrders(userId);
    }

    public string GetProgressWidth(string status)
    {
        switch (status)
        {
            case "Pending": return "25%";
            case "Shipped": return "60%";
            case "Out for Delivery": return "85%";
            case "Delivered": return "100%";
            case "Cancelled": return "100%";
            default: return "0%";
        }
    }

    public string IsActive(string currentStatus, string step)
    {
        string[] orderFlow = { "Pending", "Shipped", "Out for Delivery", "Delivered" };

        int currentIndex = Array.IndexOf(orderFlow, currentStatus);
        int stepIndex = Array.IndexOf(orderFlow, step);

        if (currentIndex == -1) currentIndex = 0;
        if (stepIndex == -1) stepIndex = 0;

        return (stepIndex <= currentIndex) ? "active" : "";
    }

    // ---------------------- Models ----------------------
    public class OrderModel
    {
        public int OrderID { get; set; }
        public string Status { get; set; }
        public decimal TotalPrice { get; set; }
        public List<OrderItemModel> OrderItems { get; set; }
    }

    public class OrderItemModel
    {
        public string name { get; set; }
        public string image1 { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
    }
}
