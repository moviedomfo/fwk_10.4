USE [FwkBlocking]
GO
/****** Object:  Table [dbo].[BlockingMarks]    Script Date: 01/11/2017 17:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BlockingMarks](
	[BlockingId] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [varchar](100) NOT NULL,
	[Attribute] [varchar](100) NOT NULL,
	[AttValue] [varchar](100) NOT NULL,
	[TTL] [int] NOT NULL,
	[UserName] [varchar](32) NOT NULL,
	[FwkGuid] [uniqueidentifier] NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[Process] [varchar](50) NULL,
 CONSTRAINT [PK_BlockingMarks] PRIMARY KEY CLUSTERED 
(
	[BlockingId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre de la tabla.-' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BlockingMarks', @level2type=N'COLUMN',@level2name=N'TableName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Atributo de la tabla o combinacion de este.- EJ CodigoPedido + IdCliente' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BlockingMarks', @level2type=N'COLUMN',@level2name=N'Attribute'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Time-To-Live.-' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BlockingMarks', @level2type=N'COLUMN',@level2name=N'TTL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Usuario que realizo el bloqueo.-' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BlockingMarks', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Guid del contexto de bloqueo.-' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BlockingMarks', @level2type=N'COLUMN',@level2name=N'FwkGuid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de epiracion de bloqueo.- (Current DateTime + TTL)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BlockingMarks', @level2type=N'COLUMN',@level2name=N'DueDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del proceso de negocio que realizo el bloqueo.-' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BlockingMarks', @level2type=N'COLUMN',@level2name=N'Process'
GO
/****** Object:  StoredProcedure [dbo].[BlockingMarks_s]    Script Date: 01/11/2017 17:06:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------  
-- Author     : HEBRAIDA
-- Date       : 2010-06-15 10:00:00
-- Description: Busca marcas por parámetros
-- Jira		  : [BB-1245]
--------------------------------------------------------------------------------------------  
CREATE PROCEDURE [dbo].[BlockingMarks_s]
(	
	@BlockingId INT = NULL,
	@TableName varchar(100) = NULL,
	@Attribute varchar(100) = NULL,
	@AttValue varchar(100) = NULL,
	
	@UserName varchar(32) = NULL,
	@FwkGuid uniqueidentifier = NULL,
	@DueDate datetime = NULL,
	@Process varchar(50) = NULL
)
As

DECLARE @sql        nvarchar(4000)      
DECLARE @parametros nvarchar(4000)    

SET @sql = N' 
			SELECT 
				BlockingId,
				TableName,
				Attribute,
				AttValue,
				TTL,
				UserName,
				FwkGuid,
				DueDate,
				Process
			FROM
				BlockingMarks
			WHERE
				(@BlockingId IS NULL OR BlockingMarks.BlockingId = @BlockingId) AND 
				(@TableName IS NULL OR BlockingMarks.TableName = @TableName) AND 
				(@Attribute IS NULL OR BlockingMarks.Attribute = @Attribute) AND 
				(@AttValue IS NULL OR BlockingMarks.AttValue = @AttValue) AND 
				
				(@UserName IS NULL OR BlockingMarks.UserName = @UserName) AND 
				(@FwkGuid IS NULL OR BlockingMarks.FwkGuid = @FwkGuid) AND 
				(@DueDate IS NULL OR BlockingMarks.DueDate = @DueDate) AND 
				(@Process IS NULL OR BlockingMarks.Process = @Process) '

SELECT @parametros =  '  
						@BlockingId INT,
						@TableName varchar(100),
						@Attribute varchar(100),
						@AttValue varchar(100),
						@UserName varchar(32),
						@FwkGuid uniqueidentifier,
						@DueDate datetime,
						@Process varchar(50) '

EXEC sp_executesql	@sql, @parametros, 
					@BlockingId, 
					@TableName,
					@Attribute, 
					@AttValue,	
					@UserName,
					@FwkGuid, 
					@DueDate, 
					@Process
GO
/****** Object:  StoredProcedure [dbo].[BlockingMarks_i]    Script Date: 01/11/2017 17:06:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BlockingMarks_i]
(


	@BlockingId int OUTPUT,
	@TableName varchar(100),
	@Attribute varchar(100),
	@AttValue varchar(100),
	@TTL int,
	@UserName varchar(32),
	@FwkGuid uniqueidentifier,
	@Process varchar (100)
)                 
AS

-- Description : Procedimiento Almacenado de Creacion de BlockingMarks
-- Author      : 
-- Date        : 2005-05-16 10:15:17

INSERT INTO BlockingMarks
(
	TableName,
	Attribute,
	AttValue,
	TTL,
	UserName,
	FwkGuid,
	DueDate,Process
)
VALUES
(
	@TableName,
	@Attribute,
	@AttValue,
	@TTL,
	@UserName,
	@FwkGuid,
	DATEADD(second, @TTL, GETDATE()),
	@Process
)
    
SELECT @BlockingId = @@IDENTITY
GO
/****** Object:  StoredProcedure [dbo].[BlockingMarks_g_ExistUser]    Script Date: 01/11/2017 17:06:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
-- Description : Busca marcas de bloqueo y retorna usuarios
--		
-- Author      : moviedo
-- Date        : 2005-05-16 10:15:17

			           
CREATE PROCEDURE [dbo].[BlockingMarks_g_ExistUser]
(
	 @BlockingId int =NULL,
	 @FwkGuid uniqueidentifier =NULL,
	 @TableName varchar(100)=NULL,
	 @Attribute varchar(100)=NULL,
	 @AttValue varchar(100)=NULL,
@Process varchar (100) =null
)
AS



Select Username
From BlockingMarks
Where 
(@BlockingId is null or BlockingId = @BlockingId)
and
(@FwkGuid is null or FwkGuid = @FwkGuid)
and
(@TableName is null or TableName = @TableName)
and
(@AttValue is null or AttValue = @AttValue)

and
(@Process is null or Process = @Process)
GO
/****** Object:  StoredProcedure [dbo].[BlockingMarks_g_Exist]    Script Date: 01/11/2017 17:06:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
-- Description : Busca marcas de bloqueo y retorna usuarios
--		
-- Author      : moviedo
-- Date        : 2005-05-16 10:15:17

			           
CREATE PROCEDURE [dbo].[BlockingMarks_g_Exist]
(
	 @BlockingId int =NULL,
	 @FwkGuid uniqueidentifier =NULL,
	 @Exist bit OUTPUT
--	 @TableName varchar(100)=NULL,
--	 @Attribute varchar(100)=NULL,
--	 @AttValue varchar(100)=NULL,
--	 @Process varchar (100) =null,
)
AS


set @Exist = 0
Select Username
From BlockingMarks
Where 
(@BlockingId is null or BlockingId = @BlockingId)
and
(@FwkGuid is null or FwkGuid = @FwkGuid)

if @@rowcount <> 0 
 		set @Exist = 1
GO
/****** Object:  StoredProcedure [dbo].[BlockingMarks_d_Specific]    Script Date: 01/11/2017 17:06:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BlockingMarks_d_Specific]
(
	@TableName varchar(100),
	@Attribute varchar(100),
	@AttValue varchar(100)
)

AS

-- Author      : moviedo
-- Date        : 2005-08-03

DELETE FROM BlockingMarks
WHERE TableName = @TableName
And Attribute = @Attribute
And AttValue = @AttValue
GO
/****** Object:  StoredProcedure [dbo].[BlockingMarks_d_clear]    Script Date: 01/11/2017 17:06:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BlockingMarks_d_clear]
(
	@Count INT OUTPUT
)
AS

-- Description :	Procedimiento Almacenado de Borrado de BlockingMarks según TTL.
--		Borra todas las marcas de bloqueo que se hayan vencido al momento en que se ejecuta el procedimiento.
-- Author      : moviedo
-- Date        : 2005-05-16 10:15:17

DECLARE @Now DATETIME
SET @Now = GETDATE()



DELETE FROM BlockingMarks
WHERE @Now > DueDate

SET @Count = @@ROWCOUNT
GO
/****** Object:  StoredProcedure [dbo].[BlockingMarks_d]    Script Date: 01/11/2017 17:06:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------  
-- Author     : moviedo
-- Date       : 2017-01-15 10:00:00
-- Description: Se agrega default null a ambos parametros
-- Jira		  : [BB-1245]
--------------------------------------------------------------------------------------------  
CREATE PROCEDURE [dbo].[BlockingMarks_d]
(
	
	@BlockingId int = NULL,
	@FwkGuid UNIQUEIDENTIFIER = NULL
)
AS




DELETE FROM BlockingMarks
WHERE
(@BlockingId is null or BlockingId = @BlockingId)
and
(@FwkGuid is null or FwkGuid = @FwkGuid)
GO
/****** Object:  StoredProcedure [dbo].[BlockingMarks_c]    Script Date: 01/11/2017 17:06:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BlockingMarks_c]

	@FwkGuid UNIQUEIDENTIFIER

AS

-- Description : Procedimiento Almacenado de Consulta de BlockingMarks según ContextId
-- Author      : moviedo
-- Date        : 2005-05-16 10:15:17

SELECT * FROM BlockingMarks
WHERE FwkGuid = @FwkGuid
GO
