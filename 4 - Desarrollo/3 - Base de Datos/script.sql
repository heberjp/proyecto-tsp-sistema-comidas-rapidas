USE [master]
GO
/****** Object:  Database [SistemaPedidos]    Script Date: 19/03/2013 12:28:08 a.m. ******/
CREATE DATABASE [SistemaPedidos]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SistemaPedidos', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSSQLSERVER2012\MSSQL\DATA\SistemaPedidos.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SistemaPedidos_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSSQLSERVER2012\MSSQL\DATA\SistemaPedidos_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SistemaPedidos] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SistemaPedidos].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SistemaPedidos] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SistemaPedidos] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SistemaPedidos] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SistemaPedidos] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SistemaPedidos] SET ARITHABORT OFF 
GO
ALTER DATABASE [SistemaPedidos] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [SistemaPedidos] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SistemaPedidos] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SistemaPedidos] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SistemaPedidos] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SistemaPedidos] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SistemaPedidos] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SistemaPedidos] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SistemaPedidos] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SistemaPedidos] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SistemaPedidos] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SistemaPedidos] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SistemaPedidos] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SistemaPedidos] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SistemaPedidos] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SistemaPedidos] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SistemaPedidos] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SistemaPedidos] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SistemaPedidos] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SistemaPedidos] SET  MULTI_USER 
GO
ALTER DATABASE [SistemaPedidos] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SistemaPedidos] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SistemaPedidos] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SistemaPedidos] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [SistemaPedidos]
GO
/****** Object:  StoredProcedure [dbo].[InsertRol]    Script Date: 19/03/2013 12:28:10 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertRol]

@Aplicacion nvarchar, 
@RolNombre nvarchar(256),
@Descripcion nvarchar(256)

AS 
	INSERT INTO Rol
           (AplicacionId
           ,RolNombre
           ,Descripcion)
     VALUES
           ( (select AplicacionId from Aplicacion where AplicacionNombre = @Aplicacion)
           ,@RolNombre
           ,@Descripcion)

GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_cliente_empresarial]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_eliminar_cliente_empresarial]
@Documento VARCHAR(50)
AS
BEGIN
--El sp retorna un 1 si se pudo eliminar correctamente o un 0 si hay facturas o pedidos para este cliente
	DECLARE
	@idFactura INT,
	@idCliente INT,
	@idUsuario INT
	
	SELECT @idFactura = NULL
	
	SELECT @idCliente = idCliente_Empresarial from Cliente_Empresarial 
	WHERE Documento=@Documento
	
	SELECT @idFactura = idFactura FROM Factura
	WHERE Cliente_Empresarial_idCliente_Empresarial=@idCliente
	
	IF @idFactura IS NULL
	BEGIN
	    SELECT @idUsuario = Usuario_idUsuario FROM Cliente_Empresarial
	    WHERE Documento=@Documento
	    
	    DELETE FROM Cliente_Empresarial
	    WHERE idCliente_Empresarial=@idCliente
	    
	    DELETE FROM Usuario
	    WHERE idUsuario=@idUsuario	    
	    
	    RETURN 1
	END
	ELSE
	BEGIN
	    RETURN 0
	END
END


GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_cliente_natural]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_eliminar_cliente_natural]
@Documento VARCHAR(50)
AS
BEGIN
--El sp retorna un 1 si se pudo eliminar correctamente o un 0 si hay facturas o pedidos para este cliente
	DECLARE
	@idFactura INT,
	@idCliente INT,
	@idUsuario INT
	
	SELECT @idFactura = NULL
	
	SELECT @idCliente = idCliente from Cliente_Natural 
	WHERE Documento=@Documento
	
	SELECT @idFactura = idFactura FROM Factura
	WHERE Cliente_Natural_idCliente_Natural=@idCliente
	
	IF @idFactura IS NULL
	BEGIN
	    SELECT @idUsuario = Usuario_idUsuario FROM Cliente_Natural
	    WHERE Documento=@Documento
	    
	    DELETE FROM Cliente_Natural
	    WHERE idCliente=@idCliente
	    
	    DELETE FROM Usuario
	    WHERE idUsuario=@idUsuario	    
	    
	    RETURN 1
	END
	ELSE
	BEGIN
	    RETURN 0
	END
END


GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_factura]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_eliminar_factura]
@idFactura INT
AS
BEGIN
	UPDATE Producto
	SET Unidades_Disponibles =	p.Unidades_Disponibles + ppf.Cantidad_Producto FROM Producto_por_Factura ppf, Producto p
	WHERE ppf.Factura_idFactura=@idFactura
	AND p.idProducto=ppf.Producto_idProducto
	
	DELETE FROM Producto_por_Factura
	WHERE Factura_idFactura = @idFactura
	
	DELETE FROM Factura
	WHERE idFactura = @idFactura
END


GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_producto_por_factura]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_eliminar_producto_por_factura]
@idFactura INT,
@NomProducto VARCHAR(50),
@Cantidad INT
AS
BEGIN
	DECLARE
	@idProducto INT

	UPDATE Producto
	SET Unidades_Disponibles =	p.Unidades_Disponibles + ppf.Cantidad_Producto FROM Producto_por_Factura ppf, Producto p
	WHERE ppf.Factura_idFactura=@idFactura
	AND p.idProducto=ppf.Producto_idProducto
	AND p.Nombre_Producto = @NomProducto
	AND p.idProducto = ppf.Producto_idProducto
	
	SELECT @idProducto = idProducto FROM Producto WHERE Nombre_Producto=@NomProducto
	
	DELETE FROM Producto_por_Factura
	WHERE Factura_idFactura = @idFactura
	AND Cantidad_Producto = @Cantidad
	AND Producto_idProducto = @idProducto
	
END

GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_vendedor]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_eliminar_vendedor]
@Documento VARCHAR(50)
AS
BEGIN
--El sp retorna un 1 si se pudo eliminar correctamente o un 0 si hay facturas o pedidos para este vendedor
	DECLARE
	@idFactura INT,
	@idVendedor INT,
	@idUsuario INT
	
	SELECT @idFactura = NULL
	
	SELECT @idVendedor = idVendedor from Vendedor
	WHERE Documento=@Documento
	
	SELECT @idFactura = idFactura FROM Factura
	WHERE Vendedor_idVendedor=@idVendedor
	
	IF @idFactura IS NULL
	BEGIN
	    SELECT @idUsuario = Usuario_idUsuario FROM Vendedor
	    WHERE Documento=@Documento
	    
	    DELETE FROM Vendedor
	    WHERE idVendedor=@idVendedor
	    
	    DELETE FROM Usuario
	    WHERE idUsuario=@idUsuario	    
	    
	    RETURN 1
	END
	ELSE
	BEGIN
	    RETURN 0
	END
END


GO
/****** Object:  StoredProcedure [dbo].[sp_modificar_cliente_empresarial]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_modificar_cliente_empresarial]
@Documento VARCHAR(50),
@Nuevo_Tipo_Documento VARCHAR(4),
@Nuevo_Documento VARCHAR(14),
@Nuevo_Nombre_Empresa varchar(50),
@Nuevo_Telefono varchar(14),
@Nuevo_Direccion varchar(50),
@Nuevo_Pagina_Web VARCHAR(50),
@Nuevo_Correo VARCHAR(50)
AS
BEGIN
	DECLARE
	@idTipoDoc INT,
	@idUsuario INT
	
	SELECT @idTipoDoc = idTipo_Documento FROM Tipo_Documento where Tipo_Documento = @Nuevo_Tipo_Documento
	SELECT @idUsuario = Usuario_idUsuario FROM Cliente_Empresarial WHERE Documento=@Documento
	
	UPDATE Cliente_Empresarial
	SET
	Tipo_Documento_idTipo_Documento = @idTipoDoc,
	Documento = @Nuevo_Documento,
	Nombre_Empresa = @Nuevo_Nombre_Empresa,
	Telefono = @Nuevo_Telefono,
	Direccion = @Nuevo_Direccion,
	Pagina_Web = @Nuevo_Pagina_Web
	WHERE Documento=@Documento
	
	UPDATE Usuario
	SET
	Correo = @Nuevo_Correo
	WHERE idUsuario=@idUsuario
END


GO
/****** Object:  StoredProcedure [dbo].[sp_modificar_cliente_natural]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_modificar_cliente_natural]
@Documento VARCHAR(50),
@Nuevo_Documento VARCHAR(50),
@Nuevo_Tipo_Documento VARCHAR(4),
@Nuevo_Primer_Nombre VARCHAR(50),
@Nuevo_Segundo_Nombre VARCHAR(50),
@Nuevo_Primer_Apellido VARCHAR(50),
@Nuevo_Segundo_Apellido VARCHAR(50),
@Nuevo_Telefono VARCHAR(14),
@Nuevo_Direccion VARCHAR(50),
@Nuevo_Pagina_Web VARCHAR(50),
@Nuevo_Correo VARCHAR(50)
AS
BEGIN
	DECLARE
	@idTipoDoc INT,
	@idUsuario INT	
	
	SELECT @idTipoDoc = idTipo_Documento FROM Tipo_Documento where Tipo_Documento = @Nuevo_Tipo_Documento
	SELECT @idUsuario = Usuario_idUsuario FROM Cliente_Natural WHERE Documento=@Documento
	
	UPDATE Cliente_Natural
	SET
	Tipo_Documento_idTipo_Documento = @idTipoDoc,
	Documento = @Nuevo_Documento,
	Primer_Nombre = @Nuevo_Primer_Nombre,
	Segundo_Nombre = @Nuevo_Segundo_Nombre,
	Primer_Apellido = @Nuevo_Primer_Apellido,
	Segundo_Apellido = @Nuevo_Segundo_Apellido,
	Telefono = @Nuevo_Telefono,
	Direccion = @Nuevo_Direccion,
	Pagina_Web = @Nuevo_Pagina_Web
	WHERE Documento=@Documento		
	
	
	UPDATE Usuario
	SET
	Correo = @Nuevo_Correo
	WHERE idUsuario=@idUsuario
END


GO
/****** Object:  StoredProcedure [dbo].[sp_modificar_empresa]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_modificar_empresa]
@Nombre_Empresa VARCHAR(50),
@Nuevo_Tipo_Documento VARCHAR(4),
@Nuevo_Documento VARCHAR(14),
@Nuevo_Nombre_Empresa varchar(50),
@Nuevo_Telefono varchar(14),
@Nuevo_Direccion varchar(50),
@Nuevo_Pagina_Web VARCHAR(50)

AS
BEGIN
	DECLARE
	@idTipoDoc INT	
	
	SELECT @idTipoDoc = idTipo_Documento FROM Tipo_Documento where Tipo_Documento = @Nuevo_Tipo_Documento
	
	UPDATE Empresa
	SET
	Tipo_Documento_idTipo_Documento = @idTipoDoc,
	Documento = @Nuevo_Documento,
	Nombre_Empresa = @Nuevo_Nombre_Empresa,
	Telefono_Empresa = @Nuevo_Telefono,
	Direccion_Empresa = @Nuevo_Direccion,
	Pagina_Web = @Nuevo_Pagina_Web
	WHERE Nombre_Empresa=@Nombre_Empresa	
	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_modificar_producto]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_modificar_producto]
@Nombre_Producto VARCHAR(50),
@Nueva_Categoria VARCHAR(40),
@Nuevo_Nombre_Producto VARCHAR(50),
@Nuevo_Unidades_Disponibles INT,
@Nuevo_Descripcion VARCHAR(50),
@Nuevo_Precio NUMERIC(18,2),
@Nuevo_IVA NUMERIC(18,2)
AS
BEGIN
	DECLARE
	@idCategoria INT
	
	SELECT @idCategoria = NULL
	
	SELECT @idCategoria = idCategoria FROM Categoria
		WHERE Categoria = @Nueva_Categoria
		
	UPDATE Producto
	SET CateGORia_idCateGoria=@idCategoria,
		Unidades_disponibles = @Nuevo_Unidades_Disponibles,
		Nombre_Producto = @Nuevo_Nombre_Producto,
		Descripcion = @Nuevo_Descripcion,
		Precio = @Nuevo_Precio,
		IVA = @Nuevo_IVA
	WHERE Nombre_Producto=@Nombre_Producto
END


GO
/****** Object:  StoredProcedure [dbo].[sp_modificar_vendedor]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_modificar_vendedor]
@Documento VARCHAR(50),
@Nuevo_Documento VARCHAR(50),
@Nuevo_Tipo_Documento VARCHAR(4),
@Nuevo_Primer_Nombre VARCHAR(50),
@Nuevo_Segundo_Nombre VARCHAR(50),
@Nuevo_Primer_Apellido VARCHAR(50),
@Nuevo_Segundo_Apellido VARCHAR(50),
@Nuevo_Telefono VARCHAR(14)
AS
BEGIN
	DECLARE
	@idTipoDoc int	
	
	SELECT @idTipoDoc = idTipo_Documento FROM Tipo_Documento where Tipo_Documento = @Nuevo_Tipo_Documento
	
	UPDATE Vendedor
	SET
	Tipo_Documento_idTipo_Documento = @idTipoDoc,
	Documento = @Nuevo_Documento,
	Primer_Nombre = @Nuevo_Primer_Nombre,
	Segundo_Nombre = @Nuevo_Segundo_Nombre,
	Primer_Apellido = @Nuevo_Primer_Apellido,
	Segundo_Apellido = @Nuevo_Segundo_Apellido,
	Telefono = @Nuevo_Telefono	
	WHERE Documento=@Documento		
	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_producto_por_factura]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_producto_por_factura]
@Nombre_Producto VARCHAR(50),
@id_Factura INT,
@Cantidad INT
AS
BEGIN
--el sp retorna un 0 si no hay tantas unidades disponibles para el producto y el 1 si se registra con exito el producto por factura
	DECLARE
	@id_Producto INT,
	@Precio_Producto_sn NUMERIC(18,2),
	@Precion_Producto_cn NUMERIC(18,2),
	@IVA NUMERIC(18,2),
	@IVA_Precio NUMERIC(18,2),
	@Sub_Total NUMERIC(18,2),
	@sn_tantos int

	SELECT @sn_tantos=Unidades_Disponibles - @Cantidad FROM Producto
	WHERE Nombre_Producto=@Nombre_Producto
	
	IF @sn_tantos>=0 BEGIN
	SELECT @id_Producto = idProducto FROM Producto WHERE Nombre_Producto = @Nombre_Producto
	SELECT @Precio_Producto_sn = Precio FROM Producto WHERE idProducto = @id_Producto
	SELECT @IVA = IVA FROM Producto WHERE idProducto = @id_Producto
	SELECT @IVA_Precio = ((@Precio_Producto_sn * @IVA)/100)
	SELECT @Precion_Producto_cn = @Precio_Producto_sn + @IVA_Precio
	SELECT @Sub_Total = @Precion_Producto_cn * @Cantidad

	UPDATE Producto
	SET Unidades_disponibles=(Unidades_disponibles-@Cantidad)
	WHERE Nombre_Producto=@Nombre_Producto
	
	INSERT INTO Producto_por_Factura VALUES (@id_Producto, @id_Factura, @Cantidad, @Sub_Total)
	EXEC sp_total_factura @id_Factura
	RETURN 1
	END
	ELSE
	BEGIN
		RETURN 0
	END
END


GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_administrador]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--GO
--	DROP PROCEDURE sp_registrar_administrador
--GO
CREATE PROCEDURE [dbo].[sp_registrar_administrador]
/*Parametros para registrar Usuario*/
@Nom_Usuario VARCHAR(50),
@Contraseña VARCHAR(50),
@Pregunta VARCHAR(50),
@Respuesta_Pregunta VARCHAR(50),
@Correo VARCHAR(50),
/*FIN PARAMETROS USUARIO*/
@Documento VARCHAR(50),
@Tipo_Documento VARCHAR(4),
@Primer_Nombre VARCHAR(50),
@Segundo_Nombre VARCHAR(50),
@Primer_Apellido VARCHAR(50),
@Segundo_Apellido VARCHAR(50),
@Telefono VARCHAR(14),
@Direccion VARCHAR(50)
AS
BEGIN
/* El sp retorna un 0 si el usuario ya existe o un -1 si se pudo registrar el administrador*/
	DECLARE
	@id_Usuario int,	
	@idTipoDoc int,
	@sn_usuario_existe INT
	
	SELECT @sn_usuario_existe = NULL
	
	SELECT @sn_usuario_existe = idUsuario FROM Usuario WHERE Nom_Usuario = @Nom_Usuario	
	SELECT @idTipoDoc = idTipo_Documento FROM Tipo_Documento WHERE Tipo_Documento = @Tipo_Documento	
	
	IF (@sn_usuario_existe IS NULL)
	BEGIN
	EXEC @id_Usuario = sp_registrar_usuario @Nom_Usuario, @Contraseña, @Pregunta, 'Administrador', @Respuesta_Pregunta, @Correo
		INSERT INTO Administrador (Usuario_idUsuario, Tipo_Documento_idTipo_Documento, Documento, Primer_Nombre, Segundo_Nombre, Primer_Apellido, Segundo_Apellido, Telefono, Direccion)
		VALUES (@id_Usuario, @idTipoDoc, @Documento, @Primer_Nombre, @Segundo_Nombre, @Primer_Apellido, @Segundo_Apellido, @Telefono, @Direccion)
		RETURN -1	
	END	
	ELSE IF(@sn_usuario_existe IS NOT NULL)
	BEGIN
		RETURN 0
	END	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_cliente_empresarial]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_registrar_cliente_empresarial]
