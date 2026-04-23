<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="verifyotp.aspx.cs" Inherits="verifyotp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <section class="flat-account background">
    <div class="container">
        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="form-login">

                    <div class="title">
                        <h3>OTP Verification ✅</h3>
                    </div>

                    <div class="form-box">
                        <label>Enter OTP *</label>
                        <asp:TextBox ID="txtOTP" runat="server" CssClass="form-control" Placeholder="XXXXXX"></asp:TextBox>
                    </div>

                    <div class="form-box">
                        <label>New Password *</label>
                        <asp:TextBox ID="txtNewPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    </div>

                    <div class="form-box">
                        <asp:Button ID="btnVerify" runat="server" CssClass="login btn btn-primary" Text="Reset Password" OnClick="btnVerify_Click" />
                    </div>

                    <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>

                </div>
            </div>
        </div>
    </div>
</section>

</asp:Content>

