USE [Builder]
GO
/****** Object:  UserDefinedDataType [dbo].[KeyID]    Script Date: 02/12/2013 17:57:27 ******/
CREATE TYPE [dbo].[KeyID] FROM [int] NOT NULL
GO
/****** Object:  Table [dbo].[CISTasks]    Script Date: 02/12/2013 17:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CISTasks](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](32) NOT NULL,
	[BranchConfigID] [int] NOT NULL,
	[Mask] [int] NOT NULL,
	[LastAttempted] [int] NOT NULL,
	[LastGood] [int] NOT NULL,
	[LastFail] [int] NOT NULL,
	[GameSpecific] [bit] NOT NULL,
	[PlatformSpecific] [bit] NOT NULL,
	[Remote] [bit] NOT NULL,
	[CompileAllowed] [bit] NOT NULL,
	[Folders] [varchar](max) NOT NULL,
	[DependentPlatforms] [varchar](max) NOT NULL,
	[AlternateFolders] [varchar](max) NOT NULL,
 CONSTRAINT [PK_CISTasks] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedDataType [dbo].[FixedString]    Script Date: 02/12/2013 17:57:27 ******/
CREATE TYPE [dbo].[FixedString] FROM [char](64) NOT NULL
GO
/****** Object:  Table [dbo].[BuildLog]    Script Date: 02/12/2013 17:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BuildLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Command] [varchar](32) NULL,
	[BranchConfigID] [smallint] NULL,
	[CommandID] [int] NULL,
	[JobID] [int] NULL,
	[Machine] [varchar](32) NULL,
	[ChangeList] [int] NULL,
	[BuildStarted] [datetime] NULL,
	[BuildEnded] [datetime] NULL,
	[CurrentStatus] [varchar](128) NULL,
	[BuildLabel] [varchar](128) NULL,
	[DetailedLogPath] [varchar](max) NULL,
 CONSTRAINT [PK_BuildLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID of the BranchConfig this log refers to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BuildLog', @level2type=N'COLUMN',@level2name=N'BranchConfigID'
GO
/****** Object:  Table [dbo].[Builders]    Script Date: 02/12/2013 17:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Builders](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Machine] [varchar](32) NOT NULL,
	[Version] [datetime] NOT NULL,
	[Deployed] [bit] NOT NULL,
	[State] [varchar](16) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[CurrentTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[CurrentStatus] [varchar](128) NULL,
	[DirectXSDKVersion] [varchar](32) NOT NULL,
	[AndroidSDKVersion] [varchar](32) NOT NULL,
	[iPhoneSDKVersion] [varchar](32) NOT NULL,
	[MacSDKVersion] [varchar](32) NOT NULL,
	[NGPSDKVersion] [varchar](32) NOT NULL,
	[PS3SDKVersion] [varchar](32) NOT NULL,
	[WiiUSDKVersion] [varchar](32) NOT NULL,
	[Xbox360SDKVersion] [varchar](32) NOT NULL,
	[FlashSDKVersion] [varchar](32) NOT NULL,
	[CPUString] [varchar](64) NOT NULL,
	[ProcessorCount] [int] NOT NULL,
	[Memory] [int] NOT NULL,
	[DriveCSize] [int] NOT NULL,
	[DriveCFree] [int] NOT NULL,
	[DriveDSize] [int] NOT NULL,
	[DriveDFree] [int] NOT NULL,
 CONSTRAINT [PK_Builders_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BranchConfig]    Script Date: 02/12/2013 17:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BranchConfig](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Version] [int] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Branch] [varchar](32) NOT NULL,
	[Server] [varchar](64) NOT NULL,
	[P4User] [varchar](64) NOT NULL,
	[P4Password] [varchar](32) NOT NULL,
	[P4ActualPassword] [varchar](32) NOT NULL,
	[P4SyncUser] [varchar](64) NOT NULL,
	[P4SyncPassword] [varchar](32) NOT NULL,
	[P4ActualSyncPassword] [varchar](32) NOT NULL,
	[P4ClientSpec] [varchar](32) NOT NULL,
	[BranchAdmin] [varchar](64) NOT NULL,
	[SDKRequirements] [varchar](max) NULL,
	[DirectXVersion] [varchar](32) NULL,
	[AndroidSDKVersion] [varchar](32) NULL,
	[iPhoneSDKVersion] [varchar](32) NULL,
	[MacSDKVersion] [varchar](32) NULL,
	[NGPSDKVersion] [varchar](32) NULL,
	[PS3SDKVersion] [varchar](32) NULL,
	[WiiUSDKVersion] [varchar](32) NULL,
	[Xbox360SDKVersion] [varchar](32) NULL,
	[FlashSDKVersion] [varchar](32) NULL,
	[PFXSubjectName] [varchar](64) NOT NULL,
	[IPhone_DeveloperSigningIdentity] [varchar](64) NOT NULL,
	[IPhone_DistributionSigningIdentity] [varchar](64) NOT NULL,
	[HeadChangelist] [int] NOT NULL,
	[LastFullyKnown] [int] NOT NULL,
	[LastGoodOverall] [int] NOT NULL,
	[LastFailOverall] [int] NOT NULL,
	[LastAttemptedOverall] [int] NOT NULL,
	[LockedDown] [bit] NOT NULL,
 CONSTRAINT [PK_BranchConfig] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Versioning]    Script Date: 02/12/2013 17:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Versioning](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](96) NOT NULL,
	[EngineVersion] [int] NOT NULL,
	[Changelist] [int] NOT NULL,
 CONSTRAINT [PK_Versioning] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedDataType [dbo].[String]    Script Date: 02/12/2013 17:57:27 ******/
CREATE TYPE [dbo].[String] FROM [nvarchar](4000) NOT NULL
GO
/****** Object:  StoredProcedure [dbo].[SP_SetBranchLockDown]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SetBranchLockDown]
(
	@ID int,
	@Lock int = 1
)

AS

IF (@Lock = 1)
	UPDATE BranchConfig
	SET
		LockedDown = 1
	WHERE
		ID = @ID
ELSE
	UPDATE BranchConfig
	SET
		LockedDown = 0
	WHERE
		ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[SP_GetMachineActivity]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetMachineActivity]
(
	@MachineNameFilter varchar(32),
    @StatusFilter varchar(128),
	@bIncludeCIS bit,
    @Days int
)
AS

SELECT
    DATEADD(d, DATEDIFF(d, 0, BuildStarted), 0) AS BuildStartedDate,
    COUNT(*) AS LogCount
FROM
	BuildLog (NOLOCK)
WHERE
	(Command <> 'CIS/ProcessP4Changes') AND
    (Machine LIKE @MachineNameFilter) AND
    (CurrentStatus LIKE @StatusFilter) AND
    (DATEDIFF(Day, BuildStarted, GETUTCDATE()) < @Days)
GROUP BY
	DATEADD(d, DATEDIFF(d, 0, BuildStarted), 0)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetInfrastructureState]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetInfrastructureState]
AS

SELECT
    b1.State,
    COUNT(b1.State) AS MachineCount
FROM
    Builders AS b1
INNER JOIN(
    SELECT
        Machine,
        MAX(StartTime) AS MaxStartTime
    FROM
        Builders AS Builders_1
    WHERE
        (Deployed = 'True') AND
        (DATEDIFF(Day, CurrentTime, GETUTCDATE()) <= 4)
    GROUP BY Machine) AS b2
ON
    b1.Machine = b2.Machine AND
    b1.StartTime = b2.MaxStartTime
GROUP BY
    b1.State
GO
/****** Object:  StoredProcedure [dbo].[StatVerifications]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StatVerifications]

AS

SELECT COUNT( BuildStarted ) AS CommandCount
FROM BuildLog
WHERE ( DATEDIFF( day, BuildStarted, GETDATE() ) < 8 )
AND ( SUBSTRING( Command, 1, 3 ) = 'CIS' )
AND Command <> 'CIS/ProcessP4Changes'

	RETURN
GO
/****** Object:  StoredProcedure [dbo].[StatPromotions]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StatPromotions]

AS
SELECT COUNT( BuildStarted ) AS CommandCount
FROM BuildLog
WHERE ( DATEDIFF( day, BuildStarted, GETDATE() ) < 8 )
AND ( SUBSTRING( Command, 1, 7 ) = 'Promote' )

	RETURN
GO
/****** Object:  StoredProcedure [dbo].[StatPCS]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StatPCS]

AS
SELECT COUNT( BuildStarted ) AS CommandCount
FROM BuildLog
WHERE ( DATEDIFF( day, BuildStarted, GETDATE() ) < 8 )
AND ( SUBSTRING( Command, 1, 3 ) = 'PCS' )
	RETURN
GO
/****** Object:  Table [dbo].[Variables]    Script Date: 02/12/2013 17:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Variables](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Variable] [varchar](64) NOT NULL,
	[BranchConfigID] [int] NOT NULL,
	[Value] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Variables] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[StatCompileJobs]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StatCompileJobs]

AS

SELECT COUNT( BuildStarted ) AS CommandCount
FROM BuildLog
WHERE ( DATEDIFF( day, BuildStarted, GETDATE() ) < 8 )
AND ( SUBSTRING( Command, 1, 11 ) = 'Jobs/Unreal' )

	RETURN
GO
/****** Object:  StoredProcedure [dbo].[StatCISJobs]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StatCISJobs]

AS

SELECT COUNT( BuildStarted ) AS CommandCount
FROM BuildLog
WHERE ( DATEDIFF( day, BuildStarted, GETDATE() ) < 8 )
AND ( SUBSTRING( Command, 1, 8 ) = 'Jobs/CIS' )

RETURN
GO
/****** Object:  StoredProcedure [dbo].[StatBuildCount]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StatBuildCount]

AS

SELECT COUNT( BuildStarted ) AS CommandCount
FROM BuildLog
WHERE ( DATEDIFF( day, BuildStarted, GETDATE() ) < 8 )
AND ( SUBSTRING( Command, 1, 13 ) <> 'CIS/ProcessP4' )

RETURN
GO
/****** Object:  Table [dbo].[Applications]    Script Date: 02/12/2013 17:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Applications](
	[ID] [dbo].[KeyID] IDENTITY(1,1) NOT NULL,
	[AppName] [dbo].[FixedString] NOT NULL,
	[Notes] [dbo].[String] NULL,
 CONSTRAINT [PK_Application] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [Unique_Application] UNIQUE NONCLUSTERED 
(
	[AppName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Commands]    Script Date: 02/12/2013 17:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Commands](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Command] [varchar](64) NOT NULL,
	[Type] [tinyint] NOT NULL,
	[Description] [varchar](64) NOT NULL,
	[BranchConfigID] [int] NOT NULL,
	[Platform] [varchar](32) NOT NULL,
	[Game] [varchar](64) NOT NULL,
	[Config] [varchar](32) NOT NULL,
	[Language] [varchar](32) NOT NULL,
	[Parameter] [varchar](64) NOT NULL,
	[Remote] [bit] NOT NULL,
	[IsPromotable] [bit] NOT NULL,
	[MachineLock] [varchar](32) NOT NULL,
	[NextTriggerDelay] [int] NULL,
	[NextTrigger] [datetime] NULL,
	[PrimaryBuild] [bit] NOT NULL,
	[LastAttemptedChangeList] [int] NOT NULL,
	[LastAttemptedDateTime] [datetime] NOT NULL,
	[LastFailedChangeList] [int] NOT NULL,
	[LastFailedDateTime] [datetime] NOT NULL,
	[LastGoodChangeList] [int] NOT NULL,
	[LastGoodLabel] [varchar](96) NULL,
	[LastGoodDateTime] [datetime] NOT NULL,
	[LatestApprovedLabel] [varchar](96) NULL,
	[Operator] [varchar](32) NOT NULL,
	[Killer] [varchar](32) NOT NULL,
	[Pending] [bit] NOT NULL,
	[Killing] [bit] NOT NULL,
	[Machine] [varchar](32) NOT NULL,
	[BuildLogID] [int] NULL,
	[ConchHolder] [datetime] NULL,
	[UserLevel] [smallint] NOT NULL,
	[Access] [int] NOT NULL,
	[Display] [int] NOT NULL,
	[DisplayDetail] [int] NOT NULL,
	[Hint] [varchar](16) NOT NULL,
 CONSTRAINT [PK_Commands] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Build, 1 = CIS, 2 = Verification, 3 = Build Promotion, 4 = Send QA Changes, 5 = Tools, 6 = Test, 7 = QA Build Promotion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Commands', @level2type=N'COLUMN',@level2name=N'Type'
GO
/****** Object:  Table [dbo].[Changelists2]    Script Date: 02/12/2013 17:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Changelists2](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BranchConfigID] [int] NOT NULL,
	[Changelist] [int] NOT NULL,
	[BuildStatus] [int] NULL,
	[Submitter] [varchar](32) NOT NULL,
	[TimeStamp] [datetime] NOT NULL,
	[Description] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Changelists2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCisBranches]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCisBranches]

AS

SELECT
    bc.ID,
    bc.Branch,
    bc.LockedDown,
    COUNT(t.ID) AS NumTasks
FROM
    BranchConfig AS bc
LEFT JOIN
    CISTasks (NOLOCK) AS t ON t.BranchConfigID = bc.ID
GROUP BY
    bc.Branch,
	bc.ID,
	bc.LockedDown
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCommandBuildLogs]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCommandBuildLogs]
(
	@CommandId int,
    @Page int,                      /* Currently ignored */
    @Count int
)
AS