/*Parametros para registrar Usuario*/
@Nom_Usuario VARCHAR(50),
@Contraseña VARCHAR(50),
@Pregunta VARCHAR(50),
@Respuesta_Pregunta VARCHAR(50),
@Correo VARCHAR(50),
/*FIN PARAMETROS USUARIO*/
@Tipo_Documento VARCHAR(4),
@Documento VARCHAR(14),
@Nombre_Empresa varchar(50),
@Telefono varchar(14),
@Direccion varchar(50),
@Pagina_Web varchar(50)
AS
BEGIN
/* El sp retorna un 0 si el usuario ya existe o un -1 si se puede registrar exitosamente*/
	DECLARE
	@sn_Usuario INT,	
	@sn_usuario_existe INT,
	@idTipoDoc INT,
	@sn_nit_existe INT
	
	SELECT @sn_usuario_existe = NULL	
	
	SELECT @sn_usuario_existe = idUsuario FROM Usuario WHERE Nom_Usuario = @Nom_Usuario
	SELECT @idTipoDoc = idTipo_Documento FROM Tipo_Documento WHERE Tipo_Documento = @Tipo_Documento	
	
	IF(@sn_usuario_existe IS NULL)
	BEGIN
	EXEC @sn_Usuario = sp_registrar_usuario @Nom_Usuario, @Contraseña, @Pregunta, 'Cliente', @Respuesta_Pregunta, @Correo
		INSERT INTO Cliente_Empresarial 
		VALUES (@sn_usuario, @idTipoDoc, @Documento, @Nombre_Empresa, @Telefono, @Direccion, @Pagina_Web)
		RETURN -1
	END
	ELSE IF(@sn_usuario_existe IS NOT NULL)
	BEGIN
		RETURN 0
	END	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_cliente_natural]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_registrar_cliente_natural]
