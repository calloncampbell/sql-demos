CREATE TABLE dbo.[Rank]
(
    RankId     INT IDENTITY(1, 1) NOT NULL,
    Name       NVARCHAR(50)       NOT NULL,
    SortOrder  SMALLINT           NOT NULL,
    CreatedAt  DATETIME2(0)       NOT NULL CONSTRAINT DF_Rank_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_Rank PRIMARY KEY CLUSTERED (RankId),
    CONSTRAINT UQ_Rank_Name UNIQUE (Name),
    CONSTRAINT CK_Rank_SortOrder CHECK (SortOrder > 0)
);
