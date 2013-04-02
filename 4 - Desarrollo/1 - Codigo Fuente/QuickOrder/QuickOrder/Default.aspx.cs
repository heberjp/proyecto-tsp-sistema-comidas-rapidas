using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuickOrder
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string imagenes = string.Empty;
            for (int i = 0; i < 5; i++)
            {
                imagenes += "<li><a href=''><img src='images/home/" + i + ".jpg' alt='' /></a></li>";
            }

            Session["imagenes"] = imagenes;
        }
    }
}