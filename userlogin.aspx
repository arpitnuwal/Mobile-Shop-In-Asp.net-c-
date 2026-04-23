<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="userlogin.aspx.cs" Inherits="userlogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <!-- ✅ SEO Meta Tags -->
    <title>Login | MobileNest - Sign in to Your Account</title>
    <meta name="description" content="Login to your MobileNest account to track orders, manage wishlist, and shop the latest smartphones and accessories hassle-free." />
    <meta name="keywords" content="MobileNest login, user login, smartphone store login, Bhilwara mobile shop, MobileNest account, online mobile store" />
    <meta name="robots" content="index, follow" />
    <meta name="author" content="MobileNest" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- ✅ Open Graph (Facebook, WhatsApp, etc.) -->
    <meta property="og:title" content="Login | MobileNest" />
    <meta property="og:description" content="Access your MobileNest account — manage your orders, wishlist, and shop confidently." />
    <meta property="og:image" content="https://yourdomain.com/images/og-login-banner.jpg" />
    <meta property="og:url" content="https://yourdomain.com/UserLogin.aspx" />
    <meta property="og:type" content="website" />

    <!-- ✅ Twitter Card -->
    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:title" content="Login | MobileNest" />
    <meta name="twitter:description" content="Sign in to MobileNest and continue your mobile shopping journey with ease." />
    <meta name="twitter:image" content="https://yourdomain.com/images/og-login-banner.jpg" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    	<section class="flat-account background">
			<div class="container">
				<div class="row">
      <div class="col-md-6 mx-auto">
            <div class="form-login">
                <div class="title">
                    <h3>Login</h3>
                </div>
                
                <div class="form-box">
                    <label for="txtEmail">Username or Email *</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Username Or Email"></asp:TextBox>
                </div>

                <div class="form-box">
                    <label for="txtPassword">Password *</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="******"></asp:TextBox>
                </div>

                <div class="form-box checkbox">
                     <a href="forgotpassword.aspx" title="">Lost your password?</a>
                </div>

                <div class="form-box">
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="login btn btn-primary" OnClick="btnLogin_Click" />
                   
                </div>

            </div>
        </div><!-- /.col-md-6 -->
                    </div>
                </div>
            </section>
</asp:Content>

