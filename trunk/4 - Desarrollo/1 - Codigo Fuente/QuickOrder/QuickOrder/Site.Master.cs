using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            Page.PreLoad += master_Page_PreLoad;
        }

        /// <summary>
        /// Valida el nombre de usuario
        /// </summary>
        private void Validarusuario() {
            var usuario = (VoQuickOrder.Usuario)Session["usuario"];

            var validacion = usuario != null;

            lbNombreUsuario.Text = validacion ? usuario.NombreUsuario : string.Empty;
            lnkblogin.Visible = !validacion;
            lnkbregister.Visible = !validacion;
            btnSalir.Visible = validacion;
        }

        /// <summary>
        /// PreLoad
        /// </summary>
        /// <param name="sender">Objeto que genera el evento</param>
        /// <param name="e">Evento</param>
        protected void master_Page_PreLoad(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Cargue de pagina
        /// </summary>
        /// <param name="sender">Objeto que genera el evento</param>
        /// <param name="e">Evento</param>
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Evento del boton salir
        /// </summary>
        /// <param name="sender">Objeto que genera el evento</param>
        /// <param name="e">Evento</param>
        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session["usuario"] = null;
            Validarusuario();
        }
    }
}