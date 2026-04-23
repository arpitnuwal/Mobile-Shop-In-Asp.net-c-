using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddBanner : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (fileBanner.HasFile)
        {
            try
            {
                string extension = Path.GetExtension(fileBanner.FileName);

                int newBannerId;

                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();

                    // Step 1: Insert row without image
                    string insertQuery = "INSERT INTO Banners (BannerTitle) OUTPUT INSERTED.BannerID VALUES (@BannerTitle)";
                    SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                    insertCmd.Parameters.AddWithValue("@BannerTitle", txtTitle.Text.Trim());

                    newBannerId = (int)insertCmd.ExecuteScalar();

                    // Step 2: Save image with BannerID name
                    string folderPath = Server.MapPath("~/Uploads/Banners/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    string fileName = newBannerId + extension; // e.g. 1.jpg
                    string filePath = Path.Combine(folderPath, fileName);
                    fileBanner.SaveAs(filePath);

                    // Step 3: Update DB with image name only
                    string updateQuery = "UPDATE Banners SET BannerImage = @BannerImage WHERE BannerID = @BannerID";
                    SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                    updateCmd.Parameters.AddWithValue("@BannerImage", fileName);
                    updateCmd.Parameters.AddWithValue("@BannerID", newBannerId);
                    updateCmd.ExecuteNonQuery();

                    con.Close();
                }

                lblMessage.Text = "✅ Banner added successfully!";
                txtTitle.Text = "";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Error: " + ex.Message;
            }
        }
        else
        {
            lblMessage.Text = "⚠ Please select an image to upload.";
        }
    }


}