SELECT TOP (@Count)
    l.Machine,
    l.BuildStarted,
    l.BuildEnded,
    l.ChangeList,
    l.CurrentStatus,
    l.BuildLabel,
    l.DetailedLogPath
FROM
    BuildLog (NOLOCK) AS l
WHERE
    (CommandID = @CommandId)
ORDER BY
    l.BuildStarted DESC
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCommandActivity]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCommandActivity]
(
	@CommandId int,
    @StatusFilter varchar(128),
    @Days int
)
AS

SELECT
    DATEADD(d, DATEDIFF(d, 0, BuildStarted), 0) AS BuildStartedDate,
    COUNT(*) AS LogCount
FROM
    BuildLog
WHERE
    (CommandID = @CommandId) AND
    (CurrentStatus LIKE @StatusFilter) AND
    (DATEDIFF(Day, BuildStarted, GETUTCDATE()) < @Days)
GROUP BY
    DATEADD(d, DATEDIFF(d, 0, BuildStarted), 0)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetBranchList]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetBranchList]
AS

SELECT
    ID,
    Branch
FROM
    BranchConfig
ORDER BY
    Branch
GO
/****** Object:  StoredProcedure [dbo].[SP_GetBranchDetails]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetBranchDetails]
(
    @BranchId int
)
AS

SELECT
    bc.ID,
    bc.Branch,
    bc.Server,
    bc.BranchAdmin,
    bc.HeadChangelist,
    bc.LockedDown
FROM
    BranchConfig (NOLOCK) AS bc
WHERE
    bc.ID = @BranchId
GO
/****** Object:  StoredProcedure [dbo].[SP_GetBuildsPerDay]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetBuildsPerDay]
(
	@NumDays int,
	@CommandType varchar(32),
	@Exceptions bit
)
AS

SELECT
	COUNT(BuildStarted) AS CommandCount,
	DATEDIFF(day, BuildStarted, GETDATE()) AS BuildAge,
	DATEADD(day, -DATEDIFF(day, BuildStarted, GETDATE()), GetDate()) AS BuildDate
FROM
	BuildLog
WHERE
	(DATEDIFF(day, BuildStarted, GETDATE()) < @NumDays) AND
	(
		((@CommandType = '') AND (SUBSTRING(Command, 1, 4) <> 'Soak')) OR
		((@CommandType <> '') AND (SUBSTRING(Command, 1, LEN(@CommandType)) = @CommandType))
	)
	AND
	(
		(@Exceptions = 0) OR
		((@Exceptions = 1) AND (Command <> 'CIS/ProcessP4Changes') AND (Command <> 'CIS/UpdateMonitorValues'))
	)
GROUP BY
	DATEDIFF(day, BuildStarted, GETDATE())
ORDER BY
	BuildAge DESC
GO
/****** Object:  StoredProcedure [dbo].[GetActiveBuilderCount]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetActiveBuilderCount] 

AS
   BEGIN TRAN
   
   SELECT COUNT( ID ) FROM [Builders] WHERE ( State = 'Connected' ) AND ( DATEDIFF( minute, CurrentTime, GETDATE() ) < 100 )
 
   COMMIT
 
   RETURN
GO
/****** Object:  StoredProcedure [dbo].[SelectActiveBuilders]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectActiveBuilders] 

AS

SELECT CurrentTime, Machine FROM Builders 
WHERE ( State = 'Connected' ) AND ( CurrentTime is NOT null ) AND ( DATEDIFF( Day, GETUTCDATE(), CurrentTime ) > -1 )
ORDER BY Machine

RETURN
GO
/****** Object:  Table [dbo].[PerformanceData]    Script Date: 02/12/2013 17:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PerformanceData](
	[AppID] [dbo].[KeyID] NOT NULL,
	[MachineID] [dbo].[KeyID] NOT NULL,
	[CounterID] [dbo].[KeyID] NOT NULL,
	[IntValue] [bigint] NOT NULL,
	[DateTimeStamp] [datetime] NOT NULL,
	[Changelist] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PerformanceCounters]    Script Date: 02/12/2013 17:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PerformanceCounters](
	[ID] [dbo].[KeyID] IDENTITY(1,1) NOT NULL,
	[CounterName] [dbo].[FixedString] NOT NULL,
 CONSTRAINT [PK_PerformanceCounters] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Machines]    Script Date: 02/12/2013 17:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Machines](
	[ID] [dbo].[KeyID] IDENTITY(1,1) NOT NULL,
	[MachineName] [dbo].[FixedString] NOT NULL,
	[Notes] [dbo].[String] NULL,
 CONSTRAINT [PK_Machine] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [Unique_MachineName] UNIQUE NONCLUSTERED 
(
	[MachineName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Jobs]    Script Date: 02/12/2013 17:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Jobs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](64) NULL,
	[Command] [varchar](64) NULL,
	[Platform] [varchar](32) NULL,
	[Game] [varchar](64) NULL,
	[Config] [varchar](32) NULL,
	[ScriptConfig] [varchar](32) NULL,
	[Language] [varchar](64) NULL,
	[Define] [varchar](64) NULL,
	[Parameter] [varchar](1024) NULL,
	[Remote] [bit] NOT NULL,
	[BranchConfigID] [int] NOT NULL,
	[CISTaskID] [int] NOT NULL,
	[CISJobStateID] [int] NOT NULL,
	[Label] [varchar](96) NULL,
	[Machine] [varchar](16) NULL,
	[BuildLogID] [int] NULL,
	[PrimaryBuild] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[Complete] [bit] NOT NULL,
	[Succeeded] [bit] NOT NULL,
	[Optional] [bit] NOT NULL,
	[Killing] [bit] NOT NULL,
	[Suppressed] [bit] NOT NULL,
	[SpawnTime] [bigint] NULL,
 CONSTRAINT [PK_Jobs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[GetTriggerable2]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTriggerable2]

	@MinAccess int,
	@MaxAccess int,
	@UserDetail int

AS

	SELECT [ID], [Description], [Command], [Hint], [UserLevel], [Machine], [MachineLock]
	FROM [Commands] WHERE 
		( Access >= @MinAccess AND Access < @MaxAccess AND UserLevel <= @UserDetail  ) 
			ORDER BY Access

RETURN
GO
/****** Object:  StoredProcedure [dbo].[GetTriggerable]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTriggerable]

	@MinAccess int,
	@MaxAccess int

AS

	SELECT [ID], [Description], [Command], [Hint], [Machine], [MachineLock]
	FROM [Commands] WHERE 
		( Access >= @MinAccess AND Access < @MaxAccess ) 
			ORDER BY Access

RETURN
GO
/****** Object:  StoredProcedure [dbo].[GetMachineID]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMachineID]
	(
	@MachineName FixedString
	)
AS
	SET NOCOUNT ON
	
	DECLARE @MachineID KeyID
	
	SET @MachineID = (SELECT ID FROM dbo.Machines WHERE MachineName = @MachineName)
	
	IF (@MachineID IS NULL)
	BEGIN
		INSERT INTO dbo.Machines (MachineName) VALUES (@MachineName)
		SET @MachineID = @@IDENTITY
	END
	
	RETURN @MachineID
GO
/****** Object:  StoredProcedure [dbo].[GetCounterID]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCounterID]
	(
	@CounterName FixedString
	)
AS
	SET NOCOUNT ON
	
	DECLARE @CounterID KeyID
	
	SET @CounterID = (SELECT ID FROM dbo.PerformanceCounters WHERE CounterName = @CounterName)
	
	IF (@CounterID IS NULL)
	BEGIN
		INSERT INTO dbo.PerformanceCounters (CounterName) VALUES (@CounterName)
		SET @CounterID = @@IDENTITY
	END
	
	RETURN @CounterID
GO
/****** Object:  StoredProcedure [dbo].[GetAppID]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAppID]
	(
	@AppName FixedString
	)
AS
	SET NOCOUNT ON
	
	DECLARE @AppID KeyID
	
	SET @AppID = (SELECT ID FROM dbo.Applications WHERE AppName = @AppName)
	
	IF (@AppID IS NULL)
	BEGIN
		INSERT INTO dbo.Applications (AppName) VALUES (@AppName)
		SET @AppID = @@IDENTITY
	END
	
	RETURN @AppID
GO
/****** Object:  StoredProcedure [dbo].[SelectVerifyStatus]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectVerifyStatus] 

AS

SELECT Commands.BuildLogID, BuildLog.ID, Commands.Machine, BuildLog.ChangeList, Builders.CurrentStatus, BuildLog.BuildStarted, Commands.Operator, Commands.Description
FROM Commands, BuildLog
JOIN Builders ON BuildLog.Machine = Builders.Machine AND Builders.State = 'Building'
WHERE ( Commands.BuildLogID = BuildLog.ID ) AND ( PrimaryBuild = 0 ) 
ORDER BY BuildLog.BuildStarted

	RETURN
GO
/****** Object:  StoredProcedure [dbo].[SelectJobStatus]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectJobStatus] 

AS

SELECT Jobs.BuildLogID, BuildLog.ID, Jobs.Machine, BuildLog.BuildStarted, Builders.CurrentStatus 
FROM Jobs, BuildLog 
JOIN Builders ON BuildLog.Machine = Builders.Machine AND Builders.State = 'Building'
WHERE ( Jobs.BuildLogID = BuildLog.ID ) AND ( Active = 1 ) AND ( Complete = 0 )
ORDER BY BuildLog.BuildStarted

RETURN
GO
/****** Object:  StoredProcedure [dbo].[SelectBuildStatus]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectBuildStatus] 

AS

SELECT Commands.BuildLogID, Commands.Operator, Commands.Description, Commands.Machine, BuildLog.ChangeList, BuildLog.ID, BuildLog.BuildStarted, Builders.CurrentTime, Builders.CurrentStatus
FROM Commands
JOIN BuildLog ON Commands.BuildLogID = BuildLog.ID
JOIN Builders ON BuildLog.Machine = Builders.Machine
WHERE (Commands.PrimaryBuild = 1) AND (Builders.State = 'Building')
ORDER BY BuildLog.BuildStarted

RETURN
GO
/****** Object:  StoredProcedure [dbo].[SelectBuilds]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectBuilds] 

	@DisplayID int,
	@DisplayDetailID int

AS

	SELECT Description, LastGoodChangeList, DATEADD( MINUTE, DATEDIFF( MINUTE, GETUTCDATE(), GETDATE() ), LastGoodDateTime ) AS LastGoodDateTime, 
		CASE Pending WHEN 0 THEN '' WHEN 1 THEN '(Build Pending)' END AS Status,
		CASE WHEN LastGoodLabel is null THEN '' WHEN LastGoodLabel is not null THEN '{' + LastGoodLabel + '}' END AS DisplayLabel 
		FROM [Commands] WHERE 
			( LastGoodDateTime is not null )
			AND ( ( @DisplayID != 0 AND ( Display = @DisplayID ) )
			OR ( @DisplayDetailID != 0 AND ( DisplayDetail = @DisplayDetailID ) ) )
				ORDER BY LastGoodChangeList DESC, LastGoodDateTime DESC

RETURN
GO
/****** Object:  Table [dbo].[CISJobStates]    Script Date: 02/12/2013 17:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CISJobStates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ChangelistID] [int] NOT NULL,
	[CISTaskID] [int] NOT NULL,
	[JobState] [tinyint] NOT NULL,
	[Error] [varchar](max) NOT NULL,
 CONSTRAINT [PK_CISJobStates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[SP_GetChangelistBuildLogs]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetChangelistBuildLogs]
(
	@Changelist int,
	@Branch varchar(32)
)
AS

SELECT 
	l.Command,
    l.CommandID,
	l.Machine,
	l.BuildStarted,
	l.BuildEnded,
	l.CurrentStatus,
	l.BuildLabel,
	l.DetailedLogPath,
    c.Description AS CommandDescription
FROM
	BuildLog (NOLOCK) AS l
LEFT OUTER JOIN
    Commands (NOLOCK) AS c ON c.ID = l.CommandID
WHERE
	(l.ChangeList = @Changelist)
ORDER BY l.CurrentStatus, l.BuildStarted DESC
GO
/****** Object:  StoredProcedure [dbo].[SP_GetBuildCommands]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetBuildCommands]
AS

SELECT
    c.ID,
    c.Description,
    c.BranchConfigID,
    c.Game,
    c.Platform,
    c.Operator,
    c.PrimaryBuild,
    c.LastAttemptedChangelist,
    c.LastAttemptedDateTime,
    c.LastGoodChangelist,
    c.LastGoodDateTime,
    c.BuildLogID,
    c.Pending,
    b.Machine,
    bc.Branch,
    l.BuildStarted
FROM
	Commands (NOLOCK) AS c
LEFT OUTER JOIN
    BuildLog (NOLOCK) AS l ON (c.BuildLogID = l.ID)
LEFT OUTER JOIN
    Builders (NOLOCK) AS b ON
        (l.Machine = b.Machine) AND
        (b.StartTime = (SELECT MAX(t.StartTime) FROM Builders (NOLOCK) AS t WHERE t.Machine = l.Machine))
LEFT OUTER JOIN
    BranchConfig (NOLOCK) AS bc ON (bc.ID = c.BranchConfigID)
WHERE
    (c.Type = 0) OR
	(c.Type = 5) OR
	(c.Type = 6)
ORDER BY
    bc.Branch,
    c.Game,
    c.Platform,
    c.Description
GO
/****** Object:  StoredProcedure [dbo].[SP_GetBuildBranches]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetBuildBranches]

AS

SELECT
    bc.ID,
    bc.Branch,
    bc.LockedDown,
    COUNT(c.ID) AS NumCommands
FROM
    BranchConfig AS bc
LEFT JOIN
    Commands AS c ON
        (c.BranchConfigID = bc.ID) AND
        (c.Type = 0)
GROUP BY
    bc.ID,
    bc.Branch,
    bc.LockedDown
GO
/****** Object:  StoredProcedure [dbo].[SP_GetBranchCommands]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetBranchCommands]
(
    @BranchId int
)
AS

SELECT
    c.ID,
    c.Type,
    c.Description,
    c.Platform,
    c.Game,
    c.Operator,
    c.PrimaryBuild,
    c.LastAttemptedChangelist,
    c.LastAttemptedDateTime,
    c.LastGoodChangelist,
    c.LastGoodDateTime,
    c.BuildLogID,
    b.Machine,
    b.StartTime,
    bc.Branch
FROM
    Commands (NOLOCK) AS c
LEFT OUTER JOIN
    BuildLog (NOLOCK) AS l ON (c.BuildLogID = l.ID)
LEFT OUTER JOIN
    Builders (NOLOCK) AS b ON
        (l.Machine = b.Machine) AND
        (b.StartTime = (SELECT MAX(t.StartTime) FROM Builders (NOLOCK) AS t WHERE t.Machine = l.Machine))
LEFT OUTER JOIN
    BranchConfig (NOLOCK) AS bc ON
        (bc.ID = c.BranchConfigID)
WHERE
    (c.BranchConfigID = @BranchId)
ORDER BY
    c.Game,
    c.Platform,
    c.Description
GO
/****** Object:  StoredProcedure [dbo].[SP_PromoteBuild]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PromoteBuild]
(
	@PromotionCommandId int,
	@BuildLabel varchar(128),
	@Operator varchar(32)
)
AS

UPDATE
	Commands
SET
	LatestApprovedLabel = @BuildLabel,
    Operator = @Operator,
	Pending = 1
WHERE
	ID = @PromotionCommandId

/** Legacy */
DECLARE @CommandType int
DECLARE @BranchConfigID int

