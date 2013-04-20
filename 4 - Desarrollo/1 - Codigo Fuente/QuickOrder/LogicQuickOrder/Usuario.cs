
namespace LogicQuickOrder
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Data.Linq;
    using System.Text;
    using DataClasesQuickOrder;

    /// <summary>
    /// Implementa los metodos de la logica de la entidad usuario
    /// </summary>
    public class Usuario
    {
        /// <summary>
        /// Valida la existencia del Usuario en la tabla usuario.
        /// </summary>
        /// <param name="usuario">Nombre Usuario</param>
        /// <param name="contrasena">COntraseña</param>
        /// <returns></returns>
        public VoQuickOrder.Usuario Autenticacion(string usuario, string contrasena)
        {
            DatabaseDataContext baseDatos = new DatabaseDataContext();

            if (usuario.Equals(string.Empty) || contrasena.Equals(string.Empty))
            {
                new Exception("El usuario y la contraseña son requeridos.");
            }

            AutentiacionResult result = baseDatos.Autentiacion(usuario, contrasena).FirstOrDefault();
            
            if (result.idUsuario == 0 || result.Primer_Nombre == string.Empty)
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

        /// <summary>
        /// Inserta el usuario en la tabla usuario
        /// </summary>
        /// <param name="usuario">Objetpo de la clase usuario</param>
        /// <returns>Id Usuario</returns>
        public int InsertarUsuario(VoQuickOrder.Usuario usuario)
        {
            DatabaseDataContext baseDatos = new DatabaseDataContext();
            return baseDatos.InsertUsuario(
                                usuario.IdRoles,
                                usuario.NombreUsuario,
                                usuario.Contrasena,
                                usuario.Pregunta,
                                usuario.Respuesta_Pregunta,
                                usuario.Correo);
        }
    }
}
