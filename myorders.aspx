<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="myorders.aspx.cs" Inherits="myorders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

        <!-- ✅ SEO Meta Tags for My Orders Page -->
    <title>My Orders | Mobile Nest - Track and Manage Your Purchases</title>
    <meta name="description" content="View and track your Mobile Nest orders in real-time. Check your delivery status, product details, and cancel orders easily." />
    <meta name="keywords" content="Mobile Nest, my orders, order tracking, delivery status, online mobile shop, Bhilwara mobile store" />
    <meta name="robots" content="noindex, follow" />
    <meta name="author" content="Mobile Nest" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- ✅ Open Graph (for WhatsApp / Facebook Preview) -->
    <meta property="og:title" content="My Orders | Mobile Nest" />
    <meta property="og:description" content="Track and manage all your Mobile Nest orders in one place. Stay updated with live order status and delivery progress." />
    <meta property="og:type" content="website" />
    <meta property="og:image" content="https://yourdomain.com/images/order-preview.jpg" />
    <meta property="og:url" content="https://yourdomain.com/myorders.aspx" />

     <style>

         /* ---------- Order Tracking Steps ---------- */
.tracking-wrapper {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin: 25px 0;
    position: relative;
}

.tracking-step {
    text-align: center;
    flex: 1;
    position: relative;
}

.circle {
    width: 30px;
    height: 30px;
    line-height: 30px;
    border-radius: 50%;
    display: inline-block;
    background: #ddd;
    color: #555;
    font-weight: 600;
    transition: 0.3s;
}

.tracking-step .label {
    margin-top: 8px;
    font-size: 14px;
    color: #666;
    font-weight: 500;
}

.tracking-line {
    height: 3px;
    flex: 1;
    background: #ddd;
    margin: 0 5px;
    transition: 0.3s;
}

/* Active states */
.circle.active {
    background: #ff7a00;
    color: #fff;
    box-shadow: 0 0 10px rgba(255,122,0,0.4);
}

.tracking-step.active .label {
    color: #ff7a00;
    font-weight: 600;
}

/* Connect active lines */
.tracking-wrapper .tracking-line.filled {
    background: #ff7a00;
}


        * { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI',sans-serif; }
        body { background-color:#f8f8f8; color:#333; }
        .con { max-width:1200px; margin:30px auto; padding:20px; }
        .page-title { font-size:30px; font-weight:700; margin-bottom:30px; color:#ff7a00; border-bottom:3px solid #ff7a00; padding-bottom:8px; }
        .order-card { background:#fff; border-radius:10px; box-shadow:0 2px 10px rgba(0,0,0,0.05); margin-bottom:25px; transition:transform 0.2s ease; }
        .order-card:hover { transform:translateY(-3px); }
        .order-header { background:#fff6ef; padding:15px 20px; border-bottom:1px solid #ffd7b5; display:flex; justify-content:space-between; align-items:center; }
        .order-number { font-size:18px; font-weight:600; color:#333; }
        .status-badge { padding:5px 10px; border-radius:5px; font-weight:500; color:#fff; }
        .Pending { background-color:#f39c12; }
        .Shipped { background-color:#3498db; }
        .Delivered { background-color:#2ecc71; }
        .Cancelled { background-color:#e74c3c; }
        .order-body { padding:20px; }
        .product-item { display:flex; align-items:center; margin-bottom:10px; }
        .product-item img { width:70px; height:70px; border-radius:6px; margin-right:15px; object-fit:cover; }
        .product-details { flex:1; }
        .product-name { font-weight:600; font-size:15px; }
        .product-qty { color:#777; font-size:14px; }
        .price { font-weight:600; color:#ff7a00; }
        .total-amount { margin-top:15px; text-align:right; font-weight:700; color:#2c3e50; }
        .progress-line { height:6px; background:#eaeaea; border-radius:3px; margin:15px 0; position:relative; }
            .cancel-btn {
    background-color: #e74c3c;
    color: #fff;
    border: none;
    padding: 7px 15px;
    border-radius: 5px;
    font-weight: 600;
    cursor: pointer;
    transition: 0.3s;
}
.cancel-btn:hover {
    background-color: #c0392b;
}

         .progress-line .fill { position:absolute; top:0; left:0; height:6px; background:#ff7a00; border-radius:3px; width:0; transition:width 0.5s; }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

      <div class="con">
        <div class="page-title">My Orders</div>

        <asp:Repeater ID="rptOrders" runat="server">
            <ItemTemplate>
                <div class="order-card">
                    <div class="order-header">
                        <div class="order-number">Order #<%# Eval("OrderID") %></div>
                        <span class="status-badge <%# Eval("Status") %>"><%# Eval("Status") %></span>
                    </div>

                    <div class="order-body">

                        <!-- 🔶 Order Tracking -->
                        <div class="tracking-wrapper">
                            <div class="tracking-step">
                                <div class='circle <%# IsActive(Eval("Status").ToString(),"Pending") %>'>1</div>
                                <div class="label">Pending</div>
                            </div>
                            <div class="tracking-line"></div>
                            <div class="tracking-step">
                                <div class='circle <%# IsActive(Eval("Status").ToString(),"Shipped") %>'>2</div>
                                <div class="label">Shipped</div>
                            </div>
                            <div class="tracking-line"></div>
                            <div class="tracking-step">
                                <div class='circle <%# IsActive(Eval("Status").ToString(),"Out for Delivery") %>'>3</div>
                                <div class="label">Out for Delivery</div>
                            </div>
                            <div class="tracking-line"></div>
                            <div class="tracking-step">
                                <div class='circle <%# IsActive(Eval("Status").ToString(),"Delivered") %>'>4</div>
                                <div class="label">Delivered</div>
                            </div>
                        </div>

                        <hr />

                        <!-- 🛒 Product List -->
                        <asp:Repeater ID="rptItems" runat="server" DataSource='<%# Eval("OrderItems") %>'>
                            <ItemTemplate>
                                <div class="product-item">
                                  <img src='<%# ResolveUrl("Uploads/Products/" + Eval("Image1")) %>' 
     class="img-fluid" 
     alt="Product" />

                                    <div class="product-details">
                                        <div class="product-name"><%# Eval("Name") %></div>
                                        <div class="product-qty">Qty: <%# Eval("Quantity") %></div>
                                    </div>
                                    <div class="price">₹ <%# Eval("Price") %></div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                       <div class="total-amount">
    Total: ₹ <%# Eval("TotalPrice") %>
</div>

<!-- Cancel Button for user -->
<div style="text-align:right; margin-top:10px;">
    <asp:Button ID="btnCancelOrder" 
                runat="server" 
                Text="Cancel Order" 
                CssClass="cancel-btn"
                CommandArgument='<%# Eval("OrderID") %>'
                OnClick="btnCancelOrder_Click"
                Visible='<%# Eval("Status").ToString() == "Pending" || Eval("Status").ToString() == "Shipped" %>' />
</div>

                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</asp:Content>

