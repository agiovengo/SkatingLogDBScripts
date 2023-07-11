USE [SkatingLogDB]
GO

ALTER TABLE dbo.LogEntry
ADD Username nvarchar(50) NULL;