SELECT TOP(1)
    @CommandType = Type,
    @BranchConfigID = BranchConfigID
FROM
    Commands (NOLOCK)
WHERE
    (ID = @PromotionCommandId) AND
    ((Type = 3) OR (Type = 7))

IF (@@ROWCOUNT > 0)
    BEGIN
        /** Game Builds */
        IF (@CommandType = 3)
            BEGIN
                UPDATE Variables
                SET
                    Value = @BuildLabel
                WHERE
                    (BranchConfigID = @BranchConfigID) AND
                    (Variable = 'LatestApprovedBuild')
            END

        /** QA Approved Builds */
        ELSE IF (@CommandType = 7)
            BEGIN
                UPDATE Variables
                SET
                    Value = @BuildLabel
                WHERE
                    (BranchConfigID = @BranchConfigID) AND
                    (Variable = 'LatestApprovedQABuild')
            END
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetVerificationBranches]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetVerificationBranches]

AS

SELECT
    bc.ID,
    bc.Branch,
    COUNT(c.ID) AS NumCommands
FROM
    BranchConfig AS bc
LEFT JOIN
    Commands (NOLOCK) AS c ON
        (c.BranchConfigID = bc.ID) AND
        (c.Type = 2)
GROUP BY
    bc.ID,
    bc.Branch
