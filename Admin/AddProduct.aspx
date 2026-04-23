<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AddProduct.aspx.cs" Inherits="AddProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div id="form1" runat="server" class="container mt-5">
        <h2 class="mb-4">Add New Product</h2>

        <div class="mb-3">
            <label class="form-label">Product Name</label>
            <asp:TextBox ID="txtName" CssClass="form-control" runat="server" />
        </div>

        <div class="mb-3">
            <label class="form-label">Category</label>
            <asp:DropDownList ID="ddlCategory" CssClass="form-select" runat="server"></asp:DropDownList>
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <asp:TextBox ID="txtDescription" TextMode="MultiLine" Rows="3" CssClass="form-control" runat="server" />
        </div>

         <div class="row">
    <div class="col-md-6 mb-3">
        <label class="form-label">RAM</label>
        <asp:TextBox ID="txtRAM" CssClass="form-control" runat="server" />
    </div>
    <div class="col-md-6 mb-3">
        <label class="form-label">ROM</label>
        <asp:TextBox ID="txtROM" CssClass="form-control" runat="server" />
    </div>
</div>
         <div class="row">
    <div class="col-md-6 mb-3">
        <label class="form-label">SKU</label>
        <asp:TextBox ID="txtSKU" CssClass="form-control" runat="server" />
    </div>

    <div class="col-md-6 mb-3">
        <label class="form-label">Sim Type</label>
        <asp:TextBox ID="txtSimType" CssClass="form-control" runat="server" />
    </div>

    <div class="col-md-6 mb-3">
        <label class="form-label">Touch Screen</label>
        <asp:TextBox ID="txtTouchScreen" CssClass="form-control" runat="server" />
    </div>

    <div class="col-md-6 mb-3">
        <label class="form-label">Resolution</label>
        <asp:TextBox ID="txtResolution" CssClass="form-control" runat="server" />
    </div>

    <div class="col-md-6 mb-3">
        <label class="form-label">Network Type</label>
        <asp:TextBox ID="txtNetworkType" CssClass="form-control" runat="server" />
    </div>

    <div class="col-md-6 mb-3">
        <label class="form-label">Battery</label>
        <asp:TextBox ID="txtBattery" CssClass="form-control" runat="server" />
    </div>

    <div class="col-md-6 mb-3">
        <label class="form-label">Processor</label>
        <asp:TextBox ID="txtProcessor" CssClass="form-control" runat="server" />
    </div>
</div>

<div class="row">
  <div class="col-md-6 mb-3">
    <label class="form-label">Colors (comma separated)</label>
    <asp:TextBox ID="txtColor" CssClass="form-control" runat="server" 
                 placeholder="Example: Red, Blue, Green, Yellow" />
</div>

    <div class="col-md-6 mb-3">
        <label class="form-label">Size</label>
        <asp:TextBox ID="txtSize" CssClass="form-control" runat="server" />
    </div>
</div>


        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Price</label>
                <asp:TextBox ID="txtPrice" CssClass="form-control" runat="server" />
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Old Price</label>
                <asp:TextBox ID="txtOldPrice" CssClass="form-control" runat="server" />
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">Discount Label (e.g. NEW, SALE)</label>
            <asp:TextBox ID="txtDiscountLabel" CssClass="form-control" runat="server" />
        </div>

        <div class="mb-3">
            <label class="form-label">Stock Quantity</label>
            <asp:TextBox ID="txtStock" CssClass="form-control" runat="server" />
        </div>
         <div class="form-check mb-3">
    <asp:CheckBox ID="chkIsSpecialOffer" CssClass="form-check-input" runat="server" />
    <label class="form-check-label">Is Special Offer?</label>
</div>

<div class="mb-3">
    <label class="form-label">Offer Title</label>
    <asp:TextBox ID="txtOfferTitle" CssClass="form-control" runat="server" />
</div>

<div class="mb-3">
    <label class="form-label">Offer Expiry Date(Optional)</label>
    <asp:TextBox ID="txtExpiryDate" CssClass="form-control" runat="server" placeholder="yyyy-mm-dd" />
</div>


       <div class="mb-3">
    <label class="form-label">Main Image</label>
    <asp:FileUpload ID="fuImage1" CssClass="form-control" runat="server" />
</div>
<div class="mb-3">
    <label class="form-label">Image 2</label>
    <asp:FileUpload ID="fuImage2" CssClass="form-control" runat="server" />
</div>
<div class="mb-3">
    <label class="form-label">Image 3</label>
    <asp:FileUpload ID="fuImage3" CssClass="form-control" runat="server" />
</div>
<div class="mb-3">
    <label class="form-label">Image 4</label>
    <asp:FileUpload ID="fuImage4" CssClass="form-control" runat="server" />
</div>


        <div class="form-check mb-3">
            <asp:CheckBox ID="chkFeatured" CssClass="form-check-input" runat="server" />
            <label class="form-check-label">Featured Product</label>
        </div>
        <div class="form-check mb-3">
            <asp:CheckBox ID="chkTopSelling" CssClass="form-check-input" runat="server" />
            <label class="form-check-label">Top Selling</label>
        </div>

         <div class="form-check mb-3">
            <asp:Label ID="lblFeatures" runat="server" Text="Select Features"></asp:Label> 
<asp:CheckBoxList ID="chkFeatures" runat="server" RepeatColumns="2"></asp:CheckBoxList>

        </div>



        <asp:Button ID="btnSave" runat="server" Text="Save Product" CssClass="btn btn-primary" OnClick="btnSave_Click" />
        <asp:Label ID="lblMessage" runat="server" CssClass="d-block mt-3 text-success"></asp:Label>
    </div>

</asp:Content>

