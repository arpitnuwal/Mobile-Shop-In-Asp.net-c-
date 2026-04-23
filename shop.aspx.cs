using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class shop : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;

    private int CurrentPage
    {
        get { return ViewState["CurrentPage"] == null ? 1 : (int)ViewState["CurrentPage"]; }
        set { ViewState["CurrentPage"] = value; }
    }

    private int PageSize
    {
        get { return ViewState["PageSize"] == null ? 15 : (int)ViewState["PageSize"]; }
        set { ViewState["PageSize"] = value; }
    }

    private string SearchCategory
    {
        get { return ViewState["SearchCategory"] == null ? "" : ViewState["SearchCategory"].ToString(); }
        set { ViewState["SearchCategory"] = value; }
    }

    private string SearchTerm
    {
        get { return ViewState["SearchTerm"] == null ? "" : ViewState["SearchTerm"].ToString(); }
        set { ViewState["SearchTerm"] = value; }
    }

    private string FeatureID
    {
        get { return ViewState["FeatureID"] == null ? "" : ViewState["FeatureID"].ToString(); }
        set { ViewState["FeatureID"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SearchCategory = Request.QueryString["category"] ?? "";
            SearchTerm = Request.QueryString["search"] ?? "";
            FeatureID = Request.QueryString["feature"] ?? "";

            PageSize = int.Parse(ddlPageSize.SelectedValue);

            CurrentPage = 1;
            BindProducts();
        }
    }

    private DataTable GetProducts()
    {
        DataTable dt = new DataTable();

        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"
                SELECT DISTINCT p.* FROM Products p
                LEFT JOIN ProductFeatures pf ON p.ProductID = pf.ProductID
                WHERE p.Status = 1";

            List<string> where = new List<string>();
            List<SqlParameter> param = new List<SqlParameter>();

            if (!string.IsNullOrEmpty(SearchCategory))
            {
                where.Add("p.CategoryID=@CID");
                param.Add(new SqlParameter("@CID", SearchCategory));
            }

            if (!string.IsNullOrEmpty(SearchTerm))
            {
                where.Add("(p.Name LIKE @S OR p.Description LIKE @S)");
                param.Add(new SqlParameter("@S", "%" + SearchTerm + "%"));
            }

            if (!string.IsNullOrEmpty(FeatureID))
            {
                where.Add("pf.FeatureID=@FID");
                param.Add(new SqlParameter("@FID", FeatureID));
            }

            if (where.Count > 0)
                query += " AND " + string.Join(" AND ", where.ToArray());

            query += " ORDER BY p.CreatedAt DESC";

            SqlDataAdapter da = new SqlDataAdapter(query, con);
            da.SelectCommand.Parameters.AddRange(param.ToArray());
            da.Fill(dt);
        }

        return dt;
    }

    private void BindProducts()
    {
        DataTable dt = GetProducts();
        int total = dt.Rows.Count;

        if (total == 0)
        {
            lblShowing.Text = "No products found";
            rptProducts.DataSource = null;
            rptProducts.DataBind();
            rptPager.DataSource = null;
            rptPager.DataBind();
            btnPrev.Enabled = btnNext.Enabled = false;
            return;
        }

        DataView dv = dt.DefaultView;

        if (ddlSort.SelectedValue == "PriceAsc")
            dv.Sort = "Price ASC";
        else if (ddlSort.SelectedValue == "PriceDesc")
            dv.Sort = "Price DESC";
        else
            dv.Sort = "CreatedAt DESC";

        dt = dv.ToTable();

        int totalPages = (int)Math.Ceiling((double)total / PageSize);
        if (CurrentPage > totalPages) CurrentPage = totalPages;
        if (CurrentPage < 1) CurrentPage = 1;

        int start = (CurrentPage - 1) * PageSize;
        int end = Math.Min(start + PageSize, total);

        lblShowing.Text = "Showing " + (start + 1) + "-" + end + " of " + total;
        lblPagingInfo.Text = "Page " + CurrentPage + " of " + totalPages;

        DataTable pageTable = dt.Clone();
        for (int i = start; i < end; i++)
            pageTable.ImportRow(dt.Rows[i]);

        rptProducts.DataSource = pageTable;
        rptProducts.DataBind();


        // ✅ FIXED PAGINATION (Active Class Works Now)
        List<ListItem> pages = new List<ListItem>();
        for (int i = 1; i <= totalPages; i++)
        {
            ListItem li = new ListItem(i.ToString(), i.ToString());

            if (i == CurrentPage)
                li.Selected = true; // ✅ Important for Active CSS
            else
                li.Selected = false;

            pages.Add(li);
        }

        rptPager.DataSource = pages;
        rptPager.DataBind();

        btnPrev.Enabled = CurrentPage > 1;
        btnNext.Enabled = CurrentPage < totalPages;
    }

    protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
    {
        CurrentPage = 1;
        BindProducts();
    }

    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        CurrentPage = 1;
        PageSize = int.Parse(ddlPageSize.SelectedValue);
        BindProducts();
    }

    protected void btnPrev_Click(object sender, EventArgs e)
    {
        CurrentPage--;
        BindProducts();
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        CurrentPage++;
        BindProducts();
    }

    protected void rptPager_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        CurrentPage = Convert.ToInt32(e.CommandArgument);
        BindProducts();
    }

    protected void btnAddToCart_Command(object sender, CommandEventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("userregister.aspx");
            return;
        }

        int productId = Convert.ToInt32(e.CommandArgument);
        int userId = Convert.ToInt32(Session["UserID"]);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();
            SqlCommand chk = new SqlCommand("SELECT COUNT(*) FROM Cart WHERE UserID=@UID AND ProductID=@PID", con);
            chk.Parameters.AddWithValue("@UID", userId);
            chk.Parameters.AddWithValue("@PID", productId);

            if (Convert.ToInt32(chk.ExecuteScalar()) == 0)
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Cart (UserID, ProductID, Quantity) VALUES (@UID,@PID,1)", con);
                cmd.Parameters.AddWithValue("@UID", userId);
                cmd.Parameters.AddWithValue("@PID", productId);
                cmd.ExecuteNonQuery();
            }
            else
            {
                SqlCommand cmd = new SqlCommand("UPDATE Cart SET Quantity = Quantity + 1 WHERE UserID=@UID AND ProductID=@PID", con);
                cmd.Parameters.AddWithValue("@UID", userId);
                cmd.Parameters.AddWithValue("@PID", productId);
                cmd.ExecuteNonQuery();
            }
        }
        Response.Redirect("cart.aspx");
    }

    protected bool IsInWishlist(object productIdObj)
    {
        if (Session["UserID"] == null || productIdObj == null) return false;

        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Wishlist WHERE ProductID=@PID AND UserID=@UID", con);
            cmd.Parameters.AddWithValue("@PID", productIdObj);
            cmd.Parameters.AddWithValue("@UID", Session["UserID"]);
            con.Open();
            return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
        }
    }
}
