
using System.Collections.Generic;

namespace LogicQuickOrder
{
    using System;
    using System.Linq;
    using DatabaseDataContext = DataClasesQuickOrder.DatabaseDataContext;
    using EntidadesDBDataContext = DataClasesQuickOrder.EntidadesDBDataContext;
    using DBUsuario = DataClasesQuickOrder.Usuario;

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
                throw new ArgumentException("El usuario y la contraseña son requeridos.", "usuario");
            }

            var db = new DatabaseDataContext();
            var result = db.Autentiacion(usuario, contrasena).FirstOrDefault();

            if (result == null)
            {
                return null;
            }

            return new VoQuickOrder.Usuario
                        {
                            NombreUsuario = usuario,
                            IdUsuario = result.idUsuario,
                            IdRoles = result.Roles_idRoles
                        };
        }

        /// <summary>
        /// Inserta el usuario en la tabla usuario
        /// </summary>
        /// <param name="usuario">Objetpo de la clase usuario</param>
        /// <returns>Id Usuario</returns>
        public bool InsertarUsuario(VoQuickOrder.Usuario usuario)
        {
            if (usuario == null)
            {
                throw new ArgumentException("El parametro producto no puede ser nulo", "usuario");
            }
            try
            {

                new DatabaseDataContext().sp_registrar_usuario(
                    usuario.NombreUsuario,
                    usuario.Contrasena,
                    usuario.Pregunta,
                    usuario.IdRoles,
                    usuario.RespuestaPregunta,
                    usuario.Correo);

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// Eliminar el usuario en la tabla usuario
        /// </summary>
        /// <param name="usuario">Objetpo de la clase usuario</param>
        /// <returns>Id Usuario</returns>
        public bool EliminarUsuario(VoQuickOrder.Usuario usuario)
        {
            if (usuario == null)
            {
                throw new ArgumentException("El parametro producto no puede ser nulo", "usuario");
            }
            try
            {
                new EntidadesDBDataContext().Usuarios.DeleteOnSubmit(new DBUsuario
                {
                    idUsuario = usuario.IdUsuario,
                    Nom_Usuario = usuario.NombreUsuario,
                    Pregunta = usuario.Pregunta,
                    Respuesta_Pregunta = usuario.RespuestaPregunta,
                    Roles_idRoles = usuario.IdRoles
                });
                return true;
            }
            catch (Exception)
            {
                return false;
            }
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
                throw new ArgumentException("Se requiere la informacion del usuario.", "usuario");
            }

            var db = new DatabaseDataContext();

            return db.ActualizarUsuario(
                usuario.IdUsuario,
                usuario.IdRoles,
                usuario.NombreUsuario,
                usuario.Contrasena,
                usuario.Pregunta,
                usuario.RespuestaPregunta,
                usuario.Correo);
        }

        public List<VoQuickOrder.Rol> ConsultarRoles()
        {
            return new EntidadesDBDataContext().Roles.ToList().Select(
                                           r => new VoQuickOrder.Rol
                                           {
                                               Nombre = r.Rol,
                                               IdRoles = r.idRoles
                                           }).ToList();
        }
    }
}
