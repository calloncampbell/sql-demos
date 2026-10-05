CREATE TABLE dbo.Affiliation
(
    AffiliationId  INT IDENTITY(1, 1) NOT NULL,
    Name           NVARCHAR(100)      NOT NULL,
    CreatedAt      DATETIME2(0)       NOT NULL CONSTRAINT DF_Affiliation_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_Affiliation PRIMARY KEY CLUSTERED (AffiliationId),
    CONSTRAINT UQ_Affiliation_Name UNIQUE (Name)
);
