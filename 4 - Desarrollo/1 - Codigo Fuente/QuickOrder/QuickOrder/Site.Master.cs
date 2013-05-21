using System;
using System.Web.UI;

namespace QuickOrder
{
    public partial class SiteMaster : MasterPage
    {
        /// <summary>
        /// Inicio de pagina
        /// </summary>
        /// <param name="sender">Objeto que genera el evento</param>
        /// <param name="e">Evento</param>
        protected void Page_Init(object sender, EventArgs e)
        {
            Validarusuario();
        }

        /// <summary>
        /// Valida el nombre de usuario
        /// </summary>
        private void Validarusuario()
        {
            var usuario = (VoQuickOrder.Usuario)Session["usuario"];
            var validacion = usuario != null;
            lbNombreUsuario.Text = validacion ? usuario.NombreUsuario : string.Empty;
            lnkblogin.Visible = !validacion;
            lnkbregister.Visible = !validacion;
            btnSalir.Visible = validacion;
        }

        /// <summary>
        /// Evento del boton salir
        /// </summary>
        /// <param name="sender">Objeto que genera el evento</param>
        /// <param name="e">Evento</param>
        protected void BtnSalirClick(object sender, EventArgs e)
        {
            Session["usuario"] = null;
            Validarusuario();
        }
    }
}