<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="forgotpassword.aspx.cs" Inherits="forgotpassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <section class="flat-account background">
    <div class="container">
        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="form-login">
                    <div class="title">
                        <h3>Reset Password 🔐</h3>
                        <p style="font-size:13px;">Enter registered email and we’ll send OTP 📩</p>
                    </div>

                    <div class="form-box">
                        <label>Email Address *</label>
                        <asp:TextBox ID="txtResetEmail" runat="server" CssClass="form-control" Placeholder="Enter your email"></asp:TextBox>
                    </div>

                    <div class="form-box">
                        <asp:Button ID="btnSendOTP" runat="server" CssClass="login btn btn-primary" Text="Send OTP" OnClick="btnSendOTP_Click"/>
                    </div>

                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                </div>
            </div>
        </div>
    </div>
</section>

</asp:Content>