/*Parametros para registrar Usuario*/
@Nom_Usuario VARCHAR(50),
@Contraseña VARCHAR(50),
@Pregunta VARCHAR(50),
@Respuesta_Pregunta VARCHAR(50),
@Correo VARCHAR(50),
/*FIN PARAMETROS USUARIO*/
/*Parametro para registrar NIT No necesario*/
@Documento VARCHAR(50),
@Tipo_Documento VARCHAR(4),
@Primer_Nombre VARCHAR(50),
@Segundo_Nombre VARCHAR(50),
@Primer_Apellido VARCHAR(50),
@Segundo_Apellido VARCHAR(50),
@Telefono VARCHAR(14),
@Direccion VARCHAR(50),
@Pagina_Web VARCHAR(50)
AS
BEGIN
/*Si el cliente no posee NIT pasar este parametro como 0*/
/* El sp retorna un 0 si el usuario ya existe o un -1 si se puede registrar exitosamente*/
	DECLARE
	@sn_Usuario int,
	@idTipoDoc int,
	@sn_usuario_existe int	
	
	SELECT @sn_usuario_existe = NULL	
	
	SELECT @sn_usuario_existe = idUsuario FROM Usuario WHERE Nom_Usuario = @Nom_Usuario	
	SELECT @idTipoDoc = idTipo_Documento FROM Tipo_Documento where Tipo_Documento = @Tipo_Documento
	
	IF(@sn_usuario_existe IS NULL)
	BEGIN	
	EXEC @sn_Usuario = sp_registrar_usuario @Nom_Usuario, @Contraseña, @Pregunta, 'Cliente', @Respuesta_Pregunta, @Correo	
	
		INSERT INTO Cliente_Natural 
		VALUES (@sn_Usuario, @idTipoDoc, @Documento, @Primer_Nombre, @Segundo_Nombre, @Primer_Apellido, @Segundo_Apellido, @Telefono, @Direccion, @Pagina_Web)
		RETURN -1	
	END
	ELSE IF(@sn_usuario_existe IS NOT NULL)
	BEGIN
		RETURN 0
	END		
