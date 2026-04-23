<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="myaccount.aspx.cs" Inherits="myaccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <!-- ✅ SEO Meta for My Account Page -->
    <title>My Account | Mobile Nest - Manage Profile, Orders & Settings</title>
    <meta name="description" content="Access your Mobile Nest account to manage profile details, view orders, change password, and update your contact information. Safe, secure, and mobile-friendly." />
    <meta name="keywords" content="Mobile Nest, my account, user dashboard, manage orders, edit profile, mobile store Bhilwara, customer account" />
    <meta name="robots" content="noindex, follow" />
    <meta name="author" content="Mobile Nest" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- ✅ Open Graph Tags (Optional for Mobile App Preview) -->
    <meta property="og:title" content="My Account | Mobile Nest" />
    <meta property="og:description" content="Manage your account, orders, and personal details easily from your Mobile Nest dashboard." />
    <meta property="og:type" content="profile" />
    <meta property="og:image" content="https://yourwebsite.com/images/profile-banner.jpg" />
    <meta property="og:url" content="https://yourwebsite.com/myaccount.aspx" />

    <!-- ✅ Favicon -->
    <link rel="icon" href="images/favicon.png" type="image/png" />

    <!-- ✅ Existing CSS -->
    <link href="stylesheets/style2.css" rel="stylesheet" />

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
                            <a href="#" title=""><asp:Label ID="lblCategoryTitle" runat="server" Text="All Products"></asp:Label></a>
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
                                <li class="active">
                                    <i class="ri-user-3-line"></i>
                                    <a href="myaccount.aspx">Change Profile</a>
                                </li>
                                <li>
                                    <i class="ri-shopping-bag-3-line"></i>
                                    <a href="myorders.aspx">My Orders</a>
                                </li>
                                <li>
                                    <i class="ri-question-line"></i><a href="help.aspx">Help</a>
                                </li>
                                <li>
                                    <i class="ri-settings-3-line"></i>
                                    <a href="settings.aspx">Setting</a>
                                </li>
                                <li>
                                    <i class="ri-logout-box-r-line"></i>
                                    <a href="logout.aspx">Log Out</a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="col-lg-9">
                        <div class="change-profile-content">
                            <div class="title">
                                <div class="loader-line"></div>
                                <h3>Change Profile</h3>
                            </div>
                            <ul class="profile-details-list">
                                <li>
                                    <div class="profile-content">
                                        <div class="d-flex align-items-center gap-sm-2 gap-1">
                                            <i class="ri-user-3-fill"></i>
                                            <span>Name :</span>
                                        </div>
                                        <h6><asp:Label ID="lblName" runat="server" Text=""></asp:Label></h6>
                                    </div>
                                </li>

                                <li>
                                    <div class="profile-content">
                                        <div class="d-flex align-items-center gap-sm-2 gap-1">
                                            <i class="ri-mail-fill"></i>
                                            <span>Email :</span>
                                        </div>
                                        <h6><asp:Label ID="lblEmail" runat="server" Text=""></asp:Label></h6>
                                    </div>
                                </li>

                                <li>
                                    <div class="profile-content">
                                        <div class="d-flex align-items-center gap-sm-2 gap-1">
                                            <i class="ri-phone-fill"></i>
                                            <span>Phone Number :</span>
                                        </div>
                                        <h6><asp:Label ID="lblPhone" runat="server" Text=""></asp:Label></h6>
                                    </div>
                                </li>

                                <li>
                                    <div class="profile-content">
                                        <div class="d-flex align-items-center gap-sm-2 gap-1">
                                            <i class="ri-lock-2-fill"></i>
                                            <span>Password :</span>
                                        </div>
                                        <h6>********</h6>
                                    </div>
                                    <a href="changepassword.aspx" class="btn theme-outline mt-0">Change</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    <!-- profile section end -->

   
    <!-- footer section end -->


    

    <!-- bootstrap js -->
    <script src="assets/js/bootstrap.bundle.min.js"></script>

 

</asp:Content>

