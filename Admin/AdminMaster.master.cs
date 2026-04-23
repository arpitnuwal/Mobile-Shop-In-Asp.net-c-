using System;
using System.Web;
using System.Web.UI;

public partial class Admin_AdminMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Check admin session
        if (Session["AdminUsername"] == null)
        {
            // Not logged in → redirect to login page
            Response.Redirect("Adminlogin.aspx");
        }
    }
}