END


GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_factura]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_registrar_factura]
@Nom_Vendedor VARCHAR(50),
@Nom_Empresa VARCHAR(50),
@Nom_Cliente_Natural VARCHAR(50),
@Nom_Cliente_Empresarial VARCHAR(50),
@Forma_Pago VARCHAR(50)
AS
/*Si la factura es para un cliente natural el parametro @Nom_Cliente_Empresarial se pasa vacio '' asi mismo en caso contrario */
BEGIN
DECLARE
	@idFormaPago INT,
	@idVendedor INT,
	@idEmpresa INT,
	@idClienteNatural INT,
	@idClienteEmpresarial INT,
	@idFactura INT
	
	SELECT @idClienteNatural = NULL
	SELECT @idClienteEmpresarial = NULL
	
	SELECT @idFormaPago = idForma_Pago FROM Forma_Pago 
	WHERE Forma_Pago = @Forma_Pago
	
	SELECT @idVendedor = idVendedor FROM Vendedor 
	WHERE Primer_Nombre = @Nom_Vendedor
	
	SELECT @idEmpresa = idEmpresa FROM Empresa 
	WHERE Nombre_Empresa = @Nom_Empresa
	
	SELECT @idClienteNatural = idCliente FROM Cliente_Natural 
	WHERE Primer_Nombre = @Nom_Cliente_Natural
	
	SELECT @idClienteEmpresarial = idCliente_Empresarial FROM Cliente_Empresarial 
	WHERE Nombre_Empresa = @Nom_Cliente_Empresarial
	
	
	INSERT INTO Factura 
	VALUES(@idVendedor, @idEmpresa, @idClienteNatural, @idClienteEmpresarial, @idFormaPago, GETDATE(), 0)
	
	SELECT @idFactura = idFactura FROM Factura
	WHERE Vendedor_idVendedor = @idVendedor
	AND Empresa_idEmpresa = @idEmpresa
	AND Cliente_Natural_idCliente_Natural = @idClienteNatural
	AND Cliente_Empresarial_idCliente_Empresarial = @idClienteEmpresarial
	AND Forma_Pago_idForma_Pago = @idFormaPago
	AND Fecha_Factura = GETDATE()
	
	--RETURN @idFactura
