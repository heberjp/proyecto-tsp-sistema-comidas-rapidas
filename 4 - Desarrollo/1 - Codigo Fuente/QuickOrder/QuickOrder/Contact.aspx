<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="QuickOrder.Contact" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h1><%: Title %>.</h1>
    <br />
    <br />
    <section class="contact">
        <h2>LUIS ANDRES OLARTE ZABALA</h2>
        <header>
            <h3>Numero:</h3>
        </header>
        <p>
            <span>311 312 27 80</span>
        </p>
        <header>
            <h3>Correo:</h3>
        </header>
        <p>
            <span><a href="mailto:Andres.olarte396@gmail.com">Andres.olarte396@gmail.com</a></span>
        </p>
    </section>

    <section class="contact">
        <header>
            <h3>Direccion:</h3>
        </header>
        <p>
            Politecnico:
            ????
        </p>
    </section>
</asp:Content>