GO
/****** Object:  StoredProcedure [dbo].[SP_GetVerificationBranchCommands]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetVerificationBranchCommands]

(
	@BranchNameFilter varchar(32)
)
AS

SELECT
    c.ID,
    c.Description,
    c.Platform,
    c.Game,
    c.Operator,
    c.PrimaryBuild,
    c.LastAttemptedChangelist,
    c.LastAttemptedDateTime,
    c.LastGoodChangelist,
    c.LastGoodDateTime,
    c.BuildLogID,
    c.Pending,
    bc.Branch,
    b.Machine,
    l.BuildStarted
FROM
    Commands AS c
LEFT OUTER JOIN
    BranchConfig (NOLOCK) AS bc ON (bc.ID = c.BranchConfigID)
LEFT OUTER JOIN
    BuildLog (NOLOCK) AS l ON (c.BuildLogID = l.ID)
LEFT OUTER JOIN
    Builders (NOLOCK) AS b ON
        (l.Machine = b.Machine) AND
        (b.StartTime = (SELECT MAX(t.StartTime) FROM Builders AS t WHERE t.Machine = l.Machine))
WHERE
    (bc.Branch LIKE @BranchNameFilter) AND
    (c.Type = 2)
ORDER BY
    c.Game,
    c.Platform,
    c.Description
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUserChangelists]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetUserChangelists]
(
	@Submitter varchar(32),
    @Page int,                      /* Currently ignored */
    @Count int
)
AS

SELECT TOP(@Count)
    l.Changelist,
    l.TimeStamp,
    l.Description,
    b.Branch
FROM
    Changelists2 (NOLOCK) AS l
LEFT OUTER JOIN
    BranchConfig (NOLOCK) AS b ON (b.ID = l.BranchConfigID)
WHERE
    (Submitter LIKE @Submitter)
ORDER BY
    [TimeStamp] DESC
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUserActivity]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetUserActivity]
(
	@SubmitterFilter varchar(32),
    @Days int
)
AS

SELECT
    DATEADD(d, DATEDIFF(d, 0, [TimeStamp]), 0) AS [TimeStamp],
    COUNT(*) AS ChangelistCount
FROM
    Changelists2 (NOLOCK)
WHERE
    (Submitter LIKE @SubmitterFilter) AND
    (DATEDIFF(Day, [TimeStamp], GETUTCDATE()) < @Days)
GROUP BY
    DATEADD(d, DATEDIFF(d, 0, [TimeStamp]), 0)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPromotionCommands]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetPromotionCommands]
AS

SELECT
    c.ID,
    c.Description,
    c.LastGoodChangelist,
    c.Type,
    bc.Branch,
	c.LatestApprovedLabel AS LatestApproved
FROM
    Commands (NOLOCK) AS c
LEFT OUTER JOIN
    BranchConfig (NOLOCK) AS bc ON (bc.ID = c.BranchConfigID)
WHERE
    ((c.Type = 3) OR (c.Type = 4) OR (c.Type = 7))
ORDER BY
    bc.Branch,
    c.Description
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPromotedLabel]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetPromotedLabel]
(
	@CommandId int
)
AS

SELECT
	c.LatestApprovedLabel AS Value
FROM
	Commands (NOLOCK) AS c
WHERE
	c.ID = @CommandID

/*
SELECT
    v.Value
FROM
    Variables (NOLOCK) AS v
INNER JOIN
    Commands (NOLOCK) AS c ON v.BranchConfigID = c.BranchConfigID
WHERE
    (c.ID = @CommandID) AND
	(((c.Type = 3) AND (v.Variable = 'LatestApprovedBuild')) OR ((c.Type = 7) AND (v.Variable = 'LatestApprovedQABuild')))
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPromotableLabels]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetPromotableLabels]
(
	@PromoteCommandId int,
    @Count int
)
AS

SELECT TOP(@Count)
    l.ChangeList,
    l.BuildEnded,
    l.CurrentStatus,
    l.BuildLabel
FROM
    BuildLog (NOLOCK) AS l
WHERE
    (l.BuildLabel IS NOT NULL) AND
    (l.CommandID IN (
            SELECT ID
            FROM Commands (NOLOCK) AS c
            WHERE
                (c.BranchConfigID IN (
                        SELECT BranchConfigID
                        FROM Commands
                        WHERE ID = @PromoteCommandId)) AND
                (c.IsPromotable = 'True')
        )
    )
ORDER BY l.BuildStarted DESC
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPerformanceDataDanV]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetPerformanceDataDanV]
(
	@CounterId int,
	@Days int
)
AS

SELECT
	cl.Changelist,
	cl.BuildStatus,
	cl.Submitter,
	cl.TimeStamp,
	cl.Description,
	p.IntValue,
	p.MachineID
FROM
	Changelists2 AS cl
INNER JOIN
	PerformanceData AS p (NOLOCK) ON p.Changelist = cl.Changelist
WHERE
	(cl.BranchConfigID = 184) AND
	(p.CounterID = @CounterId) AND
	(DATEDIFF(Day, cl.TimeStamp, GETDATE()) <= @Days)
ORDER BY
	cl.TimeStamp DESC
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPerformanceData]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetPerformanceData]
(
	@CounterId int,
	@Days int
)
AS

SELECT
	MachineID,
	IntValue,
	DateTimeStamp,
	Changelist
FROM
	PerformanceData (NOLOCK)
WHERE
	(CounterID = @CounterId) AND
	(DATEDIFF(Day, DateTimeStamp, GETDATE()) <= @Days)
ORDER BY
	DateTimeStamp
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPerforceSize]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetPerforceSize]
(
	@NumWeeks int
)
AS

SELECT
	SUM(IntValue) AS SubmittedBytes,
	DATEDIFF(week, DateTimeStamp, GETDATE()) AS WeekOfYear
FROM
	PerformanceData
WHERE
	(CounterID = 1077) AND
	(DATEDIFF(week, DateTimeStamp, GETDATE()) < @NumWeeks) AND
	(DATEDIFF(week, DateTimeStamp, GETDATE()) > 0)
GROUP BY
	DATEDIFF(week, DateTimeStamp, GETDATE())
ORDER BY
	WeekOfYear DESC
GO
/****** Object:  StoredProcedure [dbo].[SP_GetOverallBuildTime]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetOverallBuildTime]
(
	@CommandID int,
    @Days int
)
AS

SELECT
    c.ID,
    d.DateTimeStamp,
    d.IntValue,
    m.MachineName
FROM
    PerformanceCounters AS c
JOIN
    PerformanceData (NOLOCK) AS d ON (d.CounterID = c.ID)
LEFT OUTER JOIN
    Machines (NOLOCK) AS m ON (m.ID = d.MachineID)
WHERE
    (c.CounterName = 'OverallBuildTime_' + CAST(@CommandID AS varchar(32))) AND
    (DATEDIFF(Day, d.DateTimeStamp, GETUTCDATE()) <= @Days)
ORDER BY
    m.MachineName,
    d.DateTimeStamp
GO
/****** Object:  StoredProcedure [dbo].[SP_GetMachineStatus]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetMachineStatus]
(
	@MachineNameFilter varchar(32)
)
AS
	
SELECT
    b1.Machine AS MachineName,
    b1.State,
    b1.StartTime,
	b1.CurrentStatus,
    b1.CurrentTime,
    b1.Deployed,
    b1.Version,
    c.MachineLock
FROM
	Builders AS b1
INNER JOIN(
	SELECT
		Machine,
		MAX(StartTime) AS MaxStartTime
	FROM
        Builders
	WHERE
        Machine LIKE @MachineNameFilter
	GROUP BY
        Machine) AS b2
    ON
        (b1.Machine = b2.Machine) AND
        (b1.StartTime = b2.MaxStartTime)
LEFT OUTER JOIN
    Commands (NOLOCK) AS c ON (c.Description = b1.Machine)
ORDER BY
    b1.Machine ASC
GO
/****** Object:  StoredProcedure [dbo].[SP_GetMachineDetails]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetMachineDetails]
(
	@MachineName varchar(32)
)
AS

DECLARE @FirstStart datetime
DECLARE @LastStart datetime
DECLARE @CurrentState varchar(16)
DECLARE @CurrentAndroidSDKVersion varchar(32)
DECLARE @CurrentFlashSDKVersion varchar(32)
DECLARE @CurrentIPhoneSDKVersion varchar(32)
DECLARE @CurrentMacSDKVersion varchar(32)
DECLARE @CurrentNgpSDKVersion varchar(32)
DECLARE @CurrentPS3SDKVersion varchar(32)
DECLARE @CurrentXbox360SDKVersion varchar(32)
DECLARE @CurrentWiiUSDKVersion varchar(32)
DECLARE @CurrentDirectXSDKVersion varchar(32)
DECLARE @CurrentTime datetime
DECLARE @CurrentUptime bigint
DECLARE @Crashes int
DECLARE @Deployed bit
DECLARE @DriveCSize int
DECLARE @DriveCFree int
DECLARE @DriveDSize int
DECLARE @DriveDFree int
DECLARE @MachineLock varchar(32)
DECLARE @CPUString varchar(64)
DECLARE @ProcessorCount int
DECLARE @Memory int
DECLARE @Version datetime


/** fetch first and last start times */
SELECT
	@FirstStart = MIN(StartTime),
	@LastStart = MAX(StartTime)
