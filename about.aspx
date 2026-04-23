<%@ Page Title="" Language="C#" MasterPageFile="~/usermaster.master" AutoEventWireup="true" CodeFile="about.aspx.cs" Inherits="about" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>About Mobile Nest | Best Mobile Store in Bhilwara</title>
    <meta name="description" content="Learn more about Mobile Nest – Bhilwara’s trusted mobile and accessories store offering premium smartphones, 5G devices, and expert service." />
    <meta name="keywords" content="Mobile Nest Bhilwara, About Mobile Nest, Mobile Shop Rajasthan, Smartphone Store Bhilwara" />
    <link rel="canonical" href="https://yourwebsite.com/about.aspx" />
    
    <!-- Open Graph for Social Media -->
    <meta property="og:title" content="About Mobile Nest - Bhilwara’s Trusted Mobile Store" />
    <meta property="og:description" content="Mobile Nest offers the latest 5G smartphones and accessories in Bhilwara. Learn more about our story, trust, and service excellence." />
    <meta property="og:image" content="https://yourwebsite.com/images/about/About_us.jpg" />
    <meta property="og:url" content="https://yourwebsite.com/about.aspx" />
    <meta property="og:type" content="website" />
    <meta name="robots" content="index, follow" />

    <!-- Structured Data for “About Page” -->
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "AboutPage",
      "mainEntity": {
        "@type": "Organization",
        "name": "Mobile Nest",
        "url": "https://yourwebsite.com",
        "logo": "https://yourwebsite.com/images/mobilelogo.png",
        "sameAs": [
          "https://www.facebook.com/",
          "https://www.instagram.com/",
          "https://x.com/"
        ],
        "contactPoint": {
          "@type": "ContactPoint",
          "telephone": "+91-7878547696",
          "contactType": "Customer Service",
          "areaServed": "IN"
        }
      },
      "description": "About Mobile Nest – Bhilwara’s trusted destination for mobiles, gadgets, and accessories."
    }
    </script>

    <style>
        .your-rating i { cursor: pointer; color: #ccc; font-size: 24px; }
        .your-rating i.checked { color: #ffcc00; }
        .fa-star.filled { color: gold; }
        .fa-star.half { color: gold; position: relative; }
        .fa-star.half:before { content: '\f005'; position: absolute; width: 50%; overflow: hidden; color: gold; }
        .testimonial-item { margin: 15px; padding: 20px; background: #f8f8f8; border-radius: 10px; }
        .testimonial-item .image img { width: 80px; height: 80px; border-radius: 50%; object-fit: cover; }
        .stars i { margin-right: 2px; }
        .text-muted { font-style: italic; color: gray; }
    </style>
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
                        <asp:Label ID="lblCategory" runat="server" Text="About"></asp:Label>
                    </li>
                </ul><!-- /.breadcrumbs -->
            </div>
        </div>
    </div>
</section>

    <!-- About Section -->
    <section class="flat-about">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="image-about">
                        <img src="images/about/About_us.jpg" alt="About Mobile Nest" loading="lazy" />

                    </div>
                </div>
                <div class="col-md-6">
                    <div class="text-about">
                        <div class="title"><h3>Discover the Latest in Mobile Technology</h3></div>
                        <div class="content">
                            <p>Welcome to <strong>MobileNest</strong>, where innovation meets convenience. From the newest 5G smartphones to powerful accessories, we bring you trusted brands and reliable products that keep you connected.</p>
                            <p>Whether you need budget-friendly mobiles, premium devices, or daily essentials like chargers, covers, and earphones, our store is designed for you. <span>Shop with confidence knowing that customer satisfaction, genuine products, and after-sale support are always our top priority.</span></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="flat-testimonial">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="title"><h3>Testimonials</h3></div>
                    <div class="testimonial owl-carousel-17">
                        <asp:Repeater ID="rptTestimonials" runat="server">
                            <ItemTemplate>
                                <div class="testimonial-item">
                                    <div class="image">
                                       
                                        <img src='images/user.png' alt='<%# Eval("Name") %>' />
                                    </div>
                                    <div class="content">
                                        <div class="name"><%# Eval("Name") %></div>
                                        <p><%# Eval("Comment") %></p>
                                        <div class="stars">
                                            <%# GetStarsHtml(Eval("Rating")) %>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <asp:Label ID="lblNoTestimonials" runat="server" Text="No testimonials available yet." CssClass="text-muted" Visible="false"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Average Rating & Testimonial Form -->
    <section class="">
        <div class="container">
            <div class="row">

                <!-- Average Rating Display -->
                <div class="col-md-6">
                    <div class="rating">
                        <div class="title">Based on <asp:Label ID="lblReviewCount" runat="server" Text="0"></asp:Label> reviews</div>
                        <div class="score">
                            <div class="average-score">
                                <p class="numb"><asp:Label ID="lblAverageScore" runat="server" Text="0.0"></asp:Label></p>
                                <p class="text">Average score</p>
                            </div>
                            <div class="queue"><asp:Literal ID="litStars" runat="server"></asp:Literal></div>
                        </div>
                    </div>
                </div>

                <!-- Testimonial Form -->
                <div class="col-md-6">
                    <div class="form-review style1">
                        <div class="title">Give a Testimonial</div>
                        <asp:Panel ID="pnlRating" runat="server" CssClass="your-rating queue">
                            <span>Your Rating</span>
                            <asp:HiddenField ID="hfRating" runat="server" Value="0" />
                            <i class="fa fa-star" data-value="1" onclick="setRating(1)"></i>
                            <i class="fa fa-star" data-value="2" onclick="setRating(2)"></i>
                            <i class="fa fa-star" data-value="3" onclick="setRating(3)"></i>
                            <i class="fa fa-star" data-value="4" onclick="setRating(4)"></i>
                            <i class="fa fa-star" data-value="5" onclick="setRating(5)"></i>
                        </asp:Panel>
                        <br />
                        <asp:Panel ID="Panel1" runat="server">
                            <div class="review-form-name">
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Name"></asp:TextBox>
                            </div>
                            <br />
                            <div class="review-form-email">
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
                            </div>
                            <br />
                            <div class="review-form-comment">
                                <asp:TextBox ID="txtComment" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Your Review"></asp:TextBox>
                            </div>
                            <br />
                            <div class="btn-submit">
                                <asp:Button ID="btnSubmitReview" runat="server" CssClass="btn-outline-danger" Text="Add Review" OnClick="btnSubmitReview_Click" />
                            </div>
                            <br />
                        </asp:Panel>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <script>
        function setRating(val) {
            document.getElementById('<%= hfRating.ClientID %>').value = val;
            const stars = document.querySelectorAll('#<%= pnlRating.ClientID %> i');
            stars.forEach(s => s.classList.remove('checked'));
            for (let i = 0; i < val; i++) stars[i].classList.add('checked');
            }
    </script>

</asp:Content>
