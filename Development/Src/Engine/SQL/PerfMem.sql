USE [PerfMem]
GO
/****** Object:  User [tableau]    Script Date: 07/18/2008 03:15:14 ******/
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'tableau')
CREATE USER [tableau] FOR LOGIN [tableau] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Tags]    Script Date: 07/18/2008 03:15:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tags]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tags](
	[TagID] [int] IDENTITY(1,1) NOT NULL,
	[Tag] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[TagID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StatGroups]    Script Date: 07/18/2008 03:15:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StatGroups]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[StatGroups](
	[StatGroupID] [int] IDENTITY(1,1) NOT NULL,
	[StatGroupName] [varchar](255) NOT NULL,
 CONSTRAINT [PK_StatGroups] PRIMARY KEY CLUSTERED 
(
	[StatGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TaskParameters]    Script Date: 07/18/2008 03:15:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaskParameters]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TaskParameters](
	[TaskParameterID] [int] IDENTITY(1,1) NOT NULL,
	[TaskParameter] [varchar](255) NOT NULL,
 CONSTRAINT [PK_TaskParameters] PRIMARY KEY CLUSTERED 
(
	[TaskParameterID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Games]    Script Date: 07/18/2008 03:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Games]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Games](
	[GameID] [int] IDENTITY(1,1) NOT NULL,
	[GameName] [char](32) NOT NULL,
 CONSTRAINT [PK_Games] PRIMARY KEY CLUSTERED 
(
	[GameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Levels]    Script Date: 07/18/2008 03:14:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Levels]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Levels](
	[LevelID] [int] IDENTITY(1,1) NOT NULL,
	[LevelName] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Levels] PRIMARY KEY CLUSTERED 
(
	[LevelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Platforms]    Script Date: 07/18/2008 03:14:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Platforms]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Platforms](
	[PlatformID] [int] IDENTITY(1,1) NOT NULL,
	[PlatformName] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Platforms] PRIMARY KEY CLUSTERED 
(
	[PlatformID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tasks]    Script Date: 07/18/2008 03:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tasks]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tasks](
	[TaskID] [int] IDENTITY(1,1) NOT NULL,
	[TaskDescription] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Tasks] PRIMARY KEY CLUSTERED 
(
	[TaskID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Configs]    Script Date: 07/18/2008 03:14:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Configs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Configs](
	[ConfigID] [int] IDENTITY(1,1) NOT NULL,
	[ConfigName] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Configs] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Results]    Script Date: 07/18/2008 03:14:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Results]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Results](
	[ResultID] [int] IDENTITY(1,1) NOT NULL,
	[ResultDescription] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Results] PRIMARY KEY CLUSTERED 
(
	[ResultID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 07/18/2008 03:14:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Locations]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Locations](
	[LocationID] [int] IDENTITY(1,1) NOT NULL,
	[LocX] [int] NOT NULL,
	[LocY] [int] NOT NULL,
	[LocZ] [int] NOT NULL,
	[RotYaw] [int] NOT NULL,
	[RotPitch] [int] NOT NULL,
	[RotRoll] [int] NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Locations]') AND name = N'_dta_index_Locations_6_491148795__K4_K2_K3_K5_K6_K7_1')
