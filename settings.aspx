<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="settings.aspx.cs" Inherits="settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="stylesheets/style2.css" rel="stylesheet" />

    <!-- ✅ Basic SEO Tags -->
    <title>Account Settings | Vishu Mobile Store</title>
    <meta name="description" content="Manage your Vishu Mobile Store account settings. Update your profile, check orders, or delete your account permanently with one click." />
    <meta name="keywords" content="mobile store account, user settings, delete account, Vishu mobile shop, my account" />
    <meta name="robots" content="index, follow" />
    <meta name="author" content="Vishu Mobile Store" />

    <!-- ✅ Open Graph for Social Sharing -->
    <meta property="og:title" content="Manage Your Account | Vishu Mobile Store" />
    <meta property="og:description" content="Update your profile or delete your account from Vishu Mobile Store settings page." />
    <meta property="og:image" content="https://yourdomain.com/images/user.png" />
    <meta property="og:url" content="https://yourdomain.com/settings.aspx" />
    <meta property="og:type" content="website" />

    <!-- ✅ Mobile Friendly -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <section class="flat-breadcrumb">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <ul class="breadcrumbs">
                        <li class="trail-item">
                            <a href="index.aspx" title="">Home</a>
                            <span><img src="images/icons/arrow-right.png" alt=""></span>
                        </li>
                        <li class="trail-item">
                            <a href="shop.aspx" title="">Shop</a>
                            <span><img src="images/icons/arrow-right.png" alt=""></span>
                        </li>
                        <li class="trail-end">
                            <a href="#" title="">
                                <asp:Label ID="lblCategoryTitle" runat="server" Text="Settings"></asp:Label>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!-- profile section starts -->
    <section class="profile-section section-b-space">
        <div class="container">
            <div class="row g-3">
                <div class="col-lg-3">
                    <div class="profile-sidebar sticky-top">
                        <div class="profile-cover">
                            <asp:Image ID="imgProfile" runat="server" CssClass="img-fluid profile-pic" ImageUrl="~/images/user.png" />
                        </div>
                        <div class="profile-name">
                            <h5 class="user-name"><asp:Label ID="lblNameSide" runat="server" Text=""></asp:Label></h5>
                            <h6><asp:Label ID="lblEmailSide" runat="server" Text=""></asp:Label></h6>
                        </div>
                        <ul class="profile-list">
                            <li class="active"><i class="ri-user-3-line"></i><a href="myaccount.aspx">Change Profile</a></li>
                            <li><i class="ri-shopping-bag-3-line"></i><a href="myorders.aspx">My Orders</a></li>
                            <li><i class="ri-question-line"></i><a href="help.aspx">Help</a></li>
                            <li><i class="ri-settings-3-line"></i><a href="settings.aspx">Setting</a></li>
                        <li><i class="ri-logout-box-r-line"></i>
    <a href="logout.aspx" onclick="return confirm('Are you sure you want to logout?');">Log Out</a>
</li>

                        </ul>
                    </div>
                </div>

                <div class="col-lg-9">
                    <div class="setting-content">
                        <div class="title">
                            <h3>Setting</h3>
                        </div>
                        
                        <!-- Delete Account Section -->
                        <div class="delete-account">
                            <h3 class="fw-medium dark-text">Delete Your Account</h3>
                            <p class="content-color">
                                Hi <span class="dark-text fw-medium"><asp:Label ID="lblUserName" runat="server"></asp:Label></span>,
                            </p>
                            <p class="content-color">
                                Deleting your account will permanently remove your profile,
                                personal settings, and all other data. Once deleted, you’ll be logged out and can’t log in again.
                            </p>

                            <asp:Button ID="btnDeleteAccount" runat="server" Text="Delete My Account"
                                CssClass="btn theme-btn mt-3"
                                OnClick="btnDeleteAccount_Click"
                                OnClientClick="return confirm('Are you sure you want to permanently delete your account?');" />
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- bootstrap js -->
    <script src="assets/js/bootstrap.bundle.min.js"></script>

</asp:Content>
