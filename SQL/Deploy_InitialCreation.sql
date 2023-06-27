USE [SkatingLogDB]
GO

DROP TABLE IF EXISTS dbo.LogEntry
DROP TABLE IF EXISTS dbo.LevelState
DROP TABLE IF EXISTS dbo.SharpeningRecord
DROP TABLE IF EXISTS dbo.DetailedDescription
DROP TABLE IF EXISTS dbo.lkLocations
DROP TABLE IF EXISTS dbo.lkRecordTypes

CREATE TABLE [dbo].[lkRecordTypes](
	[Id] [INT] NOT NULL,
	[Description] [VARCHAR](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	Id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO [dbo].lkRecordTypes (Id, Description)
VALUES (0, 'Dance Class'),
	   (1, 'Freestyle Class'),
	   (2, 'Public Session'),
	   (3, 'Freestyle Ice'),
	   (4, 'Private Lesson'),
	   (5, 'Victory Skating Academy')

CREATE TABLE [dbo].[lkLocations](
	[Id] [INT] NOT NULL,
	[Description] [VARCHAR](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO [dbo].[lkLocations] (Id, Description)
VALUES (0, 'Ice Chalet'),
	   (1, 'Cool Sports'),
	   (2, 'Home'),
	   (3, 'Lakeshore Park')

CREATE TABLE [dbo].[SharpeningRecord](
	[Id] [INT] NOT NULL IDENTITY(1,1),
	[Date] [DATETIME2](7) NOT NULL,
	
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[LevelState](
	[Id] [INT] NOT NULL IDENTITY(1,1),
	[DateTime] [DATETIME2](7) NOT NULL,
	[FreestyleLevel] [VARCHAR](50) NOT NULL,
	[DanceLevel] [VARCHAR](50) NOT NULL,
	[PairsLevel] [VARCHAR](50) NOT NULL,
	
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[LogEntry](
	[Id] [INT] NOT NULL IDENTITY(1,1),
	[CreatedDateTime] [DATETIME2](7) NOT NULL,
	[StartDateTime] [DATETIME2](7) NOT NULL,
	[StopDateTime] [DATETIME2](7) NOT NULL,
	[RecordTypeId] [INT] NOT NULL,
	[LocationId] [INT] NOT NULL,
	[BasicDescription] [VARCHAR](500) NOT NULL,
	[DetailedDescription] [VARCHAR](1024) NULL,
	[LevelStateId] [INT] NOT NULL,
	[IsOnIce] [BIT] NOT NULL,
	[TotalTimeMinutes] AS (DATEDIFF(MINUTE,[StartDateTime],[StopDateTime])) PERSISTED,
	
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

FOREIGN KEY ([RecordTypeId]) REFERENCES [dbo].[lkRecordTypes]([Id]),
FOREIGN KEY ([LocationId]) REFERENCES [dbo].[lkLocations]([Id]),
FOREIGN KEY ([LevelStateId]) REFERENCES [dbo].[LevelState]([Id])
) ON [PRIMARY]
GO
