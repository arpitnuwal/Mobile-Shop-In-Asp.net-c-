<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="contact.aspx.cs" Inherits="contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <!-- SEO Meta Tags -->
    <title>Contact Us | Mobile Nest Bhilwara</title>
    <meta name="description" content="Get in touch with Mobile Nest Bhilwara — your trusted mobile store for smartphones, accessories, and repairs. Visit or call us for any query.">
    <meta name="keywords" content="Mobile Nest Bhilwara, contact Mobile Nest, mobile shop Bhilwara, smartphone accessories, best mobile store Bhilwara">
    <meta name="author" content="Mobile Nest Bhilwara">
    <meta name="robots" content="index, follow">
    <link rel="canonical" href="https://mobilenestbhilwara.com/contact.aspx" />

    <!-- Open Graph (for social media preview) -->
    <meta property="og:title" content="Contact Mobile Nest | Best Mobile Store in Bhilwara">
    <meta property="og:description" content="Need help or have a question? Contact Mobile Nest — your one-stop shop for mobiles and accessories in Bhilwara.">
    <meta property="og:image" content="https://mobilenestbhilwara.com/images/store-front.jpg">
    <meta property="og:url" content="https://mobilenestbhilwara.com/contact.aspx">
    <meta property="og:type" content="website">

    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="Contact Mobile Nest | Bhilwara's Trusted Mobile Store">
    <meta name="twitter:description" content="Get in touch with Mobile Nest Bhilwara for smartphones, gadgets, and expert mobile repairs.">
    <meta name="twitter:image" content="https://mobilenestbhilwara.com/images/store-front.jpg">
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
                   <li id="liShop" runat="server" class="trail-item">
                         <a href="shop.aspx" title="">Shop</a>
                         <span><img src="images/icons/arrow-right.png" alt=""></span>
                 </li>

                    <li class="trail-end">
                        <asp:Label ID="lblCategory" runat="server" Text="Contact"></asp:Label>
                    </li>
                </ul><!-- /.breadcrumbs -->
            </div>
        </div>
    </div>
</section>

    <section class="flat-map">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div id="flat-map" class="pdmap">
                    <!-- Google Maps Embed for B.L. Soni College -->
                    <iframe
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3605.8301967800317!2d74.6318297753865!3d25.34347837761713!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3968c24a80b74741%3A0x69412c7d99f6204c!2sB.L.Soni%20College%20-%20Website%20Designing%20%26%20Development%20%7C%20Digtial%20Marketing%20%7C%20Data%20Science%20AI-ML%20Training!5e0!3m2!1sen!2sin!4v1761301331366!5m2!1sen!2sin"
                        width="100%" height="444" style="border:0;" allowfullscreen="" loading="lazy"
                        referrerpolicy="no-referrer-when-downgrade">
                    </iframe>
                </div><!-- /#flat-map -->
            </div><!-- /.col-md-12 -->
        </div><!-- /.row -->
    </div><!-- /.container -->
</section><!-- /#flat-map -->
<!-- /#flat-map -->


    <section class="flat-contact style2">
    <div class="container">
        <div class="row">
            <div class="col-md-7">
                <div class="form-contact left">
                    <div class="form-contact-header">
                        <h3>Leave us a Message</h3>
                        <p>
                            We value your feedback and inquiries. Please fill out the form below and our team will get back to you as soon as possible.
                        </p>
                    </div><!-- /.form-contact-header -->
                    <div class="form-contact-content">
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                        <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>

                        <asp:Panel ID="pnlForm" runat="server">
                            <div class="form-box one-half name-contact">
                                <label for="txtFirstName">First Name*</label>
                                
                                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" placeholder="First Name"></asp:TextBox>
                                <br />
                            </div>
                            <div class="form-box one-half password-contact">
                                <label for="txtLastName">Last Name*</label>
                                <br />
                                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" placeholder="Last Name"></asp:TextBox>
                                <br />
                            </div>
                            <div class="form-box">
                                <label for="txtSubject">Subject</label>
                                <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Your Subject"></asp:TextBox>
                                <br />
                            </div>
                            <div class="form-box">
                                <label for="txtMessage">Message</label>
                                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="5"></asp:TextBox>
                                <br />
                            </div>
                            <br />
                            <div class="form-box">
                                <asp:Button ID="btnSubmit" runat="server" Text="Send" CssClass="contact" OnClick="btnSubmit_Click" />
                            </div>
                        </asp:Panel>
                        <br />
                    </div><!-- /.form-contact-content -->
                </div><!-- /.form-contact left -->
            </div><!-- /.col-md-7 -->

            <div class="col-md-5">
                <div class="box-contact">
                    <ul>
                        <li class="address">
                            <h3>Address</h3>
                            <p>LNT Road, opp. Laxmi Narayan Temple, above sarsawati Book Stationers, Bhopal Ganj,  <br />Bhilwara, Rajasthan 311001</p>
                        </li>
                        <li class="phone">
                            <h3>Phone</h3>
                            <p>(+91) 9352693280</p>
                            <p>(+91) 7878547696</p>
                        </li>
                        <li class="email">
                            <h3>Email</h3>
                            <p>cybervishu055@gmail.com</p>
                        </li>
                        <li class="address">
                            <h3>Opening Hours</h3>
                            <p>Monday to Friday: 10:00 AM – 6:00 PM</p>
                            <p>Saturday: 10:00 AM – 4:00 PM</p>
                            <p>Sunday: 12:00 PM – 4:00 PM</p>
                        </li>
                        <li>
                            <h3>Follow Us</h3>
                            <ul class="social-list style2">
                                <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fa fa-dribbble" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fa fa-google" aria-hidden="true"></i></a></li>
                            </ul><!-- /.social-list style2 -->
                        </li>
                    </ul>
                </div><!-- /.box-contact -->
            </div><!-- /.col-md-5 -->

        </div><!-- /.row -->
    </div><!-- /.container -->
</section><!-- /.flat-contact style2 -->
<!-- /.flat-contact style2 -->

</asp:Content>