CREATE NONCLUSTERED INDEX [_dta_index_Locations_6_491148795__K4_K2_K3_K5_K6_K7_1] ON [dbo].[Locations] 
(
	[LocZ] ASC,
	[LocX] ASC,
	[LocY] ASC,
	[RotYaw] ASC,
	[RotPitch] ASC,
	[RotRoll] ASC
)
INCLUDE ( [LocationID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CmdLines]    Script Date: 07/18/2008 03:14:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CmdLines]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CmdLines](
	[CmdLineID] [int] IDENTITY(1,1) NOT NULL,
	[CmdLine] [varchar](max) NOT NULL,
 CONSTRAINT [PK_CmdLines] PRIMARY KEY CLUSTERED 
(
	[CmdLineID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GameTypes]    Script Date: 07/18/2008 03:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GameTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GameTypes](
	[GameTypeID] [int] IDENTITY(1,1) NOT NULL,
	[GameType] [varchar](64) NOT NULL,
 CONSTRAINT [PK_GameTypes] PRIMARY KEY CLUSTERED 
(
	[GameTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Machines]    Script Date: 07/18/2008 03:14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Machines]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Machines](
	[MachineID] [int] IDENTITY(1,1) NOT NULL,
	[MachineName] [char](32) NOT NULL,
 CONSTRAINT [PK_Machines] PRIMARY KEY CLUSTERED 
(
	[MachineID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 07/18/2008 03:15:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GamePlayers]    Script Date: 07/18/2008 03:14:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GamePlayers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GamePlayers](
	[GamePlayerID] [int] IDENTITY(1,1) NOT NULL,
	[GamePlayerName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_GamePlayers] PRIMARY KEY CLUSTERED 
(
	[GamePlayerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GameEvents]    Script Date: 07/18/2008 03:14:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GameEvents]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GameEvents](
	[GameEventID] [int] IDENTITY(1,1) NOT NULL,
	[GameEventName] [varchar](128) NOT NULL,
 CONSTRAINT [PK_GameEvents] PRIMARY KEY CLUSTERED 
(
	[GameEventID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SubLevels]    Script Date: 07/18/2008 03:15:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubLevels]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SubLevels](
	[SubLevelID] [int] IDENTITY(1,1) NOT NULL,
	[SubLevelName] [varchar](64) NULL,
 CONSTRAINT [PK_SubLevels] PRIMARY KEY CLUSTERED 
(
	[SubLevelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Resolutions]    Script Date: 07/18/2008 03:14:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Resolutions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Resolutions](
	[ResolutionID] [int] IDENTITY(1,1) NOT NULL,
	[ResolutionName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Resolutions] PRIMARY KEY CLUSTERED 
(
	[ResolutionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Runs]    Script Date: 07/18/2008 03:15:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Runs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Runs](
	[RunID] [int] IDENTITY(1,1) NOT NULL,
	[ResultID] [int] NOT NULL,
	[PlatformID] [int] NOT NULL,
	[ConfigID] [int] NOT NULL,
	[Changelist] [int] NOT NULL,
	[MachineID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[GameID] [int] NOT NULL,
	[GameTypeID] [int] NOT NULL,
	[TaskID] [int] NOT NULL,
	[TaskParameterID] [int] NOT NULL,
	[LevelID] [int] NOT NULL,
	[TagID] [int] NOT NULL,
	[CmdLineID] [int] NOT NULL,
	[Date] [datetime] NOT NULL CONSTRAINT [DF_Runs_Date]  DEFAULT (getdate()),
	[ResolutionID] [int] NULL,
 CONSTRAINT [PK_Runs] PRIMARY KEY CLUSTERED 
(
	[RunID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Runs]') AND name = N'_dta_index_Runs_6_651149365__K10_K12_K3_K5_K1')
CREATE NONCLUSTERED INDEX [_dta_index_Runs_6_651149365__K10_K12_K3_K5_K1] ON [dbo].[Runs] 
(
	[TaskID] ASC,
	[LevelID] ASC,
	[PlatformID] ASC,
	[Changelist] ASC,
	[RunID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Runs]') AND name = N'_dta_index_Runs_6_651149365__K5_K12_K16_K10_K1_3')
CREATE NONCLUSTERED INDEX [_dta_index_Runs_6_651149365__K5_K12_K16_K10_K1_3] ON [dbo].[Runs] 
(
	[Changelist] ASC,
	[LevelID] ASC,
	[ResolutionID] ASC,
	[TaskID] ASC,
	[RunID] ASC
)
INCLUDE ( [PlatformID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stats]    Script Date: 07/18/2008 03:15:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Stats]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Stats](
	[StatID] [int] IDENTITY(1,1) NOT NULL,
	[StatGroupID] [int] NOT NULL,
	[StatName] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Stats] PRIMARY KEY CLUSTERED 
(
	[StatID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RunData]    Script Date: 07/18/2008 03:14:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RunData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RunData](
	[RunDataID] [bigint] IDENTITY(1,1) NOT NULL,
	[RunID] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
	[StatID] [int] NOT NULL,
	[StatValue] [float] NOT NULL,
	[SubLevelID] [int] NULL,
 CONSTRAINT [PK_RunData] PRIMARY KEY CLUSTERED 
(
	[RunDataID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RunData]') AND name = N'_dta_index_RunData_6_731149650__K2_K1_K4')
CREATE NONCLUSTERED INDEX [_dta_index_RunData_6_731149650__K2_K1_K4] ON [dbo].[RunData] 
(
	[RunID] ASC,
	[RunDataID] ASC,
	[StatID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RunData]') AND name = N'IX_RunData_LocationID')
CREATE NONCLUSTERED INDEX [IX_RunData_LocationID] ON [dbo].[RunData] 
(
	[LocationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RunData]') AND name = N'IX_RunData_RunID')
CREATE NONCLUSTERED INDEX [IX_RunData_RunID] ON [dbo].[RunData] 
(
	[RunID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RunData]') AND name = N'IX_RunData_StatID')
CREATE NONCLUSTERED INDEX [IX_RunData_StatID] ON [dbo].[RunData] 
(
	[StatID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RunData]') AND name = N'IX_RunData_SubLevelID')
CREATE NONCLUSTERED INDEX [IX_RunData_SubLevelID] ON [dbo].[RunData] 
(
	[SubLevelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GameEventsData]    Script Date: 07/18/2008 03:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GameEventsData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GameEventsData](
	[GearsEventsDataID] [bigint] IDENTITY(1,1) NOT NULL,
	[RunID] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
	[PlayerID] [int] NOT NULL,
	[TargetPlayerID] [int] NOT NULL,
	[GameEventID] [int] NULL,
	[GameEventDescID] [int] NOT NULL,
	[SecondsFromStart] [float] NOT NULL,
 CONSTRAINT [PK_GearsStatsData] PRIMARY KEY CLUSTERED 
(
	[GearsEventsDataID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[GameEventDescs]    Script Date: 07/18/2008 03:14:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GameEventDescs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GameEventDescs](
	[GameEventDescID] [int] IDENTITY(1,1) NOT NULL,
	[GameEventID] [int] NOT NULL,
	[GameEventDesc] [varchar](128) NOT NULL,
 CONSTRAINT [PK_GameEventDescs] PRIMARY KEY CLUSTERED 
(
	[GameEventDescID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[RunDataView]    Script Date: 07/18/2008 03:15:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[RunDataView]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[RunDataView]
WITH SCHEMABINDING 
AS
SELECT     dbo.Users.UserName, dbo.StatGroups.StatGroupName, dbo.Locations.LocX, dbo.Locations.LocY, dbo.Locations.LocZ, dbo.Locations.RotYaw, dbo.Locations.RotPitch, 
                      dbo.Locations.RotRoll, dbo.Levels.LevelName, dbo.GameTypes.GameType, dbo.Games.GameName, dbo.Configs.ConfigName, dbo.CmdLines.CmdLine, 
                      dbo.Machines.MachineName, dbo.Stats.StatName, dbo.Platforms.PlatformName, dbo.Results.ResultDescription, dbo.TaskParameters.TaskParameter, dbo.Tags.Tag, 
                      dbo.RunData.StatValue, dbo.Runs.Date, dbo.Runs.Changelist, dbo.Tasks.TaskDescription, dbo.Locations.LocationID, dbo.Resolutions.ResolutionName, 
                      dbo.SubLevels.SubLevelName
FROM         dbo.Levels INNER JOIN
                      dbo.CmdLines INNER JOIN
                      dbo.RunData INNER JOIN
                      dbo.Locations ON dbo.RunData.LocationID = dbo.Locations.LocationID INNER JOIN
                      dbo.Runs ON dbo.RunData.RunID = dbo.Runs.RunID INNER JOIN
                      dbo.Machines ON dbo.Runs.MachineID = dbo.Machines.MachineID INNER JOIN
                      dbo.Platforms ON dbo.Runs.PlatformID = dbo.Platforms.PlatformID INNER JOIN
                      dbo.Results ON dbo.Runs.ResultID = dbo.Results.ResultID ON dbo.CmdLines.CmdLineID = dbo.Runs.CmdLineID INNER JOIN
                      dbo.Configs ON dbo.Runs.ConfigID = dbo.Configs.ConfigID INNER JOIN
                      dbo.Games ON dbo.Runs.GameID = dbo.Games.GameID INNER JOIN
                      dbo.GameTypes ON dbo.Runs.GameTypeID = dbo.GameTypes.GameTypeID ON dbo.Levels.LevelID = dbo.Runs.LevelID INNER JOIN
                      dbo.Stats ON dbo.RunData.StatID = dbo.Stats.StatID INNER JOIN
                      dbo.StatGroups ON dbo.Stats.StatGroupID = dbo.StatGroups.StatGroupID INNER JOIN
                      dbo.Tags ON dbo.Runs.TagID = dbo.Tags.TagID INNER JOIN
                      dbo.TaskParameters ON dbo.Runs.TaskParameterID = dbo.TaskParameters.TaskParameterID INNER JOIN
                      dbo.Tasks ON dbo.Runs.TaskID = dbo.Tasks.TaskID INNER JOIN
                      dbo.Users ON dbo.Runs.UserID = dbo.Users.UserID INNER JOIN
                      dbo.Resolutions ON dbo.Runs.ResolutionID = dbo.Resolutions.ResolutionID INNER JOIN
                      dbo.SubLevels ON dbo.RunData.SubLevelID = dbo.SubLevels.SubLevelID
'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'RunDataView', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[49] 4[20] 2[22] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Levels"
            Begin Extent = 
               Top = 6
               Left = 830
               Bottom = 93
               Right = 990
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CmdLines"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 93
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Locations"
            Begin Extent = 
               Top = 6
               Left = 1028
               Bottom = 161
               Right = 1188
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Runs"
            Begin Extent = 
               Top = 238
               Left = 847
               Bottom = 534
               Right = 1019
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Machines"
            Begin Extent = 
               Top = 96
               Left = 38
               Bottom = 183
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Platforms"
            Begin Extent = 
               Top = 96
               Left = 236
               Bottom = 183
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Results"
            Begin Extent = 
               Top = 96
               Left = 434
               Bottom = 183
               Right = 606
            End
            DisplayFlags = 280
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RunDataView'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane2' , N'SCHEMA',N'dbo', N'VIEW',N'RunDataView', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'            TopColumn = 0
         End
         Begin Table = "Configs"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 93
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Games"
            Begin Extent = 
               Top = 6
               Left = 434
               Bottom = 93
               Right = 594
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameTypes"
            Begin Extent = 
               Top = 6
               Left = 632
               Bottom = 93
               Right = 792
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Stats"
            Begin Extent = 
               Top = 186
               Left = 38
               Bottom = 288
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "StatGroups"
            Begin Extent = 
               Top = 161
               Left = 1173
               Bottom = 248
               Right = 1338
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tags"
            Begin Extent = 
               Top = 354
               Left = 541
               Bottom = 441
               Right = 701
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TaskParameters"
            Begin Extent = 
               Top = 211
               Left = 440
               Bottom = 298
               Right = 612
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tasks"
            Begin Extent = 
               Top = 235
               Left = 644
               Bottom = 329
               Right = 808
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 256
               Left = 1097
               Bottom = 343
               Right = 1257
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Resolutions"
            Begin Extent = 
               Top = 6
               Left = 1226
               Bottom = 93
               Right = 1392
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SubLevels"
            Begin Extent = 
               Top = 385
               Left = 178
               Bottom = 472
               Right = 338
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RunData"
            Begin Extent = 
               Top = 96
               Left = 644
               Bottom = 249
               Right = 804
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RunDataView'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'RunDataView', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RunDataView'
GO
/****** Object:  StoredProcedure [dbo].[BeginRun]    Script Date: 07/18/2008 03:14:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BeginRun]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BeginRun]
	@PlatformName varchar(64) = ''Unknown'',
	@ConfigName varchar(64) = ''Unknown'',
	@Changelist int = -1,
	@MachineName varchar(32) = ''Unknown'',
	@UserName varchar(64) = ''Unknown'',
	@GameName varchar(32) = ''Unknown'',
	@ResolutionName varchar(32) = ''Unknown'',
	@GameType varchar(64) = ''Unknown'',
	@TaskDescription varchar(255) = ''Unknown'',
	@TaskParameter varchar(255) = ''Unknown'',
	@LevelName varchar(64) = ''Unknown'',
	@Tag varchar(64) = '''',
	@CmdLine varchar(MAX) = '''',
	@Date datetime = NULL
AS
BEGIN
	BEGIN TRANSACTION

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Get ResultID, add if it doesn''t exist yet.
		DECLARE @ResultID int
		SET @ResultID = (SELECT ResultID FROM dbo.Results WHERE ResultDescription = ''Unknown'')
		IF (@ResultID IS NULL)
		BEGIN
			INSERT INTO dbo.Results (ResultDescription) VALUES (''Unknown'')
			SET @ResultID = @@IDENTITY
		END

		-- Get PlatformID, add if it doesn''t exist yet.
		DECLARE @PlatformID int
		SET @PlatformID = (SELECT PlatformID FROM dbo.Platforms WHERE PlatformName = @PlatformName)
		IF (@PlatformID IS NULL)
		BEGIN
			INSERT INTO dbo.Platforms (PlatformName) VALUES (@PlatformName)
			SET @PlatformID = @@IDENTITY
		END

		-- Get ConfigID, add if it doesn''t exist yet.
		DECLARE @ConfigID int
		SET @ConfigID = (SELECT ConfigID FROM dbo.Configs WHERE ConfigName = @ConfigName)
		IF (@ConfigID IS NULL)
		BEGIN
			INSERT INTO dbo.Configs (ConfigName) VALUES (@ConfigName)
			SET @ConfigID = @@IDENTITY
		END

		-- Get MachineID, add if it doesn''t exist yet.
		DECLARE @MachineID int
		SET @MachineID = (SELECT MachineID FROM dbo.Machines WHERE MachineName = @MachineName)
		IF (@MachineID IS NULL)
		BEGIN
			INSERT INTO dbo.Machines (MachineName) VALUES (@MachineName)
			SET @MachineID = @@IDENTITY
		END

		-- Get UserID, add if it doesn''t exist yet.
		DECLARE @UserID int
		SET @UserID = (SELECT UserID FROM dbo.Users WHERE UserName = @UserName)
		IF (@UserID IS NULL)
		BEGIN
			INSERT INTO dbo.Users (UserName) VALUES (@UserName)
			SET @UserID = @@IDENTITY
		END

		-- Get GameID, add if it doesn''t exist yet.
		DECLARE @GameID int
		SET @GameID = (SELECT GameID FROM dbo.Games WHERE GameName = @GameName)
		IF (@GameID IS NULL)
		BEGIN
			INSERT INTO dbo.Games (GameName) VALUES (@GameName)
			SET @GameID = @@IDENTITY
		END

		-- Get ResolutionID, add if it doesn''t exist yet.
		DECLARE @ResolutionID int
		SET @ResolutionID = (SELECT ResolutionID FROM dbo.Resolutions WHERE ResolutionName = @ResolutionName)
		IF (@ResolutionID IS NULL)
		BEGIN
			INSERT INTO dbo.Resolutions (ResolutionName) VALUES (@ResolutionName)
			SET @ResolutionID = @@IDENTITY
		END

		-- Get GameTypeID, add if it doesn''t exist yet.
		DECLARE @GameTypeID int
		SET @GameTypeID = (SELECT GameTypeID FROM dbo.GameTypes WHERE GameType = @GameType)
		IF (@GameTypeID IS NULL)
		BEGIN
			INSERT INTO dbo.GameTypes (GameType) VALUES (@GameType)
			SET @GameTypeID = @@IDENTITY
		END

		-- Get TaskID, add if it doesn''t exist yet.
		DECLARE @TaskID int
		SET @TaskID = (SELECT TaskID FROM dbo.Tasks WHERE TaskDescription = @TaskDescription)
		IF (@TaskID IS NULL)
		BEGIN
			INSERT INTO dbo.Tasks (TaskDescription) VALUES (@TaskDescription)
			SET @TaskID = @@IDENTITY
		END

		-- Get TaskParameterID, add if it doesn''t exist yet.
		DECLARE @TaskParameterID int
		SET @TaskParameterID = (SELECT TaskParameterID FROM dbo.TaskParameters WHERE TaskParameter = @TaskParameter)
		IF (@TaskParameterID IS NULL)
		BEGIN
			INSERT INTO dbo.TaskParameters (TaskParameter) VALUES (@TaskParameter)
			SET @TaskParameterID = @@IDENTITY
		END
		
		-- Get LevelID, add if it doesn''t exist yet.
		DECLARE @LevelID int
		SET @LevelID = (SELECT LevelID FROM dbo.Levels WHERE LevelName = @LevelName)
		IF (@LevelID IS NULL)
		BEGIN
			INSERT INTO dbo.Levels (LevelName) VALUES (@LevelName)
			SET @LevelID = @@IDENTITY
		END

		-- Get TagID, add if it doesn''t exist yet.
		DECLARE @TagID int
		SET @TagID = (SELECT TagID FROM dbo.Tags WHERE Tag = @Tag)
		IF (@TagID IS NULL)
		BEGIN
			INSERT INTO dbo.Tags (Tag) VALUES (@Tag)
			SET @TagID = @@IDENTITY
		END

		-- Get CmdLineID, add if it doesn''t exist yet.
		DECLARE @CmdLineID int
		SET @CmdLineID = (SELECT CmdLineID FROM dbo.CmdLines WHERE CmdLine = @CmdLine)
		IF (@CmdLineID IS NULL)
		BEGIN
			INSERT INTO dbo.CmdLines (CmdLine) VALUES (@CmdLine)
			SET @CmdLineID= @@IDENTITY
		END

		-- Set date if it wasn''t passed in.
		IF (@Date IS NULL)
		BEGIN
			SET @Date = GETDATE()
		END

		-- Add run to DB and return its ID.
		DECLARE @RunID int
		INSERT INTO dbo.Runs		(ResultID,PlatformID,ConfigID,Changelist,MachineID,UserID,GameID,ResolutionID,GameTypeID,TaskID,TaskParameterID,LevelID,TagID,CmdLineID,Date)
							VALUES	(@ResultID,@PlatformID,@ConfigID,@Changelist,@MachineID,@UserID,@GameID,@ResolutionID,@GameTypeID,@TaskID,@TaskParameterID,@LevelID,@TagID,@CmdLineID,@Date)
		SET @RunID = @@IDENTITY

	COMMIT TRANSACTION
	
	SELECT @RunID AS [Return Value]
	RETURN @RunID
END















' 
END
GO
/****** Object:  StoredProcedure [dbo].[GetSentinelDataStatNames]    Script Date: 07/18/2008 03:14:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSentinelDataStatNames]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSentinelDataStatNames]
	-- Add the parameters for the stored procedure here
		@Task varchar(50) = "null",
		@PlatformName varchar(50) = "null",
		@LevelName varchar(50) = "null",
		@Changelist int = "-1",
		@StatGroupName varchar(128) = "null"
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @TaskID int
	SET @TaskID = (SELECT TaskID FROM Tasks WHERE Tasks.TaskDescription = @Task)

	DECLARE @PlatformID int
	SET @PlatformID = (SELECT PlatformID FROM Platforms WHERE Platforms.PlatformName = @PlatformName)

	DECLARE @LevelID int
	SET @LevelID = (SELECT LevelID FROM Levels WHERE Levels.LevelName = @LevelName)

	DECLARE @StatGroupNameID int
	SET @StatGroupNameID = (SELECT StatGroupID FROM StatGroups WHERE StatGroups.StatGroupName = @StatGroupName)

	


SELECT DISTINCT  Stats.StatName
FROM         RunData INNER JOIN
                      Stats ON RunData.StatID = Stats.StatID INNER JOIN
                      Runs ON RunData.RunID = Runs.RunID INNER JOIN
                      Levels ON Runs.LevelID = Levels.LevelID INNER JOIN
                      Platforms ON Runs.PlatformID = Platforms.PlatformID INNER JOIN
                      Tasks ON Runs.TaskID = Tasks.TaskID
WHERE     (Runs.Changelist = @Changelist) AND (Runs.TaskID = @TaskID) AND (Runs.LevelID = @LevelID) AND (Runs.PlatformID = @PlatformID) AND (Stats.StatGroupID = @StatGroupNameID )
ORDER BY Stats.StatName ASC


END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AddStat]    Script Date: 07/18/2008 03:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddStat]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[AddStat]
	@StatGroupName varchar(255),
	@StatName varchar(255)

AS
BEGIN
	BEGIN TRANSACTION

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Get StatGroupID, add if it doesn''t exist yet
		DECLARE @StatGroupID int
		SET @StatGroupID = (SELECT StatGroupID FROM dbo.StatGroups WHERE StatGroupName = @StatGroupName)
		IF (@StatGroupID IS NULL)
		BEGIN
			INSERT INTO dbo.StatGroups (StatGroupName) VALUES (@StatGroupName)
			SET @StatGroupID = @@IDENTITY
		END

		-- Get StatID, add if it doesn''t exist yet
		DECLARE @StatID int
		SET @StatID = (SELECT StatID FROM dbo.Stats WHERE StatName = @StatName)
		IF (@StatID IS NULL)
		BEGIN
			INSERT INTO dbo.Stats (StatName,StatGroupID) VALUES (@StatName,@StatGroupID)
			SET @StatID = @@IDENTITY
		END
	
	COMMIT TRANSACTION

	SELECT @StatID AS [Return Value]
	RETURN @StatID
END














' 
END
GO
/****** Object:  StoredProcedure [dbo].[GetSentinelDataStatGroups]    Script Date: 07/18/2008 03:14:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSentinelDataStatGroups]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSentinelDataStatGroups]
	-- Add the parameters for the stored procedure here
		@Task varchar(50) = "null",
		@PlatformName varchar(50) = "null",
		@LevelName varchar(50) = "null",
		@Changelist int = "-1"
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @TaskID int
	SET @TaskID = (SELECT TaskID FROM Tasks WHERE Tasks.TaskDescription = @Task)

	DECLARE @PlatformID int
	SET @PlatformID = (SELECT PlatformID FROM Platforms WHERE Platforms.PlatformName = @PlatformName)

	DECLARE @LevelID int
	SET @LevelID = (SELECT LevelID FROM Levels WHERE Levels.LevelName = @LevelName)

	

--SELECT DISTINCT  *
--FROM         RunData INNER JOIN
  --                    Runs ON RunData.RunID = Runs.RunID INNER JOIN
    --                  StatGroups ON RunData.StatID = StatGroups.StatGroupID INNER JOIN
      --                Levels ON Runs.LevelID = Levels.LevelID INNER JOIN
        --              Platforms ON Runs.PlatformID = Platforms.PlatformID INNER JOIN
          --            Tasks ON Runs.TaskID = Tasks.TaskID
--WHERE     (Runs.Changelist = @Changelist) AND (Runs.TaskID = @TaskID) AND (Runs.LevelID = @LevelID) AND (Runs.PlatformID = @PlatformID)





SELECT  DISTINCT   StatGroups.StatGroupName
FROM         Levels INNER JOIN
                      Runs ON Levels.LevelID = Runs.LevelID INNER JOIN
                      Platforms ON Runs.PlatformID = Platforms.PlatformID INNER JOIN
                      RunData ON Runs.RunID = RunData.RunID INNER JOIN
                      Tasks ON Runs.TaskID = Tasks.TaskID CROSS JOIN
                      StatGroups
WHERE     (Tasks.TaskID = @TaskID) AND (Platforms.PlatformID = @PlatformID) AND (Levels.LevelID = @LevelID) AND (Runs.Changelist = @Changelist)

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[GetChangelists]    Script Date: 07/18/2008 03:14:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetChangelists]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetChangelists]
	-- Add the parameters for the stored procedure here
	@Task varchar(50) = "null",
	@PlatformName varchar(50) = "null",
	@LevelName varchar(50) = "null"
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	DECLARE @TaskID int
	SET @TaskID = (SELECT TaskID FROM Tasks WHERE Tasks.TaskDescription = @Task)

	DECLARE @PlatformID int
	SET @PlatformID = (SELECT PlatformID FROM Platforms WHERE Platforms.PlatformName = @PlatformName)

	DECLARE @LevelID int
	SET @LevelID = (SELECT LevelID FROM Levels WHERE Levels.LevelName = @LevelName)


	--SELECT DISTINCT Changelist 
	--FROM Runs, Tasks, Platforms, Levels 
	--WHERE Tasks.TaskID = @TaskID 
	--AND Platforms.PlatformID = @PlatformID 
	--AND Levels.LevelID = @LevelID 
	--ORDER BY Changelist DESC


SELECT  DISTINCT   Runs.Changelist
FROM         Levels INNER JOIN
                      Runs ON Levels.LevelID = Runs.LevelID INNER JOIN
                      Platforms ON Runs.PlatformID = Platforms.PlatformID INNER JOIN
                      Tasks ON Runs.TaskID = Tasks.TaskID
WHERE     (Tasks.TaskID = @TaskID ) AND (Levels.LevelID = @LevelID ) AND (Platforms.PlatformID = @PlatformID)
ORDER BY Runs.Changelist DESC
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[GetSentinelData]    Script Date: 07/18/2008 03:14:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSentinelData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSentinelData]
	-- Add the parameters for the stored procedure here
		@Task varchar(50) = "null",
		@PlatformName varchar(50) = "null",
		@LevelName varchar(50) = "null",
		@Changelist int = "-1"
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @TaskID int
	SET @TaskID = (SELECT TaskID FROM Tasks WHERE Tasks.TaskDescription = @Task)

	DECLARE @PlatformID int
	SET @PlatformID = (SELECT PlatformID FROM Platforms WHERE Platforms.PlatformName = @PlatformName)

	DECLARE @LevelID int
	SET @LevelID = (SELECT LevelID FROM Levels WHERE Levels.LevelName = @LevelName)


	

SELECT     Locations.LocX, Locations.LocY, Locations.LocZ, Locations.RotYaw, Locations.RotPitch, Locations.RotRoll, Stats.StatName, RunData.StatValue, Runs.Changelist, Runs.TaskID, Runs.LevelID, Runs.PlatformID
FROM         RunData INNER JOIN
                      Locations ON RunData.LocationID = Locations.LocationID INNER JOIN
                      Stats ON RunData.StatID = Stats.StatID INNER JOIN
                      Runs ON RunData.RunID = Runs.RunID INNER JOIN
                      Levels ON Runs.LevelID = Levels.LevelID INNER JOIN
                      Platforms ON Runs.PlatformID = Platforms.PlatformID INNER JOIN
                      Tasks ON Runs.TaskID = Tasks.TaskID
WHERE     (Runs.Changelist = @Changelist) AND (Runs.TaskID = @TaskID) AND (Runs.LevelID = @LevelID) AND (Runs.PlatformID = @PlatformID)


END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[GetGameDataEventNames]    Script Date: 07/18/2008 03:14:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetGameDataEventNames]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetGameDataEventNames]
	-- Add the parameters for the stored procedure here
		@Task varchar(50) = "null",
		@PlatformName varchar(50) = "null",
		@LevelName varchar(50) = "null",
		@Changelist int = "-1"
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @TaskID int
	SET @TaskID = (SELECT TaskID FROM Tasks WHERE Tasks.TaskDescription = @Task)

	DECLARE @PlatformID int
	SET @PlatformID = (SELECT PlatformID FROM Platforms WHERE Platforms.PlatformName = @PlatformName)

	DECLARE @LevelID int
	SET @LevelID = (SELECT LevelID FROM Levels WHERE Levels.LevelName = @LevelName)

	


SELECT DISTINCT  GameEvents.GameEventName
FROM         GameEvents INNER JOIN
                      GameEventsData ON GameEventsData.GameEventID = GameEvents.GameEventID INNER JOIN
                      Runs ON GameEventsData.RunID = Runs.RunID INNER JOIN
                      Levels ON Runs.LevelID = Levels.LevelID INNER JOIN
                      Platforms ON Runs.PlatformID = Platforms.PlatformID INNER JOIN
                      Tasks ON Runs.TaskID = Tasks.TaskID
WHERE     (Runs.Changelist = @Changelist) AND (Runs.TaskID = @TaskID) AND (Runs.LevelID = @LevelID) AND (Runs.PlatformID = @PlatformID)



END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[GetGameDataEventDescNames]    Script Date: 07/18/2008 03:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetGameDataEventDescNames]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetGameDataEventDescNames]
	-- Add the parameters for the stored procedure here
		@Task varchar(50) = "null",
		@PlatformName varchar(50) = "null",
		@LevelName varchar(50) = "null",
		@Changelist int = "-1",
		@GameEventName varchar(128) = "null"
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @TaskID int
	SET @TaskID = (SELECT TaskID FROM Tasks WHERE Tasks.TaskDescription = @Task)

	DECLARE @PlatformID int
	SET @PlatformID = (SELECT PlatformID FROM Platforms WHERE Platforms.PlatformName = @PlatformName)

	DECLARE @LevelID int
	SET @LevelID = (SELECT LevelID FROM Levels WHERE Levels.LevelName = @LevelName)

	DECLARE @GameEventNameID int
	SET @GameEventNameID = (SELECT GameEventID FROM GameEvents WHERE GameEvents.GameEventName = @GameEventName)




SELECT DISTINCT  GameEventDescs.GameEventDesc
FROM         GameEventsData INNER JOIN
                      GameEventDescs ON GameEventsData.GameEventDescID = GameEventDescs.GameEventDescID INNER JOIN
                      Runs ON GameEventsData.RunID = Runs.RunID INNER JOIN
                      Levels ON Runs.LevelID = Levels.LevelID INNER JOIN
                      Platforms ON Runs.PlatformID = Platforms.PlatformID INNER JOIN
                      Tasks ON Runs.TaskID = Tasks.TaskID
WHERE     (Runs.Changelist = @Changelist) AND (Runs.TaskID = @TaskID) AND (Runs.LevelID = @LevelID) AND (Runs.PlatformID = @PlatformID) AND ( GameEventDescs.GameEventID = @GameEventNameID )
ORDER BY GameEventDescs.GameEventDesc ASC

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[GetGameData]    Script Date: 07/18/2008 03:14:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetGameData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetGameData]
	-- Add the parameters for the stored procedure here
		@Task varchar(50) = "null",
		@PlatformName varchar(50) = "null",
		@LevelName varchar(50) = "null",
		@Changelist int = "-1"
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @TaskID int
	SET @TaskID = (SELECT TaskID FROM Tasks WHERE Tasks.TaskDescription = @Task)

	DECLARE @PlatformID int
	SET @PlatformID = (SELECT PlatformID FROM Platforms WHERE Platforms.PlatformName = @PlatformName)

	DECLARE @LevelID int
	SET @LevelID = (SELECT LevelID FROM Levels WHERE Levels.LevelName = @LevelName)


	

SELECT     Locations.LocX, Locations.LocY, Locations.LocZ, Locations.RotYaw, Locations.RotPitch, Locations.RotRoll, GameEvents.GameEventName, GameEventDescs.GameEventDesc, Runs.Changelist, Runs.TaskID, Runs.LevelID, Runs.PlatformID, SecondsFromStart, GamePlayers.GamePlayerName
FROM         GameEventsData INNER JOIN
                      Locations ON GameEventsData.LocationID = Locations.LocationID INNER JOIN
                      GameEvents ON GameEventsData.GameEventID = GameEvents.GameEventID INNER JOIN
                      GameEventDescs ON GameEventsData.GameEventDescID = GameEventDescs.GameEventDescID INNER JOIN
                      Runs ON GameEventsData.RunID = Runs.RunID INNER JOIN
                      Levels ON Runs.LevelID = Levels.LevelID INNER JOIN
                      Platforms ON Runs.PlatformID = Platforms.PlatformID INNER JOIN
                      Tasks ON Runs.TaskID = Tasks.TaskID INNER JOIN
					  GamePlayers ON GameEventsData.PlayerID = GamePlayers.GamePlayerID 
		              --GamePlayers ON GameEventsData.TargetPlayerID = GamePlayers.GamePlayerID  
WHERE     (Runs.Changelist = @Changelist) AND (Runs.TaskID = @TaskID) AND (Runs.LevelID = @LevelID) AND (Runs.PlatformID = @PlatformID)


END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[GetTasks]    Script Date: 07/18/2008 03:14:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTasks]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTasks]
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Tasks;
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[EndRun]    Script Date: 07/18/2008 03:14:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EndRun]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[EndRun]
	@RunID int,
	@ResultDescription varchar(255)
AS
BEGIN
	BEGIN TRANSACTION

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Get ResultID, add if it doesn''t exist yet
		DECLARE @ResultID int
		SET @ResultID = (SELECT ResultID FROM dbo.Results WHERE ResultDescription = @ResultDescription)
		IF (@ResultID IS NULL)
		BEGIN
			INSERT INTO dbo.Results (ResultDescription) VALUES (@ResultDescription)
			SET @ResultID = @@IDENTITY
		END

		-- Update run with result.
		UPDATE dbo.Runs
		SET ResultID = @ResultID
		WHERE RunID = @RunID

	COMMIT TRANSACTION
END













' 
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteASetOfRunData]    Script Date: 07/18/2008 03:14:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteASetOfRunData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteASetOfRunData]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

BEGIN TRANSACTION


SELECT COUNT(*)
FROM RunData


SELECT *
FROM RunData
WHERE RunData.RunID IN (SELECT Runs.RunID FROM Runs WHERE Runs.Changelist=240825)


SELECT COUNT(*)
FROM RunData







SELECT Runs.RunID FROM Runs WHERE Runs.Changelist=240825





ROLLBACK TRANSACTION


COMMIT TRANSACTION



END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AddGameEventDesc]    Script Date: 07/18/2008 03:14:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddGameEventDesc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddGameEventDesc]
	@GameEventName varchar(128),
	@GameEventDesc varchar(128)
AS
BEGIN
	BEGIN TRANSACTION

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Get GameEventID, add if it doesn''t exist yet
		DECLARE @GameEventID int
		SET @GameEventID = (SELECT GameEventID FROM dbo.GameEvents WHERE GameEventName = @GameEventName)
		IF (@GameEventID IS NULL)
		BEGIN
			INSERT INTO dbo.GameEvents (GameEventName) VALUES (@GameEventName)
			SET @GameEventID = @@IDENTITY
		END

		-- Get GameEventDescID, add if it doesn''t exist yet
		DECLARE @GameEventDescID int
		SET @GameEventDescID = (SELECT GameEventDescID FROM dbo.GameEventDescs WHERE GameEventDesc = @GameEventDesc)
		IF (@GameEventDescID IS NULL)
		BEGIN
			INSERT INTO dbo.GameEventDescs (GameEventDesc,GameEventID) VALUES (@GameEventDesc,@GameEventID)
			SET @GameEventDescID = @@IDENTITY
		END
	
	COMMIT TRANSACTION

	SELECT @GameEventDescID AS [Return Value]
	RETURN @GameEventDescID
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AddGameEventData]    Script Date: 07/18/2008 03:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddGameEventData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--
-- Stat == EventDesc 
-- StatGroup == EventName
--
--
-- =============================================
CREATE PROCEDURE [dbo].[AddGameEventData]
	@RunID int,
    @SecondsFromStart float = -1,
	@PlayerName varchar(50) = ''Unknown'',
	@TargetPlayerName varchar(50) = ''Unknown'',

	@GameEventName varchar(128) = ''Unknown'',

	@GameEventDescID int = NULL,
	@GameEventDesc varchar(128) = ''Unknown'',

	@LocX int = 0,
	@LocY int = 0,
	@LocZ int = 0,
	@RotYaw int = 0,
	@RotPitch int = 0,
	@RotRoll int = 0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		-- Get LocationID, add if it doesn''t exist yet
		DECLARE @LocationID int
		SET @LocationID = (SELECT LocationID FROM dbo.Locations WHERE LocX = @LocX AND LocY = @LocY AND LocZ = @LocZ AND RotYaw = @RotYaw AND RotPitch = @RotPitch AND RotRoll = @RotRoll)
		IF (@LocationID IS NULL)
		BEGIN
			INSERT INTO dbo.Locations (LocX,LocY,LocZ,RotYaw,RotPitch,RotRoll) VALUES (@LocX,@LocY,@LocZ,@RotYaw,@RotPitch,@RotRoll)
			SET @LocationID = @@IDENTITY
		END


		-- Get PlayerNameID, add if it doesn''t exist yet
		DECLARE @PlayerNameID int
		SET @PlayerNameID = (SELECT GamePlayerID FROM dbo.GamePlayers WHERE GamePlayerName = @PlayerName)
		IF (@PlayerNameID IS NULL)
		BEGIN
			INSERT INTO dbo.GamePlayers (GamePlayerName) VALUES (@PlayerName)
			SET @PlayerNameID = @@IDENTITY
		END

		-- Get TargetPlayerNameID, add if it doesn''t exist yet
		DECLARE @TargetPlayerNameID int
		SET @TargetPlayerNameID = (SELECT GamePlayerID FROM dbo.GamePlayers WHERE GamePlayerName = @TargetPlayerName)
		IF (@TargetPlayerNameID IS NULL)
		BEGIN
			INSERT INTO dbo.GamePlayers (GamePlayerName) VALUES (@TargetPlayerName)
			SET @TargetPlayerNameID = @@IDENTITY
		END

		-- Get GameEventID, add if it doesn''t exist yet
		DECLARE @GameEventID int
		SET @GameEventID = (SELECT GameEventID FROM dbo.GameEvents WHERE GameEventName = @GameEventName)
		IF (@GameEventID IS NULL)
		BEGIN
			INSERT INTO dbo.GameEvents (GameEventName) VALUES (@GameEventName)
			SET @GameEventID = @@IDENTITY
		END



		-- If GameEventDescID is not specified, create it.	
		IF (@GameEventDescID IS NULL)
		BEGIN
			EXEC @GameEventDescID = [dbo].[AddGameEventDesc] @GameEventDesc = @GameEventDesc, @GameEventName = @GameEventName
		END



		-- Insert run data into table.
		INSERT INTO dbo.GameEventsData (RunID,LocationID,PlayerID,TargetPlayerID,GameEventID,GameEventDescID,SecondsFromStart) 
              VALUES                   (@RunID,@LocationID,@PlayerNameID,@TargetPlayerNameID,@GameEventID,@GameEventDescID, @SecondsFromStart)


END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AddRunData]    Script Date: 07/18/2008 03:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddRunData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[AddRunData]
	@RunID int,
	@SubLevelName varchar(64) = '' '',
	@StatID int = NULL,
	@StatName varchar(255) = ''Unknown'',
	@StatGroupName varchar(255) = ''Unknown'',
	@StatValue float = 0,
	@LocX int = 0,
	@LocY int = 0,
	@LocZ int = 0,
	@RotYaw int = 0,
	@RotPitch int = 0,
	@RotRoll int = 0
AS
BEGIN
	BEGIN TRANSACTION

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;


		-- Get SubLevelID, add if it doesn''t exist yet.
		DECLARE @SubLevelID int
		SET @SubLevelID = (SELECT SubLevelID FROM dbo.SubLevels WHERE SubLevelName = @SubLevelName)
		IF (@SubLevelID IS NULL)
		BEGIN
			INSERT INTO dbo.SubLevels (SubLevelName) VALUES (@SubLevelName)
			SET @SubLevelID = @@IDENTITY
		END


		-- Get LocationID, add if it doesn''t exist yet
		DECLARE @LocationID int
		SET @LocationID = (SELECT LocationID FROM dbo.Locations WHERE LocX = @LocX AND LocY = @LocY AND LocZ = @LocZ AND RotYaw = @RotYaw AND RotPitch = @RotPitch AND RotRoll = @RotRoll)
		IF (@LocationID IS NULL)
		BEGIN
			INSERT INTO dbo.Locations (LocX,LocY,LocZ,RotYaw,RotPitch,RotRoll) VALUES (@LocX,@LocY,@LocZ,@RotYaw,@RotPitch,@RotRoll)
			SET @LocationID = @@IDENTITY
		END

		-- If StatID is not specified, create it.	
		IF (@StatID IS NULL)
		BEGIN
			EXEC @StatID = [dbo].[AddStat] @StatName = @StatName, @StatGroupName = @StatGroupName
		END

		-- Insert run data into table.
		INSERT INTO dbo.RunData (RunID,LocationID,StatID,StatValue,SubLevelID) VALUES (@RunID,@LocationID,@StatID,@StatValue,@SubLevelID)

	COMMIT TRANSACTION
END













' 
END
GO
/****** Object:  ForeignKey [FK_GameEventDescs_GameEvents]    Script Date: 07/18/2008 03:14:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GameEventDescs_GameEvents]') AND parent_object_id = OBJECT_ID(N'[dbo].[GameEventDescs]'))
ALTER TABLE [dbo].[GameEventDescs]  WITH CHECK ADD  CONSTRAINT [FK_GameEventDescs_GameEvents] FOREIGN KEY([GameEventID])
REFERENCES [dbo].[GameEvents] ([GameEventID])
GO
ALTER TABLE [dbo].[GameEventDescs] CHECK CONSTRAINT [FK_GameEventDescs_GameEvents]
GO
/****** Object:  ForeignKey [FK_GameEventsData_GameEventDescs]    Script Date: 07/18/2008 03:14:32 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GameEventsData_GameEventDescs]') AND parent_object_id = OBJECT_ID(N'[dbo].[GameEventsData]'))
ALTER TABLE [dbo].[GameEventsData]  WITH CHECK ADD  CONSTRAINT [FK_GameEventsData_GameEventDescs] FOREIGN KEY([GameEventDescID])
REFERENCES [dbo].[GameEventDescs] ([GameEventDescID])
GO
ALTER TABLE [dbo].[GameEventsData] CHECK CONSTRAINT [FK_GameEventsData_GameEventDescs]
GO
/****** Object:  ForeignKey [FK_GameEventsData_GameEvents]    Script Date: 07/18/2008 03:14:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GameEventsData_GameEvents]') AND parent_object_id = OBJECT_ID(N'[dbo].[GameEventsData]'))
ALTER TABLE [dbo].[GameEventsData]  WITH CHECK ADD  CONSTRAINT [FK_GameEventsData_GameEvents] FOREIGN KEY([GameEventID])
REFERENCES [dbo].[GameEvents] ([GameEventID])
GO
ALTER TABLE [dbo].[GameEventsData] CHECK CONSTRAINT [FK_GameEventsData_GameEvents]
GO
/****** Object:  ForeignKey [FK_GameEventsData_GamePlayers]    Script Date: 07/18/2008 03:14:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GameEventsData_GamePlayers]') AND parent_object_id = OBJECT_ID(N'[dbo].[GameEventsData]'))
ALTER TABLE [dbo].[GameEventsData]  WITH CHECK ADD  CONSTRAINT [FK_GameEventsData_GamePlayers] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[GamePlayers] ([GamePlayerID])
GO
ALTER TABLE [dbo].[GameEventsData] CHECK CONSTRAINT [FK_GameEventsData_GamePlayers]
GO
/****** Object:  ForeignKey [FK_GameEventsData_GamePlayers1]    Script Date: 07/18/2008 03:14:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GameEventsData_GamePlayers1]') AND parent_object_id = OBJECT_ID(N'[dbo].[GameEventsData]'))
ALTER TABLE [dbo].[GameEventsData]  WITH CHECK ADD  CONSTRAINT [FK_GameEventsData_GamePlayers1] FOREIGN KEY([TargetPlayerID])
REFERENCES [dbo].[GamePlayers] ([GamePlayerID])
GO
ALTER TABLE [dbo].[GameEventsData] CHECK CONSTRAINT [FK_GameEventsData_GamePlayers1]
GO
/****** Object:  ForeignKey [FK_GameEventsData_Locations]    Script Date: 07/18/2008 03:14:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GameEventsData_Locations]') AND parent_object_id = OBJECT_ID(N'[dbo].[GameEventsData]'))
ALTER TABLE [dbo].[GameEventsData]  WITH CHECK ADD  CONSTRAINT [FK_GameEventsData_Locations] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Locations] ([LocationID])
GO
ALTER TABLE [dbo].[GameEventsData] CHECK CONSTRAINT [FK_GameEventsData_Locations]
GO
/****** Object:  ForeignKey [FK_GameEventsData_Runs]    Script Date: 07/18/2008 03:14:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GameEventsData_Runs]') AND parent_object_id = OBJECT_ID(N'[dbo].[GameEventsData]'))
ALTER TABLE [dbo].[GameEventsData]  WITH CHECK ADD  CONSTRAINT [FK_GameEventsData_Runs] FOREIGN KEY([RunID])
REFERENCES [dbo].[Runs] ([RunID])
GO
ALTER TABLE [dbo].[GameEventsData] CHECK CONSTRAINT [FK_GameEventsData_Runs]
GO
/****** Object:  ForeignKey [FK_RunData_Locations1]    Script Date: 07/18/2008 03:14:53 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RunData_Locations1]') AND parent_object_id = OBJECT_ID(N'[dbo].[RunData]'))
ALTER TABLE [dbo].[RunData]  WITH CHECK ADD  CONSTRAINT [FK_RunData_Locations1] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Locations] ([LocationID])
GO
ALTER TABLE [dbo].[RunData] CHECK CONSTRAINT [FK_RunData_Locations1]
GO
/****** Object:  ForeignKey [FK_RunData_Runs]    Script Date: 07/18/2008 03:14:53 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RunData_Runs]') AND parent_object_id = OBJECT_ID(N'[dbo].[RunData]'))
ALTER TABLE [dbo].[RunData]  WITH CHECK ADD  CONSTRAINT [FK_RunData_Runs] FOREIGN KEY([RunID])
REFERENCES [dbo].[Runs] ([RunID])
GO
ALTER TABLE [dbo].[RunData] CHECK CONSTRAINT [FK_RunData_Runs]
GO
/****** Object:  ForeignKey [FK_RunData_Stats1]    Script Date: 07/18/2008 03:14:53 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RunData_Stats1]') AND parent_object_id = OBJECT_ID(N'[dbo].[RunData]'))
ALTER TABLE [dbo].[RunData]  WITH CHECK ADD  CONSTRAINT [FK_RunData_Stats1] FOREIGN KEY([StatID])
REFERENCES [dbo].[Stats] ([StatID])
GO
ALTER TABLE [dbo].[RunData] CHECK CONSTRAINT [FK_RunData_Stats1]
GO
/****** Object:  ForeignKey [FK_RunData_SubLevels]    Script Date: 07/18/2008 03:14:53 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RunData_SubLevels]') AND parent_object_id = OBJECT_ID(N'[dbo].[RunData]'))
ALTER TABLE [dbo].[RunData]  WITH CHECK ADD  CONSTRAINT [FK_RunData_SubLevels] FOREIGN KEY([SubLevelID])
REFERENCES [dbo].[SubLevels] ([SubLevelID])
GO
ALTER TABLE [dbo].[RunData] CHECK CONSTRAINT [FK_RunData_SubLevels]
GO
/****** Object:  ForeignKey [FK_Runs_CmdLines]    Script Date: 07/18/2008 03:15:02 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Runs_CmdLines]') AND parent_object_id = OBJECT_ID(N'[dbo].[Runs]'))
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_CmdLines] FOREIGN KEY([CmdLineID])
REFERENCES [dbo].[CmdLines] ([CmdLineID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_CmdLines]
GO
/****** Object:  ForeignKey [FK_Runs_Configs1]    Script Date: 07/18/2008 03:15:02 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Runs_Configs1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Runs]'))
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Configs1] FOREIGN KEY([ConfigID])
REFERENCES [dbo].[Configs] ([ConfigID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Configs1]
GO
/****** Object:  ForeignKey [FK_Runs_Games1]    Script Date: 07/18/2008 03:15:02 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Runs_Games1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Runs]'))
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Games1] FOREIGN KEY([GameID])
REFERENCES [dbo].[Games] ([GameID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Games1]
GO
/****** Object:  ForeignKey [FK_Runs_GameTypes1]    Script Date: 07/18/2008 03:15:03 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Runs_GameTypes1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Runs]'))
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_GameTypes1] FOREIGN KEY([GameTypeID])
REFERENCES [dbo].[GameTypes] ([GameTypeID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_GameTypes1]
GO
/****** Object:  ForeignKey [FK_Runs_Levels1]    Script Date: 07/18/2008 03:15:03 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Runs_Levels1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Runs]'))
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Levels1] FOREIGN KEY([LevelID])
REFERENCES [dbo].[Levels] ([LevelID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Levels1]
GO
/****** Object:  ForeignKey [FK_Runs_Machines1]    Script Date: 07/18/2008 03:15:03 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Runs_Machines1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Runs]'))
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Machines1] FOREIGN KEY([MachineID])
REFERENCES [dbo].[Machines] ([MachineID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Machines1]
GO
/****** Object:  ForeignKey [FK_Runs_Platforms1]    Script Date: 07/18/2008 03:15:03 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Runs_Platforms1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Runs]'))
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Platforms1] FOREIGN KEY([PlatformID])
REFERENCES [dbo].[Platforms] ([PlatformID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Platforms1]
GO
/****** Object:  ForeignKey [FK_Runs_Resolutions]    Script Date: 07/18/2008 03:15:03 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Runs_Resolutions]') AND parent_object_id = OBJECT_ID(N'[dbo].[Runs]'))
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Resolutions] FOREIGN KEY([ResolutionID])
REFERENCES [dbo].[Resolutions] ([ResolutionID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Resolutions]
GO
/****** Object:  ForeignKey [FK_Runs_Results1]    Script Date: 07/18/2008 03:15:04 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Runs_Results1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Runs]'))
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Results1] FOREIGN KEY([ResultID])
REFERENCES [dbo].[Results] ([ResultID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Results1]
GO
/****** Object:  ForeignKey [FK_Runs_Tags1]    Script Date: 07/18/2008 03:15:04 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Runs_Tags1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Runs]'))
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Tags1] FOREIGN KEY([TagID])
REFERENCES [dbo].[Tags] ([TagID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Tags1]
GO
/****** Object:  ForeignKey [FK_Runs_TaskParameters]    Script Date: 07/18/2008 03:15:04 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Runs_TaskParameters]') AND parent_object_id = OBJECT_ID(N'[dbo].[Runs]'))
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_TaskParameters] FOREIGN KEY([TaskParameterID])
REFERENCES [dbo].[TaskParameters] ([TaskParameterID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_TaskParameters]
GO
/****** Object:  ForeignKey [FK_Runs_Tasks1]    Script Date: 07/18/2008 03:15:04 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Runs_Tasks1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Runs]'))
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Tasks1] FOREIGN KEY([TaskID])
REFERENCES [dbo].[Tasks] ([TaskID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Tasks1]
GO
/****** Object:  ForeignKey [FK_Runs_Users1]    Script Date: 07/18/2008 03:15:04 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Runs_Users1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Runs]'))
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Users1] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Users1]
GO
/****** Object:  ForeignKey [FK_Stats_StatGroups1]    Script Date: 07/18/2008 03:15:08 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Stats_StatGroups1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Stats]'))
ALTER TABLE [dbo].[Stats]  WITH CHECK ADD  CONSTRAINT [FK_Stats_StatGroups1] FOREIGN KEY([StatGroupID])
REFERENCES [dbo].[StatGroups] ([StatGroupID])
GO
ALTER TABLE [dbo].[Stats] CHECK CONSTRAINT [FK_Stats_StatGroups1]
GO
