<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AddFeatures.aspx.cs" Inherits="AddFeatures" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="container mt-5">
        <h2 class="mb-4">Add New Feature</h2>

        <div class="mb-3">
            <label class="form-label">Feature Name</label>
            <asp:TextBox ID="txtFeatureName" CssClass="form-control" runat="server" />
        </div>

        <div class="mb-3">
            <label class="form-label">Feature URL (optional)</label>
            <asp:TextBox ID="txtUrl" CssClass="form-control" runat="server" />
        </div>

        <div class="form-check mb-3">
            <asp:CheckBox ID="chkActive" CssClass="form-check-input" runat="server" Checked="true" />
            <label class="form-check-label">Active</label>
        </div>

        <asp:Button ID="btnSave" runat="server" Text="Save Feature" CssClass="btn btn-primary" OnClick="btnSave_Click" />
        <asp:Label ID="lblMessage" runat="server" CssClass="d-block mt-3 text-success"></asp:Label>
    </div>

</asp:Content>

