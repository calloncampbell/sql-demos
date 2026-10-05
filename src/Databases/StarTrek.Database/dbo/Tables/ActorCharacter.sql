-- Many-to-many: one actor can play several characters (Brent Spiner: Data, Lore, Noonien Soong)
-- and one character can be played by several actors (Spock: Leonard Nimoy, Ethan Peck).
CREATE TABLE dbo.ActorCharacter
(
    ActorCharacterId  INT IDENTITY(1, 1) NOT NULL,
    ActorId           INT                NOT NULL,
    CharacterId       INT                NOT NULL,
    Notes             NVARCHAR(200)      NULL,
    CreatedAt         DATETIME2(0)       NOT NULL CONSTRAINT DF_ActorCharacter_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_ActorCharacter PRIMARY KEY CLUSTERED (ActorCharacterId),
    CONSTRAINT UQ_ActorCharacter_Actor_Character UNIQUE (ActorId, CharacterId),
    CONSTRAINT FK_ActorCharacter_Actor FOREIGN KEY (ActorId) REFERENCES dbo.Actor (ActorId),
    CONSTRAINT FK_ActorCharacter_Character FOREIGN KEY (CharacterId) REFERENCES dbo.[Character] (CharacterId)
);
GO

CREATE NONCLUSTERED INDEX IX_ActorCharacter_CharacterId
    ON dbo.ActorCharacter (CharacterId)
    INCLUDE (ActorId);
