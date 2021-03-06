SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[patient]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[patient](
	[id] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[gender] [nvarchar](50) NOT NULL,
	[comment] [ntext] NULL,
	[time] [datetime] NOT NULL,
 CONSTRAINT [PK_patient] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[doctor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[doctor](
	[id] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[gender] [nvarchar](50) NOT NULL,
	[depart] [nvarchar](50) NOT NULL,
	[comment] [ntext] NULL,
 CONSTRAINT [PK_doctor] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[drug]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[drug](
	[id] [nchar](50) NOT NULL,
	[name] [nchar](50) NOT NULL,
	[price] [real] NOT NULL,
	[type] [nchar](20) NOT NULL,
	[comment] [ntext] NULL,
	[count] [int] NOT NULL CONSTRAINT [DF_Drug_count]  DEFAULT ((0)),
 CONSTRAINT [PK_Drug] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[presc]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[presc](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[patient] [nvarchar](50) NOT NULL,
	[doctor] [nvarchar](50) NOT NULL,
	[time] [datetime] NOT NULL,
	[comment] [ntext] NULL,
 CONSTRAINT [PK_order] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[drugcount]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[drugcount](
	[presc] [bigint] NOT NULL,
	[drug] [nchar](50) NOT NULL,
	[count] [int] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_presc_doctor]') AND parent_object_id = OBJECT_ID(N'[dbo].[presc]'))
ALTER TABLE [dbo].[presc]  WITH CHECK ADD  CONSTRAINT [FK_presc_doctor] FOREIGN KEY([doctor])
REFERENCES [dbo].[doctor] ([id])
GO
ALTER TABLE [dbo].[presc] CHECK CONSTRAINT [FK_presc_doctor]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_presc_patient]') AND parent_object_id = OBJECT_ID(N'[dbo].[presc]'))
ALTER TABLE [dbo].[presc]  WITH CHECK ADD  CONSTRAINT [FK_presc_patient] FOREIGN KEY([patient])
REFERENCES [dbo].[patient] ([id])
GO
ALTER TABLE [dbo].[presc] CHECK CONSTRAINT [FK_presc_patient]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_drugcount_drug]') AND parent_object_id = OBJECT_ID(N'[dbo].[drugcount]'))
ALTER TABLE [dbo].[drugcount]  WITH CHECK ADD  CONSTRAINT [FK_drugcount_drug] FOREIGN KEY([drug])
REFERENCES [dbo].[drug] ([id])
GO
ALTER TABLE [dbo].[drugcount] CHECK CONSTRAINT [FK_drugcount_drug]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_drugcount_presc]') AND parent_object_id = OBJECT_ID(N'[dbo].[drugcount]'))
ALTER TABLE [dbo].[drugcount]  WITH CHECK ADD  CONSTRAINT [FK_drugcount_presc] FOREIGN KEY([presc])
REFERENCES [dbo].[presc] ([id])
GO
ALTER TABLE [dbo].[drugcount] CHECK CONSTRAINT [FK_drugcount_presc]
