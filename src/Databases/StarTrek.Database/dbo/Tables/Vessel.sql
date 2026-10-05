CREATE TABLE dbo.Vessel
(
    VesselId       INT IDENTITY(1, 1) NOT NULL,
    Name           NVARCHAR(100)      NOT NULL,
    Registry       VARCHAR(20)        NULL,
    VesselType     VARCHAR(15)        NOT NULL,
    VesselClassId  INT                NULL,
    AffiliationId  INT                NOT NULL,
    LaunchYear     SMALLINT           NULL,
    [Status]       VARCHAR(15)        NOT NULL CONSTRAINT DF_Vessel_Status DEFAULT ('Active'),
    -- Natural key used by seed scripts: registry when known, otherwise the name.
    VesselKey      AS (ISNULL(CAST(Registry AS NVARCHAR(100)), Name)) PERSISTED NOT NULL,
    CreatedAt      DATETIME2(0)       NOT NULL CONSTRAINT DF_Vessel_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_Vessel PRIMARY KEY CLUSTERED (VesselId),
    CONSTRAINT UQ_Vessel_VesselKey UNIQUE (VesselKey),
    CONSTRAINT CK_Vessel_VesselType CHECK (VesselType IN ('Starship', 'Station', 'Runabout', 'Shuttlecraft')),
    CONSTRAINT CK_Vessel_Status CHECK ([Status] IN ('Active', 'Destroyed', 'Decommissioned', 'Missing', 'Unknown')),
    CONSTRAINT FK_Vessel_VesselClass FOREIGN KEY (VesselClassId) REFERENCES dbo.VesselClass (VesselClassId),
    CONSTRAINT FK_Vessel_Affiliation FOREIGN KEY (AffiliationId) REFERENCES dbo.Affiliation (AffiliationId)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX UX_Vessel_Registry
    ON dbo.Vessel (Registry)
    WHERE Registry IS NOT NULL;
GO

CREATE NONCLUSTERED INDEX IX_Vessel_VesselClassId
    ON dbo.Vessel (VesselClassId);
GO

CREATE NONCLUSTERED INDEX IX_Vessel_AffiliationId
    ON dbo.Vessel (AffiliationId);
GO

CREATE NONCLUSTERED INDEX IX_Vessel_Name
    ON dbo.Vessel (Name)
    INCLUDE (Registry, VesselType);
