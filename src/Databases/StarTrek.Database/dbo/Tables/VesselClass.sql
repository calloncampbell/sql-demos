CREATE TABLE dbo.VesselClass
(
    VesselClassId  INT IDENTITY(1, 1) NOT NULL,
    Name           NVARCHAR(50)       NOT NULL,
    CreatedAt      DATETIME2(0)       NOT NULL CONSTRAINT DF_VesselClass_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_VesselClass PRIMARY KEY CLUSTERED (VesselClassId),
    CONSTRAINT UQ_VesselClass_Name UNIQUE (Name)
);
