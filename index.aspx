<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <!-- ✅ Basic SEO Meta Tags -->
    <title>Mobile Nest | Bhilwara's Best Mobile Store for Smartphones & Accessories</title>
    <meta name="description" content="Mobile Nest Bhilwara - Shop latest smartphones, mobile accessories & gadgets at best prices. Explore top brands like Samsung, Realme, Vivo, and more." />
    <meta name="keywords" content="Mobile Nest Bhilwara, mobiles in bhilwara, smartphones, mobile store, Realme, Vivo, Oppo, Samsung, accessories" />
    <meta name="robots" content="index, follow" />
    <meta name="author" content="Mobile Nest" />
    <meta name="language" content="English" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- ✅ Open Graph for Social Sharing -->
    <meta property="og:title" content="Mobile Nest | Best Mobile Store in Bhilwara" />
    <meta property="og:description" content="Find the best deals on latest mobiles and accessories at Mobile Nest Bhilwara." />
    <meta property="og:image" content="https://yourwebsite.com/images/og-image.jpg" />
    <meta property="og:url" content="https://yourwebsite.com/" />
    <meta property="og:type" content="website" />

    <!-- ✅ Favicon -->
    <link rel="icon" href="images/favicon.png" type="image/png" />

    <style>
        .item-text {
            width: 50%;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    	<section class="flat-row flat-slider style4">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
    <div class="slider owl-carousel-15">
        <asp:Repeater ID="rptSliders" runat="server">
            <ItemTemplate>
                <div class="slider-item style8">
                    <div class="item-text">
                        <div class="header-item">
                            <p><%# Eval("Title") %></p>
                            <h2 class="name"><%# Eval("SubTitle") %></h2>
                            <p><%# Eval("Description") %></p>
                        </div>
                        <div class="content-item">
                            <div class="price">
                                <span class="sale">₹<%# string.Format("{0:N2}", Eval("Price")) %></span>
                                <div class="clearfix"></div>
                            </div>
                            <div class="regular">
                                ₹<%# string.Format("{0:N2}", Eval("OldPrice")) %>
                            </div>
                            <span class="btn-shop">
                                <a href="shop.aspx" title="">SHOP NOW 
                                    <img src="images/icons/right-3.png" alt="">
                                </a>
                            </span>
                        </div>
                    </div>

                    <div class="item-image" style="display:block;">
                        <img src='<%# "Uploads/Sliders/" + Eval("imagepath") %>' 
                             alt='<%# Eval("Title") %>' />
                    </div>

                    <div class="clearfix"></div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

<!-- /.col-md-12 -->
				</div><!-- /.row -->
			</div><!-- /.container -->
		</section><!-- /.flat-slider -->

    <section class="flat-row flat-banner-box">

			<div class="container">
				<div class="row">
                    		<asp:Repeater ID="rptBanners" runat="server">
    <ItemTemplate>
					<div class="col-md-4">
						<div class="banner-box">
					
        <div class="inner-box">
            <a href="shop.aspx" >
                <img src='<%# "Uploads/Banners/" + Eval("BannerImage") %>' alt="Banner" />

            </a>
        </div>
  
<!-- /.inner-box -->
						</div><!-- /.banner-box -->
					</div><!-- /.col-md-4 -->
					  </ItemTemplate>
</asp:Repeater>
				</div><!-- /.row -->
			</div><!-- /.container -->
		</section><!-- /.flat-banner-box -->

   

    <section class="flat-row flat-imagebox style1 second-slider">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="flat-row-title">
							<h3>Our Products</h3>
						</div><!-- /.flat-row-title -->
					</div><!-- /.col-md-12 -->
				</div><!-- /.row -->
				<div class="row">
					<div class="col-md-12 owl-carousel-10">
    <asp:Repeater ID="rptCarousel" runat="server">
        <ItemTemplate>
            <div class="owl-carousel-item">
                <div class="product-box style1">
                    <div class="imagebox style1">
                        <div class="box-image">
                            <a href='<%# "productdetails.aspx?id=" + Eval("ProductID") + "&from=shop" %>'>
                             
                                <img src='<%# ResolveUrl("~/Uploads/Products/" + Eval("Image1")) %>' alt="Product" />


                                

                            </a>
                        </div>
                        <div class="box-content">
                            <div class="cat-name">
                                <a href="#"><%# Eval("CategoryName") %></a>
                            </div>
                            <div class="product-name">
                                <a href="#"><%# Eval("productName") %></a>
                            </div>
                            <div class="price">
                                <span class="regular">₹<%# Eval("OldPrice") %></span>
                                <span class="sale">₹<%# Eval("Price") %></span>
                            </div>
                        </div>
                        <div class="box-bottom">
                            <div class="compare-wishlist">
                             
                           <a href='<%# "wishlist.aspx?productid=" + Eval("ProductID") %>'
   class="wishlist"
   title="">
    <img src='<%# IsInWishlist(Eval("ProductID")) 
        ? "images/icons/wishlist2.png" 
        : "images/icons/wishlist.png" %>' 
        alt="Wishlist" />
    Wishlist
</a>



                            </div>
                            <div class="btn-add-cart">
    <asp:LinkButton ID="btnAddToCart" runat="server" 
        CommandArgument='<%# Eval("ProductID") %>' 
        OnCommand="btnAddToCart_Command" 
        CssClass="add-cart-btn">
        <img src="images/icons/add-cart.png" alt="">Add to Cart
    </asp:LinkButton>
</div>

                        </div>
                    </div><!-- /.imagebox style1 -->
                </div><!-- /.product-box style1 -->
            </div><!-- /.owl-carousel-item -->
        </ItemTemplate>
    </asp:Repeater>
</div>

				</div><!-- /.row -->
			</div><!-- /.container -->
		</section><!-- /.flat-imagebox style1 -->

    <section class="flat-imagebox style3">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="owl-carousel-2">
                    <asp:Repeater ID="rptSpecialOffers" runat="server">
                        <ItemTemplate>

                            <div class="box-counter">
                                <div class="counter">
                                    <span class="special"><%# Eval("OfferTitle") %></span>
                                    <div class="counter-content">
                                        <p style="display: -webkit-box;
                                           -webkit-line-clamp: 3;
                                           -webkit-box-orient: vertical;
                                           overflow: hidden;
                                           text-overflow: ellipsis;">
                                            <%# Eval("Description") %>
                                        </p>

                                       <!-- Count Down Timer -->
<div class="count-down" 
     data-expiry='<%# String.Format("{0:yyyy-MM-ddTHH:mm:ss}", Eval("ExpiryDate")) %>'>
    <div class="square">
        <div class="numb days">00</div><div class="text">DAYS</div>
    </div>
    <div class="square">
        <div class="numb hours">00</div><div class="text">HOURS</div>
    </div>
    <div class="square">
        <div class="numb mins">00</div><div class="text">MINS</div>
    </div>
    <div class="square">
        <div class="numb secs">00</div><div class="text">SECS</div>
    </div>
</div>

                                        <br />
<!-- ✅ Expired Message -->
<div class="offer-expired-msg" style="display:none;">
    <span class="expired-badge">⚠️ Offer Expired</span>
</div>

                                    </div>
                                </div>

                                <div class="product-item">
                                    <div class="imagebox style3">
                                        <div class="box-image save">

                                            <!-- ✅ Click → ProductDetail.aspx?productId -->
                                            <a href='<%# "productdetails.aspx?productid=" + Eval("ProductID") %>'>
                                                <img src='<%# ResolveUrl("~/Uploads/Products/" + Eval("Image2")) %>'
                                                     alt='<%# Eval("ProductName") %>' />
                                            </a>

                                            <span>
                                                Save ₹<%# Convert.ToDecimal(Eval("OldPrice")) - Convert.ToDecimal(Eval("Price")) %>
                                            </span>
                                        </div>

                                        <div class="box-content">
                                            <div class="product-name">
                                                <a href="#"><%# Eval("DiscountLabel") %></a>
                                            </div>
                                            <ul class="product-info">
                                                <li><%# Eval("ProductName") %></li>
                                            </ul>
                                            <div class="price">
                                                <span class="sale">₹<%# Eval("Price", "{0:N2}") %></span>
                                                <span class="regular">₹<%# Eval("OldPrice", "{0:N2}") %></span>
                                            </div>
                                        </div>

                                        <div class="box-bottom box-cart style2">
                                            <asp:LinkButton ID="btnAddToCart" runat="server"
                                                CommandArgument='<%# Eval("ProductID") %>'
                                                OnCommand="btnAddToCart_Command"
                                                CssClass="btn-add-cart ">
                                             Add to Cart
                                            </asp:LinkButton>

                                            <div class="compare-wishlist">
                                                <a href='<%# "wishlist.aspx?productid=" + Eval("ProductID") %>' 
                                                   class="wishlist" title="">
                                                   <img src="images/icons/wishlist.png" alt="">Wishlist
                                                </a>
                                            </div>
                                        </div>

                                    </div>
                                </div>

                            </div>

                        </ItemTemplate>
                    </asp:Repeater>
                </div><!-- /.owl-carousel-2 -->
            </div><!-- /.col-md-12 -->
        </div><!-- /.row -->
    </div><!-- /.container -->

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                let countdowns = document.querySelectorAll(".count-down");

                countdowns.forEach(function (cd) {
                    let expiry = new Date(cd.getAttribute("data-expiry")).getTime();
                    let expiredMsg = cd.parentElement.querySelector(".offer-expired-msg");

                    function updateTimer() {
                        let now = new Date().getTime();
                        let diff = expiry - now;

                        if (diff <= 0) {
                            cd.style.display = "none";
                            expiredMsg.style.display = "block";
                            return; // Stop here
                        }

                        // Still active => update
                        let days = Math.floor(diff / (1000 * 60 * 60 * 24));
                        let hours = Math.floor((diff / (1000 * 60 * 60)) % 24);
                        let mins = Math.floor((diff / (1000 * 60)) % 60);
                        let secs = Math.floor((diff / 1000) % 60);

                        cd.querySelector(".days").innerText = days;
                        cd.querySelector(".hours").innerText = hours;
                        cd.querySelector(".mins").innerText = mins;
                        cd.querySelector(".secs").innerText = secs;
                    }

                    updateTimer();
                    setInterval(updateTimer, 1000);
                });
            });
