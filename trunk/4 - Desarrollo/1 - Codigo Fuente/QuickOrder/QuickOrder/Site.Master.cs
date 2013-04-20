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
            var usuario = (VoQuickOrder.Usuario)Session["usuario"];

            if (usuario != null)
            {
                lbNombreUsuario.Text = usuario.NombreUsuario;
            }          

            Page.PreLoad += master_Page_PreLoad;
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
    }
}