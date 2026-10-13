CREATE TABLE dbo.Vessel
(
    VesselId             INT IDENTITY(1, 1) NOT NULL,
    Name                 NVARCHAR(100)      NOT NULL,
    Registry             VARCHAR(20)        NULL,
    VesselType           VARCHAR(15)        NOT NULL,
    VesselClassId        INT                NULL,
    AffiliationId        INT                NOT NULL,
    LaunchYear           SMALLINT           NULL,
    [Status]             VARCHAR(15)        NOT NULL CONSTRAINT DF_Vessel_Status DEFAULT ('Active'),
    CreatedAt            DATETIME2(0)       NOT NULL CONSTRAINT DF_Vessel_CreatedAt DEFAULT (SYSUTCDATETIME()),
    TimelineId           TINYINT            NOT NULL CONSTRAINT DF_Vessel_TimelineId DEFAULT (1),
    -- The vessel this one was renamed/re-registered from (e.g. Titan-A -> Enterprise-G).
    RenamedFromVesselId  INT                NULL,
    -- Natural key used by seed scripts: registry when known, otherwise the name.
    -- Non-Prime timelines get a suffix so the same registry can exist in more than one timeline.
    VesselKey            AS (CAST(ISNULL(CAST(Registry AS NVARCHAR(100)), Name)
                              + CASE TimelineId WHEN 1 THEN N'' WHEN 2 THEN N' (Kelvin)' WHEN 3 THEN N' (Mirror)'
                                                ELSE N' (Timeline ' + CAST(TimelineId AS NVARCHAR(3)) + N')' END
                              AS NVARCHAR(120))) PERSISTED NOT NULL,

    CONSTRAINT PK_Vessel PRIMARY KEY CLUSTERED (VesselId),
    CONSTRAINT UQ_Vessel_VesselKey UNIQUE (VesselKey),
    CONSTRAINT CK_Vessel_VesselType CHECK (VesselType IN ('Starship', 'Station', 'Runabout', 'Shuttlecraft')),
    CONSTRAINT CK_Vessel_Status CHECK ([Status] IN ('Active', 'Destroyed', 'Decommissioned', 'Missing', 'Renamed', 'Unknown')),
    CONSTRAINT CK_Vessel_NotRenamedFromSelf CHECK (RenamedFromVesselId IS NULL OR RenamedFromVesselId <> VesselId),
    CONSTRAINT FK_Vessel_VesselClass FOREIGN KEY (VesselClassId) REFERENCES dbo.VesselClass (VesselClassId),
    CONSTRAINT FK_Vessel_Affiliation FOREIGN KEY (AffiliationId) REFERENCES dbo.Affiliation (AffiliationId),
    CONSTRAINT FK_Vessel_Timeline FOREIGN KEY (TimelineId) REFERENCES dbo.Timeline (TimelineId),
    CONSTRAINT FK_Vessel_RenamedFrom FOREIGN KEY (RenamedFromVesselId) REFERENCES dbo.Vessel (VesselId)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX UX_Vessel_Registry
    ON dbo.Vessel (Registry, TimelineId)
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
GO

CREATE NONCLUSTERED INDEX IX_Vessel_TimelineId
    ON dbo.Vessel (TimelineId);
GO

CREATE NONCLUSTERED INDEX IX_Vessel_RenamedFromVesselId
    ON dbo.Vessel (RenamedFromVesselId)
    WHERE RenamedFromVesselId IS NOT NULL;
