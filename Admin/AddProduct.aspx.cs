using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddProduct : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCategories();
            LoadFeatures();
        }
    }

    private void LoadCategories()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand("SELECT CategoryID, CategoryName FROM Categories ", con);
            con.Open();
            ddlCategory.DataSource = cmd.ExecuteReader();
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CategoryID";
            ddlCategory.DataBind();
        }

        ddlCategory.Items.Insert(0, new ListItem("-- Select Category --", "0")); // Required ✅
    }

    private void LoadFeatures()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand("SELECT FeatureID, FeatureName FROM Features WHERE Status = 1", con);
            con.Open();
            chkFeatures.DataSource = cmd.ExecuteReader();
            chkFeatures.DataTextField = "FeatureName";
            chkFeatures.DataValueField = "FeatureID";
            chkFeatures.DataBind();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlCategory.SelectedValue == "0")
        {
            lblMessage.Text = "⚠ Please select a category!";
            return;
        }

        try
        {
            string folderPath = Server.MapPath("~/Uploads/Products/");
            if (!Directory.Exists(folderPath))
                Directory.CreateDirectory(folderPath);

            string img1 = SaveFile(fuImage1, folderPath);
            string img2 = SaveFile(fuImage2, folderPath);
            string img3 = SaveFile(fuImage3, folderPath);
            string img4 = SaveFile(fuImage4, folderPath);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = @"INSERT INTO Products
                (Name, CategoryID, CategoryName, Description, Price, OldPrice, DiscountLabel,
                 Image1, Image2, Image3, Image4, StockQuantity,
                 IsFeatured, IsTopSelling, RAM, ROM, Color, Size,
                 SKU, SimType, TouchScreen, Resolution, NetworkType, Battery, Processor,
                 CreatedAt, UpdatedAt, Status, IsSpecialOffer, OfferExpiryDate, OfferTitle)
                VALUES
                (@Name, @CategoryID, @CategoryName, @Description, @Price, @OldPrice, @DiscountLabel,
                 @Image1, @Image2, @Image3, @Image4, @StockQuantity,
                 @IsFeatured, @IsTopSelling, @RAM, @ROM, @Color, @Size,
                 @SKU, @SimType, @TouchScreen, @Resolution, @NetworkType, @Battery, @Processor,
                 GETDATE(), GETDATE(), 1, @IsSpecialOffer, @OfferExpiryDate, @OfferTitle);
                 SELECT SCOPE_IDENTITY();";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@CategoryID", Convert.ToInt32(ddlCategory.SelectedValue)); // ✅ FIXED HERE
                cmd.Parameters.AddWithValue("@CategoryName", ddlCategory.SelectedItem.Text.Trim());
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtPrice.Text));
                cmd.Parameters.AddWithValue("@OldPrice", string.IsNullOrEmpty(txtOldPrice.Text) ? (object)DBNull.Value : Convert.ToDecimal(txtOldPrice.Text));
                cmd.Parameters.AddWithValue("@DiscountLabel", string.IsNullOrEmpty(txtDiscountLabel.Text) ? (object)DBNull.Value : txtDiscountLabel.Text);

                cmd.Parameters.AddWithValue("@Image1", (object)img1 ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Image2", (object)img2 ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Image3", (object)img3 ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Image4", (object)img4 ?? DBNull.Value);

                cmd.Parameters.AddWithValue("@StockQuantity", Convert.ToInt32(txtStock.Text));
                cmd.Parameters.AddWithValue("@IsFeatured", chkFeatured.Checked);
                cmd.Parameters.AddWithValue("@IsTopSelling", chkTopSelling.Checked);
                cmd.Parameters.AddWithValue("@RAM", string.IsNullOrEmpty(txtRAM.Text) ? (object)DBNull.Value : txtRAM.Text);
                cmd.Parameters.AddWithValue("@ROM", string.IsNullOrEmpty(txtROM.Text) ? (object)DBNull.Value : txtROM.Text);
                cmd.Parameters.AddWithValue("@Color", string.IsNullOrEmpty(txtColor.Text) ? (object)DBNull.Value : txtColor.Text.Trim());
                cmd.Parameters.AddWithValue("@Size", string.IsNullOrEmpty(txtSize.Text) ? (object)DBNull.Value : txtSize.Text);

                cmd.Parameters.AddWithValue("@SKU", string.IsNullOrEmpty(txtSKU.Text) ? (object)DBNull.Value : txtSKU.Text.Trim());
                cmd.Parameters.AddWithValue("@SimType", string.IsNullOrEmpty(txtSimType.Text) ? (object)DBNull.Value : txtSimType.Text.Trim());
                cmd.Parameters.AddWithValue("@TouchScreen", string.IsNullOrEmpty(txtTouchScreen.Text) ? (object)DBNull.Value : txtTouchScreen.Text.Trim());
                cmd.Parameters.AddWithValue("@Resolution", string.IsNullOrEmpty(txtResolution.Text) ? (object)DBNull.Value : txtResolution.Text.Trim());
                cmd.Parameters.AddWithValue("@NetworkType", string.IsNullOrEmpty(txtNetworkType.Text) ? (object)DBNull.Value : txtNetworkType.Text.Trim());
                cmd.Parameters.AddWithValue("@Battery", string.IsNullOrEmpty(txtBattery.Text) ? (object)DBNull.Value : txtBattery.Text.Trim());
                cmd.Parameters.AddWithValue("@Processor", string.IsNullOrEmpty(txtProcessor.Text) ? (object)DBNull.Value : txtProcessor.Text.Trim());

                cmd.Parameters.AddWithValue("@IsSpecialOffer", chkIsSpecialOffer.Checked);
                cmd.Parameters.AddWithValue("@OfferExpiryDate", string.IsNullOrEmpty(txtExpiryDate.Text) ? (object)DBNull.Value : Convert.ToDateTime(txtExpiryDate.Text));
                cmd.Parameters.AddWithValue("@OfferTitle", string.IsNullOrEmpty(txtOfferTitle.Text) ? (object)DBNull.Value : txtOfferTitle.Text);

                con.Open();
                int productId = Convert.ToInt32(cmd.ExecuteScalar());

                foreach (ListItem item in chkFeatures.Items)
                {
                    if (item.Selected)
                    {
                        string insertFeature = "INSERT INTO ProductFeatures (ProductID, FeatureID) VALUES (@ProductID, @FeatureID)";
                        using (SqlCommand cmdFeature = new SqlCommand(insertFeature, con))
                        {
                            cmdFeature.Parameters.AddWithValue("@ProductID", productId);
                            cmdFeature.Parameters.AddWithValue("@FeatureID", Convert.ToInt32(item.Value));
                            cmdFeature.ExecuteNonQuery();
                        }
                    }
                }
            }

            lblMessage.Text = "✅ Product Added Successfully!";
        }
        catch (Exception ex)
        {
            lblMessage.Text = "❌ Error: " + ex.Message;
        }
    }

    private string SaveFile(FileUpload fu, string folderPath)
    {
        if (fu.HasFile)
        {
            string fileName = Guid.NewGuid() + Path.GetExtension(fu.FileName);
            fu.SaveAs(Path.Combine(folderPath, fileName));
            return fileName;
        }
        return null;
    }
}
