using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LogicQuickOrder;

namespace QuickOrder.Account
{
    public partial class Login : Page
    {
        LogicQuickOrder.Usuario usuario;

        protected void Page_Load(object sender, EventArgs e)
        {
            usuario = new LogicQuickOrder.Usuario();
        }

        protected void LogIn(object sender, EventArgs e)
        {
            Session["usuario"] = usuario.Autenticacion(UserName.Text, Password.Text);
            if (Session["usuario"] != null)
            {
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                lbFailureText.Text = "Usuario o contraseña no existen";
            }
        }
    }
}