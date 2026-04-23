<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.master" AutoEventWireup="true" CodeFile="productdetails.aspx.cs" Inherits="productdetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


        <!-- ✅ Dynamic SEO Meta Tags for Product Details -->
    <title><%# Eval("Name") %> | MobileNest - Buy Online at Best Price</title>
    <meta name="description" content='<%# "Shop " + Eval("Name") + " at MobileNest. Discover specs, reviews & best price online in Bhilwara. 100% genuine mobiles & fast delivery." %>' />
    <meta name="keywords" content='<%# Eval("Name") + ", " + Eval("CategoryName") + ", buy mobile online, MobileNest Bhilwara, smartphones India" %>' />
    <meta name="robots" content="index, follow" />
    <meta name="author" content="MobileNest" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- ✅ Open Graph for Social Sharing -->
    <meta property="og:title" content='<%# Eval("Name") + " | MobileNest" %>' />
    <meta property="og:description" content='<%# Eval("Description") %>' />
    <meta property="og:image" content='<%# ResolveUrl("~/Uploads/Products/") + Eval("Image1") %>' />
    <meta property="og:url" content='<%# "https://mobilenest.in/ProductDetails.aspx?id=" + Eval("ProductID") %>' />
    <meta property="og:type" content="product" />

    <!-- ✅ Twitter Card -->
    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:title" content='<%# Eval("Name") + " | MobileNest" %>' />
    <meta name="twitter:description" content='<%# Eval("Description") %>' />
    <meta name="twitter:image" content='<%# ResolveUrl("~/Uploads/Products/") + Eval("Image1") %>' />


     <style>
      .stars-outer {
    display: inline-block;
    position: relative;
    font-family: FontAwesome;
    color: #ccc; /* empty stars */
}

.stars-outer::before {
    content: "\f005 \f005 \f005 \f005 \f005"; /* 5 stars */
    font-family: "Font Awesome 5 Free"; /* or your FA version */
    font-weight: 900;
}

.stars-inner {
    position: absolute;
    top: 0;
    left: 0;
    white-space: nowrap;
    overflow: hidden;
    width: 0%; /* will set dynamically */
    color: gold;
}

