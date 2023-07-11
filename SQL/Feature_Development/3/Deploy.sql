USE [SkatingLogDB]
GO

ALTER TABLE Users
ADD Role nvarchar(50) CONSTRAINT DF_Users_Role DEFAULT 'User' NOT NULL;

UPDATE Users
SET Role = 'Admin' 
WHERE Username = 'agiovengo'

