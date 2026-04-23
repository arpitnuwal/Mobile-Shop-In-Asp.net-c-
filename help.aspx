<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="help.aspx.cs" Inherits="help" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <!-- SEO Meta Tags -->
    <title>Help & FAQs | Mobile Nest Bhilwara</title>
    <meta name="description" content="Find answers to common questions at Mobile Nest Bhilwara. Track your order, manage returns, refunds, and payments easily.">
    <meta name="keywords" content="Mobile Nest Help, Mobile Nest FAQ, Mobile Nest Bhilwara support, mobile store help, order tracking Bhilwara">
    <meta name="author" content="Mobile Nest Bhilwara">
    <meta name="robots" content="index, follow">
    <link rel="canonical" href="https://mobilenestbhilwara.com/help.aspx" />

    <!-- Open Graph -->
    <meta property="og:title" content="Help & FAQs | Mobile Nest Bhilwara">
    <meta property="og:description" content="Get instant help with orders, payments, and returns at Mobile Nest Bhilwara. Visit our FAQ page for all solutions.">
    <meta property="og:image" content="https://mobilenestbhilwara.com/images/faq.svg">
    <meta property="og:url" content="https://mobilenestbhilwara.com/help.aspx">
    <meta property="og:type" content="website">

    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="Help & FAQs | Mobile Nest Bhilwara">
    <meta name="twitter:description" content="Your go-to support page for order tracking, payments, and returns — Mobile Nest Bhilwara.">
    <meta name="twitter:image" content="https://mobilenestbhilwara.com/images/faq.svg">

    <!-- JSON-LD Structured Data (for FAQ rich results on Google) -->
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "FAQPage",
      "mainEntity": [
        {
          "@type": "Question",
          "name": "I want to track my order",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "To track your order, check your tracking number received via SMS or email."
          }
        },
        {
          "@type": "Question",
          "name": "I want to manage my order",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "You can update delivery address, items, or cancel orders from your account section."
          }
        },
        {
          "@type": "Question",
          "name": "I did not receive Instant Cashback",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "Cashback reflects within 24 hours. If not, contact support with your order ID."
          }
        },
        {
          "@type": "Question",
          "name": "I am unable to pay using wallet",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "Ensure wallet balance is sufficient and KYC is completed."
          }
        },
        {
          "@type": "Question",
          "name": "I want help with returns & refunds",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "We accept returns within 7 days of delivery. Refunds take 3-5 business days."
          }
        }
      ]
    }
    </script>

    <style>
        a {
            text-decoration: none;
            color: black;
        }

        .faq-item {
            margin-bottom: 15px;
            border: 1px solid #eee;
            border-radius: 8px;
            overflow: hidden;
        }

        .faq-header {
            padding: 15px;
            cursor: pointer;
            font-weight: bold;
            border-radius: 8px;
            background: #fff3eb;
            color: #ff5e14;
            transition: background 0.3s;
        }

        .faq-header.active {
            background: #ff5e14;
            color: white;
        }

        .faq-body {
            padding: 15px;
            display: none;
            color: #555;
            font-size: 15px;
        }

        .faq-body.show {
            display: block;
        }
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
                        <li class="trail-item">
                            <a href="shop.aspx" title="">Shop</a>
                            <span><img src="images/icons/arrow-right.png" alt=""></span>
                        </li>
                        <li class="trail-end">
                            <a href="#" title=""><asp:Label ID="lblCategoryTitle" runat="server" Text="Help"></asp:Label></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <section style="padding: 60px 0; background: white;">
        <div style="max-width: 1200px; margin: auto;">
            
            <h2 style="text-align:center; font-size:34px; margin-bottom:40px; font-weight:bold; color:#333;">
                Frequently Asked Questions
            </h2>

            <div style="display:flex; gap:40px; flex-wrap:wrap;">
                
                <div style="flex:1; min-width:300px; text-align:center;">
                    <img src="images/faq.svg" alt="faq" style="width:100%; max-width:350px;">
                </div>

                <div style="flex:2; min-width:300px;">

                    <div class="faq-item">
                        <div class="faq-header active" onclick="toggleFAQ(this)">
                            I want to track my order
                        </div>
                        <div class="faq-body show">
                            To track your order, check your tracking number received via SMS or email...
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-header" onclick="toggleFAQ(this)">
                            I want to manage my order
                        </div>
                        <div class="faq-body">
                            You can update delivery address, items, or cancel orders from your account section...
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-header" onclick="toggleFAQ(this)">
                            I did not receive Instant Cashback
                        </div>
                        <div class="faq-body">
                            Cashback reflects within 24 hours. If not, contact support with your order ID...
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-header" onclick="toggleFAQ(this)">
                            I am unable to pay using wallet
                        </div>
                        <div class="faq-body">
                            Kindly ensure wallet balance is sufficient and KYC is completed...
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-header" onclick="toggleFAQ(this)">
                            I want help with returns & refunds
                        </div>
                        <div class="faq-body">
                            We accept returns within 7 days of delivery. Refunds take 3-5 business days...
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>

    <script>
        function toggleFAQ(header) {

            // Close all
            document.querySelectorAll(".faq-header").forEach(h => {
                h.classList.remove("active");
        });
        document.querySelectorAll(".faq-body").forEach(b => {
            b.classList.remove("show");
        });

        // Open clicked one
        header.classList.add("active");
        header.nextElementSibling.classList.add("show");
        }
    </script>

</asp:Content>