</script>

</section>
<!-- /.flat-imagebox style3 -->

    <section class="flat-row flat-imagebox style4 forth-slider">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="flat-row-title">
							<h3>Most Viewed</h3>
						</div><!-- /.flat-row-title -->
					</div><!-- /.col-md-12 -->
				</div><!-- /.row -->
				<div class="row">
					<div class="col-md-12">
						<div class="owl-carousel-3">
							<asp:Repeater ID="rptTopSelling" runat="server">
    <ItemTemplate>
        <div class="imagebox style4 v1">
            <div class="box-image">
                <a href='<%# "productdetails.aspx?id=" + Eval("ProductID") + "&from=shop" %>' title='<%# Eval("productName") %>'>
                    <img src='<%# ResolveUrl("~/Uploads/Products/" + Eval("Image1")) %>' alt='<%# Eval("productName") %>' />
                </a>
            </div><!-- /.box-image -->

            <div class="box-content">
                <div class="cat-name">
                    <a href="#" title=""><%# Eval("CategoryName") %></a>
                </div>
                <div class="product-name">
                    <a href="#" title=""><%# Eval("productName") %></a>
                </div>
                <div class="price">
                    <span class="sale">₹<%# Eval("Price") %></span>
                    <span class="regular">₹<%# Eval("OldPrice") %></span>
                </div>
            </div><!-- /.box-content -->
        </div>
    </ItemTemplate>
