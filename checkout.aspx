<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="checkout.aspx.cs" Inherits="checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <meta name="description" content="Complete your order securely at Mobile Nest Bhilwara. Fast delivery, easy checkout, and the latest smartphones at the best prices." />
    <meta name="keywords" content="Mobile Nest Bhilwara checkout, buy mobiles Bhilwara, mobile order, smartphone payment, online checkout Bhilwara" />
    <meta name="robots" content="index, follow" />
    <link rel="canonical" href="https://yourwebsite.com/Checkout.aspx" />

    <!-- 💬 Social / Open Graph Tags -->
    <meta property="og:title" content="Checkout | Mobile Nest Bhilwara" />
    <meta property="og:description" content="Finalize your mobile order with quick and secure checkout. Mobile Nest Bhilwara – trusted mobile store." />
    <meta property="og:image" content="https://yourwebsite.com/images/checkout-preview.jpg" />
    <meta property="og:url" content="https://yourwebsite.com/Checkout.aspx" />
    <meta property="og:type" content="website" />


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<section class="flat-checkout">
    <div class="container">
        <div class="row">

            <!-- Billing Info -->
            <div class="col-md-7">
                <div class="box-checkout">
                    <h3 class="title">Checkout</h3>
                    <div class="checkout-login">
                        Returning customer? <a href="UserLogin.aspx">Click here to login</a>
                    </div>
                    <div id="form1" runat="server" class="checkout">
                        <div class="billing-fields">
                            <div class="fields-title">
                                <h3>Billing details</h3>
                                <span></span>
                                <div class="clearfix"></div>
                            </div>
                            <div class="fields-content">
                                <div class="field-row">
                                    <p class="field-one-half">
                                        <asp:TextBox ID="txtFirstName" runat="server" placeholder="First Name"></asp:TextBox>
                                    </p>
                                    <p class="field-one-half">
                                        <asp:TextBox ID="txtLastName" runat="server" placeholder="Last Name"></asp:TextBox>
                                    </p>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="field-row">
                                    <asp:TextBox ID="txtCompany" runat="server" placeholder="Company Name (optional)"></asp:TextBox>
                                </div>

                                <div class="field-row">
                                    <p class="field-one-half">
                                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Email"></asp:TextBox>
                                    </p>
                                    <p class="field-one-half">
                                        <asp:TextBox ID="txtPhone" runat="server" placeholder="Phone"></asp:TextBox>
                                    </p>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="field-row">
                                    <asp:DropDownList ID="ddlCountry" runat="server">
                                        <asp:ListItem>Australia</asp:ListItem>
                                        <asp:ListItem>USA State</asp:ListItem>
                                        <asp:ListItem>Spain</asp:ListItem>
                                        <asp:ListItem>Vietnam</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <div class="field-row">
                                    <asp:TextBox ID="txtAddress" runat="server" placeholder="Street address"></asp:TextBox>
                                    <asp:TextBox ID="txtAddress2" runat="server" placeholder="Apartment, suite, unit etc. (optional)"></asp:TextBox>
                                </div>

                                <div class="field-row">
                                    <asp:TextBox ID="txtCity" runat="server" placeholder="Town / City"></asp:TextBox>
                                </div>

                                <div class="field-row">
                                    <p class="field-one-half">
                                        <asp:TextBox ID="txtState" runat="server" placeholder="State / County"></asp:TextBox>
                                    </p>
                                    <p class="field-one-half">
                                        <asp:TextBox ID="txtZip" runat="server" placeholder="Postcode / ZIP"></asp:TextBox>
                                    </p>
                                    <div class="clearfix"></div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Order Summary -->
            <div class="col-md-5">
    <div class="cart-totals style2">
        <h3>Your Order</h3>

        <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" CssClass="product" DataKeyNames="ProductID" OnRowDataBound="gvCart_RowDataBound">
            <Columns>
                <asp:BoundField DataField="ProductName" HeaderText="Product" />
                <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                <asp:TemplateField HeaderText="Price">
                    <ItemTemplate>
                        <asp:Label ID="lblPrice" runat="server" 
                            Text='<%# "₹" + Eval("Price") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total">
                    <ItemTemplate>
                        <asp:Label ID="lblTotal" runat="server" 
                            Text='<%# "₹" + Eval("Total") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <table>
            <tbody>
                <tr>
                    <td>Subtotal</td>
                    <td class="subtotal">
                        <asp:Label ID="lblSubTotal" runat="server" Text="₹0"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Shipping</td>
                    <td class="btn-radio">
                       
                        <div class="radio-info">
                     Free Shipping
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Total</td>
                    <td class="price-total">
                        <asp:Label ID="lblGrandTotal" runat="server" Text="₹0"></asp:Label>
                    </td>
                </tr>
            </tbody>
        </table>

        <div class="btn-radio style2">
           
            <div class="radio-info">
                <asp:RadioButton ID="rbCOD" runat="server" GroupName="payment" Text="Cash on Delivery" />
            </div>
         
        </div>

        <div class="checkbox">
            <asp:CheckBox ID="chkTerms" runat="server" Text="I've read and accept the terms & conditions *" />
        </div>

        <div class="btn-order">
            <asp:Button ID="btnPlaceOrder" runat="server" CssClass="order" Text="Place Order" OnClick="btnPlaceOrder_Click" />
        </div>

    </div>
</div>


        </div>
    </div>
</section>

</asp:Content>
