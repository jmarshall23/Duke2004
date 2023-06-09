USE [GameStats]
GO
/****** Object:  Table [dbo].[Platforms]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Platforms](
	[ID] [tinyint] NOT NULL,
	[Name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Platforms] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PawnMetadata]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PawnMetadata](
	[ID] [tinyint] NOT NULL,
	[ClassName] [varchar](50) NOT NULL,
	[FriendlyName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PawnMetadata] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Maps]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Maps](
	[ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[MapName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Maps] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Languages](
	[ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[LanguageID] [tinyint] NOT NULL,
	[FriendlyName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProjectileMetadata]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectileMetadata](
	[ID] [tinyint] NOT NULL,
	[ClassName] [varchar](50) NOT NULL,
	[FriendlyName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ProjectileMetadata] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WeaponMetadata]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WeaponMetadata](
	[ID] [tinyint] NOT NULL,
	[ClassName] [varchar](50) NOT NULL,
	[FriendlyName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_WeaponMetadata] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TestTable]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TestVal] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerNames]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PlayerNames](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[PlayerName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PlayerNames] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[DummyProcedure]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DummyProcedure]

AS

BEGIN
	BEGIN TRANSACTION 

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
		DECLARE @SessionEntryID int
		SET @SessionEntryID = -1
	COMMIT TRANSACTION


	SELECT @SessionEntryID AS [Return Value]
	RETURN @SessionEntryID

END
GO
/****** Object:  Table [dbo].[DamageMetadata]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DamageMetadata](
	[ID] [tinyint] NOT NULL,
	[ClassName] [varchar](50) NOT NULL,
	[FriendlyName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DamageMetadata] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GameTypes]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GameTypes](
	[ID] [tinyint] NOT NULL,
	[GameClassName] [varchar](30) NOT NULL,
	[FriendlyName] [varchar](30) NOT NULL,
 CONSTRAINT [PK_GameTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GameplayEventsMetadata]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GameplayEventsMetadata](
	[EventID] [smallint] NOT NULL,
	[EventName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_GameplayEvents] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GameSessionInfoTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [varchar](50) NOT NULL,
	[SessionTimestamp] [varchar](50) NOT NULL,
	[AppTitleID] [varchar](10) NOT NULL,
	[PlatformType] [tinyint] NOT NULL,
	[Language] [tinyint] NOT NULL,
	[SessionStartTime] [real] NOT NULL,
	[SessionEndTime] [real] NOT NULL,
	[GameType] [tinyint] NOT NULL,
	[MapName] [tinyint] NOT NULL,
 CONSTRAINT [PK_GameSessionInfoTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[GameSessionExists]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GameSessionExists]
	@SessionID varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Get PlayerNameID, add if it doesn't exist yet
	DECLARE @SessionDBID bigint
	SET @SessionDBID = (SELECT ID FROM dbo.GameSessionInfoTable WHERE SessionID = @SessionID)
	IF (@SessionDBID IS NULL)
		BEGIN
			SET @SessionDBID = -1
		END

	SELECT @SessionDBID AS [Return Value]
	RETURN @SessionDBID
END
GO
/****** Object:  Table [dbo].[GameIntEventsTable]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameIntEventsTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [bigint] NOT NULL,
	[EventID] [smallint] NOT NULL,
	[EventTime] [real] NOT NULL,
	[IntValue] [int] NOT NULL,
 CONSTRAINT [PK_GameIntEventsTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GameStringEventsTable]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GameStringEventsTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [bigint] NOT NULL,
	[EventID] [smallint] NOT NULL,
	[EventTime] [real] NOT NULL,
	[StringValue] [varchar](max) NOT NULL,
 CONSTRAINT [PK_GameStringEventsTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[GetAllGameSessionsByMap]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllGameSessionsByMap]
@MapName varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT     dbo.GameSessionInfoTable.SessionTimestamp AS Timestamp, dbo.GameSessionInfoTable.SessionID, dbo.GameSessionInfoTable.AppTitleID AS TitleID, 
						  dbo.Maps.MapName, dbo.Platforms.Name AS Platform, dbo.Languages.FriendlyName AS Language, dbo.GameTypes.FriendlyName AS GameType, 
						  dbo.GameSessionInfoTable.SessionStartTime, dbo.GameSessionInfoTable.SessionEndTime
	FROM       dbo.GameSessionInfoTable INNER JOIN
						  dbo.Maps ON dbo.GameSessionInfoTable.MapName = dbo.Maps.ID INNER JOIN
						  dbo.Platforms ON dbo.GameSessionInfoTable.PlatformType = dbo.Platforms.ID INNER JOIN
						  dbo.Languages ON dbo.GameSessionInfoTable.Language = dbo.Languages.ID INNER JOIN
						  dbo.GameTypes ON dbo.GameSessionInfoTable.GameType = dbo.GameTypes.ID
	WHERE     (dbo.Maps.MapName = @MapName)

END
GO
/****** Object:  Table [dbo].[PlayerMetadata]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerMetadata](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [bigint] NOT NULL,
	[PlayerID] [smallint] NOT NULL,
	[PlayerNameID] [bigint] NOT NULL,
	[IsABot] [bit] NOT NULL,
 CONSTRAINT [PK_PlayerMetadata] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_PlayerMetadata] UNIQUE NONCLUSTERED 
(
	[SessionID] ASC,
	[PlayerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[QueryGameSessionInfo]    Script Date: 08/17/2010 08:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[QueryGameSessionInfo]
AS
SELECT     dbo.GameSessionInfoTable.SessionTimestamp AS Timestamp, dbo.GameSessionInfoTable.SessionID, dbo.GameSessionInfoTable.AppTitleID AS TitleID, 
                      dbo.Maps.MapName, dbo.Platforms.Name AS Platform, dbo.Languages.FriendlyName AS Language, dbo.GameTypes.FriendlyName AS GameType, 
                      dbo.GameSessionInfoTable.SessionStartTime, dbo.GameSessionInfoTable.SessionEndTime
FROM         dbo.GameSessionInfoTable INNER JOIN
                      dbo.Maps ON dbo.GameSessionInfoTable.MapName = dbo.Maps.ID INNER JOIN
                      dbo.Platforms ON dbo.GameSessionInfoTable.PlatformType = dbo.Platforms.ID INNER JOIN
                      dbo.Languages ON dbo.GameSessionInfoTable.Language = dbo.Languages.ID INNER JOIN
                      dbo.GameTypes ON dbo.GameSessionInfoTable.GameType = dbo.GameTypes.ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "GameSessionInfoTable"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 280
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Maps"
            Begin Extent = 
               Top = 6
               Left = 243
               Bottom = 96
               Right = 394
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Platforms"
            Begin Extent = 
               Top = 6
               Left = 432
               Bottom = 93
               Right = 583
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Languages"
            Begin Extent = 
               Top = 6
               Left = 621
               Bottom = 104
               Right = 772
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameTypes"
            Begin Extent = 
               Top = 6
               Left = 810
               Bottom = 104
               Right = 968
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
      Begin ColumnWidths = 14
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryGameSessionInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2670
         Alias = 2595
         Table = 2280
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryGameSessionInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryGameSessionInfo'
GO
/****** Object:  StoredProcedure [dbo].[AddGameSession]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddGameSession]
	@SessionID varchar(50) = 'Unknown',
	@SessionTimestamp varchar(50) = 'Unknown',
	@AppTitleID varchar(10) = 'Unknown',
	@PlatformType tinyint,
	@LanguageEnum varchar(5),
	@SessionStartTime real,
	@SessionEndTime real,
	@GameClassName varchar(50),
	@MapName varchar(50)
AS
BEGIN
	BEGIN TRANSACTION

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Get GameClassID
		DECLARE @GameClassID bigint
		SET @GameClassID = (SELECT ID FROM dbo.GameTypes WHERE GameClassName = @GameClassName)
		IF (@GameClassID IS NULL)
			BEGIN
				SET @GameClassID = 0
			END

		-- Get MapNameID
		DECLARE @MapNameID bigint
		SET @MapNameID = (SELECT ID FROM dbo.Maps WHERE MapName = @MapName)
		IF (@MapNameID IS NULL)
			BEGIN
				INSERT INTO dbo.Maps 
					   (MapName)
				VALUES (@MapName)
				SET @MapNameID = SCOPE_IDENTITY()
			END

		-- Get Language
		DECLARE @LanguageID bigint
		SET @LanguageID = (SELECT ID FROM dbo.Languages WHERE FriendlyName = @LanguageEnum)


		DECLARE @SessionEntryID int

		SET @SessionEntryID = (SELECT SessionID FROM dbo.GameSessionInfoTable WHERE SessionID = @SessionID)
		IF (@SessionEntryID IS NULL)
			BEGIN
				INSERT INTO GameSessionInfoTable
					   (SessionID, SessionTimestamp, AppTitleID, PlatformType, Language, SessionStartTime, SessionEndTime, GameType, MapName)
				VALUES (@SessionID, @SessionTimestamp, @AppTitleID, @PlatformType, @LanguageID, @SessionStartTime, @SessionEndTime, @GameClassID, @MapNameID)
				SET @SessionEntryID = SCOPE_IDENTITY()
			END
		ELSE
			BEGIN
				SET @SessionEntryID = -1
			END

	COMMIT TRANSACTION

	SELECT @SessionEntryID AS [Return Value]
	RETURN @SessionEntryID
END
GO
/****** Object:  Table [dbo].[TeamMetadata]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TeamMetadata](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [bigint] NOT NULL,
	[TeamID] [tinyint] NOT NULL,
	[TeamName] [varchar](50) NOT NULL,
	[TeamColor] [int] NOT NULL,
 CONSTRAINT [PK_TeamMetadata] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProjectileIntEventsTable]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectileIntEventsTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [bigint] NOT NULL,
	[EventID] [smallint] NOT NULL,
	[EventTime] [real] NOT NULL,
	[PlayerID] [bigint] NOT NULL,
	[PlayerPosX] [real] NOT NULL,
	[PlayerPosY] [real] NOT NULL,
	[PlayerPosZ] [real] NOT NULL,
	[PlayerYaw] [smallint] NOT NULL,
	[PlayerPitch] [smallint] NOT NULL,
	[PlayerRoll] [smallint] NOT NULL,
	[ProjectileID] [tinyint] NOT NULL,
	[IntValue] [int] NOT NULL,
 CONSTRAINT [PK_ProjectileIntEventsTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerStringEventsTable]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PlayerStringEventsTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [bigint] NOT NULL,
	[EventID] [smallint] NOT NULL,
	[EventTime] [real] NOT NULL,
	[PlayerID] [bigint] NOT NULL,
	[PlayerPosX] [real] NOT NULL,
	[PlayerPosY] [real] NOT NULL,
	[PlayerPosZ] [real] NOT NULL,
	[PlayerYaw] [smallint] NOT NULL,
	[PlayerPitch] [smallint] NOT NULL,
	[PlayerRoll] [smallint] NOT NULL,
	[StringEvent] [varchar](1000) NOT NULL,
 CONSTRAINT [PK_PlayerStringEventsTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PlayerSpawnEventsTable]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerSpawnEventsTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [bigint] NOT NULL,
	[EventID] [smallint] NOT NULL,
	[EventTime] [real] NOT NULL,
	[PlayerID] [bigint] NOT NULL,
	[PlayerPosX] [real] NOT NULL,
	[PlayerPosY] [real] NOT NULL,
	[PlayerPosZ] [real] NOT NULL,
	[PlayerYaw] [smallint] NOT NULL,
	[PlayerPitch] [smallint] NOT NULL,
	[PlayerRoll] [smallint] NOT NULL,
	[PawnID] [tinyint] NOT NULL,
	[TeamID] [bigint] NOT NULL,
 CONSTRAINT [PK_PlayerSpawnEventsTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerPlayerEventsTable]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerPlayerEventsTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [bigint] NOT NULL,
	[EventID] [smallint] NOT NULL,
	[EventTime] [real] NOT NULL,
	[PlayerID] [bigint] NOT NULL,
	[PlayerPosX] [real] NOT NULL,
	[PlayerPosY] [real] NOT NULL,
	[PlayerPosZ] [real] NOT NULL,
	[PlayerYaw] [smallint] NOT NULL,
	[PlayerPitch] [smallint] NOT NULL,
	[PlayerRoll] [smallint] NOT NULL,
	[TargetID] [bigint] NOT NULL,
	[TargetYaw] [smallint] NOT NULL,
	[TargetPitch] [smallint] NOT NULL,
	[TargetRoll] [smallint] NOT NULL,
	[TargetPosX] [real] NOT NULL,
	[TargetPosY] [real] NOT NULL,
	[TargetPosZ] [real] NOT NULL,
 CONSTRAINT [PK_PlayerPlayerPlayerEventsTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WeaponIntEventsTable]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WeaponIntEventsTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [bigint] NOT NULL,
	[EventID] [smallint] NOT NULL,
	[EventTime] [real] NOT NULL,
	[PlayerID] [bigint] NOT NULL,
	[PlayerPosX] [real] NOT NULL,
	[PlayerPosY] [real] NOT NULL,
	[PlayerPosZ] [real] NOT NULL,
	[PlayerYaw] [smallint] NOT NULL,
	[PlayerPitch] [smallint] NOT NULL,
	[PlayerRoll] [smallint] NOT NULL,
	[WeaponID] [tinyint] NOT NULL,
	[IntValue] [int] NOT NULL,
 CONSTRAINT [PK_WeaponIntEventsTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[QueryAllTeamMetadataForSession]    Script Date: 08/17/2010 08:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[QueryAllTeamMetadataForSession]
AS
SELECT     dbo.GameSessionInfoTable.SessionID, dbo.TeamMetadata.TeamID, dbo.TeamMetadata.TeamName, dbo.TeamMetadata.TeamColor
FROM         dbo.GameSessionInfoTable INNER JOIN
                      dbo.TeamMetadata ON dbo.GameSessionInfoTable.ID = dbo.TeamMetadata.SessionID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "GameSessionInfoTable"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 217
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TeamMetadata"
            Begin Extent = 
               Top = 6
               Left = 243
               Bottom = 214
               Right = 394
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1875
         Alias = 900
         Table = 2145
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryAllTeamMetadataForSession'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryAllTeamMetadataForSession'
GO
/****** Object:  View [dbo].[QueryAllPlayerMetadataForSession]    Script Date: 08/17/2010 08:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[QueryAllPlayerMetadataForSession]
AS
SELECT     dbo.GameSessionInfoTable.SessionID, dbo.PlayerNames.PlayerName, dbo.PlayerMetadata.PlayerID, dbo.PlayerMetadata.IsABot
FROM         dbo.GameSessionInfoTable INNER JOIN
                      dbo.PlayerMetadata ON dbo.GameSessionInfoTable.ID = dbo.PlayerMetadata.SessionID INNER JOIN
                      dbo.PlayerNames ON dbo.PlayerMetadata.PlayerNameID = dbo.PlayerNames.ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "GameSessionInfoTable"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerMetadata"
            Begin Extent = 
               Top = 6
               Left = 243
               Bottom = 216
               Right = 394
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerNames"
            Begin Extent = 
               Top = 6
               Left = 432
               Bottom = 84
               Right = 583
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 2175
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2070
         Table = 3210
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryAllPlayerMetadataForSession'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryAllPlayerMetadataForSession'
GO
/****** Object:  Table [dbo].[TeamIntEventsTable]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamIntEventsTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [bigint] NOT NULL,
	[EventID] [smallint] NOT NULL,
	[TeamID] [bigint] NOT NULL,
	[EventTime] [real] NOT NULL,
	[IntValue] [int] NOT NULL,
 CONSTRAINT [PK_TeamEventsTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[AddGameStringEvent]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddGameStringEvent]
	@SessionID bigint,
	@EventID smallint,
	@EventTime real,
    @StringValue varchar(MAX)
AS

BEGIN
	BEGIN TRANSACTION 

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- DECLARE @StatID int
		INSERT INTO GameStringEventsTable
				 (SessionID,EventID,EventTime,StringValue)
		VALUES   (@SessionID,@EventID,@EventTime,@StringValue)
		-- SET @StatID = @@IDENTITY

	COMMIT TRANSACTION

	-- SELECT @StatID AS [Return Value]
	-- RETURN @StatID

END
GO
/****** Object:  StoredProcedure [dbo].[AddGameIntEvent]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddGameIntEvent]
	@SessionID bigint,
	@EventID smallint,
	@EventTime real,
    @IntValue int
AS

BEGIN
	BEGIN TRANSACTION 

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- DECLARE @StatID int
		INSERT INTO GameIntEventsTable
				 (SessionID,EventID,EventTime,IntValue)
		VALUES   (@SessionID,@EventID,@EventTime,@IntValue)
		-- SET @StatID = @@IDENTITY

	COMMIT TRANSACTION

	-- SELECT @StatID AS [Return Value]
	-- RETURN @StatID

END
GO
/****** Object:  Table [dbo].[PlayerLoginEventsTable]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerLoginEventsTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [bigint] NOT NULL,
	[EventID] [smallint] NOT NULL,
	[EventTime] [real] NOT NULL,
	[PlayerID] [bigint] NOT NULL,
	[PlayerPosX] [real] NOT NULL,
	[PlayerPosY] [real] NOT NULL,
	[PlayerPosZ] [real] NOT NULL,
	[PlayerYaw] [smallint] NOT NULL,
	[PlayerPitch] [smallint] NOT NULL,
	[PlayerRoll] [smallint] NOT NULL,
 CONSTRAINT [PK_PlayerLoginEventsTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerKillDeathEventsTable]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerKillDeathEventsTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [bigint] NOT NULL,
	[EventID] [smallint] NOT NULL,
	[EventTime] [real] NOT NULL,
	[PlayerID] [bigint] NOT NULL,
	[PlayerPosX] [real] NOT NULL,
	[PlayerPosY] [real] NOT NULL,
	[PlayerPosZ] [real] NOT NULL,
	[PlayerYaw] [smallint] NOT NULL,
	[PlayerPitch] [smallint] NOT NULL,
	[PlayerRoll] [smallint] NOT NULL,
	[TargetID] [bigint] NOT NULL,
	[TargetPosX] [real] NOT NULL,
	[TargetPosY] [real] NOT NULL,
	[TargetPosZ] [real] NOT NULL,
	[TargetYaw] [smallint] NOT NULL,
	[TargetPitch] [smallint] NOT NULL,
	[TargetRoll] [smallint] NOT NULL,
	[DamageID] [tinyint] NOT NULL,
	[KillType] [smallint] NOT NULL,
 CONSTRAINT [PK_PlayerKillDeathEventsTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerIntEventsTable]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerIntEventsTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [bigint] NOT NULL,
	[EventID] [smallint] NOT NULL,
	[EventTime] [real] NOT NULL,
	[PlayerID] [bigint] NOT NULL,
	[PlayerPosX] [real] NOT NULL,
	[PlayerPosY] [real] NOT NULL,
	[PlayerPosZ] [real] NOT NULL,
	[PlayerYaw] [smallint] NOT NULL,
	[PlayerPitch] [smallint] NOT NULL,
	[PlayerRoll] [smallint] NOT NULL,
	[IntValue] [int] NOT NULL,
 CONSTRAINT [PK_PlayerEventsTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerFloatEventsTable]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerFloatEventsTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [bigint] NOT NULL,
	[EventID] [smallint] NOT NULL,
	[EventTime] [real] NOT NULL,
	[PlayerID] [bigint] NOT NULL,
	[PlayerPosX] [real] NOT NULL,
	[PlayerPosY] [real] NOT NULL,
	[PlayerPosZ] [real] NOT NULL,
	[PlayerYaw] [smallint] NOT NULL,
	[PlayerPitch] [smallint] NOT NULL,
	[PlayerRoll] [smallint] NOT NULL,
	[FloatValue] [real] NOT NULL,
 CONSTRAINT [PK_PlayerFloatEventsTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[AddPlayerMetadata]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddPlayerMetadata]
	@SessionID bigint,
	@PlayerID smallint,
    @PlayerName varchar(50),
    @IsABot bit
	
AS
BEGIN
	BEGIN TRANSACTION 

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Get PlayerNameID, add if it doesn't exist yet
		DECLARE @PlayerNameID bigint
		SET @PlayerNameID = (SELECT ID FROM dbo.PlayerNames WHERE PlayerName = @PlayerName)
		IF (@PlayerNameID IS NULL)
		BEGIN
			INSERT INTO dbo.PlayerNames (PlayerName) VALUES (@PlayerName)
			SET @PlayerNameID = @@IDENTITY
		END

		DECLARE @PlayerEntryID int
		INSERT INTO PlayerMetadata
				(SessionID, PlayerID, PlayerNameID, IsABot)
		VALUES  (@SessionID, @PlayerID, @PlayerNameID, @IsABot)
		SET @PlayerEntryID = @@IDENTITY

	COMMIT TRANSACTION

	SELECT @PlayerEntryID AS [Return Value]
	RETURN @PlayerEntryID
END
GO
/****** Object:  StoredProcedure [dbo].[AddTeamMetadata]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddTeamMetadata]
	@SessionID bigint,
	@TeamID tinyint,
    @TeamName varchar(50),
    @TeamColor int
	
AS
BEGIN
	BEGIN TRANSACTION

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON; 

		DECLARE @TeamEntryID int
		INSERT INTO TeamMetadata
			   (SessionID, TeamID, TeamName, TeamColor)
		VALUES (@SessionID, @TeamID, @TeamName, @TeamColor)
		SET @TeamEntryID = @@IDENTITY

	COMMIT TRANSACTION

	SELECT @TeamEntryID AS [Return Value]
	RETURN @TeamEntryID
END
GO
/****** Object:  Table [dbo].[DamageIntEventsTable]    Script Date: 08/17/2010 08:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DamageIntEventsTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionID] [bigint] NOT NULL,
	[EventID] [smallint] NOT NULL,
	[EventTime] [real] NOT NULL,
	[PlayerID] [bigint] NOT NULL,
	[PlayerPosX] [real] NOT NULL,
	[PlayerPosY] [real] NOT NULL,
	[PlayerPosZ] [real] NOT NULL,
	[PlayerYaw] [smallint] NOT NULL,
	[PlayerPitch] [smallint] NOT NULL,
	[PlayerRoll] [smallint] NOT NULL,
	[TargetID] [bigint] NOT NULL,
	[TargetPosX] [real] NOT NULL,
	[TargetPosY] [real] NOT NULL,
	[TargetPosZ] [real] NOT NULL,
	[TargetYaw] [smallint] NOT NULL,
	[TargetPitch] [smallint] NOT NULL,
	[TargetRoll] [smallint] NOT NULL,
	[DamageID] [tinyint] NOT NULL,
	[IntValue] [int] NOT NULL,
 CONSTRAINT [PK_DamageIntEventsTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[AddWeaponIntEvent]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddWeaponIntEvent]
	@SessionID bigint,
	@EventID smallint,
	@EventTime real,
	@PlayerID smallint,
	@PlayerPosX real,
	@PlayerPosY real,
	@PlayerPosZ real,
	@PlayerYaw smallint,
	@PlayerPitch smallint,
	@PlayerRoll smallint,
    @WeaponClassName varchar(50),
    @IntValue int
AS

BEGIN
	BEGIN TRANSACTION 

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Get WeaponID to use, specify 0 for unknown
		DECLARE @WeaponID bigint
		SET @WeaponID = (SELECT ID FROM dbo.WeaponMetadata WHERE ClassName = @WeaponClassName)
		IF (@WeaponID IS NULL)
			BEGIN
				--SET @WeaponID = 0
				DECLARE @MyCount tinyint
				SELECT @MyCount = COUNT(*) FROM dbo.WeaponMetadata
				INSERT INTO dbo.WeaponMetadata (ID, ClassName, FriendlyName) VALUES (@MyCount, @WeaponClassName, 'FILLIN')
				SET @WeaponID = @MyCount
			END

		-- DECLARE @StatID int
		INSERT INTO WeaponIntEventsTable
				 (SessionID, EventID, EventTime, PlayerID, PlayerPosX, PlayerPosY, PlayerPosZ, PlayerYaw, PlayerPitch, PlayerRoll,WeaponID,IntValue)
		VALUES   (@SessionID,@EventID,@EventTime,@PlayerID,@PlayerPosX,@PlayerPosY,@PlayerPosZ,@PlayerYaw,@PlayerPitch,@PlayerRoll,@WeaponID,@IntValue)
		-- SET @StatID = @@IDENTITY

	COMMIT TRANSACTION

	-- SELECT @StatID AS [Return Value]
	-- RETURN @StatID

END
GO
/****** Object:  StoredProcedure [dbo].[AddTeamIntEvent]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddTeamIntEvent]
	@SessionID bigint,
	@EventID smallint,
	@EventTime real,
	@TeamID smallint,
    @IntValue int
AS

BEGIN
	BEGIN TRANSACTION 

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- DECLARE @StatID int
		INSERT INTO TeamIntEventsTable
				 (SessionID,EventID,EventTime,TeamID,IntValue)
		VALUES   (@SessionID,@EventID,@EventTime,@TeamID,@IntValue)
		-- SET @StatID = @@IDENTITY

	COMMIT TRANSACTION

	-- SELECT @StatID AS [Return Value]
	-- RETURN @StatID

END
GO
/****** Object:  StoredProcedure [dbo].[AddProjectileIntEvent]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddProjectileIntEvent]
	@SessionID bigint,
	@EventID smallint,
	@EventTime real,
	@PlayerID smallint,
	@PlayerPosX real,
	@PlayerPosY real,
	@PlayerPosZ real,
	@PlayerYaw smallint,
	@PlayerPitch smallint,
	@PlayerRoll smallint,
    @ProjectileClassName varchar(50),
    @IntValue int
AS

BEGIN
	BEGIN TRANSACTION 

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Get ProjectileID to use, specify 0 for unknown
		DECLARE @ProjectileID bigint
		SET @ProjectileID = (SELECT ID FROM dbo.ProjectileMetadata WHERE ClassName = @ProjectileClassName)
		IF (@ProjectileID IS NULL)
			BEGIN
				--SET @ProjectileID = 0
				DECLARE @MyCount tinyint
				SELECT @MyCount = COUNT(*) FROM dbo.ProjectileMetadata
				INSERT INTO dbo.ProjectileMetadata (ID, ClassName, FriendlyName) VALUES (@MyCount, @ProjectileClassName, 'FILLIN')
				SET @ProjectileID = @MyCount
			END

		-- DECLARE @StatID int
		INSERT INTO ProjectileIntEventsTable
				 (SessionID, EventID, EventTime, PlayerID, PlayerPosX, PlayerPosY, PlayerPosZ, PlayerYaw, PlayerPitch, PlayerRoll,ProjectileID,IntValue)
		VALUES   (@SessionID,@EventID,@EventTime,@PlayerID,@PlayerPosX,@PlayerPosY,@PlayerPosZ,@PlayerYaw,@PlayerPitch,@PlayerRoll,@ProjectileID,@IntValue)
		-- SET @StatID = @@IDENTITY

	COMMIT TRANSACTION

	-- SELECT @StatID AS [Return Value]
	-- RETURN @StatID

END
GO
/****** Object:  StoredProcedure [dbo].[AddPlayerStringEvent]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddPlayerStringEvent]
	@SessionID bigint,
	@EventID smallint,
	@EventTime real,
	@PlayerID smallint,
	@PlayerPosX real,
	@PlayerPosY real,
	@PlayerPosZ real,
	@PlayerYaw smallint,
	@PlayerPitch smallint,
	@PlayerRoll smallint,
    @StringEvent varchar(1000)
AS

BEGIN
	BEGIN TRANSACTION 

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- DECLARE @StatID int
		INSERT INTO PlayerStringEventsTable
				 (SessionID, EventID, EventTime, PlayerID, PlayerPosX, PlayerPosY, PlayerPosZ, PlayerYaw, PlayerPitch, PlayerRoll,StringEvent)
		VALUES   (@SessionID,@EventID,@EventTime,@PlayerID,@PlayerPosX,@PlayerPosY,@PlayerPosZ,@PlayerYaw,@PlayerPitch,@PlayerRoll,@StringEvent)
		-- SET @StatID = @@IDENTITY

	COMMIT TRANSACTION

	-- SELECT @StatID AS [Return Value]
	-- RETURN @StatID

END
GO
/****** Object:  StoredProcedure [dbo].[AddPlayerSpawnEvent]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddPlayerSpawnEvent]
	@SessionID bigint,
	@EventID smallint,
	@EventTime real,
	@PlayerID smallint,
	@PlayerPosX real,
	@PlayerPosY real,
	@PlayerPosZ real,
	@PlayerYaw smallint,
	@PlayerPitch smallint,
	@PlayerRoll smallint,
    @PawnClassName varchar(50),
	@TeamID bigint
AS

BEGIN
	BEGIN TRANSACTION 

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Get PawnID to use, specify 0 for unknown
		DECLARE @PawnID bigint
		SET @PawnID = (SELECT ID FROM dbo.PawnMetadata WHERE ClassName = @PawnClassName)
		IF (@PawnID IS NULL)
			BEGIN
				--SET @PawnID = 0
				DECLARE @MyCount tinyint
				SELECT @MyCount = COUNT(*) FROM dbo.PawnMetadata
				INSERT INTO dbo.PawnMetadata (ID, ClassName, FriendlyName) VALUES (@MyCount, @PawnClassName, 'FILLIN')
				SET @PawnID = @MyCount
			END

		-- DECLARE @StatID int
		INSERT INTO PlayerSpawnEventsTable
				 (SessionID, EventID, EventTime, PlayerID, PlayerPosX, PlayerPosY, PlayerPosZ, PlayerYaw, PlayerPitch, PlayerRoll,PawnID,TeamID)
		VALUES   (@SessionID,@EventID,@EventTime,@PlayerID,@PlayerPosX,@PlayerPosY,@PlayerPosZ,@PlayerYaw,@PlayerPitch,@PlayerRoll,@PawnID,@TeamID)
		-- SET @StatID = @@IDENTITY

	COMMIT TRANSACTION

	-- SELECT @StatID AS [Return Value]
	-- RETURN @StatID

END
GO
/****** Object:  StoredProcedure [dbo].[AddPlayerPlayerEvent]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddPlayerPlayerEvent]
	@SessionID bigint,
	@EventID smallint,
	@EventTime real,
	@PlayerID smallint,
	@PlayerPosX real,
	@PlayerPosY real,
	@PlayerPosZ real,
	@PlayerYaw smallint,
	@PlayerPitch smallint,
	@PlayerRoll smallint,
    @TargetID smallint,
    @TargetPosX real,
	@TargetPosY real,
	@TargetPosZ real,
	@TargetYaw smallint,
	@TargetPitch smallint,
	@TargetRoll smallint
AS

BEGIN
	BEGIN TRANSACTION 

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- DECLARE @StatID int
		INSERT INTO PlayerPlayerEventsTable
				 (SessionID, EventID, EventTime, PlayerID, PlayerPosX, PlayerPosY, PlayerPosZ, PlayerYaw, PlayerPitch, PlayerRoll, TargetID, TargetPosX, TargetPosY, TargetPosZ, TargetYaw, TargetPitch, TargetRoll)
		VALUES   (@SessionID,@EventID,@EventTime,@PlayerID,@PlayerPosX,@PlayerPosY,@PlayerPosZ,@PlayerYaw,@PlayerPitch,@PlayerRoll,@TargetID,@TargetPosX,@TargetPosY,@TargetPosZ,@TargetYaw,@TargetPitch,@TargetRoll)
		-- SET @StatID = @@IDENTITY

	COMMIT TRANSACTION

	-- SELECT @StatID AS [Return Value]
	-- RETURN @StatID

END
GO
/****** Object:  StoredProcedure [dbo].[AddPlayerLoginEvent]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddPlayerLoginEvent]
	@SessionID bigint,
	@EventID smallint,
	@EventTime real,
	@PlayerID smallint,
	@PlayerPosX real,
	@PlayerPosY real,
	@PlayerPosZ real,
	@PlayerYaw smallint,
	@PlayerPitch smallint,
	@PlayerRoll smallint
AS

BEGIN
	BEGIN TRANSACTION 

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- DECLARE @StatID int
		INSERT INTO PlayerLoginEventsTable
				 (SessionID, EventID, EventTime, PlayerID, PlayerPosX, PlayerPosY, PlayerPosZ, PlayerYaw, PlayerPitch, PlayerRoll)
		VALUES   (@SessionID,@EventID,@EventTime,@PlayerID,@PlayerPosX,@PlayerPosY,@PlayerPosZ,@PlayerYaw,@PlayerPitch,@PlayerRoll)
		-- SET @StatID = @@IDENTITY

	COMMIT TRANSACTION

	-- SELECT @StatID AS [Return Value]
	-- RETURN @StatID

END
GO
/****** Object:  StoredProcedure [dbo].[AddPlayerKillDeathEvent]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddPlayerKillDeathEvent]
	@SessionID bigint,
	@EventID smallint,
	@EventTime real,
	@PlayerID bigint,
	@PlayerPosX real,
	@PlayerPosY real,
	@PlayerPosZ real,
	@PlayerYaw smallint,
	@PlayerPitch smallint,
	@PlayerRoll smallint,
    @TargetID bigint,
	@TargetPosX real,
	@TargetPosY real,
	@TargetPosZ real,
	@TargetYaw smallint,
	@TargetPitch smallint,
	@TargetRoll smallint,
	@KillType smallint,
    @DamageClassName varchar(50)
AS

BEGIN
	BEGIN TRANSACTION 

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Get WeaponID to use, specify 0 for unknown
		DECLARE @DamageID bigint
		SET @DamageID = (SELECT ID FROM dbo.DamageMetadata WHERE ClassName = @DamageClassName)
		IF (@DamageID IS NULL)
			BEGIN
				--SET @DamageID = 0
				DECLARE @MyCount tinyint
				SELECT @MyCount = COUNT(*) FROM dbo.DamageMetadata
				INSERT INTO dbo.DamageMetadata (ID, ClassName, FriendlyName) VALUES (@MyCount, @DamageClassName, 'FILLIN')
				SET @DamageID = @MyCount
			END

		-- DECLARE @StatID int
		INSERT INTO PlayerKillDeathEventsTable
				 (SessionID, EventID, EventTime, PlayerID, PlayerPosX, PlayerPosY, PlayerPosZ, PlayerYaw, PlayerPitch, PlayerRoll, TargetID, TargetPosX, TargetPosY, TargetPosZ, TargetYaw, TargetPitch, TargetRoll, KillType, DamageID)
		VALUES   (@SessionID,@EventID,@EventTime,@PlayerID,@PlayerPosX,@PlayerPosY,@PlayerPosZ,@PlayerYaw,@PlayerPitch,@PlayerRoll,@TargetID,@TargetPosX,@TargetPosY,@TargetPosZ,@TargetYaw,@TargetPitch,@TargetRoll,@KillType,@DamageID)
		-- SET @StatID = @@IDENTITY

	COMMIT TRANSACTION

	-- SELECT @StatID AS [Return Value]
	-- RETURN @StatID

END
GO
/****** Object:  StoredProcedure [dbo].[AddPlayerIntEvent]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddPlayerIntEvent]
	@SessionID bigint,
	@EventID smallint,
	@EventTime real,
	@PlayerID smallint,
	@PlayerPosX real,
	@PlayerPosY real,
	@PlayerPosZ real,
	@PlayerYaw smallint,
	@PlayerPitch smallint,
	@PlayerRoll smallint,
    @IntValue int
AS

BEGIN
	BEGIN TRANSACTION 

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- DECLARE @StatID int
		INSERT INTO PlayerIntEventsTable
				 (SessionID, EventID, EventTime, PlayerID, PlayerPosX, PlayerPosY, PlayerPosZ, PlayerYaw, PlayerPitch, PlayerRoll,IntValue)
		VALUES   (@SessionID,@EventID,@EventTime,@PlayerID,@PlayerPosX,@PlayerPosY,@PlayerPosZ,@PlayerYaw,@PlayerPitch,@PlayerRoll,@IntValue)
		-- SET @StatID = @@IDENTITY

	COMMIT TRANSACTION

	-- SELECT @StatID AS [Return Value]
	-- RETURN @StatID

END
GO
/****** Object:  StoredProcedure [dbo].[AddPlayerFloatEvent]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddPlayerFloatEvent]
	@SessionID bigint,
	@EventID smallint,
	@EventTime real,
	@PlayerID smallint,
	@PlayerPosX real,
	@PlayerPosY real,
	@PlayerPosZ real,
	@PlayerYaw smallint,
	@PlayerPitch smallint,
	@PlayerRoll smallint,
    @FloatValue real
AS

BEGIN
	BEGIN TRANSACTION 

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- DECLARE @StatID int
		INSERT INTO PlayerFloatEventsTable
				 (SessionID, EventID, EventTime, PlayerID, PlayerPosX, PlayerPosY, PlayerPosZ, PlayerYaw, PlayerPitch, PlayerRoll,FloatValue)
		VALUES   (@SessionID,@EventID,@EventTime,@PlayerID,@PlayerPosX,@PlayerPosY,@PlayerPosZ,@PlayerYaw,@PlayerPitch,@PlayerRoll,@FloatValue)
		-- SET @StatID = @@IDENTITY

	COMMIT TRANSACTION

	-- SELECT @StatID AS [Return Value]
	-- RETURN @StatID

END
GO
/****** Object:  StoredProcedure [dbo].[GetAllEventCountsForSessionOLD]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllEventCountsForSessionOLD]
@SessionID varchar(50)
AS

SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.DamageIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.DamageIntEventsTable.EventID INNER JOIN
					  dbo.GameSessionInfoTable ON dbo.DamageIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID
WHERE dbo.GameSessionInfoTable.SessionID = @SessionID
GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameplayEventsMetadata.EventID
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.GameIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.GameIntEventsTable.EventID INNER JOIN
					  dbo.GameSessionInfoTable ON dbo.GameIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID
WHERE dbo.GameSessionInfoTable.SessionID = @SessionID
GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameplayEventsMetadata.EventID
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.GameStringEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.GameStringEventsTable.EventID INNER JOIN
					  dbo.GameSessionInfoTable ON dbo.GameStringEventsTable.SessionID = dbo.GameSessionInfoTable.ID
WHERE dbo.GameSessionInfoTable.SessionID = @SessionID
GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameplayEventsMetadata.EventID
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerFloatEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerFloatEventsTable.EventID INNER JOIN
					  dbo.GameSessionInfoTable ON dbo.PlayerFloatEventsTable.SessionID = dbo.GameSessionInfoTable.ID
WHERE dbo.GameSessionInfoTable.SessionID = @SessionID
GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameplayEventsMetadata.EventID
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerIntEventsTable.EventID INNER JOIN
					  dbo.GameSessionInfoTable ON dbo.PlayerIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID
WHERE dbo.GameSessionInfoTable.SessionID = @SessionID
GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameplayEventsMetadata.EventID
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerKillDeathEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerKillDeathEventsTable.EventID INNER JOIN
					  dbo.GameSessionInfoTable ON dbo.PlayerKillDeathEventsTable.SessionID = dbo.GameSessionInfoTable.ID
WHERE dbo.GameSessionInfoTable.SessionID = @SessionID
GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameplayEventsMetadata.EventID
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerLoginEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerLoginEventsTable.EventID INNER JOIN
					  dbo.GameSessionInfoTable ON dbo.PlayerLoginEventsTable.SessionID = dbo.GameSessionInfoTable.ID
WHERE dbo.GameSessionInfoTable.SessionID = @SessionID
GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameplayEventsMetadata.EventID
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerPlayerEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerPlayerEventsTable.EventID INNER JOIN
					  dbo.GameSessionInfoTable ON dbo.PlayerPlayerEventsTable.SessionID = dbo.GameSessionInfoTable.ID
WHERE dbo.GameSessionInfoTable.SessionID = @SessionID
GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameplayEventsMetadata.EventID
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerSpawnEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerSpawnEventsTable.EventID INNER JOIN
					  dbo.GameSessionInfoTable ON dbo.PlayerSpawnEventsTable.SessionID = dbo.GameSessionInfoTable.ID
WHERE dbo.GameSessionInfoTable.SessionID = @SessionID
GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameplayEventsMetadata.EventID
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerStringEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerStringEventsTable.EventID INNER JOIN
					  dbo.GameSessionInfoTable ON dbo.PlayerStringEventsTable.SessionID = dbo.GameSessionInfoTable.ID
WHERE dbo.GameSessionInfoTable.SessionID = @SessionID
GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameplayEventsMetadata.EventID
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.ProjectileIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.ProjectileIntEventsTable.EventID INNER JOIN
					  dbo.GameSessionInfoTable ON dbo.ProjectileIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID
WHERE dbo.GameSessionInfoTable.SessionID = @SessionID
GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameplayEventsMetadata.EventID
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.TeamIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.TeamIntEventsTable.EventID INNER JOIN
					  dbo.GameSessionInfoTable ON dbo.TeamIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID
WHERE dbo.GameSessionInfoTable.SessionID = @SessionID
GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameplayEventsMetadata.EventID
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.WeaponIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.WeaponIntEventsTable.EventID INNER JOIN
					  dbo.GameSessionInfoTable ON dbo.WeaponIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID
WHERE dbo.GameSessionInfoTable.SessionID = @SessionID
GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameplayEventsMetadata.EventID
GO
/****** Object:  StoredProcedure [dbo].[GetAllPlayerMetadataForSession]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllPlayerMetadataForSession]
	@SessionID varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT * from dbo.QueryAllPlayerMetadataForSession
	WHERE SessionID = @SessionID

END
GO
/****** Object:  StoredProcedure [dbo].[AddDamageIntEvent]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddDamageIntEvent]
	@SessionID bigint,
	@EventID smallint,
	@EventTime real,
	@PlayerID bigint,
	@PlayerPosX real,
	@PlayerPosY real,
	@PlayerPosZ real,
	@PlayerYaw smallint,
	@PlayerPitch smallint,
	@PlayerRoll smallint,
    @TargetID bigint,
	@TargetPosX real,
	@TargetPosY real,
	@TargetPosZ real,
	@TargetYaw smallint,
	@TargetPitch smallint,
	@TargetRoll smallint,
    @DamageClassName varchar(50),
	@IntValue int
AS

BEGIN
	BEGIN TRANSACTION 

		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		-- Get DamageID to use, specify 0 for unknown
		DECLARE @DamageID bigint
		SET @DamageID = (SELECT ID FROM dbo.DamageMetadata WHERE ClassName = @DamageClassName)
		IF (@DamageID IS NULL)
			BEGIN
				--SET @DamageID = 0
				DECLARE @MyCount tinyint
				SELECT @MyCount = COUNT(*) FROM dbo.DamageMetadata
				INSERT INTO dbo.DamageMetadata (ID, ClassName, FriendlyName) VALUES (@MyCount, @DamageClassName, 'FILLIN')
				SET @DamageID = @MyCount
			END

		-- DECLARE @StatID int
		INSERT INTO DamageIntEventsTable
				 (SessionID, EventID, EventTime, PlayerID, PlayerPosX, PlayerPosY, PlayerPosZ, PlayerYaw, PlayerPitch, PlayerRoll, TargetID, TargetPosX, TargetPosY, TargetPosZ, TargetYaw, TargetPitch, TargetRoll, DamageID, IntValue)
		VALUES   (@SessionID,@EventID,@EventTime,@PlayerID,@PlayerPosX,@PlayerPosY,@PlayerPosZ,@PlayerYaw,@PlayerPitch,@PlayerRoll,@TargetID,@TargetPosX,@TargetPosY,@TargetPosZ,@TargetYaw,@TargetPitch,@TargetRoll,@DamageID,@IntValue)
		-- SET @StatID = @@IDENTITY

	COMMIT TRANSACTION

	-- SELECT @StatID AS [Return Value]
	-- RETURN @StatID

END
GO
/****** Object:  View [dbo].[QueryEventCountsBySession]    Script Date: 08/17/2010 08:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[QueryEventCountsBySession]
AS
SELECT DISTINCT dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventName AS Event,  dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.DamageIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.DamageIntEventsTable.EventID INNER JOIN
                      dbo.GameSessionInfoTable ON dbo.DamageIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID
GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventID 



UNION
SELECT DISTINCT dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID,  COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.GameIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.GameIntEventsTable.EventID INNER JOIN
 dbo.GameSessionInfoTable ON dbo.GameIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID

GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventID 

UNION
SELECT DISTINCT dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID,  COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.GameStringEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.GameStringEventsTable.EventID INNER JOIN
 dbo.GameSessionInfoTable ON dbo.GameStringEventsTable.SessionID = dbo.GameSessionInfoTable.ID

GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventID 

UNION
SELECT DISTINCT dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventName AS Event,  dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerFloatEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerFloatEventsTable.EventID INNER JOIN
 dbo.GameSessionInfoTable ON dbo.PlayerFloatEventsTable.SessionID = dbo.GameSessionInfoTable.ID

GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventID 

UNION
SELECT DISTINCT dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventName AS Event,  dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerIntEventsTable.EventID INNER JOIN
 dbo.GameSessionInfoTable ON dbo.PlayerIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID

GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventID 

UNION
SELECT DISTINCT dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventName AS Event,  dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerKillDeathEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerKillDeathEventsTable.EventID INNER JOIN
 dbo.GameSessionInfoTable ON dbo.PlayerKillDeathEventsTable.SessionID = dbo.GameSessionInfoTable.ID

GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventID 

UNION
SELECT DISTINCT dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventName AS Event,  dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerLoginEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerLoginEventsTable.EventID INNER JOIN
 dbo.GameSessionInfoTable ON dbo.PlayerLoginEventsTable.SessionID = dbo.GameSessionInfoTable.ID

GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventID 

UNION
SELECT DISTINCT dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventName AS Event,  dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerPlayerEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerPlayerEventsTable.EventID INNER JOIN
 dbo.GameSessionInfoTable ON dbo.PlayerPlayerEventsTable.SessionID = dbo.GameSessionInfoTable.ID

GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventID 

UNION
SELECT DISTINCT dbo.GameSessionInfoTable.SessionID,  dbo.GameplayEventsMetadata.EventName AS Event, dbo.GameplayEventsMetadata.EventID AS ID,  COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerSpawnEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerSpawnEventsTable.EventID INNER JOIN
 dbo.GameSessionInfoTable ON dbo.PlayerSpawnEventsTable.SessionID = dbo.GameSessionInfoTable.ID

GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventID 

UNION
SELECT DISTINCT dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventName AS Event,  dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerStringEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerStringEventsTable.EventID INNER JOIN
 dbo.GameSessionInfoTable ON dbo.PlayerStringEventsTable.SessionID = dbo.GameSessionInfoTable.ID

GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventID 

UNION
SELECT DISTINCT dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventName AS Event,  dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.ProjectileIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.ProjectileIntEventsTable.EventID INNER JOIN
 dbo.GameSessionInfoTable ON dbo.ProjectileIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID

GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventID 

UNION
SELECT DISTINCT dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventName AS Event,  dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.TeamIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.TeamIntEventsTable.EventID INNER JOIN
 dbo.GameSessionInfoTable ON dbo.TeamIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID

GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventID 

UNION
SELECT DISTINCT dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventName AS Event,  dbo.GameplayEventsMetadata.EventID AS ID, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.WeaponIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.WeaponIntEventsTable.EventID INNER JOIN
 dbo.GameSessionInfoTable ON dbo.WeaponIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID

GROUP BY dbo.GameplayEventsMetadata.EventName, dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "GameplayEventsMetadata"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 84
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DamageIntEventsTable"
            Begin Extent = 
               Top = 6
               Left = 243
               Bottom = 114
               Right = 410
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameSessionInfoTable"
            Begin Extent = 
               Top = 6
               Left = 448
               Bottom = 114
               Right = 631
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 3420
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryEventCountsBySession'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryEventCountsBySession'
GO
/****** Object:  View [dbo].[QueryDamageIntEvents]    Script Date: 08/17/2010 08:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[QueryDamageIntEvents]
AS
SELECT     dbo.GameSessionInfoTable.SessionID, dbo.DamageIntEventsTable.EventTime, dbo.DamageIntEventsTable.EventID, dbo.GameplayEventsMetadata.EventName, 
                      dbo.PlayerMetadata.PlayerID, dbo.PlayerNames.PlayerName, dbo.DamageIntEventsTable.PlayerRoll, dbo.DamageIntEventsTable.PlayerPitch, 
                      dbo.DamageIntEventsTable.PlayerYaw, dbo.DamageIntEventsTable.PlayerPosZ, dbo.DamageIntEventsTable.PlayerPosY, dbo.DamageIntEventsTable.PlayerPosX, 
                      PlayerMetadata_1.PlayerID AS TargetID, PlayerNames_1.PlayerName AS TargetName, dbo.DamageIntEventsTable.TargetPosX, 
                      dbo.DamageIntEventsTable.TargetPosY, dbo.DamageIntEventsTable.TargetPosZ, dbo.DamageIntEventsTable.TargetYaw, dbo.DamageIntEventsTable.TargetPitch, 
                      dbo.DamageIntEventsTable.TargetRoll, dbo.DamageMetadata.FriendlyName AS DamageClass, dbo.DamageIntEventsTable.IntValue
FROM         dbo.DamageIntEventsTable INNER JOIN
                      dbo.PlayerMetadata ON dbo.DamageIntEventsTable.PlayerID = dbo.PlayerMetadata.ID INNER JOIN
                      dbo.PlayerNames ON dbo.PlayerMetadata.PlayerNameID = dbo.PlayerNames.ID INNER JOIN
                      dbo.GameplayEventsMetadata ON dbo.DamageIntEventsTable.EventID = dbo.GameplayEventsMetadata.EventID INNER JOIN
                      dbo.PlayerMetadata AS PlayerMetadata_1 ON dbo.DamageIntEventsTable.TargetID = PlayerMetadata_1.ID INNER JOIN
                      dbo.PlayerNames AS PlayerNames_1 ON PlayerMetadata_1.PlayerNameID = PlayerNames_1.ID INNER JOIN
                      dbo.DamageMetadata ON dbo.DamageIntEventsTable.DamageID = dbo.DamageMetadata.ID INNER JOIN
                      dbo.GameSessionInfoTable ON dbo.DamageIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID AND 
                      dbo.PlayerMetadata.SessionID = dbo.GameSessionInfoTable.ID AND PlayerMetadata_1.SessionID = dbo.GameSessionInfoTable.ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "DamageIntEventsTable"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 361
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerMetadata"
            Begin Extent = 
               Top = 109
               Left = 252
               Bottom = 217
               Right = 403
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerNames"
            Begin Extent = 
               Top = 47
               Left = 470
               Bottom = 125
               Right = 621
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameplayEventsMetadata"
            Begin Extent = 
               Top = 22
               Left = 244
               Bottom = 100
               Right = 395
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerMetadata_1"
            Begin Extent = 
               Top = 226
               Left = 249
               Bottom = 334
               Right = 400
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerNames_1"
            Begin Extent = 
               Top = 245
               Left = 479
               Bottom = 323
               Right = 630
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DamageMetadata"
            Begin Extent = 
               Top = 337
               Left = 262
               Bottom = 430
             ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryDamageIntEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  Right = 413
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameSessionInfoTable"
            Begin Extent = 
               Top = 6
               Left = 659
               Bottom = 114
               Right = 826
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
      Begin ColumnWidths = 21
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryDamageIntEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryDamageIntEvents'
GO
/****** Object:  View [dbo].[QueryWeaponIntEvents]    Script Date: 08/17/2010 08:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[QueryWeaponIntEvents]
AS
SELECT     dbo.GameSessionInfoTable.SessionID, dbo.WeaponIntEventsTable.EventTime, dbo.GameplayEventsMetadata.EventID, dbo.GameplayEventsMetadata.EventName, 
                      dbo.PlayerMetadata.PlayerID, dbo.PlayerNames.PlayerName, dbo.WeaponIntEventsTable.PlayerRoll, dbo.WeaponIntEventsTable.PlayerPitch, 
                      dbo.WeaponIntEventsTable.PlayerYaw, dbo.WeaponIntEventsTable.PlayerPosZ, dbo.WeaponIntEventsTable.PlayerPosY, dbo.WeaponIntEventsTable.PlayerPosX, 
                      dbo.WeaponMetadata.FriendlyName AS WeaponName, dbo.WeaponIntEventsTable.IntValue
FROM         dbo.WeaponIntEventsTable INNER JOIN
                      dbo.PlayerMetadata ON dbo.WeaponIntEventsTable.PlayerID = dbo.PlayerMetadata.ID INNER JOIN
                      dbo.PlayerNames ON dbo.PlayerMetadata.PlayerNameID = dbo.PlayerNames.ID INNER JOIN
                      dbo.GameplayEventsMetadata ON dbo.WeaponIntEventsTable.EventID = dbo.GameplayEventsMetadata.EventID INNER JOIN
                      dbo.WeaponMetadata ON dbo.WeaponIntEventsTable.WeaponID = dbo.WeaponMetadata.ID INNER JOIN
                      dbo.GameSessionInfoTable ON dbo.WeaponIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID AND 
                      dbo.PlayerMetadata.SessionID = dbo.GameSessionInfoTable.ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "WeaponIntEventsTable"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 361
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerMetadata"
            Begin Extent = 
               Top = 98
               Left = 229
               Bottom = 206
               Right = 380
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerNames"
            Begin Extent = 
               Top = 98
               Left = 420
               Bottom = 176
               Right = 571
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameplayEventsMetadata"
            Begin Extent = 
               Top = 13
               Left = 226
               Bottom = 91
               Right = 377
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeaponMetadata"
            Begin Extent = 
               Top = 218
               Left = 225
               Bottom = 311
               Right = 376
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameSessionInfoTable"
            Begin Extent = 
               Top = 6
               Left = 609
               Bottom = 114
               Right = 776
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
      Begin ColumnWidths = 11
         Width =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryWeaponIntEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryWeaponIntEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryWeaponIntEvents'
GO
/****** Object:  View [dbo].[QueryProjectileIntEvents]    Script Date: 08/17/2010 08:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[QueryProjectileIntEvents]
AS
SELECT     dbo.GameSessionInfoTable.SessionID, dbo.ProjectileIntEventsTable.EventTime, dbo.GameplayEventsMetadata.EventID, dbo.GameplayEventsMetadata.EventName, 
                      dbo.PlayerMetadata.PlayerID, dbo.PlayerNames.PlayerName, dbo.ProjectileIntEventsTable.PlayerRoll, dbo.ProjectileIntEventsTable.PlayerPitch, 
                      dbo.ProjectileIntEventsTable.PlayerYaw, dbo.ProjectileIntEventsTable.PlayerPosZ, dbo.ProjectileIntEventsTable.PlayerPosY, 
                      dbo.ProjectileIntEventsTable.PlayerPosX, dbo.ProjectileMetadata.FriendlyName AS ProjectileName, dbo.ProjectileIntEventsTable.IntValue
FROM         dbo.ProjectileIntEventsTable INNER JOIN
                      dbo.PlayerMetadata ON dbo.ProjectileIntEventsTable.PlayerID = dbo.PlayerMetadata.ID INNER JOIN
                      dbo.PlayerNames ON dbo.PlayerMetadata.PlayerNameID = dbo.PlayerNames.ID INNER JOIN
                      dbo.GameplayEventsMetadata ON dbo.ProjectileIntEventsTable.EventID = dbo.GameplayEventsMetadata.EventID INNER JOIN
                      dbo.ProjectileMetadata ON dbo.ProjectileIntEventsTable.ProjectileID = dbo.ProjectileMetadata.ID INNER JOIN
                      dbo.GameSessionInfoTable ON dbo.ProjectileIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID AND 
                      dbo.PlayerMetadata.SessionID = dbo.GameSessionInfoTable.ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "ProjectileIntEventsTable"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 360
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerMetadata"
            Begin Extent = 
               Top = 142
               Left = 233
               Bottom = 250
               Right = 384
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerNames"
            Begin Extent = 
               Top = 206
               Left = 422
               Bottom = 284
               Right = 573
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameplayEventsMetadata"
            Begin Extent = 
               Top = 16
               Left = 272
               Bottom = 94
               Right = 423
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectileMetadata"
            Begin Extent = 
               Top = 282
               Left = 227
               Bottom = 375
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameSessionInfoTable"
            Begin Extent = 
               Top = 6
               Left = 461
               Bottom = 114
               Right = 628
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
      Begin ColumnWidths = 11
      ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryProjectileIntEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'   Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryProjectileIntEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryProjectileIntEvents'
GO
/****** Object:  View [dbo].[QueryPlayerStringEvents]    Script Date: 08/17/2010 08:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[QueryPlayerStringEvents]
AS
SELECT     dbo.GameSessionInfoTable.SessionID, dbo.PlayerStringEventsTable.EventTime, dbo.GameplayEventsMetadata.EventID, dbo.GameplayEventsMetadata.EventName, 
                      dbo.PlayerMetadata.PlayerID, dbo.PlayerNames.PlayerName, dbo.PlayerStringEventsTable.PlayerRoll, dbo.PlayerStringEventsTable.PlayerPitch, 
                      dbo.PlayerStringEventsTable.PlayerYaw, dbo.PlayerStringEventsTable.PlayerPosZ, dbo.PlayerStringEventsTable.PlayerPosY, 
                      dbo.PlayerStringEventsTable.PlayerPosX, dbo.PlayerStringEventsTable.StringEvent
FROM         dbo.PlayerStringEventsTable INNER JOIN
                      dbo.PlayerMetadata ON dbo.PlayerStringEventsTable.PlayerID = dbo.PlayerMetadata.ID INNER JOIN
                      dbo.PlayerNames ON dbo.PlayerMetadata.PlayerNameID = dbo.PlayerNames.ID INNER JOIN
                      dbo.GameplayEventsMetadata ON dbo.PlayerStringEventsTable.EventID = dbo.GameplayEventsMetadata.EventID INNER JOIN
                      dbo.GameSessionInfoTable ON dbo.PlayerStringEventsTable.SessionID = dbo.GameSessionInfoTable.ID AND 
                      dbo.PlayerMetadata.SessionID = dbo.GameSessionInfoTable.ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[28] 2[13] 3) )"
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
         Begin Table = "PlayerStringEventsTable"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 330
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerMetadata"
            Begin Extent = 
               Top = 173
               Left = 247
               Bottom = 301
               Right = 398
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerNames"
            Begin Extent = 
               Top = 190
               Left = 469
               Bottom = 268
               Right = 620
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameplayEventsMetadata"
            Begin Extent = 
               Top = 79
               Left = 240
               Bottom = 157
               Right = 391
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameSessionInfoTable"
            Begin Extent = 
               Top = 12
               Left = 460
               Bottom = 102
               Right = 627
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
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerStringEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' CriteriaPane = 
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerStringEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerStringEvents'
GO
/****** Object:  View [dbo].[QueryPlayerSpawnEvents]    Script Date: 08/17/2010 08:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[QueryPlayerSpawnEvents]
AS
SELECT     dbo.GameSessionInfoTable.SessionID, dbo.PlayerSpawnEventsTable.EventID, dbo.PlayerSpawnEventsTable.EventTime, dbo.GameplayEventsMetadata.EventName, dbo.PlayerMetadata.PlayerID, 
                      dbo.PlayerNames.PlayerName, dbo.PlayerSpawnEventsTable.PlayerRoll, dbo.PlayerSpawnEventsTable.PlayerPitch, dbo.PlayerSpawnEventsTable.PlayerYaw, 
                      dbo.PlayerSpawnEventsTable.PlayerPosZ, dbo.PlayerSpawnEventsTable.PlayerPosY, dbo.PlayerSpawnEventsTable.PlayerPosX, dbo.TeamMetadata.TeamID, 
                      dbo.TeamMetadata.TeamName, dbo.PawnMetadata.FriendlyName AS Pawn
FROM         dbo.PlayerSpawnEventsTable INNER JOIN
                      dbo.PlayerMetadata ON dbo.PlayerSpawnEventsTable.PlayerID = dbo.PlayerMetadata.ID INNER JOIN
                      dbo.PlayerNames ON dbo.PlayerMetadata.PlayerNameID = dbo.PlayerNames.ID INNER JOIN
                      dbo.GameplayEventsMetadata ON dbo.PlayerSpawnEventsTable.EventID = dbo.GameplayEventsMetadata.EventID INNER JOIN
                      dbo.PawnMetadata ON dbo.PlayerSpawnEventsTable.PawnID = dbo.PawnMetadata.ID INNER JOIN
                      dbo.TeamMetadata ON dbo.PlayerSpawnEventsTable.TeamID = dbo.TeamMetadata.ID INNER JOIN
                      dbo.GameSessionInfoTable ON dbo.PlayerSpawnEventsTable.SessionID = dbo.GameSessionInfoTable.ID AND 
                      dbo.PlayerMetadata.SessionID = dbo.GameSessionInfoTable.ID AND dbo.TeamMetadata.SessionID = dbo.GameSessionInfoTable.ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[44] 4[17] 2[20] 3) )"
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
         Begin Table = "PlayerSpawnEventsTable"
            Begin Extent = 
               Top = 50
               Left = 14
               Bottom = 316
               Right = 165
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerMetadata"
            Begin Extent = 
               Top = 99
               Left = 189
               Bottom = 235
               Right = 340
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerNames"
            Begin Extent = 
               Top = 69
               Left = 427
               Bottom = 147
               Right = 578
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameplayEventsMetadata"
            Begin Extent = 
               Top = 8
               Left = 194
               Bottom = 86
               Right = 345
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PawnMetadata"
            Begin Extent = 
               Top = 212
               Left = 403
               Bottom = 305
               Right = 554
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TeamMetadata"
            Begin Extent = 
               Top = 275
               Left = 226
               Bottom = 407
               Right = 362
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameSessionInfoTable"
            Begin Extent = 
               Top = 9
               Left = 605
               Bottom = 117
              ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerSpawnEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' Right = 772
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
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerSpawnEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerSpawnEvents'
GO
/****** Object:  View [dbo].[QueryPlayerPlayerEvents]    Script Date: 08/17/2010 08:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[QueryPlayerPlayerEvents]
AS
SELECT     dbo.GameSessionInfoTable.SessionID, dbo.PlayerPlayerEventsTable.EventID, dbo.GameplayEventsMetadata.EventName, dbo.PlayerPlayerEventsTable.EventTime, dbo.PlayerMetadata.PlayerID, 
                      dbo.PlayerNames.PlayerName, dbo.PlayerPlayerEventsTable.PlayerPosX, dbo.PlayerPlayerEventsTable.PlayerPosY, dbo.PlayerPlayerEventsTable.PlayerPosZ, 
                      dbo.PlayerPlayerEventsTable.PlayerYaw, dbo.PlayerPlayerEventsTable.PlayerPitch, dbo.PlayerPlayerEventsTable.PlayerRoll, 
                      PlayerMetadata_1.PlayerID AS TargetID, PlayerNames_1.PlayerName AS TargetName, dbo.PlayerPlayerEventsTable.TargetYaw, 
                      dbo.PlayerPlayerEventsTable.TargetPitch, dbo.PlayerPlayerEventsTable.TargetRoll
FROM         dbo.PlayerPlayerEventsTable INNER JOIN
                      dbo.PlayerMetadata ON dbo.PlayerPlayerEventsTable.PlayerID = dbo.PlayerMetadata.ID INNER JOIN
                      dbo.PlayerMetadata AS PlayerMetadata_1 ON dbo.PlayerPlayerEventsTable.TargetID = PlayerMetadata_1.ID INNER JOIN
                      dbo.PlayerNames ON dbo.PlayerMetadata.PlayerNameID = dbo.PlayerNames.ID INNER JOIN
                      dbo.PlayerNames AS PlayerNames_1 ON PlayerMetadata_1.PlayerNameID = PlayerNames_1.ID INNER JOIN
                      dbo.GameplayEventsMetadata ON dbo.PlayerPlayerEventsTable.EventID = dbo.GameplayEventsMetadata.EventID INNER JOIN
                      dbo.GameSessionInfoTable ON dbo.PlayerPlayerEventsTable.SessionID = dbo.GameSessionInfoTable.ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[30] 2[11] 3) )"
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
         Begin Table = "PlayerPlayerEventsTable"
            Begin Extent = 
               Top = 20
               Left = 27
               Bottom = 300
               Right = 261
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerMetadata"
            Begin Extent = 
               Top = 135
               Left = 331
               Bottom = 243
               Right = 482
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerMetadata_1"
            Begin Extent = 
               Top = 258
               Left = 331
               Bottom = 366
               Right = 482
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerNames"
            Begin Extent = 
               Top = 137
               Left = 520
               Bottom = 215
               Right = 671
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerNames_1"
            Begin Extent = 
               Top = 256
               Left = 526
               Bottom = 334
               Right = 677
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameplayEventsMetadata"
            Begin Extent = 
               Top = 44
               Left = 331
               Bottom = 122
               Right = 482
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameSessionInfoTable"
            Begin Extent = 
               Top = 11
               Left = 511
               Bottom = 119
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerPlayerEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'            Right = 678
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
      Begin ColumnWidths = 15
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1110
         Table = 2070
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerPlayerEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerPlayerEvents'
GO
/****** Object:  View [dbo].[QueryPlayerLoginEvents]    Script Date: 08/17/2010 08:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[QueryPlayerLoginEvents]
AS
SELECT     dbo.GameSessionInfoTable.SessionID, dbo.PlayerMetadata.PlayerID, dbo.PlayerNames.PlayerName, dbo.PlayerLoginEventsTable.EventTime, 
                      dbo.GameplayEventsMetadata.EventID, dbo.GameplayEventsMetadata.EventName, dbo.PlayerLoginEventsTable.PlayerRoll, 
                      dbo.PlayerLoginEventsTable.PlayerPitch, dbo.PlayerLoginEventsTable.PlayerYaw, dbo.PlayerLoginEventsTable.PlayerPosZ, 
                      dbo.PlayerLoginEventsTable.PlayerPosY, dbo.PlayerLoginEventsTable.PlayerPosX
FROM         dbo.PlayerLoginEventsTable INNER JOIN
                      dbo.PlayerMetadata ON dbo.PlayerLoginEventsTable.PlayerID = dbo.PlayerMetadata.ID INNER JOIN
                      dbo.PlayerNames ON dbo.PlayerMetadata.PlayerNameID = dbo.PlayerNames.ID INNER JOIN
                      dbo.GameplayEventsMetadata ON dbo.PlayerLoginEventsTable.EventID = dbo.GameplayEventsMetadata.EventID INNER JOIN
                      dbo.GameSessionInfoTable ON dbo.PlayerLoginEventsTable.SessionID = dbo.GameSessionInfoTable.ID AND 
                      dbo.PlayerMetadata.SessionID = dbo.GameSessionInfoTable.ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[26] 2[14] 3) )"
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
         Begin Table = "PlayerLoginEventsTable"
            Begin Extent = 
               Top = 83
               Left = 6
               Bottom = 340
               Right = 157
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerMetadata"
            Begin Extent = 
               Top = 244
               Left = 188
               Bottom = 352
               Right = 339
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerNames"
            Begin Extent = 
               Top = 277
               Left = 431
               Bottom = 355
               Right = 582
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameplayEventsMetadata"
            Begin Extent = 
               Top = 31
               Left = 211
               Bottom = 109
               Right = 362
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameSessionInfoTable"
            Begin Extent = 
               Top = 114
               Left = 404
               Bottom = 222
               Right = 571
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
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerLoginEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' CriteriaPane = 
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerLoginEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerLoginEvents'
GO
/****** Object:  View [dbo].[QueryPlayerKillDeathEvents]    Script Date: 08/17/2010 08:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[QueryPlayerKillDeathEvents]
AS
SELECT     dbo.GameSessionInfoTable.SessionID, dbo.GameplayEventsMetadata.EventName, dbo.PlayerKillDeathEventsTable.EventID, 
                      dbo.PlayerKillDeathEventsTable.EventTime, dbo.PlayerMetadata.PlayerID, dbo.PlayerNames.PlayerName, dbo.PlayerKillDeathEventsTable.PlayerPosX, 
                      dbo.PlayerKillDeathEventsTable.PlayerPosY, dbo.PlayerKillDeathEventsTable.PlayerPosZ, dbo.PlayerKillDeathEventsTable.PlayerYaw, 
                      dbo.PlayerKillDeathEventsTable.PlayerPitch, dbo.PlayerKillDeathEventsTable.PlayerRoll, PlayerMetadata_1.PlayerID AS TargetID, 
                      PlayerNames_1.PlayerName AS TargetName, dbo.PlayerKillDeathEventsTable.TargetPosX, dbo.PlayerKillDeathEventsTable.TargetPosY, 
                      dbo.PlayerKillDeathEventsTable.TargetPosZ, dbo.PlayerKillDeathEventsTable.TargetYaw, dbo.PlayerKillDeathEventsTable.TargetPitch, 
                      dbo.PlayerKillDeathEventsTable.TargetRoll, dbo.DamageMetadata.FriendlyName AS DamageName
FROM         dbo.PlayerKillDeathEventsTable INNER JOIN
                      dbo.PlayerMetadata ON dbo.PlayerKillDeathEventsTable.PlayerID = dbo.PlayerMetadata.ID INNER JOIN
                      dbo.PlayerMetadata AS PlayerMetadata_1 ON dbo.PlayerKillDeathEventsTable.TargetID = PlayerMetadata_1.ID INNER JOIN
                      dbo.PlayerNames ON dbo.PlayerMetadata.PlayerNameID = dbo.PlayerNames.ID INNER JOIN
                      dbo.PlayerNames AS PlayerNames_1 ON PlayerMetadata_1.PlayerNameID = PlayerNames_1.ID INNER JOIN
                      dbo.GameplayEventsMetadata ON dbo.PlayerKillDeathEventsTable.EventID = dbo.GameplayEventsMetadata.EventID INNER JOIN
                      dbo.GameSessionInfoTable ON dbo.PlayerKillDeathEventsTable.SessionID = dbo.GameSessionInfoTable.ID INNER JOIN
                      dbo.DamageMetadata ON dbo.PlayerKillDeathEventsTable.DamageID = dbo.DamageMetadata.ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[31] 2[9] 3) )"
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
         Begin Table = "PlayerKillDeathEventsTable"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 379
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerMetadata"
            Begin Extent = 
               Top = 116
               Left = 491
               Bottom = 224
               Right = 642
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerMetadata_1"
            Begin Extent = 
               Top = 248
               Left = 326
               Bottom = 356
               Right = 477
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerNames"
            Begin Extent = 
               Top = 7
               Left = 726
               Bottom = 85
               Right = 877
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerNames_1"
            Begin Extent = 
               Top = 249
               Left = 532
               Bottom = 327
               Right = 683
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameplayEventsMetadata"
            Begin Extent = 
               Top = 129
               Left = 288
               Bottom = 207
               Right = 439
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameSessionInfoTable"
            Begin Extent = 
               Top = 14
               Left = 279
               Bottom = 122
    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerKillDeathEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'           Right = 446
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DamageMetadata"
            Begin Extent = 
               Top = 276
               Left = 752
               Bottom = 369
               Right = 903
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
      Begin ColumnWidths = 20
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1230
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1530
         Table = 2250
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerKillDeathEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerKillDeathEvents'
GO
/****** Object:  View [dbo].[QueryPlayerIntEvents]    Script Date: 08/17/2010 08:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[QueryPlayerIntEvents]
AS
SELECT     dbo.GameSessionInfoTable.SessionID, dbo.PlayerIntEventsTable.EventTime, dbo.PlayerIntEventsTable.EventID, dbo.GameplayEventsMetadata.EventName, dbo.PlayerMetadata.PlayerID, 
                      dbo.PlayerNames.PlayerName, dbo.PlayerIntEventsTable.IntValue, dbo.PlayerIntEventsTable.PlayerRoll, dbo.PlayerIntEventsTable.PlayerPitch, 
                      dbo.PlayerIntEventsTable.PlayerYaw, dbo.PlayerIntEventsTable.PlayerPosZ, dbo.PlayerIntEventsTable.PlayerPosY, dbo.PlayerIntEventsTable.PlayerPosX
FROM         dbo.PlayerIntEventsTable INNER JOIN
                      dbo.PlayerMetadata ON dbo.PlayerIntEventsTable.PlayerID = dbo.PlayerMetadata.ID INNER JOIN
                      dbo.PlayerNames ON dbo.PlayerMetadata.PlayerNameID = dbo.PlayerNames.ID INNER JOIN
                      dbo.GameplayEventsMetadata ON dbo.PlayerIntEventsTable.EventID = dbo.GameplayEventsMetadata.EventID INNER JOIN
                      dbo.GameSessionInfoTable ON dbo.PlayerIntEventsTable.SessionID = dbo.GameSessionInfoTable.ID AND 
                      dbo.PlayerMetadata.SessionID = dbo.GameSessionInfoTable.ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[14] 3) )"
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
         Begin Table = "PlayerIntEventsTable"
            Begin Extent = 
               Top = 29
               Left = 33
               Bottom = 260
               Right = 184
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerMetadata"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 150
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerNames"
            Begin Extent = 
               Top = 6
               Left = 416
               Bottom = 123
               Right = 567
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameplayEventsMetadata"
            Begin Extent = 
               Top = 168
               Left = 221
               Bottom = 246
               Right = 372
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameSessionInfoTable"
            Begin Extent = 
               Top = 6
               Left = 605
               Bottom = 114
               Right = 772
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
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerIntEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerIntEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerIntEvents'
GO
/****** Object:  View [dbo].[QueryPlayerFloatEvents]    Script Date: 08/17/2010 08:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[QueryPlayerFloatEvents]
AS
SELECT     dbo.GameSessionInfoTable.SessionID, dbo.PlayerFloatEventsTable.EventTime, dbo.PlayerFloatEventsTable.EventID, dbo.GameplayEventsMetadata.EventName, 
					  dbo.PlayerMetadata.PlayerID, dbo.PlayerNames.PlayerName,  
                      dbo.PlayerFloatEventsTable.FloatValue, dbo.PlayerFloatEventsTable.PlayerRoll, dbo.PlayerFloatEventsTable.PlayerPitch, 
                      dbo.PlayerFloatEventsTable.PlayerYaw, dbo.PlayerFloatEventsTable.PlayerPosZ, dbo.PlayerFloatEventsTable.PlayerPosY, 
                      dbo.PlayerFloatEventsTable.PlayerPosX
FROM         dbo.PlayerFloatEventsTable INNER JOIN
                      dbo.PlayerMetadata ON dbo.PlayerFloatEventsTable.PlayerID = dbo.PlayerMetadata.ID INNER JOIN
                      dbo.PlayerNames ON dbo.PlayerMetadata.PlayerNameID = dbo.PlayerNames.ID INNER JOIN
                      dbo.GameplayEventsMetadata ON dbo.PlayerFloatEventsTable.EventID = dbo.GameplayEventsMetadata.EventID INNER JOIN
                      dbo.GameSessionInfoTable ON dbo.PlayerFloatEventsTable.SessionID = dbo.GameSessionInfoTable.ID AND 
                      dbo.PlayerMetadata.SessionID = dbo.GameSessionInfoTable.ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[31] 2[10] 3) )"
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
         Begin Table = "PlayerFloatEventsTable"
            Begin Extent = 
               Top = 5
               Left = 19
               Bottom = 263
               Right = 170
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerMetadata"
            Begin Extent = 
               Top = 112
               Left = 204
               Bottom = 257
               Right = 355
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerNames"
            Begin Extent = 
               Top = 193
               Left = 383
               Bottom = 303
               Right = 534
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameplayEventsMetadata"
            Begin Extent = 
               Top = 7
               Left = 229
               Bottom = 101
               Right = 387
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GameSessionInfoTable"
            Begin Extent = 
               Top = 19
               Left = 468
               Bottom = 173
               Right = 635
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
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerFloatEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'End
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerFloatEvents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryPlayerFloatEvents'
GO
/****** Object:  View [dbo].[QueryAllEventCounts]    Script Date: 08/17/2010 08:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[QueryAllEventCounts]
AS
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.DamageIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.DamageIntEventsTable .EventID
GROUP BY dbo.GameplayEventsMetadata.EventName
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.GameIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.GameIntEventsTable.EventID
GROUP BY dbo.GameplayEventsMetadata.EventName
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.GameStringEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.GameStringEventsTable.EventID
GROUP BY dbo.GameplayEventsMetadata.EventName
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerFloatEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerFloatEventsTable.EventID
GROUP BY dbo.GameplayEventsMetadata.EventName
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerIntEventsTable.EventID
GROUP BY dbo.GameplayEventsMetadata.EventName
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerKillDeathEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerKillDeathEventsTable.EventID
GROUP BY dbo.GameplayEventsMetadata.EventName
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerLoginEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerLoginEventsTable.EventID
GROUP BY dbo.GameplayEventsMetadata.EventName
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerPlayerEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerPlayerEventsTable.EventID
GROUP BY dbo.GameplayEventsMetadata.EventName
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerSpawnEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerSpawnEventsTable.EventID
GROUP BY dbo.GameplayEventsMetadata.EventName
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.PlayerStringEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.PlayerStringEventsTable.EventID
GROUP BY dbo.GameplayEventsMetadata.EventName
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.ProjectileIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.ProjectileIntEventsTable.EventID
GROUP BY dbo.GameplayEventsMetadata.EventName
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.TeamIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.TeamIntEventsTable.EventID
GROUP BY dbo.GameplayEventsMetadata.EventName
UNION
SELECT DISTINCT dbo.GameplayEventsMetadata.EventName AS Event, COUNT(*) AS Count
FROM         dbo.GameplayEventsMetadata INNER JOIN
                      dbo.WeaponIntEventsTable ON dbo.GameplayEventsMetadata.EventID = dbo.WeaponIntEventsTable.EventID
GROUP BY dbo.GameplayEventsMetadata.EventName
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[15] 4[21] 2[46] 3) )"
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
         Begin Table = "GameplayEventsMetadata"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 263
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlayerIntEventsTable"
            Begin Extent = 
               Top = 1
               Left = 315
               Bottom = 164
               Right = 482
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeaponIntEventsTable"
            Begin Extent = 
               Top = 179
               Left = 326
               Bottom = 287
               Right = 493
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 2895
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1665
         Alias = 900
         Table = 2535
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryAllEventCounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'QueryAllEventCounts'
GO
/****** Object:  StoredProcedure [dbo].[GetAllTeamMetadataForSession]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllTeamMetadataForSession]
	@SessionID varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM dbo.QueryAllTeamMetadataForSession
	WHERE SessionID = @SessionID

END
GO
/****** Object:  StoredProcedure [dbo].[GetAllProjectileIntEvents]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllProjectileIntEvents]
@SessionID varchar(50),
@PlayerID tinyint
AS


SELECT * FROM dbo.QueryProjectileIntEvents
WHERE SessionID = @SessionID AND PlayerID = @PlayerID
GO
/****** Object:  StoredProcedure [dbo].[GetAllPlayerStringEvents]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllPlayerStringEvents]
@SessionID varchar(50),
@PlayerID tinyint
AS


SELECT * FROM dbo.QueryPlayerStringEvents
WHERE SessionID = @SessionID AND PlayerID = @PlayerID
GO
/****** Object:  StoredProcedure [dbo].[GetAllPlayerSpawnEvents]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllPlayerSpawnEvents]
@SessionID varchar(50),
@PlayerID tinyint
AS


SELECT * FROM dbo.QueryPlayerSpawnEvents
WHERE SessionID = @SessionID AND PlayerID = @PlayerID
GO
/****** Object:  StoredProcedure [dbo].[GetAllPlayerPlayerEvents]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllPlayerPlayerEvents]
@SessionID varchar(50),
@PlayerID tinyint
AS


SELECT * FROM dbo.QueryPlayerPlayerEvents
WHERE SessionID = @SessionID AND PlayerID = @PlayerID
GO
/****** Object:  StoredProcedure [dbo].[GetAllWeaponIntEvents]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllWeaponIntEvents]
@SessionID varchar(50),
@PlayerID tinyint
AS


SELECT * FROM dbo.QueryWeaponIntEvents
WHERE SessionID = @SessionID AND PlayerID = @PlayerID
GO
/****** Object:  StoredProcedure [dbo].[GetAllPlayerLoginEvents]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllPlayerLoginEvents]
@SessionID varchar(50),
@PlayerID tinyint
AS


SELECT * FROM dbo.QueryPlayerLoginEvents
WHERE SessionID = @SessionID AND PlayerID = @PlayerID
GO
/****** Object:  StoredProcedure [dbo].[GetAllPlayerKillDeathEvents]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllPlayerKillDeathEvents]
@SessionID varchar(50),
@PlayerID tinyint
AS


SELECT * FROM dbo.QueryPlayerKillDeathEvents
WHERE SessionID = @SessionID AND PlayerID = @PlayerID
GO
/****** Object:  StoredProcedure [dbo].[GetAllPlayerIntEvents]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllPlayerIntEvents]
@SessionID varchar(50),
@PlayerID tinyint
AS

IF @PlayerID IS NULL
	BEGIN
		SELECT * FROM dbo.QueryPlayerIntEvents
		WHERE SessionID = @SessionID
	END
ELSE
	BEGIN
		SELECT * FROM dbo.QueryPlayerIntEvents
		WHERE SessionID = @SessionID AND PlayerID = @PlayerID
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllPlayerFloatEvents]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllPlayerFloatEvents]
@SessionID varchar(50),
@PlayerID tinyint
AS


SELECT * FROM dbo.QueryPlayerFloatEvents
WHERE SessionID = @SessionID AND PlayerID = @PlayerID
GO
/****** Object:  StoredProcedure [dbo].[GetAllEventCountsForSession]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllEventCountsForSession]
@SessionID varchar(50)
AS


SELECT DISTINCT Event, ID, SUM(Count) AS Count FROM dbo.QueryEventCountsBySession
WHERE SessionID = @SessionID
GROUP BY Event, ID
GO
/****** Object:  StoredProcedure [dbo].[GetAllDamageIntEvents]    Script Date: 08/17/2010 08:46:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllDamageIntEvents]
@SessionID varchar(50),
@PlayerID tinyint
AS


SELECT * FROM dbo.QueryDamageIntEvents
WHERE SessionID = @SessionID AND PlayerID = @PlayerID
GO
/****** Object:  ForeignKey [FK_DamageIntEventsTable_DamageMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[DamageIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_DamageIntEventsTable_DamageMetadata] FOREIGN KEY([DamageID])
REFERENCES [dbo].[DamageMetadata] ([ID])
GO
ALTER TABLE [dbo].[DamageIntEventsTable] CHECK CONSTRAINT [FK_DamageIntEventsTable_DamageMetadata]
GO
/****** Object:  ForeignKey [FK_DamageIntEventsTable_GameplayEventsMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[DamageIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_DamageIntEventsTable_GameplayEventsMetadata] FOREIGN KEY([EventID])
REFERENCES [dbo].[GameplayEventsMetadata] ([EventID])
GO
ALTER TABLE [dbo].[DamageIntEventsTable] CHECK CONSTRAINT [FK_DamageIntEventsTable_GameplayEventsMetadata]
GO
/****** Object:  ForeignKey [FK_DamageIntEventsTable_GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[DamageIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_DamageIntEventsTable_GameSessionInfoTable] FOREIGN KEY([SessionID])
REFERENCES [dbo].[GameSessionInfoTable] ([ID])
GO
ALTER TABLE [dbo].[DamageIntEventsTable] CHECK CONSTRAINT [FK_DamageIntEventsTable_GameSessionInfoTable]
GO
/****** Object:  ForeignKey [FK_DamageIntEventsTable_PlayerMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[DamageIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_DamageIntEventsTable_PlayerMetadata] FOREIGN KEY([TargetID])
REFERENCES [dbo].[PlayerMetadata] ([ID])
GO
ALTER TABLE [dbo].[DamageIntEventsTable] CHECK CONSTRAINT [FK_DamageIntEventsTable_PlayerMetadata]
GO
/****** Object:  ForeignKey [FK_DamageIntEventsTable_PlayerMetadata1]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[DamageIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_DamageIntEventsTable_PlayerMetadata1] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerMetadata] ([ID])
GO
ALTER TABLE [dbo].[DamageIntEventsTable] CHECK CONSTRAINT [FK_DamageIntEventsTable_PlayerMetadata1]
GO
/****** Object:  ForeignKey [FK_GameIntEventsTable_GameplayEventsMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[GameIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_GameIntEventsTable_GameplayEventsMetadata] FOREIGN KEY([EventID])
REFERENCES [dbo].[GameplayEventsMetadata] ([EventID])
GO
ALTER TABLE [dbo].[GameIntEventsTable] CHECK CONSTRAINT [FK_GameIntEventsTable_GameplayEventsMetadata]
GO
/****** Object:  ForeignKey [FK_GameIntEventsTable_GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[GameIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_GameIntEventsTable_GameSessionInfoTable] FOREIGN KEY([SessionID])
REFERENCES [dbo].[GameSessionInfoTable] ([ID])
GO
ALTER TABLE [dbo].[GameIntEventsTable] CHECK CONSTRAINT [FK_GameIntEventsTable_GameSessionInfoTable]
GO
/****** Object:  ForeignKey [FK_GameSessionInfoTable_GameTypes]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[GameSessionInfoTable]  WITH CHECK ADD  CONSTRAINT [FK_GameSessionInfoTable_GameTypes] FOREIGN KEY([GameType])
REFERENCES [dbo].[GameTypes] ([ID])
GO
ALTER TABLE [dbo].[GameSessionInfoTable] CHECK CONSTRAINT [FK_GameSessionInfoTable_GameTypes]
GO
/****** Object:  ForeignKey [FK_GameSessionInfoTable_Languages]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[GameSessionInfoTable]  WITH CHECK ADD  CONSTRAINT [FK_GameSessionInfoTable_Languages] FOREIGN KEY([Language])
REFERENCES [dbo].[Languages] ([ID])
GO
ALTER TABLE [dbo].[GameSessionInfoTable] CHECK CONSTRAINT [FK_GameSessionInfoTable_Languages]
GO
/****** Object:  ForeignKey [FK_GameSessionInfoTable_Maps]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[GameSessionInfoTable]  WITH CHECK ADD  CONSTRAINT [FK_GameSessionInfoTable_Maps] FOREIGN KEY([MapName])
REFERENCES [dbo].[Maps] ([ID])
GO
ALTER TABLE [dbo].[GameSessionInfoTable] CHECK CONSTRAINT [FK_GameSessionInfoTable_Maps]
GO
/****** Object:  ForeignKey [FK_GameSessionInfoTable_Platforms]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[GameSessionInfoTable]  WITH CHECK ADD  CONSTRAINT [FK_GameSessionInfoTable_Platforms] FOREIGN KEY([PlatformType])
REFERENCES [dbo].[Platforms] ([ID])
GO
ALTER TABLE [dbo].[GameSessionInfoTable] CHECK CONSTRAINT [FK_GameSessionInfoTable_Platforms]
GO
/****** Object:  ForeignKey [FK_GameStringEventsTable_GameplayEventsMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[GameStringEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_GameStringEventsTable_GameplayEventsMetadata] FOREIGN KEY([EventID])
REFERENCES [dbo].[GameplayEventsMetadata] ([EventID])
GO
ALTER TABLE [dbo].[GameStringEventsTable] CHECK CONSTRAINT [FK_GameStringEventsTable_GameplayEventsMetadata]
GO
/****** Object:  ForeignKey [FK_GameStringEventsTable_GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[GameStringEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_GameStringEventsTable_GameSessionInfoTable] FOREIGN KEY([SessionID])
REFERENCES [dbo].[GameSessionInfoTable] ([ID])
GO
ALTER TABLE [dbo].[GameStringEventsTable] CHECK CONSTRAINT [FK_GameStringEventsTable_GameSessionInfoTable]
GO
/****** Object:  ForeignKey [FK_PlayerFloatEventsTable_GameplayEventsMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerFloatEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerFloatEventsTable_GameplayEventsMetadata] FOREIGN KEY([EventID])
REFERENCES [dbo].[GameplayEventsMetadata] ([EventID])
GO
ALTER TABLE [dbo].[PlayerFloatEventsTable] CHECK CONSTRAINT [FK_PlayerFloatEventsTable_GameplayEventsMetadata]
GO
/****** Object:  ForeignKey [FK_PlayerFloatEventsTable_GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerFloatEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerFloatEventsTable_GameSessionInfoTable] FOREIGN KEY([SessionID])
REFERENCES [dbo].[GameSessionInfoTable] ([ID])
GO
ALTER TABLE [dbo].[PlayerFloatEventsTable] CHECK CONSTRAINT [FK_PlayerFloatEventsTable_GameSessionInfoTable]
GO
/****** Object:  ForeignKey [FK_PlayerFloatEventsTable_PlayerMetadata1]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerFloatEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerFloatEventsTable_PlayerMetadata1] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerMetadata] ([ID])
GO
ALTER TABLE [dbo].[PlayerFloatEventsTable] CHECK CONSTRAINT [FK_PlayerFloatEventsTable_PlayerMetadata1]
GO
/****** Object:  ForeignKey [FK_PlayerEventsTable_GameplayEventsMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerEventsTable_GameplayEventsMetadata] FOREIGN KEY([EventID])
REFERENCES [dbo].[GameplayEventsMetadata] ([EventID])
GO
ALTER TABLE [dbo].[PlayerIntEventsTable] CHECK CONSTRAINT [FK_PlayerEventsTable_GameplayEventsMetadata]
GO
/****** Object:  ForeignKey [FK_PlayerEventsTable_GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerEventsTable_GameSessionInfoTable] FOREIGN KEY([SessionID])
REFERENCES [dbo].[GameSessionInfoTable] ([ID])
GO
ALTER TABLE [dbo].[PlayerIntEventsTable] CHECK CONSTRAINT [FK_PlayerEventsTable_GameSessionInfoTable]
GO
/****** Object:  ForeignKey [FK_PlayerEventsTable_PlayerMetadata1]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerEventsTable_PlayerMetadata1] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerMetadata] ([ID])
GO
ALTER TABLE [dbo].[PlayerIntEventsTable] CHECK CONSTRAINT [FK_PlayerEventsTable_PlayerMetadata1]
GO
/****** Object:  ForeignKey [FK_PlayerKillDeathEventsTable_DamageMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerKillDeathEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerKillDeathEventsTable_DamageMetadata] FOREIGN KEY([DamageID])
REFERENCES [dbo].[DamageMetadata] ([ID])
GO
ALTER TABLE [dbo].[PlayerKillDeathEventsTable] CHECK CONSTRAINT [FK_PlayerKillDeathEventsTable_DamageMetadata]
GO
/****** Object:  ForeignKey [FK_PlayerKillDeathEventsTable_GameplayEventsMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerKillDeathEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerKillDeathEventsTable_GameplayEventsMetadata] FOREIGN KEY([EventID])
REFERENCES [dbo].[GameplayEventsMetadata] ([EventID])
GO
ALTER TABLE [dbo].[PlayerKillDeathEventsTable] CHECK CONSTRAINT [FK_PlayerKillDeathEventsTable_GameplayEventsMetadata]
GO
/****** Object:  ForeignKey [FK_PlayerKillDeathEventsTable_GameplayEventsMetadata1]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerKillDeathEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerKillDeathEventsTable_GameplayEventsMetadata1] FOREIGN KEY([KillType])
REFERENCES [dbo].[GameplayEventsMetadata] ([EventID])
GO
ALTER TABLE [dbo].[PlayerKillDeathEventsTable] CHECK CONSTRAINT [FK_PlayerKillDeathEventsTable_GameplayEventsMetadata1]
GO
/****** Object:  ForeignKey [FK_PlayerKillDeathEventsTable_GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerKillDeathEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerKillDeathEventsTable_GameSessionInfoTable] FOREIGN KEY([SessionID])
REFERENCES [dbo].[GameSessionInfoTable] ([ID])
GO
ALTER TABLE [dbo].[PlayerKillDeathEventsTable] CHECK CONSTRAINT [FK_PlayerKillDeathEventsTable_GameSessionInfoTable]
GO
/****** Object:  ForeignKey [FK_PlayerKillDeathEventsTable_PlayerMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerKillDeathEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerKillDeathEventsTable_PlayerMetadata] FOREIGN KEY([TargetID])
REFERENCES [dbo].[PlayerMetadata] ([ID])
GO
ALTER TABLE [dbo].[PlayerKillDeathEventsTable] CHECK CONSTRAINT [FK_PlayerKillDeathEventsTable_PlayerMetadata]
GO
/****** Object:  ForeignKey [FK_PlayerKillDeathEventsTable_PlayerMetadata1]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerKillDeathEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerKillDeathEventsTable_PlayerMetadata1] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerMetadata] ([ID])
GO
ALTER TABLE [dbo].[PlayerKillDeathEventsTable] CHECK CONSTRAINT [FK_PlayerKillDeathEventsTable_PlayerMetadata1]
GO
/****** Object:  ForeignKey [FK_PlayerLoginEventsTable_GameplayEventsMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerLoginEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerLoginEventsTable_GameplayEventsMetadata] FOREIGN KEY([EventID])
REFERENCES [dbo].[GameplayEventsMetadata] ([EventID])
GO
ALTER TABLE [dbo].[PlayerLoginEventsTable] CHECK CONSTRAINT [FK_PlayerLoginEventsTable_GameplayEventsMetadata]
GO
/****** Object:  ForeignKey [FK_PlayerLoginEventsTable_GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerLoginEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerLoginEventsTable_GameSessionInfoTable] FOREIGN KEY([SessionID])
REFERENCES [dbo].[GameSessionInfoTable] ([ID])
GO
ALTER TABLE [dbo].[PlayerLoginEventsTable] CHECK CONSTRAINT [FK_PlayerLoginEventsTable_GameSessionInfoTable]
GO
/****** Object:  ForeignKey [FK_PlayerLoginEventsTable_PlayerMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerLoginEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerLoginEventsTable_PlayerMetadata] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerMetadata] ([ID])
GO
ALTER TABLE [dbo].[PlayerLoginEventsTable] CHECK CONSTRAINT [FK_PlayerLoginEventsTable_PlayerMetadata]
GO
/****** Object:  ForeignKey [FK_PlayerMetadata_GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerMetadata]  WITH CHECK ADD  CONSTRAINT [FK_PlayerMetadata_GameSessionInfoTable] FOREIGN KEY([SessionID])
REFERENCES [dbo].[GameSessionInfoTable] ([ID])
GO
ALTER TABLE [dbo].[PlayerMetadata] CHECK CONSTRAINT [FK_PlayerMetadata_GameSessionInfoTable]
GO
/****** Object:  ForeignKey [FK_PlayerMetadata_PlayerNames]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerMetadata]  WITH CHECK ADD  CONSTRAINT [FK_PlayerMetadata_PlayerNames] FOREIGN KEY([PlayerNameID])
REFERENCES [dbo].[PlayerNames] ([ID])
GO
ALTER TABLE [dbo].[PlayerMetadata] CHECK CONSTRAINT [FK_PlayerMetadata_PlayerNames]
GO
/****** Object:  ForeignKey [FK_PlayerPlayerEventsTable_PlayerMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerPlayerEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerPlayerEventsTable_PlayerMetadata] FOREIGN KEY([TargetID])
REFERENCES [dbo].[PlayerMetadata] ([ID])
GO
ALTER TABLE [dbo].[PlayerPlayerEventsTable] CHECK CONSTRAINT [FK_PlayerPlayerEventsTable_PlayerMetadata]
GO
/****** Object:  ForeignKey [FK_PlayerPlayerPlayerEventsTable_GameplayEventsMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerPlayerEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerPlayerPlayerEventsTable_GameplayEventsMetadata] FOREIGN KEY([EventID])
REFERENCES [dbo].[GameplayEventsMetadata] ([EventID])
GO
ALTER TABLE [dbo].[PlayerPlayerEventsTable] CHECK CONSTRAINT [FK_PlayerPlayerPlayerEventsTable_GameplayEventsMetadata]
GO
/****** Object:  ForeignKey [FK_PlayerPlayerPlayerEventsTable_GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerPlayerEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerPlayerPlayerEventsTable_GameSessionInfoTable] FOREIGN KEY([SessionID])
REFERENCES [dbo].[GameSessionInfoTable] ([ID])
GO
ALTER TABLE [dbo].[PlayerPlayerEventsTable] CHECK CONSTRAINT [FK_PlayerPlayerPlayerEventsTable_GameSessionInfoTable]
GO
/****** Object:  ForeignKey [FK_PlayerPlayerPlayerEventsTable_PlayerMetadata1]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerPlayerEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerPlayerPlayerEventsTable_PlayerMetadata1] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerMetadata] ([ID])
GO
ALTER TABLE [dbo].[PlayerPlayerEventsTable] CHECK CONSTRAINT [FK_PlayerPlayerPlayerEventsTable_PlayerMetadata1]
GO
/****** Object:  ForeignKey [FK_PlayerSpawnEventsTable_GameplayEventsMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerSpawnEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerSpawnEventsTable_GameplayEventsMetadata] FOREIGN KEY([EventID])
REFERENCES [dbo].[GameplayEventsMetadata] ([EventID])
GO
ALTER TABLE [dbo].[PlayerSpawnEventsTable] CHECK CONSTRAINT [FK_PlayerSpawnEventsTable_GameplayEventsMetadata]
GO
/****** Object:  ForeignKey [FK_PlayerSpawnEventsTable_GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerSpawnEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerSpawnEventsTable_GameSessionInfoTable] FOREIGN KEY([SessionID])
REFERENCES [dbo].[GameSessionInfoTable] ([ID])
GO
ALTER TABLE [dbo].[PlayerSpawnEventsTable] CHECK CONSTRAINT [FK_PlayerSpawnEventsTable_GameSessionInfoTable]
GO
/****** Object:  ForeignKey [FK_PlayerSpawnEventsTable_PawnMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerSpawnEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerSpawnEventsTable_PawnMetadata] FOREIGN KEY([PawnID])
REFERENCES [dbo].[PawnMetadata] ([ID])
GO
ALTER TABLE [dbo].[PlayerSpawnEventsTable] CHECK CONSTRAINT [FK_PlayerSpawnEventsTable_PawnMetadata]
GO
/****** Object:  ForeignKey [FK_PlayerSpawnEventsTable_PlayerMetadata1]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerSpawnEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerSpawnEventsTable_PlayerMetadata1] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerMetadata] ([ID])
GO
ALTER TABLE [dbo].[PlayerSpawnEventsTable] CHECK CONSTRAINT [FK_PlayerSpawnEventsTable_PlayerMetadata1]
GO
/****** Object:  ForeignKey [FK_PlayerSpawnEventsTable_TeamMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerSpawnEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerSpawnEventsTable_TeamMetadata] FOREIGN KEY([TeamID])
REFERENCES [dbo].[TeamMetadata] ([ID])
GO
ALTER TABLE [dbo].[PlayerSpawnEventsTable] CHECK CONSTRAINT [FK_PlayerSpawnEventsTable_TeamMetadata]
GO
/****** Object:  ForeignKey [FK_PlayerStringEventsTable_GameplayEventsMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerStringEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerStringEventsTable_GameplayEventsMetadata] FOREIGN KEY([EventID])
REFERENCES [dbo].[GameplayEventsMetadata] ([EventID])
GO
ALTER TABLE [dbo].[PlayerStringEventsTable] CHECK CONSTRAINT [FK_PlayerStringEventsTable_GameplayEventsMetadata]
GO
/****** Object:  ForeignKey [FK_PlayerStringEventsTable_GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerStringEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerStringEventsTable_GameSessionInfoTable] FOREIGN KEY([SessionID])
REFERENCES [dbo].[GameSessionInfoTable] ([ID])
GO
ALTER TABLE [dbo].[PlayerStringEventsTable] CHECK CONSTRAINT [FK_PlayerStringEventsTable_GameSessionInfoTable]
GO
/****** Object:  ForeignKey [FK_PlayerStringEventsTable_PlayerMetadata1]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[PlayerStringEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_PlayerStringEventsTable_PlayerMetadata1] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerMetadata] ([ID])
GO
ALTER TABLE [dbo].[PlayerStringEventsTable] CHECK CONSTRAINT [FK_PlayerStringEventsTable_PlayerMetadata1]
GO
/****** Object:  ForeignKey [FK_ProjectileIntEventsTable_GameplayEventsMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[ProjectileIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_ProjectileIntEventsTable_GameplayEventsMetadata] FOREIGN KEY([EventID])
REFERENCES [dbo].[GameplayEventsMetadata] ([EventID])
GO
ALTER TABLE [dbo].[ProjectileIntEventsTable] CHECK CONSTRAINT [FK_ProjectileIntEventsTable_GameplayEventsMetadata]
GO
/****** Object:  ForeignKey [FK_ProjectileIntEventsTable_GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[ProjectileIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_ProjectileIntEventsTable_GameSessionInfoTable] FOREIGN KEY([SessionID])
REFERENCES [dbo].[GameSessionInfoTable] ([ID])
GO
ALTER TABLE [dbo].[ProjectileIntEventsTable] CHECK CONSTRAINT [FK_ProjectileIntEventsTable_GameSessionInfoTable]
GO
/****** Object:  ForeignKey [FK_ProjectileIntEventsTable_PlayerMetadata1]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[ProjectileIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_ProjectileIntEventsTable_PlayerMetadata1] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerMetadata] ([ID])
GO
ALTER TABLE [dbo].[ProjectileIntEventsTable] CHECK CONSTRAINT [FK_ProjectileIntEventsTable_PlayerMetadata1]
GO
/****** Object:  ForeignKey [FK_ProjectileIntEventsTable_ProjectileMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[ProjectileIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_ProjectileIntEventsTable_ProjectileMetadata] FOREIGN KEY([ProjectileID])
REFERENCES [dbo].[ProjectileMetadata] ([ID])
GO
ALTER TABLE [dbo].[ProjectileIntEventsTable] CHECK CONSTRAINT [FK_ProjectileIntEventsTable_ProjectileMetadata]
GO
/****** Object:  ForeignKey [FK_TeamEventsTable_GameplayEventsMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[TeamIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_TeamEventsTable_GameplayEventsMetadata] FOREIGN KEY([EventID])
REFERENCES [dbo].[GameplayEventsMetadata] ([EventID])
GO
ALTER TABLE [dbo].[TeamIntEventsTable] CHECK CONSTRAINT [FK_TeamEventsTable_GameplayEventsMetadata]
GO
/****** Object:  ForeignKey [FK_TeamEventsTable_GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[TeamIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_TeamEventsTable_GameSessionInfoTable] FOREIGN KEY([SessionID])
REFERENCES [dbo].[GameSessionInfoTable] ([ID])
GO
ALTER TABLE [dbo].[TeamIntEventsTable] CHECK CONSTRAINT [FK_TeamEventsTable_GameSessionInfoTable]
GO
/****** Object:  ForeignKey [FK_TeamEventsTable_TeamMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[TeamIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_TeamEventsTable_TeamMetadata] FOREIGN KEY([TeamID])
REFERENCES [dbo].[TeamMetadata] ([ID])
GO
ALTER TABLE [dbo].[TeamIntEventsTable] CHECK CONSTRAINT [FK_TeamEventsTable_TeamMetadata]
GO
/****** Object:  ForeignKey [FK_TeamMetadata_GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[TeamMetadata]  WITH CHECK ADD  CONSTRAINT [FK_TeamMetadata_GameSessionInfoTable] FOREIGN KEY([SessionID])
REFERENCES [dbo].[GameSessionInfoTable] ([ID])
GO
ALTER TABLE [dbo].[TeamMetadata] CHECK CONSTRAINT [FK_TeamMetadata_GameSessionInfoTable]
GO
/****** Object:  ForeignKey [FK_WeaponIntEventsTable_GameplayEventsMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[WeaponIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_WeaponIntEventsTable_GameplayEventsMetadata] FOREIGN KEY([EventID])
REFERENCES [dbo].[GameplayEventsMetadata] ([EventID])
GO
ALTER TABLE [dbo].[WeaponIntEventsTable] CHECK CONSTRAINT [FK_WeaponIntEventsTable_GameplayEventsMetadata]
GO
/****** Object:  ForeignKey [FK_WeaponIntEventsTable_GameSessionInfoTable]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[WeaponIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_WeaponIntEventsTable_GameSessionInfoTable] FOREIGN KEY([SessionID])
REFERENCES [dbo].[GameSessionInfoTable] ([ID])
GO
ALTER TABLE [dbo].[WeaponIntEventsTable] CHECK CONSTRAINT [FK_WeaponIntEventsTable_GameSessionInfoTable]
GO
/****** Object:  ForeignKey [FK_WeaponIntEventsTable_PlayerMetadata1]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[WeaponIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_WeaponIntEventsTable_PlayerMetadata1] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerMetadata] ([ID])
GO
ALTER TABLE [dbo].[WeaponIntEventsTable] CHECK CONSTRAINT [FK_WeaponIntEventsTable_PlayerMetadata1]
GO
/****** Object:  ForeignKey [FK_WeaponIntEventsTable_WeaponMetadata]    Script Date: 08/17/2010 08:46:43 ******/
ALTER TABLE [dbo].[WeaponIntEventsTable]  WITH CHECK ADD  CONSTRAINT [FK_WeaponIntEventsTable_WeaponMetadata] FOREIGN KEY([WeaponID])
REFERENCES [dbo].[WeaponMetadata] ([ID])
GO
ALTER TABLE [dbo].[WeaponIntEventsTable] CHECK CONSTRAINT [FK_WeaponIntEventsTable_WeaponMetadata]
GO
