using System;
using System.Web.UI;

namespace QuickOrder
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var imagenes = string.Empty;
            for (var i = 0; i < 5; i++)
            {
                imagenes += "<li><a href=''><img src='images/home/" + i + ".jpg' alt='' /></a></li>";
            }

            Session["imagenes"] = imagenes;
        }
    }
}