.stars-inner::before {
    content: "\f005 \f005 \f005 \f005 \f005";
    font-family: "Font Awesome 5 Free";
    font-weight: 900;
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
                        <a href="Default.aspx" title="">Home</a>
                        <span><img src="images/icons/arrow-right.png" alt=""></span>
                    </li>
                   <li id="liShop" runat="server" class="trail-item">
                         <a href="Shop.aspx" title="">Shop</a>
                         <span><img src="images/icons/arrow-right.png" alt=""></span>
                 </li>

                    <li class="trail-end">
                        <asp:Label ID="lblCategory" runat="server" Text=""></asp:Label>
                    </li>
                </ul><!-- /.breadcrumbs -->
            </div>
        </div>
    </div>
</section>


		 <asp:Repeater ID="rptProduct" runat="server">
            <ItemTemplate>
                <section class="flat-product-detail">
                    <div class="container">
                        <div class="row">
                            <!-- LEFT: Product Images -->
                            <div class="col-md-6">
                                <div class="flexslider">
                                    <ul class="slides">
                                        <li data-thumb='<%# ResolveUrl("~/Uploads/Products/") + Eval("Image1") %>'>
                                            <a href="#" class='zoom'>
                                                <img src='<%# ResolveUrl("~/Uploads/Products/") + Eval("Image1") %>' alt=''  />
                                            </a>
                                        </li>
                                        <li data-thumb='<%# ResolveUrl("~/Uploads/Products/") + Eval("Image2") %>'>
                                            <a href="#" class='zoom'>
                                                <img src='<%# ResolveUrl("~/Uploads/Products/") + Eval("Image2") %>' alt='' />
                                            </a>
                                        </li>
                                        <li data-thumb='<%# ResolveUrl("~/Uploads/Products/") + Eval("Image3") %>'>
                                            <a href="#" class='zoom'>
                                                <img src='<%# ResolveUrl("~/Uploads/Products/") + Eval("Image3") %>' alt='' />
                                            </a>
                                        </li>
                                        <li data-thumb='<%# ResolveUrl("~/Uploads/Products/") + Eval("Image4") %>'>
                                            <a href="#" class='zoom'>
                                                <img src='<%# ResolveUrl("~/Uploads/Products/") + Eval("Image4") %>' alt='' />
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <!-- RIGHT: Product Info -->
                            <div class="col-md-6">
                                <div class="product-detail">
                                    <div class="header-detail">
                                        <h4 class="name"><%# Eval("Name") %></h4>
                                        <div class="category">
                                            <%# Eval("CategoryName") %>
                                        </div>
                                      <div class="reviewed">
    <div class="review">
        <div class="queue">
            <%# GetStarsHTML(Convert.ToDouble(Eval("AverageRating"))) %>
        </div>
        <div class="text">
            <span><asp:Label ID="lblTotalReviews" runat="server"></asp:Label> Reviews</span>
            <span class="add-review">Add Your Review</span>
        </div>
    </div>

    <div class="status-product">
        Availablity 
        <span>
            <%# Convert.ToInt32(Eval("StockQuantity")) > 0 ? "In Stock" : "Out of Stock" %>
        </span>
    </div>
</div>


                                    </div>

                                    <div class="content-detail">
                                        <div class="price">
                                            <div class="regular">
                                                ₹<%# Eval("OldPrice") %>
                                            </div>
                                            <div class="sale">
                                                ₹<%# Eval("Price") %>
                                            </div>
                                        </div>
                                        <div class="info-text" style="display: -webkit-box;
        -webkit-line-clamp: 3;   /* 👉 3 lines */
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;">
                                            <%# Eval("Description") %>
                                        </div>
                                        <div class="product-id">
                                            SKU: <span class="id"><%# Eval("SKU") %></span>
                                        </div>
                                    </div>

                                    <div class="footer-detail">
                                        <div class="quanlity-box">
                                           <div class="colors">
    <asp:DropDownList ID="ddlColor" runat="server"></asp:DropDownList>
</div>

                                            <div class="quanlity">
                                                <asp:TextBox ID="txtQty" runat="server" Text="1" type="number" min="1" MaxLength="3"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="box-cart style2">
                                            <div class="btn-add-cart">
                                                <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" 
    CommandArgument='<%# Eval("ProductID") %>' 
    OnCommand="btnAddToCart_Command" CssClass="btn btn-primary" />

                                            </div>
                                        </div>
                                        <div class="social-single">
                                            <span>SHARE</span>
                                            <ul class="social-list style2">
                                                <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                                <li><a href="#"><i class="fa fa-instagram"></i></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- /.col-md-6 -->
                        </div>
                    </div>
                </section>
            </ItemTemplate>
        </asp:Repeater><!-- /.flat-product-detail style1 -->

		<section class="flat-product-content ">
			<ul class="product-detail-bar ">
				
				<li class="active">Tecnical Specs</li>
				<li>Reviews</li>
			</ul><!-- /.product-detail-bar style1 -->
			<div class="container">
				
				<div class="row">
    <div class="col-md-12">
        <div class="tecnical-specs">
            <h4 class="name"><asp:Label ID="lblProductName" runat="server" /></h4>
            <table>
                <tbody>
                    <tr>
                        <td>RAM</td>
                        <td><asp:Label ID="lblRAM" runat="server" /></td>
                    </tr>
                    <tr>
                        <td>Sim Type</td>
                        <td><asp:Label ID="lblSimType" runat="server" /></td>
                    </tr>
                    <tr>
                        <td>TouchScreen</td>
                        <td><asp:Label ID="lblTouchScreen" runat="server" /></td>
                    </tr>
                    <tr>
                        <td>Color</td>
                        <td><asp:Label ID="lblColor" runat="server" /></td>
                    </tr>
                    <tr>
                        <td>Display Size</td>
                        <td><asp:Label ID="lblSize" runat="server" /></td>
                    </tr>
                    <tr>
                        <td>Resolution</td>
                        <td><asp:Label ID="lblResolution" runat="server" /></td>
                    </tr>
                    <tr>
                        <td>Network Type</td>
                        <td><asp:Label ID="lblNetworkType" runat="server" /></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
  <div class="row">
    <!-- Review Summary -->
 <div class="col-md-6">
    <div class="rating">
        <div class="title">
            Based on <asp:Label ID="lblTotalReviews" runat="server" Text="0"></asp:Label> reviews
        </div>
        <div class="score">
            <div class="average-score">
                <p class="numb">
                    <asp:Label ID="lblAverageScore" runat="server" Text="0.0"></asp:Label>
                </p>
                <p class="text">Average score</p>
            </div>
            <div class="queue">
                <asp:Literal ID="litStars" runat="server"></asp:Literal>
            </div>
        </div>
      
    </div><!-- /.rating -->
</div> <!-- /.col-md-6 -->


    <!-- Add Review Form -->
    <div class="col-md-6">
        <div class="form-review style1">
            <div class="title">Add a review</div>
            <div class="your-rating queue">
                <span>Your Rating:</span>
                <asp:HiddenField ID="hfRating" runat="server" />
                <span id="stars">
                    <i class="fa fa-star" data-val="1"></i>
                    <i class="fa fa-star" data-val="2"></i>
                    <i class="fa fa-star" data-val="3"></i>
                    <i class="fa fa-star" data-val="4"></i>
                    <i class="fa fa-star" data-val="5"></i>
                </span>
            </div>
            <br />
            <asp:TextBox ID="txtReviewTitle" runat="server" placeholder="Title" CssClass="form-control"></asp:TextBox>
            <br />
            <asp:TextBox ID="txtReviewText" runat="server" TextMode="MultiLine" Rows="4" placeholder="Your Review" CssClass="form-control"></asp:TextBox>
            <br />
            <asp:Button ID="btnAddReview" runat="server" Text="Add Review" OnClick="btnAddReview_Click" CssClass="btn btn-primary" />
                <br />
             </div>
    </div>

    <!-- Reviews List -->
    <div class="col-md-12">
    <ul class="review-list">
        <asp:Repeater ID="rptReviews" runat="server">
            <ItemTemplate>
                <li class='<%# Container.ItemIndex >= 3 ? "extra-review" : "" %>' style='<%# Container.ItemIndex >= 3 ? "display:none;" : "" %>'>
                    <div class="review-metadata">
                        <div class="name">
                            <%# Eval("FullName") %> : <span><%# Eval("CreatedAt", "{0:MMMM dd, yyyy}") %></span>
                        </div>
                        <br />
                        <div class="queue">
                            <%# GetStarsHTML(Convert.ToInt32(Eval("Rating"))) %>
                        </div>
                    </div>
                    <div class="review-content">
                        <p><%# Eval("ReviewText") %></p>
                    </div>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>

    <div id="showMoreWrapper" style="text-align:center; margin-top:10px;">
        <a href="javascript:void(0);" id="showMoreLink">Read more reviews</a>
    </div>
</div>

</div>

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    $(document).ready(function(){
        $("#showMoreLink").click(function(){
            $(".extra-review").slideToggle();
            $(this).text(function(i, text){
                return text === "Read more reviews" ? "Show less" : "Read more reviews";
            });
        });
    });
</script>


<script>
    const stars = document.querySelectorAll('#stars i');
    stars.forEach(star => {
        star.addEventListener('click', function () {
            const val = parseInt(this.getAttribute('data-val'));
            document.getElementById('<%= hfRating.ClientID %>').value = val;
            stars.forEach((s, i) => {
                s.style.color = i < val ? 'gold' : 'gray';
        });
    });
    });
</script>
			</div><!-- /.container -->
		</section><!-- /.flat-product-content style1 -->

		<section class="flat-row flat-imagebox style4 forth-slider">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="flat-row-title">
							<h3>Top Selling</h3>
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
                <a href='<%# "ProductDetails.aspx?id=" + Eval("ProductID") + "&from=shop" %>' title='<%# Eval("Name") %>'>
                    <img src='<%# ResolveUrl("~/Uploads/Products/" + Eval("Image1")) %>' alt='<%# Eval("Name") %>' />
                </a>
            </div><!-- /.box-image -->

            <div class="box-content">
                <div class="cat-name">
                    <a href="#" title=""><%# Eval("CategoryName") %></a>
                </div>
                <div class="product-name">
                    <a href="#" title=""><%# Eval("Name") %></a>
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

</asp:Content>