FROM
	Builders
WHERE
	(Machine = @MachineName)

/* fetch current stats */
SELECT TOP 1
	@CurrentState = State,
    @CurrentAndroidSDKVersion = AndroidSDKVersion,
	@CurrentDirectXSDKVersion = DirectXSDKVersion,
    @CurrentFlashSDKVersion = FlashSDKVersion,
    @CurrentIPhoneSDKVersion = iPhoneSDKVersion,
    @CurrentMacSDKVersion = MacSDKVersion,
    @CurrentNgpSDKVersion = NGPSDKVersion,
	@CurrentPS3SDKVersion = PS3SDKVersion,
    @CurrentWiiUSDKVersion = WiiUSDKVersion,
	@CurrentXbox360SDKVersion = Xbox360SDKVersion,
    @CurrentTime = CurrentTime,
	@CurrentUptime = DATEDIFF(Second, StartTime, GETUTCDATE()),
    @CPUString = CPUString,
    @Deployed = Deployed,
    @DriveCSize = DriveCSize,
    @DriveCFree = DriveCFree,
    @DriveDSize = DriveDSize,
    @DriveDFree = DriveDFree,
    @ProcessorCount = ProcessorCount,
    @Memory = Memory,
    @Version = Version
FROM
	Builders
WHERE
	(Machine = @MachineName)
ORDER BY
	StartTime DESC

/* fetch number of crashes */
SELECT
	@Crashes = COUNT(*)
FROM
	Builders
WHERE
	(Machine = @MachineName) AND
	(EndTime IS NULL)

/* check if locked for maintenance */
SELECT
	@MachineLock = MachineLock
FROM
	Commands
WHERE
	Description = @MachineName


SELECT
    @MachineName AS MachineName,
	@FirstStart AS FirstStart,
	@LastStart AS LastStart,
    @CPUString AS CPUString,
	@CurrentState AS CurrentState,
    @CurrentAndroidSDKVersion AS CurrendAndroidSDKVersion,
	@CurrentDirectXSDKVersion AS CurrentDirectXSDKVersion,
    @CurrentFlashSDKVersion AS CurrentFlashSDKVersion,
    @CurrentIPhoneSDKVersion AS CurrentIPhoneSDKVersion,
    @CurrentMacSDKVersion AS CurrentMacSDKVersion,
    @CurrentNgpSDKVersion AS CurrentNgpSDKVersion,
	@CurrentPS3SDKVersion AS CurrentPS3SDKVersion,
    @CurrentWiiUSDKVersion AS CurrentWiiUSDKVersion,
	@CurrentXbox360SDKVersion AS CurrentXbox360SDKVersion,
    @CurrentTime AS CurrentTime,
	@CurrentUptime AS CurrentUptime,
	@Crashes AS Crashes,
    @DriveCSize AS DriveCSize,
    @DriveCFree AS DriveCFree,
    @DriveDSize AS DriveDSize,
    @DriveDFree AS DriveDFree,
	@MachineLock AS MachineLock,
    @ProcessorCount AS ProcessorCount,
    @Memory AS Memory,
    @Version AS Version
GO
/****** Object:  StoredProcedure [dbo].[SP_GetMachineBuildLogs]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetMachineBuildLogs]
(
	@MachineName varchar(32),
    @Page int,                      /* Currently ignored */
    @Count int
)
AS

SELECT TOP (@Count)
    l.Command,
    l.CommandID,
    l.JobID,
    l.ChangeList,
    l.BuildStarted,
    l.BuildEnded,
    l.CurrentStatus,
    l.BuildLabel,
    l.DetailedLogPath,
    l.BranchConfigID,
    c.Description AS CommandDescription,
    c.Type,
    j.Name AS JobDescription,
    b.Branch
FROM
    BuildLog (NOLOCK) AS l
LEFT OUTER JOIN
    Commands (NOLOCK) AS c ON (c.ID = l.CommandID)
LEFT OUTER JOIN
    Jobs (NOLOCK) AS j ON (j.ID = l.JobID)
LEFT OUTER JOIN
    BranchConfig (NOLOCK) AS b ON (b.ID = l.BranchConfigID)
WHERE
    (l.Machine = @MachineName)
ORDER BY
    l.BuildStarted DESC
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCisTurnaround]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCisTurnaround]
(
	@NumDays int
)
AS

SELECT
	Jobs.Name,
	Changelists2.TimeStamp,
	Changelists2.Changelist,
	Jobs.SpawnTime,
	BuildLog.BuildStarted,
	BuildLog.BuildEnded
FROM
	Jobs
INNER JOIN
	BuildLog ON BuildLog.ID = Jobs.BuildLogID
INNER JOIN
	Changelists2 ON Changelists2.Changelist = BuildLog.Changelist
WHERE
	(LEFT(Jobs.Name, 16) = 'CIS Code Builder') AND
	(Complete = 1) AND
	(DATEDIFF(day, BuildLog.BuildStarted, GETDATE()) < @NumDays) AND
	(BuildLog.BuildEnded IS NOT NULL)
ORDER BY
	SpawnTime ASC
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCisPendingTasks]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCisPendingTasks]

AS

SELECT
    j.Name,
    j.Platform,
    j.Game,
    j.Config,
    j.CISTaskID,
    bc.Branch
FROM
    Jobs (NOLOCK) AS j
LEFT OUTER JOIN
    BranchConfig (NOLOCK) AS bc ON (j.BranchConfigID = bc.ID)
WHERE
    (j.CISTaskID > 0) AND
    (j.Active = 0) AND
    (j.Complete = 0) AND
    (j.Optional = 0) AND
    (j.PrimaryBuild = 0)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCisLatestChangelists]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCisLatestChangelists]
AS

SELECT
    cl.BranchConfigID,
    cl.Changelist,
    cl.BuildStatus,
    cl.Submitter,
    cl.TimeStamp,
    bc.Branch
FROM
    Changelists2 as cl
INNER JOIN(
    SELECT
        BranchConfigID,
        MAX([TimeStamp]) AS MaxTimeStamp
    FROM
        Changelists2
    GROUP BY
        BranchConfigID) AS t
    ON
        (cl.BranchConfigID = t.BranchConfigID) AND
        (cl.TimeStamp = t.MaxTimeStamp)
LEFT OUTER JOIN
    BranchConfig (NOLOCK) AS bc ON (bc.ID = cl.BranchConfigID)
ORDER BY
    bc.Branch
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCisBranchChangelists]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCisBranchChangelists]
(
	@ID int,
    @Count int
)
AS

SELECT TOP(@Count)
    cl.Changelist,
    cl.BuildStatus,
    cl.Submitter,
    cl.Timestamp,
    cl.Description
FROM
    Changelists2 AS cl
LEFT OUTER JOIN
    BranchConfig (NOLOCK) AS bc ON (bc.ID = cl.BranchConfigID)
WHERE
    (bc.ID = @ID)
ORDER BY
    cl.TimeStamp DESC
