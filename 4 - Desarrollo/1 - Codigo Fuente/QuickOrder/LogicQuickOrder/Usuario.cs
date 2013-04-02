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

            if (usuario.Equals(string.Empty) || contrasena.Equals(string.Empty))
            {
                new Exception("El usuario y la contraseña son requeridos.");
            }

            AutentiacionResult result = baseDatos.Autentiacion(usuario, contrasena).FirstOrDefault();
            
            if (result.idUsuario == 0 || result.idUsuario == null)
            {
                return null;
            }

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

        public int InsertarUsuario(VoQuickOrder.Usuario usuario)
        {
            DatabaseDataContext baseDatos = new DatabaseDataContext();
            return baseDatos.LAOZ_InsertUsuario(
                                usuario.IdRoles,
                                usuario.NombreUsuario,
                                usuario.Contrasena,
                                usuario.Pregunta,
                                usuario.Respuesta_Pregunta,
                                usuario.Correo);
        }
    }
}
