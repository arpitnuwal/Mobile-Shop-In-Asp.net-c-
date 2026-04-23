<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ManageOrders.aspx.cs" Inherits="Admin_ManageOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f7f7f7;
        }
        .container {
            width: 90%;
            margin: 40px auto;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .btn {
            padding: 6px 12px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            color: #fff;
        }
        .ship { background-color: #17a2b8; }
        .out { background-color: #ff9800; }
        .deliver { background-color: #28a745; }
        .cancel { background-color: #dc3545; }
        .btn:hover { opacity: 0.9; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <h2>Manage Orders</h2>

        <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" CssClass="table"
            OnRowCommand="gvOrders_RowCommand"
            OnRowCancelingEdit="gvOrders_RowCancelingEdit">
            <Columns>
                <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
                <asp:BoundField DataField="UserEmail" HeaderText="User Email" />
                <asp:BoundField DataField="TotalPrice" HeaderText="Total (₹)" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:BoundField DataField="CreatedAt" HeaderText="Date" DataFormatString="{0:dd-MM-yyyy}" />
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnShip" runat="server" Text="Ship" CommandName="Ship" CommandArgument='<%# Eval("OrderID") %>' CssClass="btn ship" />
                        <asp:Button ID="btnOut" runat="server" Text="Out for Delivery" CommandName="OutForDelivery" CommandArgument='<%# Eval("OrderID") %>' CssClass="btn out" />
                        <asp:Button ID="btnDeliver" runat="server" Text="Deliver" CommandName="Deliver" CommandArgument='<%# Eval("OrderID") %>' CssClass="btn deliver" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandName="CancelOrder" CommandArgument='<%# Eval("OrderID") %>' CssClass="btn cancel" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
