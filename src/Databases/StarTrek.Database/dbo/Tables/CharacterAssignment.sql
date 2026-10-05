-- Who served where: a character's posting on a ship or station, in a given series.
CREATE TABLE dbo.CharacterAssignment
(
    CharacterAssignmentId  INT IDENTITY(1, 1) NOT NULL,
    CharacterId            INT                NOT NULL,
    VesselId               INT                NOT NULL,
    SeriesId               INT                NOT NULL,
    Position               NVARCHAR(100)      NOT NULL,
    RankId                 INT                NULL,
    CreatedAt              DATETIME2(0)       NOT NULL CONSTRAINT DF_CharacterAssignment_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_CharacterAssignment PRIMARY KEY CLUSTERED (CharacterAssignmentId),
    CONSTRAINT UQ_CharacterAssignment_Character_Vessel_Series_Position UNIQUE (CharacterId, VesselId, SeriesId, Position),
    CONSTRAINT FK_CharacterAssignment_Character FOREIGN KEY (CharacterId) REFERENCES dbo.[Character] (CharacterId),
    CONSTRAINT FK_CharacterAssignment_Vessel FOREIGN KEY (VesselId) REFERENCES dbo.Vessel (VesselId),
    CONSTRAINT FK_CharacterAssignment_Series FOREIGN KEY (SeriesId) REFERENCES dbo.Series (SeriesId),
    CONSTRAINT FK_CharacterAssignment_Rank FOREIGN KEY (RankId) REFERENCES dbo.[Rank] (RankId)
);
GO

CREATE NONCLUSTERED INDEX IX_CharacterAssignment_VesselId
    ON dbo.CharacterAssignment (VesselId)
    INCLUDE (CharacterId, Position, RankId);
GO

CREATE NONCLUSTERED INDEX IX_CharacterAssignment_SeriesId
    ON dbo.CharacterAssignment (SeriesId);
GO

CREATE NONCLUSTERED INDEX IX_CharacterAssignment_RankId
    ON dbo.CharacterAssignment (RankId);
