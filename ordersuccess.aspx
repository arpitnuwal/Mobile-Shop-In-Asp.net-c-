<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="ordersuccess.aspx.cs" Inherits="ordersuccess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

      <!-- ✅ SEO Meta Tags for Order Success Page -->
    <title>Order Placed Successfully | Mobile Nest</title>
    <meta name="description" content="Your order has been placed successfully at Mobile Nest. Thank you for shopping with Bhilwara's most trusted mobile store!" />
    <meta name="keywords" content="Mobile Nest, order success, mobile store Bhilwara, mobile shop, online mobile shopping" />
    <meta name="robots" content="noindex, follow" />
    <meta name="author" content="Mobile Nest" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- ✅ Open Graph Tags -->
    <meta property="og:title" content="Order Placed Successfully | Mobile Nest" />
    <meta property="og:description" content="Thank you for shopping at Mobile Nest! Your order has been successfully placed." />
    <meta property="og:image" content="https://mobilenest.in/images/order-success-banner.jpg" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="https://mobilenest.in/OrderSuccess.aspx" />

    <!-- ✅ Twitter Card -->
    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:title" content="Order Placed Successfully | Mobile Nest" />
    <meta name="twitter:description" content="Your Mobile Nest order has been confirmed. We’ll notify you when it’s on the way!" />
    <meta name="twitter:image" content="https://mobilenest.in/images/order-success-banner.jpg" />


    <style type="text/css">
        /* ✅ Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #fff;
            color: #333;
        }

        .order-success {
            text-align: center;
            padding: 50px 0;
        }

        .success-icon {
            font-size: 80px;
            color: #f7931e;
            margin-bottom: 20px;
            animation: pulse 1.5s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.1); opacity: 0.8; }
            100% { transform: scale(1); opacity: 1; }
        }

        .order-details {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            margin: 30px 0;
            text-align: left;
            box-shadow: 0 4px 20px rgba(247, 147, 30, 0.2);
            border: 1px solid rgba(247, 147, 30, 0.2);
        }

        .order-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .info-label {
            font-weight: 600;
            color: #f7931e;
        }

        .shipping-info {
            margin-top: 25px;
        }

        .shipping-info h4 {
            font-weight: 600;
            color: #f7931e;
            margin-bottom: 10px;
        }

        /* ✅ Table */
        .table-container {
            width: 100%;
            overflow-x: auto;
            margin-top: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(247, 147, 30, 0.25);
        }

        .product {
            width: 100%;
            border-collapse: collapse;
            font-size: 15px;
            background-color: #fff;
            border-radius: 12px;
            overflow: hidden;
        }

        .product th {
            background-color: #f7931e !important;
            color: #fff !important;
            text-align: center;
            padding: 14px 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .product td {
            background-color: #fff !important;
            color: #333 !important;
            padding: 14px 12px;
            border-bottom: 1px solid rgba(247, 147, 30, 0.2);
            text-align: center;
            transition: all 0.2s ease-in-out;
        }

        .product tr:hover td {
            background-color: rgba(247, 147, 30, 0.07) !important;
            transform: scale(1.01);
        }

        .product tr:last-child td {
            border-bottom: none;
        }

        /* ✅ Buttons */
        .action-buttons {
            margin-top: 40px;
        }

        .action-buttons .btn {
            min-width: 170px;
            font-weight: 600;
            border-radius: 30px;
            padding: 10px 18px;
            background-color: #f7931e;
            color: #fff !important;
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
        }

        .action-buttons .btn:hover {
            transform: translateY(-2px);
            background-color: #e67e00;
            box-shadow: 0 4px 10px rgba(247, 147, 30, 0.3);
        }

        /* ✅ Responsive */
        @media (max-width: 768px) {
            .order-details {
                padding: 20px;
            }

            .product th,
            .product td {
                font-size: 14px;
                padding: 10px;
            }

            .action-buttons .btn {
                display: block;
                width: 100%;
                margin-bottom: 12px;
            }

            .action-buttons .btn + .btn {
                margin-left: 0;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <section class="flat-checkout">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="order-success">
                        <div class="success-icon">✓</div>
                        <h2 style="color:#f7931e;">Order Placed Successfully!</h2>
                        <p style="color:#444;">Thank you for your purchase. Your order has been confirmed.</p>

                        <asp:Panel ID="pnlOrderDetails" runat="server" CssClass="order-details">
                            <h3 style="color:#f7931e;">Order Information</h3>
                            <div class="order-info">
                                <div class="info-item">
                                    <strong class="info-label">Order ID:</strong>
                                    <asp:Label ID="lblOrderID" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="info-item">
                                    <strong class="info-label">Order Date:</strong>
                                    <asp:Label ID="lblOrderDate" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="info-item">
                                    <strong class="info-label">Total Amount:</strong>
                                    <asp:Label ID="lblTotalAmount" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="info-item">
                                    <strong class="info-label">Payment Method:</strong>
                                    <asp:Label ID="lblPaymentMethod" runat="server" Text=""></asp:Label>
                                </div>
                            </div>

                            <div class="shipping-info">
                                <h4>Shipping Address</h4>
                                <asp:Label ID="lblShippingAddress" runat="server" Text=""></asp:Label>
                            </div>
                        </asp:Panel>

                        <!-- ✅ Clean Table -->
                        <div class="table-container">
                            <asp:GridView ID="gvOrderItems" runat="server" AutoGenerateColumns="false" CssClass="product" Width="100%"
                                BorderStyle="None" GridLines="Horizontal">
                                <Columns>
                                    <asp:BoundField DataField="ProductName" HeaderText="Product" HeaderStyle-Width="40%" />
                                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" HeaderStyle-Width="20%"
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:TemplateField HeaderText="Price" HeaderStyle-Width="20%">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            ₹<%# Convert.ToDecimal(Eval("Price")).ToString("0.00") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total" HeaderStyle-Width="20%">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            ₹<%# Convert.ToDecimal(Eval("Total")).ToString("0.00") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>

                        <!-- ✅ Buttons -->
                        <div class="action-buttons">
                            <asp:Button ID="btnContinueShopping" runat="server" Text="Continue Shopping" CssClass="btn" OnClick="btnContinueShopping_Click" />
                            <asp:Button ID="btnViewOrders" runat="server" Text="View My Orders" CssClass="btn" OnClick="btnViewOrders_Click" style="margin-left: 10px;" />
                            <asp:Button ID="btnPrintInvoice" runat="server" Text="Print Invoice" CssClass="btn" OnClick="btnPrintInvoice_Click" style="margin-left: 10px;" />
                        </div>
                         <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger" style="margin-top: 20px;">
                            <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
