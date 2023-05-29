
USE [master]
GO
CREATE DATABASE [ContentJournal]
GO


USE [ContentJournal]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Entries](
	[DatabaseIndex] [int] IDENTITY(1,1) NOT NULL,
	[Text] [nvarchar](MAX) NOT NULL
) ON [PRIMARY]
GO
