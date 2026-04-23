<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="shop.aspx.cs" Inherits="shop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

        <!-- ✅ SEO Meta Tags -->
    <title>Shop Mobiles Online | Vishu Mobile Store</title>
    <meta name="description" content="Explore latest smartphones at Vishu Mobile Store. Find top brands, compare prices, and buy mobiles online with fast delivery and easy checkout." />
    <meta name="keywords" content="mobile store, buy mobiles online, smartphone shop, android phones, best price mobiles, Vishu mobile store" />
    <meta name="robots" content="index, follow" />
    <meta name="author" content="Vishu Mobile Store" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- ✅ Open Graph (Social Sharing) -->
    <meta property="og:title" content="Shop Latest Mobiles | Vishu Mobile Store" />
    <meta property="og:description" content="Check out latest smartphones at Vishu Mobile Store. Great deals on top brands with smooth checkout." />
    <meta property="og:image" content="https://yourdomain.com/images/og-shop-banner.jpg" />
    <meta property="og:url" content="https://yourdomain.com/Shop.aspx" />
    <meta property="og:type" content="website" />

    <!-- ✅ Twitter Card -->
    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:title" content="Shop Latest Mobiles | Vishu Mobile Store" />
    <meta name="twitter:description" content="Explore the best mobile phones online with great deals and offers." />
    <meta name="twitter:image" content="https://yourdomain.com/images/og-shop-banner.jpg" />


    <style>
     .flat-pagination.style1 ul.pagination {
    display: inline-flex;
    list-style: none;
    gap: 6px;
    padding: 0;
}

/* Default state - sab normal */
.flat-pagination.style1 ul.pagination li a {
    padding: 10px 15px;
    border-radius: 6px;
    text-decoration: none;
    transition: 0.3s ease;
    background: #ffffff !important;
    color: #ff5e14 !important;
    border: 1px solid #ff5e14;
}

/* Hover */
.flat-pagination.style1 ul.pagination li a:hover {
    background: #ff5e14 !important;
    color: #ffffff !important;
}