END


GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_producto]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_registrar_producto]
@Categoria VARCHAR(40),
@Nombre_Producto VARCHAR(50),
@Unidades_Disponibles INT,
@Descripcion VARCHAR(50),
@Precio NUMERIC(18,2),
@IVA NUMERIC(18,2)
AS
BEGIN
--El sp retorna un 0 si el producto ya existe y un -1 si se registra exitosamente
	DECLARE
	@idCategoria INT,
	@idProducto INT
	
	SELECT @idCategoria = NULL, @idProducto = NULL
	SELECT @idProducto = idProducto FROM Producto WHERE Nombre_Producto = @Nombre_Producto
	IF(@idProducto IS NULL)
	BEGIN
		SELECT @idCategoria = idCategoria FROM Categoria
		WHERE Categoria = @Categoria
		
		INSERT INTO Producto VALUES (@idCategoria, @Unidades_Disponibles, @Nombre_Producto, @Descripcion, @Precio, @IVA)
		RETURN -1
	END
	ELSE
	BEGIN
		RETURN 0
	END	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_usuario]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_registrar_usuario]
@Nom_Usuario varchar(50),
@Contraseña varchar(50),
@Pregunta varchar(50),
@Rol varchar(50),
@Respuesta_Pregunta varchar(50),
@Correo varchar(50)
AS
BEGIN
	DECLARE
	@sn_existe int,
	@idRol int,
	@idUsuario int
SELECT @sn_existe = NULL

SELECT @sn_existe = idUsuario FROM Usuario
					WHERE Nom_Usuario=@Nom_Usuario					
					
IF (@sn_existe is null)
BEGIN
		SELECT @idRol = idRoles FROM Roles
						WHERE Rol = @Rol
		INSERT INTO Usuario(Nom_Usuario, Contraseña, Correo, Pregunta, Respuesta_Pregunta, Roles_idRoles)
		VALUES (@Nom_Usuario, @Contraseña, @Correo, @Pregunta, @Respuesta_Pregunta, @idRol)		
		
		SELECT @idUsuario = idUsuario FROM Usuario
					WHERE Nom_Usuario=@Nom_Usuario				
		
		RETURN @idUsuario
END
ELSE
		RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_vendedor]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_registrar_vendedor]
/*Parametros para registrar Usuario*/
@Nom_Usuario VARCHAR(50),
@Contraseña VARCHAR(50),
@Pregunta VARCHAR(50),
@Respuesta_Pregunta VARCHAR(50),
@Correo VARCHAR(50),
/*FIN PARAMETROS USUARIO*/
/*Parametro para registrar NIT No necesario*/
@Documento VARCHAR(50),
@Tipo_Documento VARCHAR(4),
@Primer_Nombre VARCHAR(50),
@Segundo_Nombre VARCHAR(50),
@Primer_Apellido VARCHAR(50),
@Segundo_Apellido VARCHAR(50),
@Telefono VARCHAR(14)
AS
BEGIN
/* El sp retorna un 0 si el usuario ya existe o un -1 si se puede registrar exitosamente*/
	DECLARE
	@sn_Usuario int,
	@idTipoDoc int,
	@sn_usuario_existe int	
	
	SELECT @sn_usuario_existe = NULL	
	
	SELECT @sn_usuario_existe = idUsuario FROM Usuario WHERE Nom_Usuario = @Nom_Usuario	
	SELECT @idTipoDoc = idTipo_Documento FROM Tipo_Documento where Tipo_Documento = @Tipo_Documento
	
	IF(@sn_usuario_existe IS NULL)
	BEGIN	
	EXEC @sn_Usuario = sp_registrar_usuario @Nom_Usuario, @Contraseña, @Pregunta, 'Vendedor', @Respuesta_Pregunta, @Correo	
	
		INSERT INTO Vendedor
		VALUES (@sn_Usuario, @idTipoDoc, @Documento, @Primer_Nombre, @Segundo_Nombre, @Primer_Apellido, @Segundo_Apellido, @Telefono)
		RETURN -1	
	END
	ELSE IF(@sn_usuario_existe IS NOT NULL)
	BEGIN
		RETURN 0
	END		
END


