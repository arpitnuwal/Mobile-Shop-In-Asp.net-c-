<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AddCategory.aspx.cs" Inherits="AddCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div id="form1" runat="server" class="container mt-5">
        <h2 class="mb-4">Add New Category</h2>

        <div class="mb-3">
            <label class="form-label">Category Name</label> 
            <asp:TextBox ID="txtCategoryName" CssClass="form-control" runat="server" />
        </div>

        <asp:Button ID="btnSave" runat="server" Text="Save Category" CssClass="btn btn-primary" OnClick="btnSave_Click" />
        <asp:Label ID="lblMessage" runat="server" CssClass="d-block mt-3 text-success"></asp:Label>
    </div>

</asp:Content>

