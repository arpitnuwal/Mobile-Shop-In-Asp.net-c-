<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Adminblog.aspx.cs" Inherits="Adminblog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

       <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f3f4f6;
            padding: 40px;
        }
        .container {
            max-width: 700px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        input[type=text], textarea, input[type=datetime-local] {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        input[type=file] {
            border: none;
        }
        .btn {
            background: #007bff;
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .btn:hover { background: #0056b3; }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        th { background: #007bff; color: white; }
        img { width: 80px; height: auto; border-radius: 8px; }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

      <div class="container">
        <h2>🖋️ Add New Blog Post</h2>

        <div class="form-group">
            <label>Title:</label>
            <asp:TextBox ID="txtTitle" runat="server" />
        </div>

        <div class="form-group">
            <label>Upload Image:</label>
            <asp:FileUpload ID="fileImage" runat="server" />
        </div>

        <div class="form-group">
            <label>Description:</label>
            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" />
        </div>

        <div class="form-group">
            <label>Post Date:</label>
            <asp:TextBox ID="txtDate" runat="server" TextMode="DateTimeLocal" />
        </div>

        <div class="form-group">
            <label>Comments Count:</label>
            <asp:TextBox ID="txtComments" runat="server" />
        </div>

        <asp:Button ID="btnAdd" runat="server" Text="Add Post" CssClass="btn" OnClick="btnAdd_Click" />

        <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>

        <h3>📚 All Blog Posts</h3>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField DataField="PostID" HeaderText="ID" />
                <asp:ImageField DataImageUrlField="ImageUrl" HeaderText="Image" ControlStyle-Width="80" ControlStyle-Height="80" />
                <asp:BoundField DataField="Title" HeaderText="Title" />
                <asp:BoundField DataField="PostDate" HeaderText="Date" DataFormatString="{0:MMM dd, yyyy}" />
                <asp:BoundField DataField="CommentsCount" HeaderText="Comments" />
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>

