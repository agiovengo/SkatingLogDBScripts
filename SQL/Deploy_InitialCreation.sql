USE [SkatingLogDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS dbo.lkLocations
DROP TABLE IF EXISTS dbo.lkClassifications
DROP TABLE IF EXISTS dbo.lkSubclasses
DROP TABLE IF EXISTS dbo.DetailedDescription
DROP TABLE IF EXISTS dbo.SharpeningEntry
DROP TABLE IF EXISTS dbo.SkatingLogEntry

CREATE TABLE [dbo].[SkatingLogEntry](
	[EntryId] [INT] NOT NULL IDENTITY(1,1),
	[EntryDateTime] [DATETIME2](7) NOT NULL,
	[StartDateTime] [DATETIME2](7) NOT NULL,
	[StopDateTime] [DATETIME2](7) NOT NULL,
	[ClassificationId] [INT] NOT NULL,
	[SubclassId] [INT] NOT NULL,
	[LocationId] [INT] NOT NULL,
	[BasicDescription] [VARCHAR](500) NOT NULL,
	[DetailedDescription] [VARCHAR](1024) NULL,
	[FreestyleLevel] [INT] NOT NULL,
	[DanceLevel] [INT] NOT NULL,
	[TotalTimeMinutes] AS (DATEDIFF(MINUTE,[StartDateTime],[StopDateTime])) PERSISTED,
	
PRIMARY KEY CLUSTERED 
(
	[EntryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[lkClassifications](
	[Id] [INT] NOT NULL,
	[Description] [VARCHAR](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	Id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO [dbo].lkClassifications (Id, Description)
VALUES (0, 'On-Ice'),
	   (1, 'Off-Ice')

CREATE TABLE [dbo].[lkSubclasses](
	[Id] [INT] NOT NULL,
	[Description] [VARCHAR](50) NOT NULL,
	[Classification] [INT] NOT NULL
PRIMARY KEY CLUSTERED 
(
	Id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO [dbo].lkSubclasses (Id, Description, Classification)
VALUES (0, 'Dance Class', 0),
	   (1, 'Freestyle Class', 0),
	   (2, 'Public Session', 0),
	   (3, 'Freestyle Ice', 0),
	   (4, 'On-Ice Lesson', 0),
	   (5, 'Off-Ice Lesson', 1),
	   (6, 'Victory Skating Academy', 1)

CREATE TABLE [dbo].[lkLocations](
	[LocationId] [INT] NOT NULL,
	[Description] [VARCHAR](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO [dbo].[lkLocations] (LocationId, Description)
VALUES (0, 'Ice Chalet'),
	   (1, 'Cool Sports'),
	   (2, 'Home'),
	   (3, 'Lakeshore Park')

CREATE TABLE [dbo].[SharpeningEntry](
	[SharpeningEntryId] [INT] NOT NULL IDENTITY(1,1),
	[LastSharpeningDate] [DATETIME2](7) NOT NULL,
	
PRIMARY KEY CLUSTERED 
(
	[SharpeningEntryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

