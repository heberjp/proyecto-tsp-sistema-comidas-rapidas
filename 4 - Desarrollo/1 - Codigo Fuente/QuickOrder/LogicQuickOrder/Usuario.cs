
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
            if (usuario.Equals(string.Empty) || contrasena.Equals(string.Empty))
            {
                new Exception("El usuario y la contraseña son requeridos.");
            }

            var db = new DatabaseDataContext();
            var result = db.Autentiacion(usuario, contrasena).FirstOrDefault();

            if (result == null)
            {
                return null;
            }

            return new VoQuickOrder.Usuario
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
        }

        /// <summary>
        /// Inserta el usuario en la tabla usuario
        /// </summary>
        /// <param name="usuario">Objetpo de la clase usuario</param>
        /// <returns>Id Usuario</returns>
        public int InsertarUsuario(VoQuickOrder.Usuario usuario)
        {
            if (usuario == null)
            {
                new Exception("Se requiere la informacion del usuario.");
            }

            var db = new DatabaseDataContext();
            return db.InsertUsuario(
                                usuario.IdRoles,
                                usuario.NombreUsuario,
                                usuario.Contrasena,
                                usuario.Pregunta,
                                usuario.Respuesta_Pregunta,
                                usuario.Correo);
        }

        /// <summary>
        /// Actualiza el usuario en la tabla usuario
        /// </summary>
        /// <param name="usuario">Objetpo de la clase usuario</param>
        /// <returns>Id Usuario</returns>
        public int ActualizarUsuario(VoQuickOrder.Usuario usuario)
        {
            if (usuario == null)
            {
                new Exception("Se requiere la informacion del usuario.");
            }

            var db = new DatabaseDataContext();
            return db.ActualizarUsuario(
                                usuario.IdUsuario,
                                usuario.IdRoles,
                                usuario.NombreUsuario,
                                usuario.Contrasena,
                                usuario.Pregunta,
                                usuario.Respuesta_Pregunta,
                                usuario.Correo);
        }
    }
}
