using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
         // Clear all sessions
        Session.Clear();
        Session.RemoveAll();
        Session.Abandon();

        // Optional: clear authentication cookies
        if (Request.Cookies[".ASPXAUTH"] != null)
        {
            Response.Cookies[".ASPXAUTH"].Expires = DateTime.Now.AddDays(-1);
        }

        // Redirect after clearing everything
        Response.Redirect("userlogin.aspx");
    }
    }