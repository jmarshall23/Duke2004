USE [UnrealBuildToolStats]
GO
/****** Object:  Table [dbo].[Platforms]    Script Date: 12/21/2010 13:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Platforms](
	[PlatformID] [int] IDENTITY(1,1) NOT NULL,
	[PlatformName] [varchar](32) NOT NULL,
 CONSTRAINT [PK_Configs] PRIMARY KEY CLUSTERED 
(
	[PlatformID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ConfigNames] ON [dbo].[Platforms] 
(
	[PlatformName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Machines]    Script Date: 12/21/2010 13:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Machines](
	[MachineID] [int] IDENTITY(1,1) NOT NULL,
	[MachineName] [varchar](32) NOT NULL,
 CONSTRAINT [PK_Machines] PRIMARY KEY CLUSTERED 
(
	[MachineID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_MachineNames] ON [dbo].[Machines] 
(
	[MachineName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Games]    Script Date: 12/21/2010 13:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Games](
	[GameID] [int] IDENTITY(1,1) NOT NULL,
	[GameName] [varchar](32) NOT NULL,
 CONSTRAINT [PK_Games] PRIMARY KEY CLUSTERED 
(
	[GameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_GameNames] ON [dbo].[Games] 
(
	[GameName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Executors]    Script Date: 12/21/2010 13:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Executors](
	[ExecutorID] [int] IDENTITY(1,1) NOT NULL,
	[ExecutorName] [varchar](32) NOT NULL,
 CONSTRAINT [PK_Executors] PRIMARY KEY CLUSTERED 
(
	[ExecutorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Executors] ON [dbo].[Executors] 
(
	[ExecutorName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Configs]    Script Date: 12/21/2010 13:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Configs](
	[ConfigID] [int] IDENTITY(1,1) NOT NULL,
	[ConfigName] [varchar](32) NOT NULL,
 CONSTRAINT [PK_Platforms] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PlatformNames] ON [dbo].[Configs] 
(
	[ConfigName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[AddRun_v2]    Script Date: 12/21/2010 13:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddRun_v2]
	@Duration float,
	@ConfigName varchar(32),
	@PlatformName varchar(32),
	@GameName varchar(32),
	@MachineName varchar(32),
	@UserName varchar(32),
	@ExecutorName varchar(32),
	@bSuccess bit,
	@bGeneratedDebugInfo bit,
	@NumActions int,
	@NumOutdatedActions int,
	@NumExecutedActions int,
	@NumIncludedBytesPerUnityCPP int,
	@MinFilesUsingPrecompiledHeader int,
	@ProcessorCountMultiplier float,
	@bUseUnityBuild bit,
	@bStressTestUnity bit,
	@bCheckSystemHeadersForModification bit,
	@bCheckExternalHeadersForModification bit,
	@bUsePDBFiles bit,
	@bUsePCHFiles bit,
	@bPrintDebugInfo bit,
	@bLogDetailedActionStats bit,
	@bAllowXGE bit,
	@bShowXGEMonitor bit,
	@bShouldDeleteAllOutdatedProducedItems bit,
	@bUseIncrementalLinking bit,
	@bSupportEditAndContinue bit,
	@bUseIntelCompiler bit 

AS
BEGIN
	BEGIN TRANSACTION

	-- Set date. if it wasn't passed in.
	DECLARE @Date datetime
	SET @Date = GETDATE()
		
	COMMIT TRANSACTION
END
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12/21/2010 13:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](32) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_UserNames] ON [dbo].[Users] 
(
	[UserName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Runs]    Script Date: 12/21/2010 13:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Runs](
	[RunID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Duration] [float] NOT NULL,
	[ConfigID] [int] NOT NULL,
	[PlatformID] [int] NOT NULL,
	[GameID] [int] NOT NULL,
	[MachineID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ExecutorID] [int] NOT NULL,
	[bSuccess] [bit] NOT NULL,
	[bGeneratedDebugInfo] [bit] NOT NULL,
	[NumActions] [int] NOT NULL,
	[NumOutdatedActions] [int] NOT NULL,
	[NumExecutedActions] [int] NOT NULL,
	[NumIncludedBytesPerUnityCPP] [int] NOT NULL,
	[MinFilesUsingPrecompiledHeader] [int] NOT NULL,
	[ProcessorCountMultiplier] [float] NOT NULL,
	[bUseUnityBuild] [bit] NOT NULL,
	[bStressTestUnity] [bit] NOT NULL,
	[bCheckSystemHeadersForModification] [bit] NOT NULL,
	[bCheckExternalHeadersForModification] [bit] NOT NULL,
	[bUsePDBFiles] [bit] NOT NULL,
	[bUsePCHFiles] [bit] NOT NULL,
	[bPrintDebugInfo] [bit] NOT NULL,
	[bLogDetailedActionStats] [bit] NOT NULL,
	[bAllowXGE] [bit] NOT NULL,
	[bShowXGEMonitor] [bit] NOT NULL,
	[bShouldDeleteAllOutdatedProducedItems] [bit] NOT NULL,
	[bUseIncrementalLinking] [bit] NOT NULL,
	[bSupportEditAndContinue] [bit] NOT NULL,
	[bUseIntelCompiler] [bit] NOT NULL,
	[LinkTime] [float] NOT NULL,
	[bUseSNCCompiler] [bit] NOT NULL,
 CONSTRAINT [PK_Runs] PRIMARY KEY CLUSTERED 
(
	[RunID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[AddRun_v1]    Script Date: 12/21/2010 13:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddRun_v1]
	@Duration float,
	@ConfigName varchar(32),
	@PlatformName varchar(32),
	@GameName varchar(32),
	@MachineName varchar(32),
	@UserName varchar(32),
	@bSuccess bit,
	@bGeneratedDebugInfo bit,
	@NumActions int,
	@NumOutdatedActions int,
	@NumExecutedActions int,
	@NumIncludedBytesPerUnityCPP int,
	@MinFilesUsingPrecompiledHeader int,
	@ProcessorCountMultiplier float,
	@bUseUnityBuild bit,
	@bStressTestUnity bit,
	@bCheckSystemHeadersForModification bit,
	@bCheckExternalHeadersForModification bit,
	@bUsePDBFiles bit,
	@bUsePCHFiles bit,
	@bPrintDebugInfo bit,
	@bLogDetailedActionStats bit,
	@bAllowXGE bit,
	@bShowXGEMonitor bit,
	@bShouldDeleteAllOutdatedProducedItems bit,
	@bUseIncrementalLinking bit,
	@bSupportEditAndContinue bit,
	@bUseIntelCompiler bit 

AS
BEGIN
	BEGIN TRANSACTION

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
	
		-- Get PlatformID, add if it doesn't exist yet.
		DECLARE @PlatformID int
		SET @PlatformID = (SELECT PlatformID FROM dbo.Platforms WHERE PlatformName = @PlatformName)
		IF (@PlatformID IS NULL)
		BEGIN
			INSERT INTO dbo.Platforms (PlatformName) VALUES (@PlatformName)
			SET @PlatformID = @@IDENTITY
		END

		-- Get ConfigID, add if it doesn't exist yet.
		DECLARE @ConfigID int
		SET @ConfigID = (SELECT ConfigID FROM dbo.Configs WHERE ConfigName = @ConfigName)
		IF (@ConfigID IS NULL)
		BEGIN
			INSERT INTO dbo.Configs (ConfigName) VALUES (@ConfigName)
			SET @ConfigID = @@IDENTITY
		END

		-- Get MachineID, add if it doesn't exist yet.
		DECLARE @MachineID int
		SET @MachineID = (SELECT MachineID FROM dbo.Machines WHERE MachineName = @MachineName)
		IF (@MachineID IS NULL)
		BEGIN
			INSERT INTO dbo.Machines (MachineName) VALUES (@MachineName)
			SET @MachineID = @@IDENTITY
		END

		-- Get UserID, add if it doesn't exist yet.
		DECLARE @UserID int
		SET @UserID = (SELECT UserID FROM dbo.Users WHERE UserName = @UserName)
		IF (@UserID IS NULL)
		BEGIN
			INSERT INTO dbo.Users (UserName) VALUES (@UserName)
			SET @UserID = @@IDENTITY
		END

		-- Get GameID, add if it doesn't exist yet.
		DECLARE @GameID int
		SET @GameID = (SELECT GameID FROM dbo.Games WHERE GameName = @GameName)
		IF (@GameID IS NULL)
		BEGIN
			INSERT INTO dbo.Games (GameName) VALUES (@GameName)
			SET @GameID = @@IDENTITY
		END

		-- Get GameID, add if it doesn't exist yet.
		DECLARE @ExecutorID int
		SET @ExecutorID = (SELECT ExecutorID FROM dbo.Executors WHERE ExecutorName = 'Unknown')
		IF (@ExecutorID IS NULL)
		BEGIN
			INSERT INTO dbo.Executors (ExecutorName) VALUES ('Unknown')
			SET @ExecutorID = @@IDENTITY
		END

		-- Set date. if it wasn't passed in.
		DECLARE @Date datetime
		SET @Date = GETDATE()
	
		-- Add run to DB.
		INSERT	INTO dbo.Runs (	Date,
								Duration,
								ConfigID,
								PlatformID,
								GameID,
								MachineID,
								UserID,
								ExecutorID,
								bSuccess,
								bGeneratedDebugInfo,
								NumActions,
								NumOutdatedActions,
								NumExecutedActions,
								NumIncludedBytesPerUnityCPP,
								MinFilesUsingPrecompiledHeader,
								ProcessorCountMultiplier,
								bUseUnityBuild,
								bStressTestUnity,
								bCheckSystemHeadersForModification,
								bCheckExternalHeadersForModification,
								bUsePDBFiles,
								bUsePCHFiles,
								bPrintDebugInfo,
								bLogDetailedActionStats,
								bAllowXGE,
								bShowXGEMonitor,
								bShouldDeleteAllOutdatedProducedItems,
								bUseIncrementalLinking,
								bSupportEditAndContinue,
								bUseIntelCompiler )
				VALUES		  (	@Date,
								@Duration,
								@ConfigID,
								@PlatformID,
								@GameID,
								@MachineID,
								@UserID,
								@ExecutorID,
								@bSuccess,
								@bGeneratedDebugInfo,
								@NumActions,
								@NumOutdatedActions,
								@NumExecutedActions,
								@NumIncludedBytesPerUnityCPP,
								@MinFilesUsingPrecompiledHeader,
								@ProcessorCountMultiplier,
								@bUseUnityBuild,
								@bStressTestUnity,
								@bCheckSystemHeadersForModification,
								@bCheckExternalHeadersForModification,
								@bUsePDBFiles,
								@bUsePCHFiles,
								@bPrintDebugInfo,
								@bLogDetailedActionStats,
								@bAllowXGE,
								@bShowXGEMonitor,
								@bShouldDeleteAllOutdatedProducedItems,
								@bUseIncrementalLinking,
								@bSupportEditAndContinue,
								@bUseIntelCompiler )
		
	COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dbo].[SampleQuery]    Script Date: 12/21/2010 13:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SampleQuery]
	
AS
BEGIN
	SELECT	Date, Duration, LinkTime, bSuccess, bGeneratedDebugInfo, NumActions, NumOutdatedActions, NumExecutedActions, NumIncludedBytesPerUnityCPP, MinFilesUsingPrecompiledHeader, ProcessorCountMultiplier, bUseUnityBuild,
			bStressTestUnity, bCheckSystemHeadersForModification, bCheckExternalHeadersForModification, bUsePDBFiles, bUsePCHFiles, bPrintDebugInfo, bLogDetailedActionStats, bAllowXGE, bShowXGEMonitor,
			bShouldDeleteAllOutdatedProducedItems, bUseIncrementalLinking, bSupportEditAndContinue, bUseIntelCompiler, bUseSNCCompiler, ConfigName, PlatformName, GameName, MachineName, UserName, ExecutorName 
	FROM Runs
	JOIN	Configs		ON Runs.ConfigID = Configs.ConfigID
	JOIN	Platforms	ON Runs.PlatformID = Platforms.PlatformID
	JOIN	Games		ON Runs.GameID = Games.GameID
	JOIN	Machines	ON Runs.MachineID = Machines.MachineID
	JOIN	Users		ON Runs.UserID = Users.UserID
	JOIN	Executors	ON Runs.ExecutorID = Executors.ExecutorID
END
GO
/****** Object:  StoredProcedure [dbo].[AddRun_v3]    Script Date: 12/21/2010 13:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddRun_v3]
	@Duration float,
	@LinkTime float,
	@ConfigName varchar(32),
	@PlatformName varchar(32),
	@GameName varchar(32),
	@MachineName varchar(32),
	@UserName varchar(32),
	@ExecutorName varchar(32),
	@bSuccess bit,
	@bGeneratedDebugInfo bit,
	@NumActions int,
	@NumOutdatedActions int,
	@NumExecutedActions int,
	@NumIncludedBytesPerUnityCPP int,
	@MinFilesUsingPrecompiledHeader int,
	@ProcessorCountMultiplier float,
	@bUseUnityBuild bit,
	@bStressTestUnity bit,
	@bCheckSystemHeadersForModification bit,
	@bCheckExternalHeadersForModification bit,
	@bUsePDBFiles bit,
	@bUsePCHFiles bit,
	@bPrintDebugInfo bit,
	@bLogDetailedActionStats bit,
	@bAllowXGE bit,
	@bShowXGEMonitor bit,
	@bShouldDeleteAllOutdatedProducedItems bit,
	@bUseIncrementalLinking bit,
	@bSupportEditAndContinue bit,
	@bUseIntelCompiler bit,
	@bUseSNCCompiler bit

AS
BEGIN
	BEGIN TRANSACTION

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
	
		-- Get PlatformID, add if it doesn't exist yet.
		DECLARE @PlatformID int
		SET @PlatformID = (SELECT PlatformID FROM dbo.Platforms WHERE PlatformName = @PlatformName)
		IF (@PlatformID IS NULL)
		BEGIN
			INSERT INTO dbo.Platforms (PlatformName) VALUES (@PlatformName)
			SET @PlatformID = @@IDENTITY
		END

		-- Get ConfigID, add if it doesn't exist yet.
		DECLARE @ConfigID int
		SET @ConfigID = (SELECT ConfigID FROM dbo.Configs WHERE ConfigName = @ConfigName)
		IF (@ConfigID IS NULL)
		BEGIN
			INSERT INTO dbo.Configs (ConfigName) VALUES (@ConfigName)
			SET @ConfigID = @@IDENTITY
		END

		-- Get MachineID, add if it doesn't exist yet.
		DECLARE @MachineID int
		SET @MachineID = (SELECT MachineID FROM dbo.Machines WHERE MachineName = @MachineName)
		IF (@MachineID IS NULL)
		BEGIN
			INSERT INTO dbo.Machines (MachineName) VALUES (@MachineName)
			SET @MachineID = @@IDENTITY
		END

		-- Get UserID, add if it doesn't exist yet.
		DECLARE @UserID int
		SET @UserID = (SELECT UserID FROM dbo.Users WHERE UserName = @UserName)
		IF (@UserID IS NULL)
		BEGIN
			INSERT INTO dbo.Users (UserName) VALUES (@UserName)
			SET @UserID = @@IDENTITY
		END

		-- Get GameID, add if it doesn't exist yet.
		DECLARE @GameID int
		SET @GameID = (SELECT GameID FROM dbo.Games WHERE GameName = @GameName)
		IF (@GameID IS NULL)
		BEGIN
			INSERT INTO dbo.Games (GameName) VALUES (@GameName)
			SET @GameID = @@IDENTITY
		END

		-- Get GameID, add if it doesn't exist yet.
		DECLARE @ExecutorID int
		SET @ExecutorID = (SELECT ExecutorID FROM dbo.Executors WHERE ExecutorName = @ExecutorName)
		IF (@ExecutorID IS NULL)
		BEGIN
			INSERT INTO dbo.Executors (ExecutorName) VALUES (@ExecutorName)
			SET @ExecutorID = @@IDENTITY
		END

		-- Set date. if it wasn't passed in.
		DECLARE @Date datetime
		SET @Date = GETDATE()
	
		-- Add run to DB.
		INSERT	INTO dbo.Runs (	Date,
								Duration,
								LinkTime,
								ConfigID,
								PlatformID,
								GameID,
								MachineID,
								UserID,
								ExecutorID,
								bSuccess,
								bGeneratedDebugInfo,
								NumActions,
								NumOutdatedActions,
								NumExecutedActions,
								NumIncludedBytesPerUnityCPP,
								MinFilesUsingPrecompiledHeader,
								ProcessorCountMultiplier,
								bUseUnityBuild,
								bStressTestUnity,
								bCheckSystemHeadersForModification,
								bCheckExternalHeadersForModification,
								bUsePDBFiles,
								bUsePCHFiles,
								bPrintDebugInfo,
								bLogDetailedActionStats,
								bAllowXGE,
								bShowXGEMonitor,
								bShouldDeleteAllOutdatedProducedItems,
								bUseIncrementalLinking,
								bSupportEditAndContinue,
								bUseIntelCompiler,
								bUseSNCCompiler )
				VALUES		  (	@Date,
								@Duration,
								@LinkTime,
								@ConfigID,
								@PlatformID,
								@GameID,
								@MachineID,
								@UserID,
								@ExecutorID,
								@bSuccess,
								@bGeneratedDebugInfo,
								@NumActions,
								@NumOutdatedActions,
								@NumExecutedActions,
								@NumIncludedBytesPerUnityCPP,
								@MinFilesUsingPrecompiledHeader,
								@ProcessorCountMultiplier,
								@bUseUnityBuild,
								@bStressTestUnity,
								@bCheckSystemHeadersForModification,
								@bCheckExternalHeadersForModification,
								@bUsePDBFiles,
								@bUsePCHFiles,
								@bPrintDebugInfo,
								@bLogDetailedActionStats,
								@bAllowXGE,
								@bShowXGEMonitor,
								@bShouldDeleteAllOutdatedProducedItems,
								@bUseIncrementalLinking,
								@bSupportEditAndContinue,
								@bUseIntelCompiler,
								@bUseSNCCompiler )
		
	COMMIT TRANSACTION
END
GO
/****** Object:  Default [DF_Runs_LinkTime]    Script Date: 12/21/2010 13:30:20 ******/
ALTER TABLE [dbo].[Runs] ADD  CONSTRAINT [DF_Runs_LinkTime]  DEFAULT ((-1)) FOR [LinkTime]
GO
/****** Object:  Default [DF_Runs_bUseSNCCompiler]    Script Date: 12/21/2010 13:30:20 ******/
ALTER TABLE [dbo].[Runs] ADD  CONSTRAINT [DF_Runs_bUseSNCCompiler]  DEFAULT ((0)) FOR [bUseSNCCompiler]
GO
/****** Object:  ForeignKey [FK_Runs_Configs]    Script Date: 12/21/2010 13:30:20 ******/
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Configs] FOREIGN KEY([ConfigID])
REFERENCES [dbo].[Configs] ([ConfigID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Configs]
GO
/****** Object:  ForeignKey [FK_Runs_Executors]    Script Date: 12/21/2010 13:30:20 ******/
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Executors] FOREIGN KEY([ExecutorID])
REFERENCES [dbo].[Executors] ([ExecutorID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Executors]
GO
/****** Object:  ForeignKey [FK_Runs_Games]    Script Date: 12/21/2010 13:30:20 ******/
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Games] FOREIGN KEY([GameID])
REFERENCES [dbo].[Games] ([GameID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Games]
GO
/****** Object:  ForeignKey [FK_Runs_Machines]    Script Date: 12/21/2010 13:30:20 ******/
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Machines] FOREIGN KEY([MachineID])
REFERENCES [dbo].[Machines] ([MachineID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Machines]
GO
/****** Object:  ForeignKey [FK_Runs_Platforms]    Script Date: 12/21/2010 13:30:20 ******/
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Platforms] FOREIGN KEY([PlatformID])
REFERENCES [dbo].[Platforms] ([PlatformID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Platforms]
GO
/****** Object:  ForeignKey [FK_Runs_Users]    Script Date: 12/21/2010 13:30:20 ******/
ALTER TABLE [dbo].[Runs]  WITH CHECK ADD  CONSTRAINT [FK_Runs_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Runs] CHECK CONSTRAINT [FK_Runs_Users]
GO
