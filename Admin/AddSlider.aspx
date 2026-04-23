<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AddSlider.aspx.cs" Inherits="AddSlider" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div id="form1" runat="server" class="space-y-4 bg-white p-6 rounded-xl shadow-md">
        <h2 class="text-2xl font-bold mb-4">Add New Slider</h2>

        <asp:TextBox ID="txtTitle" runat="server" CssClass="border p-2 w-full" placeholder="Title"></asp:TextBox>
        <asp:TextBox ID="txtSubTitle" runat="server" CssClass="border p-2 w-full" placeholder="Sub Title"></asp:TextBox>
        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="border p-2 w-full" placeholder="Description"></asp:TextBox>

        <asp:TextBox ID="txtPrice" runat="server" CssClass="border p-2 w-full" placeholder="Price"></asp:TextBox>
        <asp:TextBox ID="txtOldPrice" runat="server" CssClass="border p-2 w-full" placeholder="Old Price"></asp:TextBox>


        <asp:FileUpload ID="fileImage" runat="server" CssClass="border p-2 w-full" />
        
        <asp:Button ID="btnSave" runat="server" Text="Save Slider" OnClick="btnSave_Click"
            CssClass="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600" />
    </div>

</asp:Content>

