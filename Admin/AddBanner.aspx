<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AddBanner.aspx.cs" Inherits="AddBanner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="bg-gray-100">
    <div class="max-w-xl mx-auto mt-10 bg-white p-6 rounded-xl shadow-lg">
        <h2 class="text-2xl font-bold mb-4">Add New Banner</h2>

        <label class="block mb-2 font-medium">Banner Title:</label>
        <asp:TextBox ID="txtTitle" runat="server" CssClass="border rounded w-full p-2 mb-4"></asp:TextBox>

        <label class="block mb-2 font-medium">Upload Banner Image:</label>
        <asp:FileUpload ID="fileBanner" runat="server" CssClass="mb-4" />

        <asp:Button ID="btnSave" runat="server" Text="Save Banner" 
            CssClass="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700" 
            OnClick="btnSave_Click" />

        <asp:Label ID="lblMessage" runat="server" CssClass="block mt-4 text-green-600 font-semibold"></asp:Label>
    </div>
</div>

</asp:Content>

