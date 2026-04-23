using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddSlider : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        int newSliderId = 0;
        string fileName = "";

        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"INSERT INTO Sliders
            (Title, SubTitle, Description, Price, OldPrice, CreatedAt, Status)
            VALUES (@Title, @SubTitle, @Description, @Price, @OldPrice, GETDATE(), 1);
            SELECT SCOPE_IDENTITY();";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Title", txtTitle.Text);
            cmd.Parameters.AddWithValue("@SubTitle", txtSubTitle.Text);
            cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
            cmd.Parameters.AddWithValue("@Price", string.IsNullOrEmpty(txtPrice.Text) ? (object)DBNull.Value : txtPrice.Text);
            cmd.Parameters.AddWithValue("@OldPrice", string.IsNullOrEmpty(txtOldPrice.Text) ? (object)DBNull.Value : txtOldPrice.Text);

            con.Open();
            newSliderId = Convert.ToInt32(cmd.ExecuteScalar());
            con.Close();
        }

        // Save image with SliderID name
        if (fileImage.HasFile && newSliderId > 0)
        {
            string extension = Path.GetExtension(fileImage.FileName);
            fileName = newSliderId + extension; // e.g. 5.jpg
            string serverPath = Server.MapPath("~/Uploads/Sliders/" + fileName);

            fileImage.SaveAs(serverPath);

            // update only filename in DB
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string updateQuery = "UPDATE Sliders SET ImagePath = @ImagePath WHERE SliderID = @SliderID";
                SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                updateCmd.Parameters.AddWithValue("@ImagePath", fileName); // only 5.jpg
                updateCmd.Parameters.AddWithValue("@SliderID", newSliderId);

                con.Open();
                updateCmd.ExecuteNonQuery();
                con.Close();
            }
        }
    }

}