<%@ Page Title="Shopping Cart  -  exampl.com" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="cart.aspx.cs" Inherits="cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

      <!-- 🔍 SEO Meta Tags -->
    <meta name="description" content="Check your selected items in the shopping cart before proceeding to checkout. Mobile Nest Bhilwara offers the latest smartphones and accessories at the best prices." />
    <meta name="keywords" content="Mobile Nest Bhilwara, shopping cart, mobiles, checkout, buy smartphones, Bhilwara mobile store" />
    <meta name="robots" content="index, follow" />
    <link rel="canonical" href="https://yourwebsite.com/Cart.aspx" />

    <!-- 💬 Social / Open Graph Tags -->
    <meta property="og:title" content="Shopping Cart | Mobile Nest Bhilwara" />
    <meta property="og:description" content="Review your selected items and proceed to checkout at Mobile Nest Bhilwara." />
    <meta property="og:image" content="https://yourwebsite.com/images/cart-preview.jpg" />
    <meta property="og:url" content="https://yourwebsite.com/Cart.aspx" />
    <meta property="og:type" content="website" />

    <!-- Add any page-specific CSS here -->
    <style>
        .flat-shop-cart {
            padding: 50px 0;
        }
        .flat-row-title h3 {
            font-size: 28px;
            margin-bottom: 30px;
            font-weight: 600;
        }
        .table-cart {
            width: 100%;
            border-collapse: collapse;
        }
        .table-cart th, .table-cart td {
            padding: 15px 10px;
            text-align: left;
            vertical-align: middle;
            border-bottom: 1px solid #e0e0e0;
        }
        .img-product img {
            border-radius: 5px;
        }
        .name-product {
            font-weight: 500;
            margin-top: 5px;
        }
        .price, .total {
            font-weight: 600;
        }
        .quanlity {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        .input-qty {
            width: 70px;
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            text-align: center;
        }
        .btn-update-qty, .checkout {
            padding: 7px 15px;
            border-radius: 5px;
            background-color: #007bff;
            color: black !important;
           
            cursor: pointer;
            
        }
        .btn-update-qty {

          
            padding-bottom: 50px !important;
            margin-right: 8px !important;

        }
        
        .btn-update-qty:hover, .checkout:hover {
            background-color: #f28b00;
            color: white !important;
        }
        .cart-totals {
            padding: 20px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        .cart-totals table {
            width: 100%;
        }
        .cart-totals table td {
            padding: 10px 0;
        }
        .price-total {
            font-weight: 700;
            font-size: 18px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section class="flat-shop-cart">
        <div class="container">
            <div class="row">
                <!-- Cart Items -->
                <div class="col-lg-8">
                    <div class="flat-row-title style1">
                        <h3>Shopping Cart</h3>
                    </div>

                    <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
                        <HeaderTemplate>
                            <table class="table-cart">
                                <thead>
                                    <tr>
                                        <th>Product</th>
                                        <th>Quantity</th>
                                        <th>Total</th>
                                        <th>Remove</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>

                        <ItemTemplate>
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="img-product">
                                            <img src='<%# ResolveUrl("~/Uploads/Products/") + Eval("ImagePath") %>' alt='<%# Eval("Name") %>' width="80" />

                                        </div>
                                        <div>
                                            <div class="name-product"><%# Eval("Name") %></div>
                                            <div class="price">₹<%# Eval("Price") %></div>
                                        </div>
                                    </div>
                                </td>

                                <td>
                                    <div class="quanlity">
                                       <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Quantity") %>' CssClass="input-qty" Attributes="type='number' min='1' max='99'" />

                                        <asp:Button ID="btnUpdateQty" runat="server" CommandName="UpdateQty" CommandArgument='<%# Eval("CartID") %>' Text="Update" CssClass="btn-update-qty w-100" />
                                    </div>
                                </td>

                                <td>
                                   <div class="total">
    ₹<%# (Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))) %>
</div>

                                </td>

                                <td>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteItem" CommandArgument='<%# Eval("CartID") %>'>
                                        <img src="images/icons/delete.png" alt="Delete" />
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>

                        <FooterTemplate>
                                </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>

                <!-- Cart Totals -->
                <div class="col-lg-4">
                    <div class="cart-totals">
                        <h3>Cart Totals</h3>
                        <table>
                            <tbody>
                                <tr>
                                    <td>Subtotal</td>
                                    <td class="subtotal">₹<asp:Label ID="lblSubtotal" runat="server" /></td>
                                </tr>
                                <tr>
                                    <td>Shipping</td>
                                    <td>Free Shipping</td>
                                </tr>
                                <tr>
                                    <td>Total</td>
                                    <td class="price-total">₹<asp:Label ID="lblTotal" runat="server" /></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="mt-3">
                            <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout" CssClass="checkout w-100" OnClick="btnCheckout_Click"/>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>
</asp:Content>
