<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="changepassword.aspx.cs" Inherits="changepassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        body {
            background: #f3f4f6;
        }
        .change-pass-container {
            max-width: 500px;
            margin: 60px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .change-pass-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
            font-weight: 600;
        }
        .form-control {
            border-radius: 8px;
            padding: 10px;
            width: 100%;
            border: 1px solid #ccc;
        }
        .theme-btn {
            width: 100%;
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px;
            border-radius: 8px;
            margin-top: 10px;
            transition: 0.3s;
        }
        .theme-btn:hover {
            background-color: #ff6a00;
            color: white;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="change-pass-container">
        <h2>Change Password</h2>
        <div class="form-group">
            <label>Current Password</label><br />
            <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Enter your current password"></asp:TextBox>
        </div>

        <div class="form-group mt-3" style="margin-top:15px;">
            <label>New Password</label><br />
            <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Enter your new password"></asp:TextBox>
        </div>

        <div class="form-group mt-3" style="margin-top:15px;">
            <label>Confirm Password</label><br />
            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Confirm your new password"></asp:TextBox>
        </div>

        <asp:Button ID="btnSave" runat="server" Text="Save Password" CssClass="theme-btn" OnClick="btnSave_Click" />
    </div>
</asp:Content>
