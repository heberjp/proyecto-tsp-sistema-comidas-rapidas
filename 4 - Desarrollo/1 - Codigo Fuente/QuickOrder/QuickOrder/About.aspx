<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="QuickOrder.About" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h1><%: Title %>.</h1>
    <br />
    <h4>Your app description page.</h4>
    <article>
        <p>
            Use this area to provide additional information.
        </p>

        <p>
            Use this area to provide additional information.
        </p>

        <p>
            Use this area to provide additional information.
        </p>
    </article>

    <aside>
        <h3>Aside Title</h3>
        <p>
            Use this area to provide additional information.
        </p>
        <ul>
            <li><a runat="server" href="~/">Home</a></li>
            <li><a runat="server" href="~/About.aspx">About</a></li>
            <li><a runat="server" href="~/Contact.aspx">Contact</a></li>
        </ul>
    </aside>
</asp:Content>
