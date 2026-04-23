<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="wishlist.aspx.cs" Inherits="wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

       <!-- ✅ SEO Meta Tags -->
    <title>My Wishlist | MobileNest - Save Your Favourite Phones & Accessories</title>
    <meta name="description" content="View your saved mobile phones, accessories, and favourite tech gadgets at MobileNest. Add them to cart anytime and continue your shopping journey." />
    <meta name="keywords" content="wishlist, MobileNest wishlist, saved items, favourite mobiles, online mobile store, smartphone wishlist, MobileNest Bhilwara" />
    <meta name="robots" content="index, follow" />
    <meta name="author" content="MobileNest" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- ✅ Open Graph (Facebook, WhatsApp Preview) -->
    <meta property="og:title" content="My Wishlist | MobileNest" />
    <meta property="og:description" content="All your saved smartphones and accessories in one place. Continue shopping from your wishlist with ease." />
    <meta property="og:image" content="https://yourdomain.com/images/og-wishlist-banner.jpg" />
    <meta property="og:url" content="https://yourdomain.com/Wishlist.aspx" />
    <meta property="og:type" content="website" />

    <!-- ✅ Twitter Card -->
    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:title" content="My Wishlist | MobileNest" />
    <meta name="twitter:description" content="Access your wishlist on MobileNest — your saved phones and accessories are just one click away!" />
    <meta name="twitter:image" content="https://yourdomain.com/images/og-wishlist-banner.jpg" />

<style>
    /* Desktop default */
    .desktop-wishlist { display:block; }
    .mobile-wishlist { display:none; }

    /* Mobile view */
    @media(max-width:768px){
        .desktop-wishlist { display:none; }
        .mobile-wishlist { display:block; }
    }
</style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<section class="flat-breadcrumb">
    <div class="container">
        <ul class="breadcrumbs">
            <li class="trail-item"><a href="index.aspx">Home</a></li>
            <li class="trail-item"><a href="shop.aspx">Shop</a></li>
            <li class="trail-end"><a href="#">Wishlist</a></li>
        </ul>
    </div>
</section>

<section class="flat-wishlist">
    <div class="container">
        <div class="wishlist">
            <div class="title"><h3>My wishlist</h3></div>

            <!-- ✅ Desktop + Tablet -->
            <div class="wishlist-content desktop-wishlist">
                <table class="table-wishlist">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Unit Price</th>
                            <th>Stock</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptWishlist" runat="server" OnItemCommand="rptWishlist_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <div class="delete">
                                            <asp:LinkButton ID="btnDelete" runat="server"
                                                CommandName="DeleteItem"
                                                CommandArgument='<%# Eval("WishlistID") %>'
                                                OnClientClick="return confirm('Remove this item?');">
                                                <img src="images/icons/delete.png" alt="" />
                                            </asp:LinkButton>
                                        </div>

                                        <div class="product">
                                            <img src='<%# ResolveUrl("~/Uploads/Products/" + Eval("Image1")) %>'
                                                 class="had-se-bhi-jyda-choti-img" />
                                            <span><%# Eval("ProductName") %></span>
                                        </div>
                                    </td>

                                    <td>₹<%# Eval("Price") %></td>

                                    <td><%# Convert.ToInt32(Eval("StockQuantity")) > 0 ? "In Stock" : "Out Of Stock" %></td>

                                    <td>
                                        <asp:LinkButton ID="btnAddToCart" runat="server"
                                            CommandName="AddToCart"
                                            CommandArgument='<%# Eval("ProductID") %>'>
                                            <img src="images/icons/add-cart.png" /> Add to Cart
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>

            <!-- ✅ Mobile Layout -->
            <div class="mobile-wishlist">
                <asp:Repeater ID="rptWishlistMobile" runat="server" OnItemCommand="rptWishlist_ItemCommand">
                    <ItemTemplate>
                        <div class="mobile-wishlist-item" style="padding:12px; background:#fff; margin-bottom:15px; border-radius:8px; box-shadow:0 0 10px #00000010;">
                            
                            <div style="display:flex; justify-content:space-between;">
                                <img src='<%# ResolveUrl("~/Uploads/Products/" + Eval("Image1")) %>'
                                     style="width:70px; border-radius:6px;" />

                                <asp:LinkButton ID="btnDeleteMob" runat="server"
                                    CommandName="DeleteItem"
                                    CommandArgument='<%# Eval("WishlistID") %>'>
                                    <img src="images/icons/delete.png" style="width:20px;" />
                                </asp:LinkButton>
                            </div>

                            <div style="margin-top:10px; font-weight:bold;">
                                <%# Eval("ProductName") %>
                            </div>

                            <div style="color:#ff5e14; font-size:18px; font-weight:600;">
                                ₹<%# Eval("Price") %>
                            </div>

                            <div style="font-size:14px;">
                                <%# Convert.ToInt32(Eval("StockQuantity")) > 0 ? "In Stock ✅" : "Out Of Stock ❌" %>
                            </div>

                            <asp:LinkButton ID="btnAddToCartMob" runat="server"
                                CommandName="AddToCart"
                                CommandArgument='<%# Eval("ProductID") %>'
                                style="margin-top:10px; display:inline-block; background:#ff5e14; padding:8px 18px; border-radius:6px; color:#fff;">
                                <img src="images/icons/add-cart.png" style="width:16px; margin-right:6px;" />
                                Add to Cart
                            </asp:LinkButton>

                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

        </div>
    </div>
</section>

</asp:Content>
