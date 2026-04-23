using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManageOrders : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindOrders();
        }
    }

    private void BindOrders()
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = @"SELECT o.OrderID, u.Email AS UserEmail, o.TotalPrice, o.Status, o.CreatedAt
                             FROM Orders o
                             INNER JOIN Users u ON o.UserID = u.UserID
                             ORDER BY o.CreatedAt DESC";

            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvOrders.DataSource = dt;
            gvOrders.DataBind();
        }
    }

    protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int orderId = Convert.ToInt32(e.CommandArgument);
        string newStatus = "";

        if (e.CommandName == "Ship")
            newStatus = "Shipped";
        else if (e.CommandName == "OutForDelivery")
            newStatus = "Out for Delivery";
        else if (e.CommandName == "Deliver")
            newStatus = "Delivered";
        else if (e.CommandName == "CancelOrder")
            newStatus = "Cancelled";

        if (newStatus != "")
        {
            UpdateOrderStatus(orderId, newStatus);
            BindOrders();
        }
    }

    protected void gvOrders_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvOrders.EditIndex = -1;
        BindOrders();
    }

    private void UpdateOrderStatus(int orderId, string status)
    {
        string userEmail = "";
        decimal total = 0;

        using (SqlConnection con = new SqlConnection(connStr))
        {
            con.Open();

            string getUser = @"SELECT u.Email, o.TotalPrice 
                               FROM Orders o
                               INNER JOIN Users u ON o.UserID = u.UserID
                               WHERE o.OrderID = @OrderID";
            SqlCommand cmdGet = new SqlCommand(getUser, con);
            cmdGet.Parameters.AddWithValue("@OrderID", orderId);
            SqlDataReader reader = cmdGet.ExecuteReader();

            if (reader.Read())
            {
                userEmail = reader["Email"].ToString();
                total = Convert.ToDecimal(reader["TotalPrice"]);
            }
            reader.Close();

            string update = "UPDATE Orders SET Status = @Status WHERE OrderID = @OrderID";
            SqlCommand cmd = new SqlCommand(update, con);
            cmd.Parameters.AddWithValue("@Status", status);
            cmd.Parameters.AddWithValue("@OrderID", orderId);
            cmd.ExecuteNonQuery();
        }

        if (userEmail != "")
        {
            SendOrderEmail(userEmail, orderId, status, total);
        }
    }

    private void SendOrderEmail(string email, int orderId, string status, decimal total)
    {
        try
        {
            string subject = "";
            string body = "";

            if (status == "Shipped")
            {
                subject = "Your Order #" + orderId + " has been Shipped!";
                body = "<p>Your order #" + orderId + " (₹" + total.ToString("N2") + ") has been <b>shipped</b>!</p>";
            }
            else if (status == "Out for Delivery")
            {
                subject = "Your Order #" + orderId + " is Out for Delivery!";
                body = "<p>Your order #" + orderId + " (₹" + total.ToString("N2") + ") is <b>out for delivery</b>. It’ll reach you soon!</p>";
            }
            else if (status == "Cancelled")
            {
                subject = "Your Order #" + orderId + " has been Cancelled.";
                body = "<p>Your order #" + orderId + " has been <b>cancelled</b>. If this was a mistake, please contact support.</p>";
            }
            else if (status == "Delivered")
            {
                subject = "Your Order #" + orderId + " has been Delivered!";
                body = "<p>Thank you for shopping with MobileNest! Your order #" + orderId + " totaling ₹" + total.ToString("N2") + " has been successfully <b>delivered</b>.</p>";
            }

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("cybervishu055@gmail.com", "MobileNest");
            mail.To.Add(email);
            mail.Subject = subject;
            mail.Body = body;
            mail.IsBodyHtml = true;

            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new NetworkCredential("cybervishu055@gmail.com", "qbxgunyvtwdiczjk");
            smtp.EnableSsl = true;
            smtp.Send(mail);
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Mail Error: " + ex.Message.Replace("'", "") + "');</script>");
        }
    }
}
