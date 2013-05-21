<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="QuickOrder._Default" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script src="Scripts/jquery.pikachoose.js"></script>
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
                    <img src="images/Home1/1.jpg" width="960" height="400" alt="" /></li>
                <li>
                    <img src="images/Home1/2.jpg" width="960" height="400" alt="" /></li>
                <li>
                    <img src="images/Home1/3.jpg" width="960" height="400" alt="" /></li>
                <li>
                    <img src="images/Home1/4.jpg" width="960" height="400" alt="" /></li>
            </ul>
        </div>
        <div class="clear"></div>
        <div class="border"></div>
        <%--<div class="home-widget">
            <h3>Lorem Ipsum</h3>
            <img src="images/Home1/3.jpg" width="280" height="250" alt="" />
            <p>Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae.</p>
        </div>
        <div class="home-widget">
            <h3>Lorem Ipsum</h3>
            <img src="images/Home1/4.jpg" width="280" height="250" alt="" />
            <p>Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae.</p>
        </div>
        <div class="home-widget">
            <h3>Lorem Ipsum</h3>
            <img src="images/Home1/1.jpg" width="280" height="250" alt="" />
            <p>Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae.</p>
        </div>--%>
        <div class="border2">
            <br />
            <br />
            <div id="pricing-table">
                <div class="plan">
                    <h3>Desalluno
                    <asp:Label runat="server" ID="ValorDesalluno" /></h3>
                    <a class="button" href="Menu.aspx">Ordena Ahora</a>
                    <asp:GridView ID="gvDesallunos" runat="server"></asp:GridView>
                </div>
                <div class="plan">
                    <h3>Almuerzo<span>$99</span></h3>
                    <a class="button" href="Menu.aspx">Order Now</a>
                    <ul>
                        <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                        <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                        <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                        <li><strong style="text-transform: uppercase">lorem Ipsum</strong> Dolor Sit Amet</li>
                    </ul>
                </div>
                <div>
                    <h3>Sena<span>$99</span></h3>
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
    </div>
</asp:Content>
