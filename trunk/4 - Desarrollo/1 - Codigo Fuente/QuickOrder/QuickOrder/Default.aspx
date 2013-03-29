<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="QuickOrder._Default" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script type="text/javascript" src="scripts/jquery.pikachoose.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#pikame").PikaChoose();
        });
    </script>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div class="wrapper">
        <div class="pikachoose">
            <ul id="pikame">
                <li>
                    <img src="images/home/1.jpg" alt="" /></li>
                <li>
                    <img src="images/home/2.jpg" alt="" /></li>
                <li>
                    <img src="images/home/3.jpg" alt="" /></li>
                <li>
                    <img src="images/home/4.jpg" alt="" /></li>
            </ul>
        </div>
        <div class="clear"></div>
        <div class="border"></div>
        <div class="home-widget">
            <h3>Lorem Ipsum</h3>
            <img src="images/home/3.jpg" width="300" alt="" />
            <p>Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae.</p>
        </div>
        <div class="home-widget">
            <h3>Lorem Ipsum</h3>
            <img src="images/home/4.jpg" width="300" alt="" />
            <p>Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae.</p>
        </div>
        <div class="home-widget">
            <h3>Lorem Ipsum</h3>
            <img src="images/home/1.jpg" width="300" alt="" />
            <p>Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae.</p>
        </div>
        <div class="border2" />
        <br />
        <br />
        <div></div>
        <div id="pricing-table">
            <div class="plan">
                <h3>Breakfast<span>$99</span></h3>
                <a class="button" href="Menu.aspx">Order Now</a>
                <ul>
                    <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                    <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                    <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                    <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                </ul>
            </div>
            <div class="plan">
                <h3>Lunch<span>$99</span></h3>
                <a class="button" href="Menu.aspx">Order Now</a>
                <ul>
                    <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                    <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                    <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                    <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                </ul>
            </div>
            <div class="plan">
                <h3>Dinner<span>$99</span></h3>
                <a class="button" href="Menu.aspx">Order Now</a>
                <ul>
                    <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                    <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                    <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                    <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                </ul>
            </div>
        </div>
    </div>

</asp:Content>
