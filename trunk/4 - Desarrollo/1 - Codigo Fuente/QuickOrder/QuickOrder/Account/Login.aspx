<%@ Page Title="Log in" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="QuickOrder.Account.Login" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <h1><%: Title %>.</h1>

    <div id="loginForm">
        <br />
        <div class="validation-summary-errors">
            <asp:Label runat="server" ID="lbFailureText" />
        </div>
        <fieldset>
            <legend>Log in Form</legend>
            <ol>
                <li>
                    <asp:Label runat="server" AssociatedControlID="UserName">Nombre de usuario</asp:Label>
                    <asp:TextBox runat="server" ID="UserName" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName" CssClass="field-validation-error" ErrorMessage="El usuario es requerido." />
                </li>
                <li>
                    <asp:Label runat="server" AssociatedControlID="Password">Contraseña</asp:Label>
                    <asp:TextBox runat="server" ID="Password" TextMode="Password" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="field-validation-error" ErrorMessage="La contraseña es requerida." />
                </li>
                <li>
                    <asp:CheckBox runat="server" ID="RememberMe" />
                    <asp:Label runat="server" AssociatedControlID="RememberMe" CssClass="checkbox">Recordarme?</asp:Label>
                </li>
            </ol>
            <asp:Button runat="server" CommandName="Login" Text="Ingresar" OnClick="LogIn" />
        </fieldset>
        <p>
            <h4>
                <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Registrarse</asp:HyperLink>
                if you don't have an account.
            </h4>
        </p>
    </div>

    <section id="socialLoginForm">
        <h2>Use another service to log in.</h2>
        <uc:OpenAuthProviders runat="server" ID="OpenAuthLogin" />
    </section>
</asp:Content>
