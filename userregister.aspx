<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="userregister.aspx.cs" Inherits="userregister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    	<section class="flat-account background">
    <div class="container">
				<div class="row">
                    	<div class="col-md-6 mx-auto mb-4">
						<div class="form-register">
    <div class="title">
        <h3>Register</h3>
    </div>
    <asp:Panel ID="pnlRegister" runat="server">
        <div class="form-box">
            <label>Email address *</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-box">
            <label>Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
        </div>
        <a href="UserLogin.aspx">Already A user</a>
        <div class="form-box">
            <asp:Button ID="btnSendOtp" runat="server" Text="Send OTP" CssClass="register" OnClick="btnSendOtp_Click" />
        </div>
    </asp:Panel>

    <!-- OTP Verification Panel -->
    <asp:Panel ID="pnlOtp" runat="server" Visible="false">
        <div class="form-box">
            <label>Enter OTP</label>
            <asp:TextBox ID="txtOtp" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-box">
            <asp:Button ID="btnVerifyOtp" runat="server" Text="Verify & Register" CssClass="register" OnClick="btnVerifyOtp_Click" />
        </div>
    </asp:Panel>
</div>
<!-- /.form-register -->
					</div><!-- /.col-md-6 -->
                    </div>
        </div>
            </section>

</asp:Content>

