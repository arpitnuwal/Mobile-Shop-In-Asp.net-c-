using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class contact : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        lblError.Text = "";

        if (string.IsNullOrEmpty(txtFirstName.Text) || string.IsNullOrEmpty(txtLastName.Text) || string.IsNullOrEmpty(txtMessage.Text))
        {
            lblError.Text = "Please fill all required fields.";
            return;
        }

        try
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "INSERT INTO ContactMessages (FirstName, LastName, Subject, Message, CreatedAt) " +
                               "VALUES (@FirstName, @LastName, @Subject, @Message, @CreatedAt)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
                cmd.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
                cmd.Parameters.AddWithValue("@Subject", txtSubject.Text.Trim());
                cmd.Parameters.AddWithValue("@Message", txtMessage.Text.Trim());
                cmd.Parameters.AddWithValue("@CreatedAt", DateTime.Now);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                lblMsg.Text = "✅ Your message has been sent successfully!";
                ClearFields();
            }
        }
        catch (Exception ex)
        {
            lblError.Text = "Error: " + ex.Message;
        }
    }

    private void ClearFields()
    {
        txtFirstName.Text = "";
        txtLastName.Text = "";
        txtSubject.Text = "";
        txtMessage.Text = "";
    }
}
