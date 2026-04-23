<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="BlogDetails.aspx.cs" Inherits="BlogDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title><%= Page.Title %> | Mobile Nest Blog</title>

    <meta name="description" content="<%= MetaDescription %>" />
    <meta name="keywords" content="<%= MetaKeywords %>" />
    <link rel="canonical" href="https://yourwebsite.com/BlogDetails.aspx?id=<%= Request.QueryString["id"] %>" />

    <!-- Open Graph for Social Media -->
    <meta property="og:title" content="<%= Page.Title %>" />
    <meta property="og:description" content="<%= MetaDescription %>" />
    <meta property="og:image" content="<%= MetaImage %>" />
    <meta property="og:url" content="https://yourwebsite.com/BlogDetails.aspx?id=<%= Request.QueryString["id"] %>" />
    <meta property="og:type" content="article" />
    <meta name="robots" content="index, follow" />

    <!-- Schema Markup for Blog Post -->
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "BlogPosting",
      "headline": "<%= Page.Title %>",
      "image": "<%= MetaImage %>",
      "author": {
        "@type": "Organization",
        "name": "Mobile Nest"
      },
      "publisher": {
        "@type": "Organization",
        "name": "Mobile Nest",
        "logo": {
          "@type": "ImageObject",
          "url": "https://yourwebsite.com/images/mobilelogo.png"
        }
      },
      "mainEntityOfPage": {
        "@type": "WebPage",
        "@id": "https://yourwebsite.com/BlogDetails.aspx?id=<%= Request.QueryString["id"] %>"
      },
      "datePublished": "<%= MetaDate %>",
      "description": "<%= MetaDescription %>"
    }
    </script>

    <style>
        .main-post.single {
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            transition: 0.3s ease;
        }
        .main-post.single:hover {
            transform: translateY(-5px);
        }
        .content-post h3 {
            font-size: 26px;
            line-height: 1.4;
        }
        .meta-post {
            color: #888;
            font-size: 14px;
        }
        .meta-post li {
            display: inline-block;
            margin-right: 10px;
        }
        .entry-post {
            margin-top: 20px;
            font-size: 17px;
            line-height: 1.7;
        }
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <section class="main-blog">
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <div class="post-wrap">
                        <article class="main-post single">
                            <div class="featured-post">
                                <a href="#" title="">
                                    <asp:Image ID="imgBlog" runat="server" AlternateText="Blog Image"  style="width: 100%; height:500px;"/>
                                </a>
                            </div><!-- /.featured-post -->
                            <div class="divider25"></div>
                            <div class="content-post">
                                <h3 class="title-post">
                                    <asp:Label ID="lblTitle" runat="server" Font-Bold="true" Font-Size="20px"></asp:Label>
                                </h3>
                                <ul class="meta-post">
                                    <li class="comment">
                                        <asp:Label ID="lblComments" runat="server"></asp:Label> Comments
                                    </li>
                                    <li class="date">
                                        <asp:Label ID="lblDate" runat="server"></asp:Label>
                                    </li>
                                </ul><!-- /.meta-post -->
                                <div class="entry-post">
                                    <asp:Label ID="lblDescription" runat="server" TextMode="HTML"></asp:Label>
                                </div><!-- /.entry-post -->
                                <!-- Social / share icons and comments remain same -->
                            </div><!-- /.content-post -->
                        </article><!-- /.main-post single -->
                    </div><!-- /.post-wrap -->
                </div><!-- /.col-md-12 col-lg-12 -->
            </div><!-- /.row -->
        </div><!-- /.container -->
    </section><!-- /.main-blog -->
    <br /><br />
</asp:Content>
