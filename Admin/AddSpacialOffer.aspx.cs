using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddSpacialOffer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string fileName = "";
        if (fuImage.HasFile)
        {
            fileName = Guid.NewGuid() + System.IO.Path.GetExtension(fuImage.FileName);
            fuImage.SaveAs(Server.MapPath("~/Uploads/" + fileName));
        }

        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString))
        {
            string query = @"INSERT INTO SpecialOffers
                            (ProductName, OfferTitle, Description, Price, OldPrice, DiscountLabel, ImagePath, ExpiryDate)
                            VALUES (@ProductName, @OfferTitle, @Description, @Price, @OldPrice, @DiscountLabel, @ImagePath, @ExpiryDate)";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text);
            cmd.Parameters.AddWithValue("@OfferTitle", txtOfferTitle.Text);
            cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
            cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtPrice.Text));
            cmd.Parameters.AddWithValue("@OldPrice", string.IsNullOrEmpty(txtOldPrice.Text) ? (object)DBNull.Value : Convert.ToDecimal(txtOldPrice.Text));
            cmd.Parameters.AddWithValue("@DiscountLabel", string.IsNullOrEmpty(txtDiscountLabel.Text) ? (object)DBNull.Value : txtDiscountLabel.Text);
            cmd.Parameters.AddWithValue("@ImagePath", fileName);
            cmd.Parameters.AddWithValue("@ExpiryDate", string.IsNullOrEmpty(txtExpiryDate.Text) ? (object)DBNull.Value : Convert.ToDateTime(txtExpiryDate.Text));

            con.Open();
            cmd.ExecuteNonQuery();
        }

        lblMessage.Text = "✅ Special Offer saved successfully!";
    }

}