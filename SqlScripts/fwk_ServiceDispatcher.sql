
GO

/****** Object:  Table [dbo].[fwk_ServiceDispatcher]    Script Date: 07/03/2014 10:36:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[fwk_ServiceDispatcher](
	[InstanseName] [varchar](200) NOT NULL,
	[AuditMode] [smallint] NOT NULL,
	[HostIp] [varchar](50) NOT NULL,
	[HostName] [varchar](100) NOT NULL,
	[CompanyName] [varchar](100) NOT NULL,
	[Logo] [varbinary](1000) NULL,
	[InstanseId] [uniqueidentifier] NULL,
	[Url_URI] [varchar](1000) NULL,
	[Port] [int] NULL,
 CONSTRAINT [PK_fwk_ServiceDispatcher_1] PRIMARY KEY CLUSTERED 
(
	[InstanseName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Required=0, Optional=1, None=3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'fwk_ServiceDispatcher', @level2type=N'COLUMN',@level2name=N'AuditMode'
GO