GO
/****** Object:  StoredProcedure [dbo].[SP_GetChangelistDetails]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetChangelistDetails]
(
	@ChangelistId int
)
AS

SELECT DISTINCT
    c.Submitter,
    c.TimeStamp,
    c.Description,
	bc.Branch,
	bc.ID AS BranchConfigID
FROM
	Changelists2 AS c
INNER JOIN
	BranchConfig (NOLOCK) AS bc ON (c.BranchConfigID = bc.ID)
WHERE
    (c.Changelist = @ChangelistId)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCommandDetails]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCommandDetails]
(
	@CommandId int
)
AS

SELECT
    c.ID,
    c.Type,
    c.Description,
    c.Command,
    c.BranchConfigID,
    c.Platform,
    c.Game,
    c.Config,
    c.Language,
    c.Parameter,
    c.UserLevel,
    c.Hint,
    c.IsPromotable,
    c.MachineLock,
    c.NextTriggerDelay,
    c.NextTrigger,
    c.Access,
    c.Display,
    c.DisplayDetail,
    c.PrimaryBuild,
    c.LastAttemptedChangeList,
    c.LastAttemptedDateTime,
    c.LastFailedChangeList,
    c.LastFailedDateTime,
    c.LastGoodChangeList,
    c.LastGoodLabel,
    c.LastGoodDateTime,
    c.Operator,
    c.Killer,
    c.Pending,
    c.Killing,
    c.Machine,
    c.BuildLogID,
    c.ConchHolder,
    b.Machine,
    b.StartTime,
    bc.Branch
FROM
    Commands (NOLOCK) AS c
LEFT OUTER JOIN
    BuildLog (NOLOCK) AS l ON (c.BuildLogID = l.ID)
LEFT OUTER JOIN
    Builders (NOLOCK) AS b ON
        (l.Machine = b.Machine) AND
        (b.StartTime = (SELECT MAX(t.StartTime) FROM Builders AS t WHERE t.Machine = l.Machine))
LEFT OUTER JOIN
    BranchConfig (NOLOCK) AS bc ON (bc.ID = c.BranchConfigID)
WHERE
    (c.ID = @CommandId)
GO
/****** Object:  StoredProcedure [dbo].[SP_TriggerCommand]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TriggerCommand]
(
	@CommandId int,
    @Operator varchar(32)
)
AS

UPDATE
    Commands
SET
    Operator = @Operator,
	Pending = 1
WHERE
    ID = @CommandId
GO
/****** Object:  StoredProcedure [dbo].[SP_Test]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Test]
AS

WITH FilteredChangelists2 AS (
    SELECT
        [Timestamp],
        CASE WHEN BuildStatus = -1 THEN 1 ELSE 0 END AS Success
    FROM
        Changelists2
    WHERE
        (BranchConfigID = 1) AND
        (BuildStatus IS NOT NULL)
),
OrderedChangelists2 AS (
    SELECT
        [Timestamp],
        Success,
        ROW_NUMBER() OVER(ORDER BY [Timestamp]) AS rn,
        ROW_NUMBER() OVER(PARTITION BY Success ORDER BY [Timestamp]) AS rnPart
    FROM
        FilteredChangelists2
),
Groups AS (
    SELECT
        MIN(rn) AS rnFrom,
        MIN([Timestamp]) AS TimeFrom,
        MAX(rn) AS rnTo,
        MAX([Timestamp]) AS TimeTo,
        Success
    FROM
        OrderedChangelists2
    GROUP BY
        rn - rnPart,
        Success
)

SELECT
    g.*
FROM
    Groups AS g
LEFT OUTER JOIN
    OrderedChangelists2 s ON (s.rn + 1 = g.rnFrom) AND (s.Success <> g.Success) AND (s.Timestamp <= g.TimeFrom)
LEFT OUTER JOIN
    OrderedChangelists2 e ON (e.rn - 1 = g.rnTo) AND (e.Success <> g.Success) AND (e.Timestamp >= g.TimeTo)
ORDER BY rnFrom
GO
/****** Object:  StoredProcedure [dbo].[SP_StopCommand]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_StopCommand]
(
	@CommandId int,
    @Killer varchar(32)
)
AS

UPDATE
    Commands
SET
    Killing = 1,
    Killer = @Killer
WHERE
    ID = @CommandId
GO
/****** Object:  StoredProcedure [dbo].[SP_SetMachineMaintenance]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SetMachineMaintenance]
(
	@MachineName varchar(32),
	@Maintenance int = 1
)

AS

IF (@Maintenance = 1)
	UPDATE Commands
	SET
		MachineLock = @MachineName,
        Pending = 'True'
	WHERE
		Description = @MachineName
ELSE
	UPDATE Commands
	SET
		MachineLock = 'None',
        Pending = 'False'
	WHERE
		Description = @MachineName
GO
/****** Object:  Table [dbo].[Subscriptions]    Script Date: 02/12/2013 17:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Subscriptions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CommandID] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[Email] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Subscriptions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[StatGBSubmittedToPerforce]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StatGBSubmittedToPerforce]

AS

SELECT SUM( IntValue ) / ( 1024.0 * 1024.0 * 1024.0 ) FROM PerformanceData
WHERE ( CounterID = 1077 AND DATEDIFF( day, DateTimeStamp, GETDATE() ) < 8 )

RETURN
GO
/****** Object:  StoredProcedure [dbo].[StatGBPublished]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StatGBPublished]

AS

SELECT SUM( IntValue ) / ( 1024.0 * 1024.0 * 1024.0 ) FROM PerformanceData
WHERE ( CounterID = 1079 OR CounterID = 1080 OR CounterID = 1081 OR CounterID = 1082 ) 
AND DATEDIFF( day, DateTimeStamp, GETDATE() ) < 8

RETURN
GO
/****** Object:  StoredProcedure [dbo].[StatGBFTPd]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StatGBFTPd]

AS

SELECT SUM( IntValue ) / ( 1024.0 * 1024.0 * 1024.0 ) FROM PerformanceData
WHERE ( CounterID = 1078 AND DATEDIFF( day, DateTimeStamp, GETDATE() ) < 8 )

RETURN
GO
/****** Object:  StoredProcedure [dbo].[SP_GetFailedCommands]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetFailedCommands]
(
    @WithinDays int
)
AS

SELECT
    c.ID,
    c.Description,
    c.Game,
    c.Platform,
    bc.Branch,
    c.PrimaryBuild,
    c.LastGoodChangeList,
    c.LastAttemptedChangeList,
    DATEDIFF(Day, c.LastGoodDateTime, c.LastAttemptedDateTime) AS DaysBroken
FROM
	Commands(NOLOCK) AS c
LEFT OUTER JOIN
    BranchConfig (NOLOCK) AS bc ON (bc.ID = c.BranchConfigID)
WHERE
    (c.Type = 0) AND
    (c.LastAttemptedChangeList <> c.LastGoodChangeList) AND
    (DATEDIFF(Day, c.LastAttemptedDateTime, GETUTCDATE()) <= @WithinDays)
ORDER BY
    bc.Branch,
    c.Game,
    c.Platform,
    c.Description
GO
/****** Object:  StoredProcedure [dbo].[SP_GetDesktopPerformance]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetDesktopPerformance]
(
	@CounterId int,
	@MachineId int
)
AS

SELECT
	Changelist,
	IntValue / 1000 AS Performance,
	DateTimeStamp
FROM
	PerformanceData
WHERE
	(CounterID = @CounterId) AND
	(MachineID = @MachineId) AND
	(DATEDIFF(day, '8/31/2012', DateTimeStamp) >= 0 )
ORDER BY
	Changelist
GO
/****** Object:  StoredProcedure [dbo].[SP_GetLatestBuilds]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetLatestBuilds]
AS

SELECT DISTINCT
    bc.ID,
    bc.Branch,
    v.Variable AS Build,
    v.Value AS Label,
    l.ChangeList,
    l.BuildEnded
FROM
    Variables (NOLOCK) AS v
LEFT OUTER JOIN
    BranchConfig (NOLOCK) AS bc ON (bc.ID = v.BranchConfigID)
LEFT OUTER JOIN
    BuildLog (NOLOCK) AS l ON
        (l.BranchConfigID = v.BranchConfigID) AND
        (l.BuildLabel = v.Value)
WHERE
    (v.Variable LIKE 'Latest%Build') AND
    (v.Value <> '')
ORDER BY
    bc.Branch,
    v.Variable
GO
/****** Object:  StoredProcedure [dbo].[SP_RemoveCommandSubscription]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RemoveCommandSubscription]
(
	@CommandId int,
	@Type tinyint,
    @UserEmail varchar(32)
)
AS

DELETE FROM
    Subscriptions
WHERE
    (CommandID = @CommandId) AND
    (Type = @Type) AND
    (Email = @UserEmail)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCommandSubscriptions]    Script Date: 02/12/2013 17:57:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCommandSubscriptions]
(
	@CommandId int,
	@UserEmail varchar(32)
)
AS

SELECT
	Type
FROM
	Subscriptions
WHERE
	(CommandID = @CommandId) AND
	(Email = @UserEmail)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetChangelistCisLogs]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetChangelistCisLogs]
(
	@Changelist int
)
AS

SELECT
	t.Name,
	s.JobState,
    s.Error
FROM
    Changelists2 AS cl
JOIN
	CISJobStates (NOLOCK) AS s ON
	(s.ChangelistID = cl.ID)
LEFT OUTER JOIN
	CISTasks (NOLOCK) AS t ON (t.ID = s.CISTaskID)
WHERE
	(cl.Changelist = @Changelist)
ORDER BY
	t.Name ASC

	/*
LEFT OUTER JOIN CISTasks AS t ON
	(t.ID = cl.CISTaskID)
LEFT OUTER JOIN CISJobStates AS s ON
	(s.CISTaskID = cl.CISTaskID) AND
	(s.ChangelistID = cl.ID)
WHERE
    (cl.Changelist = @Changelist)*/
