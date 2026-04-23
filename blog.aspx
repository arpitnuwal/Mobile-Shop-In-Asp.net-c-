<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="blog.aspx.cs" Inherits="blog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Mobile Nest Blog | Latest Mobile Trends, Tips & Reviews in Bhilwara</title>
    <meta name="description" content="Read expert reviews, smartphone buying guides, and the latest updates from Mobile Nest – Bhilwara’s trusted mobile and accessories store." />
    <meta name="keywords" content="Mobile Nest Blog, Bhilwara mobile store, smartphone reviews, mobile tips, tech blog, Bhilwara gadgets" />
    <link rel="canonical" href="https://yourwebsite.com/blog.aspx" />

    <!-- Open Graph for Social Media -->
    <meta property="og:title" content="Mobile Nest Blog - Latest Mobile News & Reviews" />
    <meta property="og:description" content="Discover the latest smartphone trends, gadget news, and tech insights from Bhilwara’s top mobile store – Mobile Nest." />
    <meta property="og:image" content="https://yourwebsite.com/images/blog-default.jpg" />
    <meta property="og:url" content="https://yourwebsite.com/blog.aspx" />
    <meta property="og:type" content="website" />
    <meta name="robots" content="index, follow" />

    <!-- Structured Data for Blog Listing -->
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "Blog",
      "name": "Mobile Nest Blog",
      "url": "https://yourwebsite.com/blog.aspx",
      "description": "Official blog of Mobile Nest, Bhilwara’s trusted smartphone and accessories store.",
      "publisher": {
        "@type": "Organization",
        "name": "Mobile Nest",
        "logo": {
          "@type": "ImageObject",
          "url": "https://yourwebsite.com/images/mobilelogo.png"
        }
      },
      "inLanguage": "en-IN"
    }
    </script>

    <style>
        .blog-description {
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            text-align:left;
        }
        .show-more {
            color: #007bff;
            cursor: pointer;
            font-weight: bold;
            margin-top: 5px;
            display: inline-block;
        }
      
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

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
                        <asp:Label ID="lblCategory" runat="server" Text="Blog"></asp:Label>
                    </li>
                </ul><!-- /.breadcrumbs -->
            </div>
        </div>
    </div>
</section>

    <section class="main-blog">
        <div class="container">
            <div class="row">
                <asp:Repeater ID="rptBlogs" runat="server">
                    <ItemTemplate>
                        <div class="col-md-6 col-lg-6 mx-auto p-5 p-lg-2">
                            <div class="post-wrap style2">
                                <div class="featured-post">
                                    <a href="blogdetails.aspx?id=<%# Eval("PostID") %>" title="">
                                        <img src='<%# ResolveUrl("~/" + Eval("ImageUrl")) %>' 
                                             alt="blog image" 
                                             style="width:90%; height:auto; border-radius:10px;" />
                                    </a>
                                </div>

                                <div class="divider26"></div>

                                <div class="content-post">
                                    <h3 class="title-post">
                                        <a href="blogdetails.aspx?id=<%# Eval("PostID") %>" title="">
                                            <%# Eval("Title") %>
                                        </a>
                                    </h3>

                                    <ul class="meta-post">
                                        <li class="comment">
                                            <a href="#" title="">
                                                <%# Eval("CommentsCount") %> Comments
                                            </a>
                                        </li>
                                        <li class="date">
                                            <a href="#" title="">
                                                <%# Eval("PostDate", "{0:MMMM dd, yyyy}") %>
                                            </a>
                                        </li>
                                    </ul>

                                    <div class="entry-post">
                                        <p class="blog-description">
                                            <%# Eval("Description") %>
                                        </p>
                                        <a href='blogdetails.aspx?id=<%# Eval("PostID") %>' class="show-more">Read More</a>
                                    </div>
                                </div>

                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div><!-- /.container -->
    </section><!-- /.main-blog -->

    <br /><br />
</asp:Content>
