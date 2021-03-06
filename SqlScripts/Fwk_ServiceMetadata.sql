
/****** Object:  StoredProcedure [dbo].[fwk_Service_g_Name]    Script Date: 01/27/2011 08:42:59 ******/
DROP PROCEDURE [dbo].[fwk_Service_g_Name]
GO
/****** Object:  StoredProcedure [dbo].[fwk_Service_s_All]    Script Date: 01/27/2011 08:43:00 ******/
DROP PROCEDURE [dbo].[fwk_Service_s_All]
GO
/****** Object:  StoredProcedure [dbo].[fwk_Service_i]    Script Date: 01/27/2011 08:43:00 *****/
DROP PROCEDURE [dbo].[fwk_Service_i]
GO
/****** Object:  StoredProcedure [dbo].[fwk_Service_u]    Script Date: 01/27/2011 08:43:00 ******/
DROP PROCEDURE [dbo].[fwk_Service_u]
GO
DROP PROCEDURE [dbo].[fwk_Service_d]
GO
/****** Object:  Table [dbo].[fwk_Service]    Script Date: 01/27/2011 08:43:00 ******/
DROP TABLE [dbo].[fwk_Service]
GO

/****** Object:  StoredProcedure [dbo].[fwk_Service_d]    Script Date: 12/04/2010 12:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fwk_Service_d]
(

	@Name varchar(255),
	 @ApplicationId varchar(30) = null
)                 
AS

-- Description : Procedimiento Almacenado de Eliminacion de Service
-- Author      : moviedo
-- Date        :02/08/201005:02:04

DELETE FROM 
	fwk_Service
WHERE 
	(
	[Name] = @Name 
	AND  fwk_Service.ApplicationId = @ApplicationId
)
GO
/****** Object:  StoredProcedure [dbo].[fwk_Service_g_Name]    Script Date: 12/04/2010 12:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fwk_Service_g_Name]
	(
	@Name VARCHAR(255),
	 @ApplicationId varchar(30) = null
	)
AS
BEGIN
	SELECT	fwk_Service.*
	FROM	fwk_Service
	WHERE	fwk_Service.Name = @Name
	AND  fwk_Service.ApplicationId = @ApplicationId
END
GO
/****** Object:  StoredProcedure [dbo].[fwk_Service_s_All]    Script Date: 12/04/2010 12:03:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		moviedo
-- Description:	Buscar todos los servicios.
-- =============================================
CREATE PROCEDURE [dbo].[fwk_Service_s_All]

@ApplicationId VARCHAR(30) = NULL

AS

SELECT	 [Name]
		,[Description]
		,Request
		,Response
		,TransactionalBehaviour
		,Handler
		,IsolationLevel
		,Available
		,Audit
		,CreatedDateTime
		,CreatedUserName
		,ApplicationId 
	 FROM fwk_Service
	 
where
(@ApplicationId IS NULL   OR fwk_Service.ApplicationId = @ApplicationId)
GO
/****** Object:  StoredProcedure [dbo].[fwk_Service_i]    Script Date: 12/04/2010 12:03:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fwk_Service_i]
(

	@Name varchar(255),
	@Description varchar(1000)= null,
	@Handler varchar(255),
	@Request varchar(255),
	@Response varchar(255),
	@Available bit,
	@Audit bit,
	@TransactionalBehaviour varchar(20),
	@IsolationLevel varchar(20),
	@CreatedDateTime datetime	= null,
	@CreatedUserName varchar(20)= null,
	@ApplicationId varchar(30) = null
)                 
AS

-- Description : Procedimiento Almacenado de Creacion de Service
-- Author      : moviedo

INSERT INTO fwk_Service
(
	[Name],
	[Description],
	Handler,
	Request,
	Response,
	Available,
	Audit,
	TransactionalBehaviour,
	IsolationLevel,
	ApplicationId,
	CreatedDateTime 	,
	CreatedUserName 
)
VALUES
(
	@Name,
	@Description,
	@Handler,
	@Request,
	@Response,
	@Available,
	@Audit,
	@TransactionalBehaviour,
	@IsolationLevel,
	@ApplicationId,
	@CreatedDateTime	,
	@CreatedUserName 
)
GO
/****** Object:  StoredProcedure [dbo].[fwk_Service_u]    Script Date: 12/04/2010 12:03:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fwk_Service_u]
(

	@Name varchar(255),
	@Description varchar(1000)= null,
	@Handler varchar(255),
	@Request varchar(255),
	@Response varchar(255),
	@Available bit,
	@Audit bit,
	@TransactionalBehaviour varchar(20),
	@IsolationLevel varchar(20),
	@ApplicationId varchar(50) = null,
	@CreatedDateTime datetime	= null,
	@CreatedUserName varchar(20)= null,
	@UpdateServiceName varchar(255)
 
)                 
AS

-- Description : Procedimiento Almacenado de Actualizacion de Service
-- Author      : moviedo
-- Date        : 02/08/2010 05:02:04

UPDATE fwk_Service

 SET 
	[Name] = @Name,
	[Description] = @Description,
	Handler = @Handler,
	Request = @Request,
	Response = @Response,
	Available = @Available,
	Audit = @Audit,
	TransactionalBehaviour = @TransactionalBehaviour,
	IsolationLevel = @IsolationLevel,
	
	CreatedDateTime = @CreatedDateTime ,
	CreatedUserName = @CreatedUserName 
WHERE 
(
	[Name] = @UpdateServiceName  
	AND ApplicationId =	@ApplicationId
)
GO
/****** Object:  Table [dbo].[fwk_Service]    Script Date: 12/04/2010 12:03:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[fwk_Service](
	[Name] [varchar](255) NOT NULL,
	[Description] [varchar](1000) NULL,
	[Handler] [varchar](255) NOT NULL,
	[Request] [varchar](255) NOT NULL,
	[Response] [varchar](255) NOT NULL,
	[Available] [bit] NOT NULL,
	[Audit] [bit] NOT NULL,
	[TransactionalBehaviour] [varchar](20) NOT NULL,
	[IsolationLevel] [varchar](20) NOT NULL,
	[ApplicationId] [nchar](50) NOT NULL,
	[CreatedDateTime] [datetime] NULL,
	[CreatedUserName] [varchar](20) NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED 
(
	[Name] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del servicio.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Descripción del servicio.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del assembly y fullname de la clase de servicio.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'Handler'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del assembly y fullname de la clase de request.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'Request'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del assembly y fullname de la clase de response.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'Response'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Indica si el servicio está disponible para ser ejecutado. Valores posibles: true / false.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'Available'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Indica si la ejecución del servicio debe ser auditada o no. Valores posibles: true / false.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'Audit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Define el comportamiento transaccional del servicio raíz.

*Required: el servicio transacciona. Si hay un ámbito transaccional ya abierto, utiliza el existente, en caso contrario crea una nueva transaccion.

*RequiresNew: Siempre se crea una nueva transacción.
 
*Suppress: no transacciona, todas las operaciones se hacen sin estar en un ámbito transaccional. ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'TransactionalBehaviour'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Especifica el nivel de aislamiento de la transacción.

*Chaos: los cambios pendientes de transacciones más aisladas no puede ser sobreescritos.

*ReadCommitted: los datos volátites no puede ser leidos durante la transacción, pero pueden ser modificados.

*ReadUncommitted: los datos volátines pueden ser leidos y modificados durante la transacción.

*RepeatableRead: los datos volátiles pueden ser leidos pero no modificados durante la transación. Nuevos datos pueden ser creados.

*Serializable: los datos volátiles pueden ser leidos pero no modificados, y no es posible crear nuevos datos durante la transacción.

*Snapshot: los datos volátiles pueden ser leidos. Antes de modificarse datos,  se verifica que otra transacción los haya cambiado luego de haber sido leidos. Si los datos se actualizaron, se levanta un error.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_Service', @level2type=N'COLUMN',@level2name=N'IsolationLevel'
GO