GO
/****** Object:  StoredProcedure [dbo].[sp_reporte_factura]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_reporte_factura]
@idFactura int
AS
BEGIN
DECLARE
@idCliNat INT,
@idCliEmp INT

SELECT @idCliNat = null
SELECT @idCliEmp = null

SELECT @idCliNat = F.Cliente_Natural_idCliente_Natural FROM Factura F
WHERE idFactura=@idFactura
SELECT @idCliEmp = F.Cliente_Empresarial_idCliente_Empresarial FROM Factura F
WHERE idFactura=@idFactura

if @idCliNat is not null
BEGIN
    select 'NomCli' = Cliente.Primer_Nombre + ' ' + Cliente.Primer_Apellido,'NomVen' = Vendedor.Primer_Nombre + ' ' + Vendedor.Primer_Apellido,
        'idFactura' = Factura.idFactura, 'FechaFactura' = Factura.Fecha_Factura, 'idProducto' = Producto.idProducto,'ProductoNom' = Producto.Nombre_Producto,
        'CantProducto' = Producto_por_Factura.Cantidad_Producto,'PrecioProducto' = Producto.Precio,'IVAProducto' = Producto.IVA, 'SubTotalProducto' = Producto_por_Factura.Sub_Total,
        'TotalFactura' = Factura.Total, 'NomEmp'= Empresa.Nombre_Empresa
    from Empresa,Cliente_Natural Cliente,Vendedor,Producto_por_Factura, Factura, Producto where Factura_idFactura=@idFactura and Factura.idFactura=@idFactura and Cliente.idCliente=Factura.Cliente_Natural_idCliente_Natural
            and Vendedor.idVendedor=Factura.Vendedor_idVendedor and Producto.idProducto=Producto_por_Factura.Producto_idProducto and Empresa.idEmpresa=Factura.Empresa_idEmpresa;	
END
ELSE
BEGIN
    select 'NomCli' =  Cliente_Empresarial.Nombre_Empresa,'NomVen'= Vendedor.Primer_Nombre +' '+ Vendedor.Segundo_Apellido ,
        'idFactura' = Factura.idFactura, 'FechaFactura' = Factura.Fecha_Factura, 'idProducto' = Producto.idProducto,'ProductoNom' = Producto.Nombre_Producto,
        'CantProducto' = Producto_por_Factura.Cantidad_Producto,'PrecioProducto' = Producto.Precio,'IVAProducto' = Producto.IVA, 'SubTotalProducto' = Producto_por_Factura.Sub_Total,
        'TotalFactura' = Factura.Total, 'NomEmp'= Empresa.Nombre_Empresa
    from Empresa,Cliente_Empresarial,Vendedor,Producto_por_Factura, Factura, Producto where Factura_idFactura=@idFactura and Factura.idFactura=@idFactura and Cliente_Empresarial.idCliente_Empresarial=Factura.Cliente_Empresarial_idCliente_Empresarial
        and Vendedor.idVendedor=Factura.Vendedor_idVendedor and Producto.idProducto=Producto_por_Factura.Producto_idProducto and Empresa.idEmpresa=Factura.Empresa_idEmpresa;	
END
END


GO
/****** Object:  StoredProcedure [dbo].[sp_total_factura]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_total_factura]
@idFactura INT
AS
BEGIN
	DECLARE
	@Total_Factura NUMERIC(18,2)
	
	SELECT @Total_Factura = SUM(Sub_Total) FROM Producto_por_Factura
	WHERE Factura_idFactura = @idFactura
	
	UPDATE Factura SET Total = @Total_Factura
	WHERE idFactura = @idFactura
	
END


GO
/****** Object:  Table [dbo].[Administrador]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Administrador](
	[idAdministrador] [int] IDENTITY(1,1) NOT NULL,
	[Usuario_idUsuario] [int] NOT NULL,
	[Tipo_Documento_idTipo_Documento] [int] NOT NULL,
	[Documento] [varchar](15) NULL,
	[Primer_Nombre] [varchar](30) NOT NULL,
	[Segundo_Nombre] [varchar](30) NULL,
	[Primer_Apellido] [varchar](30) NULL,
	[Segundo_Apellido] [varchar](30) NULL,
	[Telefono] [varchar](14) NULL,
	[Direccion] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[idAdministrador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Usuario_idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categoria](
	[idCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Categoria] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cliente_Empresarial]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente_Empresarial](
	[idCliente_Empresarial] [int] IDENTITY(1,1) NOT NULL,
	[Usuario_idUsuario] [int] NOT NULL,
	[Tipo_Documento_idTipo_Documento] [int] NULL,
	[Documento] [varchar](15) NULL,
	[Nombre_Empresa] [varchar](30) NULL,
	[Telefono] [varchar](14) NULL,
	[Direccion] [varchar](50) NULL,
	[Pagina_Web] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCliente_Empresarial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Usuario_idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cliente_Natural]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente_Natural](
	[idCliente] [int] IDENTITY(1,1) NOT NULL,
	[Usuario_idUsuario] [int] NOT NULL,
	[Tipo_Documento_idTipo_Documento] [int] NULL,
	[Documento] [varchar](15) NULL,
	[Primer_Nombre] [varchar](30) NOT NULL,
	[Segundo_Nombre] [varchar](30) NULL,
	[Primer_Apellido] [varchar](30) NULL,
	[Segundo_Apellido] [varchar](30) NULL,
	[Telefono] [varchar](14) NULL,
	[Direccion] [varchar](50) NULL,
	[Pagina_Web] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Usuario_idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empresa]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empresa](
	[idEmpresa] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_Empresa] [varchar](30) NULL,
	[Tipo_Documento_idTipo_Documento] [int] NULL,
	[Documento] [varchar](15) NULL,
	[Direccion_Empresa] [varchar](50) NULL,
	[Telefono_Empresa] [varchar](14) NULL,
	[Pagina_Web] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[idEmpresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Factura]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Factura](
	[idFactura] [int] IDENTITY(1,1) NOT NULL,
	[Vendedor_idVendedor] [int] NOT NULL,
	[Empresa_idEmpresa] [int] NOT NULL,
	[Cliente_Natural_idCliente_Natural] [int] NULL,
	[Cliente_Empresarial_idCliente_Empresarial] [int] NULL,
	[Forma_Pago_idForma_Pago] [int] NOT NULL,
	[Fecha_Factura] [datetime] NULL,
	[Total] [numeric](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[idFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Forma_Pago]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Forma_Pago](
	[idForma_Pago] [int] IDENTITY(1,1) NOT NULL,
	[Forma_Pago] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[idForma_Pago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Forma_Pago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Producto](
	[idProducto] [int] IDENTITY(1,1) NOT NULL,
	[CateGOria_idCateGOria] [int] NOT NULL,
	[Unidades_disponibles] [int] NULL,
	[Nombre_Producto] [varchar](30) NULL,
	[Descripcion] [varchar](50) NULL,
	[Precio] [numeric](18, 2) NULL,
	[IVA] [numeric](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Producto_por_Factura]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto_por_Factura](
	[idProducto_por_Factura] [int] IDENTITY(1,1) NOT NULL,
	[Producto_idProducto] [int] NOT NULL,
	[Factura_idFactura] [int] NOT NULL,
	[Cantidad_Producto] [int] NULL,
	[Sub_Total] [numeric](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[idProducto_por_Factura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rol]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Rol](
	[id_Rol] [int] NOT NULL,
	[Rol] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Rol] PRIMARY KEY CLUSTERED 
(
	[id_Rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Roles](
	[idRoles] [int] IDENTITY(1,1) NOT NULL,
	[Rol] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[idRoles] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tCiudad]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tCiudad](
	[id_Ciudad] [int] NOT NULL,
	[Ciudad] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tCiudad] PRIMARY KEY CLUSTERED 
(
	[id_Ciudad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tCliente]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tCliente](
	[id_Cliente] [int] NOT NULL,
 CONSTRAINT [PK_tCliente] PRIMARY KEY CLUSTERED 
(
	[id_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tEmpresa]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tEmpresa](
	[id_Empresa] [int] NOT NULL,
	[Nom_Empresa] [varchar](100) NOT NULL,
	[Tipo_Documento_id_Tipo_Documento] [int] NOT NULL,
	[Documento] [varchar](50) NOT NULL,
	[Fcha_Creacion] [datetime] NOT NULL,
	[Fecha_Actualizacion] [datetime] NOT NULL,
	[Ciudad_id_Ciudad] [int] NOT NULL,
 CONSTRAINT [PK_tEmpresa] PRIMARY KEY CLUSTERED 
(
	[id_Empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tipo_Documento]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tipo_Documento](
	[idTipo_Documento] [int] IDENTITY(1,1) NOT NULL,
	[Tipo_Documento] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[idTipo_Documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tPersona]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tPersona](
	[id_Persona] [int] NOT NULL,
	[Primer_Nombre] [varchar](100) NOT NULL,
	[Segundo_Nombre] [varchar](100) NULL,
	[Primer_Apellido] [varchar](100) NOT NULL,
	[Segundo_Apellido] [varchar](100) NULL,
	[Tipo_doc_id_Tipo_Doc] [int] NOT NULL,
	[Documento] [varchar](50) NOT NULL,
	[Ciudad_id_Ciudad] [int] NOT NULL,
	[Fecha_Nacimiento] [datetime] NOT NULL,
	[Usuario_id_Usuario] [int] NOT NULL,
 CONSTRAINT [PK_tPersona] PRIMARY KEY CLUSTERED 
(
	[id_Persona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tTipo_Documento]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tTipo_Documento](
	[id_Tipo_Documento] [int] NOT NULL,
	[Tipo_Documento] [varchar](30) NOT NULL,
 CONSTRAINT [PK_tTipo_Documento] PRIMARY KEY CLUSTERED 
(
	[id_Tipo_Documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tUsuario]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tUsuario](
	[id_Usuario] [int] NOT NULL,
	[Usuario] [varchar](60) NOT NULL,
	[Contraseña] [varchar](60) NOT NULL,
	[fec_ingreso] [datetime] NOT NULL,
	[no_intentos] [int] NULL,
	[Rol_id_Rol] [int] NOT NULL,
	[Pregunta] [varchar](100) NOT NULL,
	[Respuesta] [varchar](100) NOT NULL,
 CONSTRAINT [PK_tUsuario] PRIMARY KEY CLUSTERED 
(
	[id_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Roles_idRoles] [int] NOT NULL,
	[Nom_Usuario] [varchar](30) NULL,
	[Contraseña] [varchar](30) NULL,
	[Pregunta] [varchar](30) NULL,
	[Respuesta_Pregunta] [varchar](30) NULL,
	[Correo] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Nom_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario_por_Empresa]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario_por_Empresa](
	[Usuario_id_Usuario] [int] NOT NULL,
	[Empresa_id_Empresa] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vendedor]    Script Date: 19/03/2013 12:28:11 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Vendedor](
	[idVendedor] [int] IDENTITY(1,1) NOT NULL,
	[Usuario_idUsuario] [int] NOT NULL,
	[Tipo_Documento_idTipo_Documento] [int] NOT NULL,
	[Documento] [varchar](15) NULL,
	[Primer_Nombre] [varchar](30) NOT NULL,
	[Segundo_Nombre] [varchar](30) NULL,
	[Primer_Apellido] [varchar](30) NULL,
	[Segundo_Apellido] [varchar](30) NULL,
	[Telefono] [varchar](14) NULL,
PRIMARY KEY CLUSTERED 
(
	[idVendedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Administrador]  WITH CHECK ADD FOREIGN KEY([Tipo_Documento_idTipo_Documento])
REFERENCES [dbo].[Tipo_Documento] ([idTipo_Documento])
GO
ALTER TABLE [dbo].[Administrador]  WITH CHECK ADD FOREIGN KEY([Usuario_idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[Cliente_Empresarial]  WITH CHECK ADD FOREIGN KEY([Tipo_Documento_idTipo_Documento])
REFERENCES [dbo].[Tipo_Documento] ([idTipo_Documento])
GO
ALTER TABLE [dbo].[Cliente_Empresarial]  WITH CHECK ADD FOREIGN KEY([Usuario_idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[Cliente_Natural]  WITH CHECK ADD FOREIGN KEY([Tipo_Documento_idTipo_Documento])
REFERENCES [dbo].[Tipo_Documento] ([idTipo_Documento])
GO
ALTER TABLE [dbo].[Cliente_Natural]  WITH CHECK ADD FOREIGN KEY([Usuario_idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[Empresa]  WITH CHECK ADD FOREIGN KEY([Tipo_Documento_idTipo_Documento])
REFERENCES [dbo].[Tipo_Documento] ([idTipo_Documento])
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD FOREIGN KEY([Cliente_Natural_idCliente_Natural])
REFERENCES [dbo].[Cliente_Natural] ([idCliente])
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD FOREIGN KEY([Cliente_Empresarial_idCliente_Empresarial])
REFERENCES [dbo].[Cliente_Empresarial] ([idCliente_Empresarial])
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD FOREIGN KEY([Empresa_idEmpresa])
REFERENCES [dbo].[Empresa] ([idEmpresa])
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD FOREIGN KEY([Forma_Pago_idForma_Pago])
REFERENCES [dbo].[Forma_Pago] ([idForma_Pago])
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD FOREIGN KEY([Vendedor_idVendedor])
REFERENCES [dbo].[Vendedor] ([idVendedor])
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD FOREIGN KEY([CateGOria_idCateGOria])
REFERENCES [dbo].[Categoria] ([idCategoria])
GO
ALTER TABLE [dbo].[Producto_por_Factura]  WITH CHECK ADD FOREIGN KEY([Factura_idFactura])
REFERENCES [dbo].[Factura] ([idFactura])
GO
ALTER TABLE [dbo].[Producto_por_Factura]  WITH CHECK ADD FOREIGN KEY([Producto_idProducto])
REFERENCES [dbo].[Producto] ([idProducto])
GO
ALTER TABLE [dbo].[tEmpresa]  WITH CHECK ADD  CONSTRAINT [FK_tEmpresa_tCiudad] FOREIGN KEY([Ciudad_id_Ciudad])
REFERENCES [dbo].[tCiudad] ([id_Ciudad])
GO
ALTER TABLE [dbo].[tEmpresa] CHECK CONSTRAINT [FK_tEmpresa_tCiudad]
GO
ALTER TABLE [dbo].[tEmpresa]  WITH CHECK ADD  CONSTRAINT [FK_tEmpresa_tTipo_Documento] FOREIGN KEY([Tipo_Documento_id_Tipo_Documento])
REFERENCES [dbo].[tTipo_Documento] ([id_Tipo_Documento])
GO
ALTER TABLE [dbo].[tEmpresa] CHECK CONSTRAINT [FK_tEmpresa_tTipo_Documento]
GO
ALTER TABLE [dbo].[tPersona]  WITH CHECK ADD  CONSTRAINT [FK_tPersona_tCiudad] FOREIGN KEY([Ciudad_id_Ciudad])
REFERENCES [dbo].[tCiudad] ([id_Ciudad])
GO
ALTER TABLE [dbo].[tPersona] CHECK CONSTRAINT [FK_tPersona_tCiudad]
GO
ALTER TABLE [dbo].[tPersona]  WITH CHECK ADD  CONSTRAINT [FK_tPersona_tTipo_Documento] FOREIGN KEY([Tipo_doc_id_Tipo_Doc])
REFERENCES [dbo].[tTipo_Documento] ([id_Tipo_Documento])
GO
ALTER TABLE [dbo].[tPersona] CHECK CONSTRAINT [FK_tPersona_tTipo_Documento]
GO
ALTER TABLE [dbo].[tPersona]  WITH CHECK ADD  CONSTRAINT [FK_tPersona_tUsuario] FOREIGN KEY([Usuario_id_Usuario])
REFERENCES [dbo].[tUsuario] ([id_Usuario])
GO
ALTER TABLE [dbo].[tPersona] CHECK CONSTRAINT [FK_tPersona_tUsuario]
GO
ALTER TABLE [dbo].[tUsuario]  WITH CHECK ADD  CONSTRAINT [FK_tUsuario_Rol] FOREIGN KEY([Rol_id_Rol])
REFERENCES [dbo].[Rol] ([id_Rol])
GO
ALTER TABLE [dbo].[tUsuario] CHECK CONSTRAINT [FK_tUsuario_Rol]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD FOREIGN KEY([Roles_idRoles])
REFERENCES [dbo].[Roles] ([idRoles])
GO
ALTER TABLE [dbo].[Usuario_por_Empresa]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_por_Empresa_tEmpresa] FOREIGN KEY([Empresa_id_Empresa])
REFERENCES [dbo].[tEmpresa] ([id_Empresa])
GO
ALTER TABLE [dbo].[Usuario_por_Empresa] CHECK CONSTRAINT [FK_Usuario_por_Empresa_tEmpresa]
GO
ALTER TABLE [dbo].[Usuario_por_Empresa]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_por_Empresa_tUsuario] FOREIGN KEY([Usuario_id_Usuario])
REFERENCES [dbo].[tUsuario] ([id_Usuario])
GO
ALTER TABLE [dbo].[Usuario_por_Empresa] CHECK CONSTRAINT [FK_Usuario_por_Empresa_tUsuario]
GO
ALTER TABLE [dbo].[Vendedor]  WITH CHECK ADD FOREIGN KEY([Tipo_Documento_idTipo_Documento])
REFERENCES [dbo].[Tipo_Documento] ([idTipo_Documento])
GO
ALTER TABLE [dbo].[Vendedor]  WITH CHECK ADD FOREIGN KEY([Usuario_idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
USE [master]
GO
ALTER DATABASE [SistemaPedidos] SET  READ_WRITE 
GO
