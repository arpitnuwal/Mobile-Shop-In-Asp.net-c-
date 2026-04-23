<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AddSpacialOffer.aspx.cs" Inherits="AddSpacialOffer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="p-10 bg-gray-100">
    <div class="space-y-4 max-w-lg mx-auto bg-white p-6 rounded shadow">
        <h2 class="text-2xl font-bold mb-4">Add Special Offer</h2>

        <asp:TextBox ID="txtProductName" runat="server" CssClass="border p-2 w-full" placeholder="Product Name"></asp:TextBox>
        <asp:TextBox ID="txtOfferTitle" runat="server" CssClass="border p-2 w-full" placeholder="Offer Title"></asp:TextBox>
        <asp:TextBox ID="txtDescription" runat="server" CssClass="border p-2 w-full" TextMode="MultiLine" Rows="3" placeholder="Description"></asp:TextBox>
        <asp:TextBox ID="txtPrice" runat="server" CssClass="border p-2 w-full" placeholder="Price"></asp:TextBox>
        <asp:TextBox ID="txtOldPrice" runat="server" CssClass="border p-2 w-full" placeholder="Old Price"></asp:TextBox>
        <asp:TextBox ID="txtDiscountLabel" runat="server" CssClass="border p-2 w-full" placeholder="Discount Label"></asp:TextBox>
        <asp:FileUpload ID="fuImage" runat="server" CssClass="border p-2 w-full" />
        <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="border p-2 w-full" placeholder="Expiry Date (yyyy-mm-dd)"></asp:TextBox>

        <asp:Button ID="btnSave" runat="server" Text="Save Offer" CssClass="bg-blue-600 text-white px-4 py-2 rounded" OnClick="btnSave_Click" />
        <asp:Label ID="lblMessage" runat="server" CssClass="block mt-2 font-semibold"></asp:Label>
    </div>
</div>

</asp:Content>

