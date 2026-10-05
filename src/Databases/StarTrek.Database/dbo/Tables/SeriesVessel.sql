CREATE TABLE dbo.SeriesVessel
(
    SeriesId   INT          NOT NULL,
    VesselId   INT          NOT NULL,
    IsPrimary  BIT          NOT NULL CONSTRAINT DF_SeriesVessel_IsPrimary DEFAULT (0),
    CreatedAt  DATETIME2(0) NOT NULL CONSTRAINT DF_SeriesVessel_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_SeriesVessel PRIMARY KEY CLUSTERED (SeriesId, VesselId),
    CONSTRAINT FK_SeriesVessel_Series FOREIGN KEY (SeriesId) REFERENCES dbo.Series (SeriesId),
    CONSTRAINT FK_SeriesVessel_Vessel FOREIGN KEY (VesselId) REFERENCES dbo.Vessel (VesselId)
);
GO

CREATE NONCLUSTERED INDEX IX_SeriesVessel_VesselId
    ON dbo.SeriesVessel (VesselId);
GO

-- Each series has at most one primary ship/station.
CREATE UNIQUE NONCLUSTERED INDEX UX_SeriesVessel_OnePrimary
    ON dbo.SeriesVessel (SeriesId)
    WHERE IsPrimary = 1;