</asp:Repeater>
<!-- /.imagebox style4 v1 -->
				
						</div><!-- /.owl-carousel-3 -->
					</div><!-- /.col-md-12 -->
				</div><!-- /.row -->
			</div><!-- /.container -->
		</section><!-- /.flat-imagebox style4 -->


    <!-- /.flat-highlights -->

		<section class="flat-iconbox">
			<div class="container">
				<div class="row">
					<div class="col-md-3">
						<div class="iconbox">
							<div class="box-header">
								<div class="image">
									<img src="images/icons/car.png" alt="">
								</div>
								<div class="box-title">
									<h3>Worldwide Shipping</h3>
								</div>
							</div><!-- /.box-header -->
							<div class="box-content">
								<p>Free Shipping On Order Over $100</p>
							</div><!-- /.box-content -->
						</div><!-- /.iconbox -->
					</div><!-- /.col-md-3 -->
					<div class="col-md-3">
						<div class="iconbox">
							<div class="box-header">
								<div class="image">
									<img src="images/icons/order.png" alt="">
								</div>
								<div class="box-title">
									<h3>Order Online Service</h3>
								</div>
							</div><!-- /.box-header -->
							<div class="box-content">
								<p>Free return products in 30 days</p>
							</div><!-- /.box-content -->
						</div><!-- /.iconbox -->
					</div><!-- /.col-md-3 -->
					<div class="col-md-3">
						<div class="iconbox">
							<div class="box-header">
								<div class="image">
									<img src="images/icons/payment.png" alt="">
								</div>
								<div class="box-title">
									<h3>Payment</h3>
								</div>
							</div><!-- /.box-header -->
							<div class="box-content">
								<p>Secure System</p>
							</div><!-- /.box-content -->
						</div><!-- /.iconbox -->
					</div><!-- /.col-md-3 -->
					<div class="col-md-3">
						<div class="iconbox">
							<div class="box-header">
								<div class="image">
									<img src="images/icons/return.png" alt="">
								</div>
								<div class="box-title">
									<h3>Return 30 Days</h3>
								</div>
							</div><!-- /.box-header -->
							<div class="box-content">
								<p>Free return products in 30 days</p>
							</div><!-- /.box-content -->
						</div><!-- /.iconbox -->
					</div><!-- /.col-md-3 -->
				</div><!-- /.row -->
			</div><!-- /.container -->
		</section><!-- /.flat-iconbox -->

    <script type="text/javascript">
        window.onload = function () {
            var urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get("msg") === "success") {
                alert("Registration Successful!");
            }
        }
</script>

</asp:Content>