GO
/****** Object:  StoredProcedure [dbo].[SP_AddCommandSubscription]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddCommandSubscription]
(
	@CommandId int,
	@Type tinyint,
    @UserEmail varchar(32)
)
AS


INSERT INTO Subscriptions (CommandID, Type, Email)
SELECT @CommandId, @Type, @UserEmail
WHERE NOT EXISTS(
    SELECT
        *
    FROM
        Subscriptions
    WHERE
        (CommandID = @CommandId) AND
        (Type = @Type) AND
        (Email = @UserEmail))
GO
/****** Object:  StoredProcedure [dbo].[CreatePerformanceData2]    Script Date: 02/12/2013 17:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreatePerformanceData2]
	(
		@CounterName FixedString,
		@MachineName FixedString,
		@AppName FixedString,
		@IntValue bigint,
		@Changelist int,
		@DateTimeStamp datetime
	)
AS

	DECLARE @AppID KeyID
	DECLARE @MachineID KeyID
	DECLARE @CounterID KeyID

	EXEC @AppID = dbo.GetAppID @AppName
	EXEC @MachineID = dbo.GetMachineID @MachineName
	EXEC @CounterID = dbo.GetCounterID @CounterName

	INSERT INTO dbo.PerformanceData ( AppID, MachineID, CounterID, IntValue, Changelist, DateTimeStamp ) VALUES ( @AppID, @MachineID, @CounterID, @IntValue, @Changelist, @DateTimeStamp )
	
	RETURN
GO
/****** Object:  Default [DF_BranchConfig_Version]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig] ADD  CONSTRAINT [DF_BranchConfig_Version]  DEFAULT ((0)) FOR [Version]
GO
/****** Object:  Default [DF_BranchConfig_AndroidSDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig] ADD  CONSTRAINT [DF_BranchConfig_AndroidSDKVersion]  DEFAULT ('None') FOR [AndroidSDKVersion]
GO
/****** Object:  Default [DF_BranchConfig_iPhoneSDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig] ADD  CONSTRAINT [DF_BranchConfig_iPhoneSDKVersion]  DEFAULT ('None') FOR [iPhoneSDKVersion]
GO
/****** Object:  Default [DF_BranchConfig_WiiUSDKVersion1]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig] ADD  CONSTRAINT [DF_BranchConfig_WiiUSDKVersion1]  DEFAULT ('None') FOR [MacSDKVersion]
GO
/****** Object:  Default [DF_BranchConfig_NGPSDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig] ADD  CONSTRAINT [DF_BranchConfig_NGPSDKVersion]  DEFAULT ('None') FOR [NGPSDKVersion]
GO
/****** Object:  Default [DF_BranchConfig_PS3SDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig] ADD  CONSTRAINT [DF_BranchConfig_PS3SDKVersion]  DEFAULT ('None') FOR [PS3SDKVersion]
GO
/****** Object:  Default [DF_BranchConfig_WiiUSDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig] ADD  CONSTRAINT [DF_BranchConfig_WiiUSDKVersion]  DEFAULT ('None') FOR [WiiUSDKVersion]
GO
/****** Object:  Default [DF_BranchConfig_Xbox360SDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig] ADD  CONSTRAINT [DF_BranchConfig_Xbox360SDKVersion]  DEFAULT ('None') FOR [Xbox360SDKVersion]
GO
/****** Object:  Default [DF_BranchConfig_FlashSDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig] ADD  CONSTRAINT [DF_BranchConfig_FlashSDKVersion]  DEFAULT ('None') FOR [FlashSDKVersion]
GO
/****** Object:  Default [DF_BranchConfig_HeadChangelist]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig] ADD  CONSTRAINT [DF_BranchConfig_HeadChangelist]  DEFAULT ((0)) FOR [HeadChangelist]
GO
/****** Object:  Default [DF_BranchConfig_LastFullyKnown]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig] ADD  CONSTRAINT [DF_BranchConfig_LastFullyKnown]  DEFAULT ((-1)) FOR [LastFullyKnown]
GO
/****** Object:  Default [DF_BranchConfig_LastGoodOverall]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig] ADD  CONSTRAINT [DF_BranchConfig_LastGoodOverall]  DEFAULT ((-1)) FOR [LastGoodOverall]
GO
/****** Object:  Default [DF_BranchConfig_LastFailedOverall]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig] ADD  CONSTRAINT [DF_BranchConfig_LastFailedOverall]  DEFAULT ((-1)) FOR [LastFailOverall]
GO
/****** Object:  Default [DF_BranchConfig_LastChangelistProcessed]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig] ADD  CONSTRAINT [DF_BranchConfig_LastChangelistProcessed]  DEFAULT ((-1)) FOR [LastAttemptedOverall]
GO
/****** Object:  Default [DF_BranchConfig_LockedDown]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig] ADD  CONSTRAINT [DF_BranchConfig_LockedDown]  DEFAULT ((0)) FOR [LockedDown]
GO
/****** Object:  Default [DF_Builders_Version]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_Version]  DEFAULT ('1/1/2001 0:00:00 AM') FOR [Version]
GO
/****** Object:  Default [DF_Builders_Deployed]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_Deployed]  DEFAULT ((0)) FOR [Deployed]
GO
/****** Object:  Default [DF_Builders_DirectXSDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_DirectXSDKVersion]  DEFAULT ('None') FOR [DirectXSDKVersion]
GO
/****** Object:  Default [DF_Builders_AndroidSDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_AndroidSDKVersion]  DEFAULT ('None') FOR [AndroidSDKVersion]
GO
/****** Object:  Default [DF_Builders_iPhoneSDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_iPhoneSDKVersion]  DEFAULT ('None') FOR [iPhoneSDKVersion]
GO
/****** Object:  Default [DF_Builders_MacSDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_MacSDKVersion]  DEFAULT ('None') FOR [MacSDKVersion]
GO
/****** Object:  Default [DF_Builders_NGPSDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_NGPSDKVersion]  DEFAULT ('None') FOR [NGPSDKVersion]
GO
/****** Object:  Default [DF_Builders_PS3SDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_PS3SDKVersion]  DEFAULT ('None') FOR [PS3SDKVersion]
GO
/****** Object:  Default [DF_Builders_WiiUSDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_WiiUSDKVersion]  DEFAULT ('None') FOR [WiiUSDKVersion]
GO
/****** Object:  Default [DF_Builders_Xbox360SDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_Xbox360SDKVersion]  DEFAULT ('None') FOR [Xbox360SDKVersion]
GO
/****** Object:  Default [DF_Builders_FlashSDKVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_FlashSDKVersion]  DEFAULT ('None') FOR [FlashSDKVersion]
GO
/****** Object:  Default [DF_Builders_CPUString]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_CPUString]  DEFAULT ('') FOR [CPUString]
GO
/****** Object:  Default [DF_Builders_ProcessorCount]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_ProcessorCount]  DEFAULT ((0)) FOR [ProcessorCount]
GO
/****** Object:  Default [DF_Builders_Memory]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_Memory]  DEFAULT ((0)) FOR [Memory]
GO
/****** Object:  Default [DF_Builders_DriveCSize]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_DriveCSize]  DEFAULT ((0)) FOR [DriveCSize]
GO
/****** Object:  Default [DF_Builders_DriveCUsed]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_DriveCUsed]  DEFAULT ((0)) FOR [DriveCFree]
GO
/****** Object:  Default [DF_Builders_DriveDSize]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_DriveDSize]  DEFAULT ((0)) FOR [DriveDSize]
GO
/****** Object:  Default [DF_Builders_DriveDUsed]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Builders] ADD  CONSTRAINT [DF_Builders_DriveDUsed]  DEFAULT ((0)) FOR [DriveDFree]
GO
/****** Object:  Default [DF_BuildLog_BranchID]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BuildLog] ADD  CONSTRAINT [DF_BuildLog_BranchID]  DEFAULT ((1)) FOR [BranchConfigID]
GO
/****** Object:  Default [DF_Changelists2_BranchConfigID]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Changelists2] ADD  CONSTRAINT [DF_Changelists2_BranchConfigID]  DEFAULT ((1)) FOR [BranchConfigID]
GO
/****** Object:  Default [DF_Changelists2_Changelist]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Changelists2] ADD  CONSTRAINT [DF_Changelists2_Changelist]  DEFAULT ((1)) FOR [Changelist]
GO
/****** Object:  Default [DF_Changelists2_BuildStatus]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Changelists2] ADD  CONSTRAINT [DF_Changelists2_BuildStatus]  DEFAULT ((0)) FOR [BuildStatus]
GO
/****** Object:  Default [DF_Changelists2_TimeStamp]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Changelists2] ADD  CONSTRAINT [DF_Changelists2_TimeStamp]  DEFAULT ((0)) FOR [TimeStamp]
GO
/****** Object:  Default [DF_CISJobStates_ChangelistID]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[CISJobStates] ADD  CONSTRAINT [DF_CISJobStates_ChangelistID]  DEFAULT ((1)) FOR [ChangelistID]
GO
/****** Object:  Default [DF_CISJobStates_CISTaskID]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[CISJobStates] ADD  CONSTRAINT [DF_CISJobStates_CISTaskID]  DEFAULT ((1)) FOR [CISTaskID]
GO
/****** Object:  Default [DF_CISJobStates_JobState]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[CISJobStates] ADD  CONSTRAINT [DF_CISJobStates_JobState]  DEFAULT ((0)) FOR [JobState]
GO
/****** Object:  Default [DF_CISTasks_Name]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[CISTasks] ADD  CONSTRAINT [DF_CISTasks_Name]  DEFAULT ('') FOR [Name]
GO
/****** Object:  Default [DF_CISTasks_BranchConfigID]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[CISTasks] ADD  CONSTRAINT [DF_CISTasks_BranchConfigID]  DEFAULT ((1)) FOR [BranchConfigID]
GO
/****** Object:  Default [DF_CISTasks_Mask]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[CISTasks] ADD  CONSTRAINT [DF_CISTasks_Mask]  DEFAULT ((0)) FOR [Mask]
GO
/****** Object:  Default [DF_CISTasks_LastAttempted]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[CISTasks] ADD  CONSTRAINT [DF_CISTasks_LastAttempted]  DEFAULT ((0)) FOR [LastAttempted]
GO
/****** Object:  Default [DF_CISTasks_LastGood]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[CISTasks] ADD  CONSTRAINT [DF_CISTasks_LastGood]  DEFAULT ((0)) FOR [LastGood]
GO
/****** Object:  Default [DF_CISTasks_LastFail]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[CISTasks] ADD  CONSTRAINT [DF_CISTasks_LastFail]  DEFAULT ((0)) FOR [LastFail]
GO
/****** Object:  Default [DF_CISTasks_GameSpecific]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[CISTasks] ADD  CONSTRAINT [DF_CISTasks_GameSpecific]  DEFAULT ((0)) FOR [GameSpecific]
GO
/****** Object:  Default [DF_CISTasks_PlatformSpecific]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[CISTasks] ADD  CONSTRAINT [DF_CISTasks_PlatformSpecific]  DEFAULT ((0)) FOR [PlatformSpecific]
GO
/****** Object:  Default [DF_CISTasks_Remote]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[CISTasks] ADD  CONSTRAINT [DF_CISTasks_Remote]  DEFAULT ((0)) FOR [Remote]
GO
/****** Object:  Default [DF_CISTasks_CompileAllowed]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[CISTasks] ADD  CONSTRAINT [DF_CISTasks_CompileAllowed]  DEFAULT ((0)) FOR [CompileAllowed]
GO
/****** Object:  Default [DF_Commands_IsPromotion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Commands] ADD  CONSTRAINT [DF_Commands_IsPromotion]  DEFAULT ((0)) FOR [Type]
GO
/****** Object:  Default [DF_Commands_IsPromotable]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Commands] ADD  CONSTRAINT [DF_Commands_IsPromotable]  DEFAULT ((0)) FOR [IsPromotable]
GO
/****** Object:  Default [DF_Commands_PrimaryBuild]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Commands] ADD  CONSTRAINT [DF_Commands_PrimaryBuild]  DEFAULT ((0)) FOR [PrimaryBuild]
GO
/****** Object:  Default [DF_Commands_LastAttemptedDateTime]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Commands] ADD  CONSTRAINT [DF_Commands_LastAttemptedDateTime]  DEFAULT ('1/1/2001 12:00:00 AM') FOR [LastAttemptedDateTime]
GO
/****** Object:  Default [DF_Commands_LastFailedDateTime]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Commands] ADD  CONSTRAINT [DF_Commands_LastFailedDateTime]  DEFAULT ('1/1/2001 12:00:00 AM') FOR [LastFailedDateTime]
GO
/****** Object:  Default [DF_Commands_LastGoodDateTime]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Commands] ADD  CONSTRAINT [DF_Commands_LastGoodDateTime]  DEFAULT ('1/1/2001 12:00:00 AM') FOR [LastGoodDateTime]
GO
/****** Object:  Default [DF_Commands_Pending]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Commands] ADD  CONSTRAINT [DF_Commands_Pending]  DEFAULT ((0)) FOR [Pending]
GO
/****** Object:  Default [DF_Commands_Killing]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Commands] ADD  CONSTRAINT [DF_Commands_Killing]  DEFAULT ((0)) FOR [Killing]
GO
/****** Object:  Default [DF_Commands_UserLevel]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Commands] ADD  CONSTRAINT [DF_Commands_UserLevel]  DEFAULT ((0)) FOR [UserLevel]
GO
/****** Object:  Default [DF_Commands_Hint]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Commands] ADD  CONSTRAINT [DF_Commands_Hint]  DEFAULT ('Black') FOR [Hint]
GO
/****** Object:  Default [DF_Jobs_CISTaskID]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_CISTaskID]  DEFAULT ((0)) FOR [CISTaskID]
GO
/****** Object:  Default [DF_Jobs_CISJobStateID]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_CISJobStateID]  DEFAULT ((0)) FOR [CISJobStateID]
GO
/****** Object:  Default [DF_Jobs_Active]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_Active]  DEFAULT ((0)) FOR [Active]
GO
/****** Object:  Default [DF_Jobs_Complete]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_Complete]  DEFAULT ((0)) FOR [Complete]
GO
/****** Object:  Default [DF_Jobs_Succeeded]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_Succeeded]  DEFAULT ((0)) FOR [Succeeded]
GO
/****** Object:  Default [DF_Jobs_Copied]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_Copied]  DEFAULT ((0)) FOR [Optional]
GO
/****** Object:  Default [DF_Jobs_Killing]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_Killing]  DEFAULT ((0)) FOR [Killing]
GO
/****** Object:  Default [DF_Jobs_Suppressed]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Jobs] ADD  CONSTRAINT [DF_Jobs_Suppressed]  DEFAULT ((0)) FOR [Suppressed]
GO
/****** Object:  Default [DF_PerformanceData_IntValue]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[PerformanceData] ADD  CONSTRAINT [DF_PerformanceData_IntValue]  DEFAULT ((0)) FOR [IntValue]
GO
/****** Object:  Default [DF_PerformanceData_Changelist]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[PerformanceData] ADD  CONSTRAINT [DF_PerformanceData_Changelist]  DEFAULT ((0)) FOR [Changelist]
GO
/****** Object:  Default [DF_Subscriptions_Type]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Subscriptions] ADD  CONSTRAINT [DF_Subscriptions_Type]  DEFAULT ((0)) FOR [Type]
GO
/****** Object:  Default [DF_Variables_BranchConfigID]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Variables] ADD  CONSTRAINT [DF_Variables_BranchConfigID]  DEFAULT ((0)) FOR [BranchConfigID]
GO
/****** Object:  Default [DF_Versioning_EngineVersion]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Versioning] ADD  CONSTRAINT [DF_Versioning_EngineVersion]  DEFAULT ((0)) FOR [EngineVersion]
GO
/****** Object:  Default [DF_Versioning_Changelist]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Versioning] ADD  CONSTRAINT [DF_Versioning_Changelist]  DEFAULT ((0)) FOR [Changelist]
GO
/****** Object:  ForeignKey [FK_BranchConfig_BranchConfig]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[BranchConfig]  WITH CHECK ADD  CONSTRAINT [FK_BranchConfig_BranchConfig] FOREIGN KEY([ID])
REFERENCES [dbo].[BranchConfig] ([ID])
GO
ALTER TABLE [dbo].[BranchConfig] CHECK CONSTRAINT [FK_BranchConfig_BranchConfig]
GO
/****** Object:  ForeignKey [FK_Changelists2_BranchConfig]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Changelists2]  WITH CHECK ADD  CONSTRAINT [FK_Changelists2_BranchConfig] FOREIGN KEY([BranchConfigID])
REFERENCES [dbo].[BranchConfig] ([ID])
GO
ALTER TABLE [dbo].[Changelists2] CHECK CONSTRAINT [FK_Changelists2_BranchConfig]
GO
/****** Object:  ForeignKey [FK_CISJobStates_Changelists]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[CISJobStates]  WITH CHECK ADD  CONSTRAINT [FK_CISJobStates_Changelists] FOREIGN KEY([ChangelistID])
REFERENCES [dbo].[Changelists2] ([ID])
GO
ALTER TABLE [dbo].[CISJobStates] CHECK CONSTRAINT [FK_CISJobStates_Changelists]
GO
/****** Object:  ForeignKey [FK_CISJobStates_CISTasks]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[CISJobStates]  WITH CHECK ADD  CONSTRAINT [FK_CISJobStates_CISTasks] FOREIGN KEY([CISTaskID])
REFERENCES [dbo].[CISTasks] ([ID])
GO
ALTER TABLE [dbo].[CISJobStates] CHECK CONSTRAINT [FK_CISJobStates_CISTasks]
GO
/****** Object:  ForeignKey [FK_Commands_BranchConfig]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Commands]  WITH CHECK ADD  CONSTRAINT [FK_Commands_BranchConfig] FOREIGN KEY([BranchConfigID])
REFERENCES [dbo].[BranchConfig] ([ID])
GO
ALTER TABLE [dbo].[Commands] CHECK CONSTRAINT [FK_Commands_BranchConfig]
GO
/****** Object:  ForeignKey [FK_Commands_Commands]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Commands]  WITH CHECK ADD  CONSTRAINT [FK_Commands_Commands] FOREIGN KEY([ID])
REFERENCES [dbo].[Commands] ([ID])
GO
ALTER TABLE [dbo].[Commands] CHECK CONSTRAINT [FK_Commands_Commands]
GO
/****** Object:  ForeignKey [FK_Jobs_BranchConfig]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Jobs]  WITH CHECK ADD  CONSTRAINT [FK_Jobs_BranchConfig] FOREIGN KEY([BranchConfigID])
REFERENCES [dbo].[BranchConfig] ([ID])
GO
ALTER TABLE [dbo].[Jobs] CHECK CONSTRAINT [FK_Jobs_BranchConfig]
GO
/****** Object:  ForeignKey [FK_Subscriptions_Commands]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Subscriptions]  WITH CHECK ADD  CONSTRAINT [FK_Subscriptions_Commands] FOREIGN KEY([CommandID])
REFERENCES [dbo].[Commands] ([ID])
GO
ALTER TABLE [dbo].[Subscriptions] CHECK CONSTRAINT [FK_Subscriptions_Commands]
GO
/****** Object:  ForeignKey [FK_Variables_BranchConfig]    Script Date: 02/12/2013 17:57:25 ******/
ALTER TABLE [dbo].[Variables]  WITH CHECK ADD  CONSTRAINT [FK_Variables_BranchConfig] FOREIGN KEY([BranchConfigID])
REFERENCES [dbo].[BranchConfig] ([ID])
GO
ALTER TABLE [dbo].[Variables] CHECK CONSTRAINT [FK_Variables_BranchConfig]
GO
