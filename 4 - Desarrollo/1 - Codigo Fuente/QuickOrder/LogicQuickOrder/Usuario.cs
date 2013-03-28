namespace LogicQuickOrder
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Data.Linq;
    using System.Text;
    using DataClasesQuickOrder;

    public class Usuario
    {
        public VoQuickOrder.Usuario Autenticacion(string usuario, string contrasena)
        {
            DatabaseDataContext baseDatos = new DatabaseDataContext();
            AutentiacionResult result = (AutentiacionResult)baseDatos.Autentiacion(usuario, contrasena);

            var usu = new VoQuickOrder.Usuario
                        {
                            Contrasena = contrasena,
                            NombreUsuario = usuario,
                            IdUsuario = result.idUsuario,
                            Nombre = string.Format(" {0} {1} ", result.Primer_Nombre, result.Segundo_Nombre),
                            Apellido = string.Format(" {0} {1} ", result.Primer_Apellido, result.Segundo_Apellido),
                            Direccion = result.Direccion,
                            Correo = result.Correo,
                            Telefono = result.Telefono
                        };

            return usu;
        }

        //public int InsertarUsuario(VoQuickOrder.Usuario)
        //{ 
        
        //}
    }
}