/* Active page - sirf yaha special color */
.flat-pagination.style1 ul.pagination li.activa a{
    background: #ff5e14 !important;
    color: #ffffff !important;
    font-weight: bold !important;
    border: 1px solid #ff8a50 !important;
}

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <section class="flat-breadcrumb">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <ul class="breadcrumbs">
                        <li class="trail-item">
                            <a href="index.aspx" title="">Home</a>
                            <span><img src="images/icons/arrow-right.png" alt=""></span>
                        </li>
                        <li class="trail-item">
                            <a href="shop.aspx" title="">Shop</a>
                            <span><img src="images/icons/arrow-right.png" alt=""></span>
                        </li>
                        <li class="trail-end">
                            <a href="#" title=""><asp:Label ID="lblCategoryTitle" runat="server" Text="All Products"></asp:Label></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <main id="shop" class="style2">
        <div class="container">
            <div class="col-md-12">
                <div class="main-shop">
                    <div class="wrap-imagebox">
                        <div class="flat-row-title style4">
                            <h3><asp:Label ID="lblCategoryTitleH3" runat="server" Text="All Products"></asp:Label></h3>
                            <div class="clearfix"></div>
                        </div>
                        <br class="d-lg-none d-sm-none d-block"/>

                        <div class="sort-product style2">
                            <asp:Label ID="lblShowing" runat="server" Text="Showing 0 results"></asp:Label>
                            <div class="sort" style="float:right;">
                                <div class="popularity" style="display:inline-block; margin-right:8px;">
                                    <asp:DropDownList ID="ddlSort" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged">
                                        <asp:ListItem Value="Popular">Sort by popularity</asp:ListItem>
                                        <asp:ListItem Value="PriceAsc">Price: Low to High</asp:ListItem>
                                        <asp:ListItem Value="PriceDesc">Price: High to Low</asp:ListItem>
                                        <asp:ListItem Value="Newest">Newest</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="showed" style="display:inline-block;">
                                    <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                                        <asp:ListItem Value="9">Show 9</asp:ListItem>
                                        <asp:ListItem Value="12">Show 12</asp:ListItem>
                                        <asp:ListItem Value="15" Selected="true">Show 15</asp:ListItem>
                                        <asp:ListItem Value="24">Show 24</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <!-- Product grid (Repeater) -->
                        <div class="row">
                            <asp:Repeater ID="rptProducts" runat="server">
                                <ItemTemplate>
                                    <div class="col-lg-4 col-sm-6" style="float:left; width:33.3333%; box-sizing:border-box; padding:10px;">
                                        <div class="product-box">
                                            <div class="imagebox">
                                                <div class="box-image small-img">
                                                    <a href='<%# ResolveUrl("productdetails.aspx?id=" + Eval("ProductID") + "&from=shop") %>' title="">
                                                        <img src='<%# Eval("Image1") != DBNull.Value ? ResolveUrl("~/uploads/products/") + Eval("Image1") : ResolveUrl("~/images/no-image.png") %>' alt="img" />
                                                    </a>
                                                </div>
                                                <div class="box-content">
                                                    <div class="product-name">
                                                        <a href='productdetails.aspx?productid=<%# Eval("ProductID") %>' title="">
                                                            <%# Eval("Name") %>
                                                        </a>
                                                    </div>
                                                    <div class="price">
                                                        <span class="sale">
                                                            <%# Eval("Price") != DBNull.Value ? String.Format("₹{0:N2}", Eval("Price")) : "" %>
                                                        </span>
                                                        <span class="regular">
                                                            <%# Eval("OldPrice") != DBNull.Value ? String.Format("₹{0:N2}", Eval("OldPrice")) : "" %>
                                                        </span>
                                                    </div>
                                                    <div class="discount-label">
                                                        <%# Eval("DiscountLabel") %>
                                                    </div>
                                                </div>
                                                <div class="box-bottom">
                                                    <div class="btn-add-cart">
                                                        <asp:LinkButton ID="btnAddToCart" runat="server" 
                                                            CommandArgument='<%# Eval("ProductID") %>' 
                                                            OnCommand="btnAddToCart_Command" 
                                                            CssClass="add-cart-btn">
                                                            <img src="images/icons/add-cart.png" alt="">Add to Cart
                                                        </asp:LinkButton>
                                                    </div>
                                                    <div class="compare-wishlist">
                                                        <a href='<%# "wishlist.aspx?productid=" + Eval("ProductID") %>'
                                                            class="wishlist"
                                                            title="">
                                                            <img src='<%# IsInWishlist(Eval("ProductID")) 
                                                                ? "images/icons/wishlist2.png" 
                                                                : "images/icons/wishlist.png" %>' 
                                                                alt="Wishlist" />
                                                            Wishlist
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <div style="clear:both;"></div>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>

                        <!-- Pagination -->
                        <div class="blog-pagination style1" style="margin-top:20px; text-align:center;">
                            <span style="display:block; margin-bottom:10px;">
                                <asp:Label ID="lblPagingInfo" runat="server"></asp:Label>
                            </span>

                            <asp:Panel ID="pnlPager" runat="server" CssClass="flat-pagination style1">
                                <ul class="pagination">
                                    <li>
                                        <asp:LinkButton ID="btnPrev" runat="server"
                                            CssClass="waves-effect"
                                            Text="« Prev"
                                            OnClick="btnPrev_Click" />
                                    </li>

                                    <asp:Repeater ID="rptPager" runat="server" OnItemCommand="rptPager_ItemCommand">
                                        <ItemTemplate>
                                            <li class='<%# ((ListItem)Container.DataItem).Selected ? "activa" : "" %>'>
                                                <asp:LinkButton ID="lnkPage" runat="server"
                                                    Text='<%# Eval("Text") %>'
                                                    CommandName="Page"
                                                    CommandArgument='<%# Eval("Value") %>'
                                                    CssClass="waves-effect" />
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                    <li>
                                        <asp:LinkButton ID="btnNext" runat="server"
                                            CssClass="waves-effect"
                                            Text="Next »"
                                            OnClick="btnNext_Click" />
                                    </li>
                                </ul>
                            </asp:Panel>

                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

</asp:Content>

