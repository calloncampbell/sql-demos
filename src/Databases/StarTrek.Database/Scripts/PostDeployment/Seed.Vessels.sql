/*
    Seed.Vessels.sql
    Ships, stations and small craft, plus which series and films feature them (SeriesVessel).
    Vessels are identified by VesselKey = Registry, or Name when there is no registry,
    with a timeline suffix outside the Prime timeline (e.g. 'NCC-1701 (Kelvin)').
*/
PRINT N'Seeding Vessel...';

DROP TABLE IF EXISTS #VesselSource;

CREATE TABLE #VesselSource
(
    Name             NVARCHAR(100) NOT NULL,
    Registry         VARCHAR(20)   NULL,
    VesselType       VARCHAR(15)   NOT NULL,
    VesselClassName  NVARCHAR(50)  NULL,
    AffiliationName  NVARCHAR(100) NOT NULL,
    LaunchYear       SMALLINT      NULL,
    [Status]         VARCHAR(15)   NOT NULL,
    TimelineName     NVARCHAR(50)  NOT NULL DEFAULT (N'Prime'),
    RenamedFromKey   NVARCHAR(120) NULL
);

INSERT INTO #VesselSource (Name, Registry, VesselType, VesselClassName, AffiliationName, LaunchYear, [Status])
VALUES
    (N'Enterprise',     'NX-01',      'Starship',     N'NX',            N'United Earth Starfleet', 2151, 'Decommissioned'),
    (N'USS Enterprise', 'NCC-1701',   'Starship',     N'Constitution',  N'Starfleet',              2245, 'Destroyed'),
    (N'USS Stargazer',  'NCC-2893',   'Starship',     N'Constellation', N'Starfleet',              NULL, 'Decommissioned'),
    (N'USS Saratoga',   'NCC-31911',  'Starship',     N'Miranda',       N'Starfleet',              NULL, 'Destroyed'),
    (N'USS Enterprise', 'NCC-1701-D', 'Starship',     N'Galaxy',        N'Starfleet',              2363, 'Destroyed'),
    (N'Deep Space 9',   NULL,         'Station',      N'Nor',           N'Bajoran Militia',        NULL, 'Active'),
    (N'USS Defiant',    'NX-74205',   'Starship',     N'Defiant',       N'Starfleet',              NULL, 'Destroyed'),
    (N'USS Rio Grande', 'NCC-72452',  'Runabout',     N'Danube',        N'Starfleet',              NULL, 'Active'),
    (N'IKS Rotarran',   NULL,         'Starship',     N'B''rel',        N'Klingon Empire',         NULL, 'Active'),
    (N'USS Voyager',    'NCC-74656',  'Starship',     N'Intrepid',      N'Starfleet',              2371, 'Active'),
    (N'Val Jean',       NULL,         'Starship',     NULL,             N'Maquis',                 NULL, 'Destroyed'),
    (N'Delta Flyer',    NULL,         'Shuttlecraft', NULL,             N'Starfleet',              2375, 'Destroyed');

-- Discovery, Picard, Lower Decks, Starfleet Academy and the films.
INSERT INTO #VesselSource (Name, Registry, VesselType, VesselClassName, AffiliationName, LaunchYear, [Status], TimelineName, RenamedFromKey)
VALUES
    (N'USS Shenzhou',   'NCC-1227',     'Starship', N'Walker',           N'Starfleet',     NULL, 'Destroyed',      N'Prime',  NULL),
    (N'USS Discovery',  'NCC-1031',     'Starship', N'Crossfield',       N'Starfleet',     NULL, 'Active',         N'Prime',  NULL),
    (N'USS Reliant',    'NCC-1864',     'Starship', N'Miranda',          N'Starfleet',     NULL, 'Destroyed',      N'Prime',  NULL),
    (N'HMS Bounty',     NULL,           'Starship', N'B''rel',           N'Starfleet',     NULL, 'Destroyed',      N'Prime',  NULL),
    (N'USS Enterprise', 'NCC-1701-A',   'Starship', N'Constitution',     N'Starfleet',     2286, 'Decommissioned', N'Prime',  NULL),
    (N'USS Excelsior',  'NCC-2000',     'Starship', N'Excelsior',        N'Starfleet',     NULL, 'Unknown',        N'Prime',  NULL),
    (N'USS Enterprise', 'NCC-1701-B',   'Starship', N'Excelsior',        N'Starfleet',     2293, 'Unknown',        N'Prime',  NULL),
    (N'USS Enterprise', 'NCC-1701-E',   'Starship', N'Sovereign',        N'Starfleet',     2372, 'Unknown',        N'Prime',  NULL),
    (N'USS Titan',      'NCC-80102',    'Starship', N'Luna',             N'Starfleet',     NULL, 'Unknown',        N'Prime',  NULL),
    (N'USS Cerritos',   'NCC-75567',    'Starship', N'California',       N'Starfleet',     NULL, 'Active',         N'Prime',  NULL),
    (N'La Sirena',      NULL,           'Starship', NULL,                N'Civilian',      NULL, 'Unknown',        N'Prime',  NULL),
    (N'USS Stargazer',  'NCC-82893',    'Starship', NULL,                N'Starfleet',     NULL, 'Unknown',        N'Prime',  NULL),
    (N'USS Titan-A',    'NCC-80102-A',  'Starship', N'Constitution III', N'Starfleet',     NULL, 'Renamed',        N'Prime',  NULL),
    (N'USS Enterprise', 'NCC-1701-G',   'Starship', N'Constitution III', N'Starfleet',     2401, 'Active',         N'Prime',  N'NCC-80102-A'),
    (N'USS Athena',     NULL,           'Starship', NULL,                N'Starfleet',     NULL, 'Active',         N'Prime',  NULL),
    -- Kelvin timeline: same names and registries as Prime ships, but different vessels.
    (N'USS Kelvin',     'NCC-0514',     'Starship', NULL,                N'Starfleet',     NULL, 'Destroyed',      N'Kelvin', NULL),
    (N'USS Enterprise', 'NCC-1701',     'Starship', N'Constitution',     N'Starfleet',     2258, 'Destroyed',      N'Kelvin', NULL),
    (N'USS Enterprise', 'NCC-1701-A',   'Starship', N'Constitution',     N'Starfleet',     2263, 'Active',         N'Kelvin', NULL),
    (N'USS Vengeance',  NULL,           'Starship', NULL,                N'Section 31',    NULL, 'Destroyed',      N'Kelvin', NULL);

IF EXISTS (SELECT 1 FROM #VesselSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.Affiliation AS a WHERE a.Name = s.AffiliationName))
    THROW 50002, N'Seed.Vessels: unknown affiliation referenced.', 1;

IF EXISTS (SELECT 1 FROM #VesselSource AS s WHERE s.VesselClassName IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.VesselClass AS vc WHERE vc.Name = s.VesselClassName))
    THROW 50003, N'Seed.Vessels: unknown vessel class referenced.', 1;

IF EXISTS (SELECT 1 FROM #VesselSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.Timeline AS t WHERE t.Name = s.TimelineName))
BEGIN
    SELECT s.Name, s.Registry, s.TimelineName AS UnknownTimeline
    FROM #VesselSource AS s
    WHERE NOT EXISTS (SELECT 1 FROM dbo.Timeline AS t WHERE t.Name = s.TimelineName);
    THROW 50006, N'Seed.Vessels: unknown timeline referenced (see result set above).', 1;
END;

-- Match on registry/name within a timeline; dbo.Vessel.VesselKey adds the timeline suffix itself.
MERGE dbo.Vessel AS tgt
USING (
    SELECT s.Name, s.Registry, s.VesselType, vc.VesselClassId, a.AffiliationId, s.LaunchYear, s.[Status], t.TimelineId,
           ISNULL(CAST(s.Registry AS NVARCHAR(100)), s.Name) AS BaseKey
    FROM #VesselSource AS s
    INNER JOIN dbo.Affiliation AS a ON a.Name = s.AffiliationName
    INNER JOIN dbo.Timeline AS t ON t.Name = s.TimelineName
    LEFT JOIN dbo.VesselClass AS vc ON vc.Name = s.VesselClassName
) AS src
    ON ISNULL(CAST(tgt.Registry AS NVARCHAR(100)), tgt.Name) = src.BaseKey
   AND tgt.TimelineId = src.TimelineId
WHEN MATCHED AND EXISTS (
        SELECT tgt.Name, tgt.VesselType, tgt.VesselClassId, tgt.AffiliationId, tgt.LaunchYear, tgt.[Status]
        EXCEPT
        SELECT src.Name, src.VesselType, src.VesselClassId, src.AffiliationId, src.LaunchYear, src.[Status])
    THEN UPDATE SET
        Name          = src.Name,
        VesselType    = src.VesselType,
        VesselClassId = src.VesselClassId,
        AffiliationId = src.AffiliationId,
        LaunchYear    = src.LaunchYear,
        [Status]      = src.[Status]
WHEN NOT MATCHED BY TARGET
    THEN INSERT (Name, Registry, VesselType, VesselClassId, AffiliationId, LaunchYear, [Status], TimelineId)
         VALUES (src.Name, src.Registry, src.VesselType, src.VesselClassId, src.AffiliationId, src.LaunchYear, src.[Status], src.TimelineId);

-- Rename lineage (e.g. USS Titan-A was rechristened USS Enterprise-G). Resolved after the MERGE so both rows exist.
IF EXISTS (SELECT 1 FROM #VesselSource AS s WHERE s.RenamedFromKey IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Vessel AS v WHERE v.VesselKey = s.RenamedFromKey))
BEGIN
    SELECT s.Name, s.Registry, s.RenamedFromKey AS UnknownVesselKey
    FROM #VesselSource AS s
    WHERE s.RenamedFromKey IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Vessel AS v WHERE v.VesselKey = s.RenamedFromKey);
    THROW 50007, N'Seed.Vessels: unknown RenamedFromKey (see result set above).', 1;
END;

UPDATE v
SET RenamedFromVesselId = rf.VesselId
FROM #VesselSource AS s
INNER JOIN dbo.Timeline AS t ON t.Name = s.TimelineName
INNER JOIN dbo.Vessel AS v
    ON ISNULL(CAST(v.Registry AS NVARCHAR(100)), v.Name) = ISNULL(CAST(s.Registry AS NVARCHAR(100)), s.Name)
   AND v.TimelineId = t.TimelineId
LEFT JOIN dbo.Vessel AS rf ON rf.VesselKey = s.RenamedFromKey
WHERE EXISTS (SELECT v.RenamedFromVesselId EXCEPT SELECT rf.VesselId);

DROP TABLE #VesselSource;

PRINT N'Seeding SeriesVessel...';

DROP TABLE IF EXISTS #SeriesVesselSource;

CREATE TABLE #SeriesVesselSource
(
    SeriesAbbreviation VARCHAR(5)    NOT NULL,
    VesselKey          NVARCHAR(120) NOT NULL,
    IsPrimary          BIT           NOT NULL,
    PRIMARY KEY (SeriesAbbreviation, VesselKey)
);

INSERT INTO #SeriesVesselSource (SeriesAbbreviation, VesselKey, IsPrimary)
VALUES
    ('ENT', N'NX-01',          1),
    ('TOS', N'NCC-1701',       1),
    ('SNW', N'NCC-1701',       1),
    ('TNG', N'NCC-1701-D',     1),
    ('TNG', N'NCC-2893',       0),
    ('DS9', N'Deep Space 9',   1),
    ('DS9', N'NX-74205',       0),
    ('DS9', N'NCC-72452',      0),
    ('DS9', N'IKS Rotarran',   0),
    ('DS9', N'NCC-31911',      0),
    ('VOY', N'NCC-74656',      1),
    ('VOY', N'Val Jean',       0),
    ('VOY', N'Delta Flyer',    0),
    ('DIS', N'NCC-1031',       1),
    ('DIS', N'NCC-1227',       0),
    ('DIS', N'NCC-1701',       0),
    ('PIC', N'La Sirena',      1),
    ('PIC', N'NCC-82893',      0),
    ('PIC', N'NCC-80102-A',    0),
    ('PIC', N'NCC-1701-D',     0),
    ('PIC', N'NCC-1701-G',     0),
    ('LD',  N'NCC-75567',      1),
    ('LD',  N'NCC-80102',      0),
    ('SFA', N'USS Athena',     1),
    ('TMP', N'NCC-1701',       1),
    ('TWOK',N'NCC-1701',       1),
    ('TWOK',N'NCC-1864',       0),
    ('TSFS',N'NCC-1701',       1),
    ('TSFS',N'NCC-2000',       0),
    ('TVH', N'HMS Bounty',     1),
    ('TVH', N'NCC-1701-A',     0),
    ('TFF', N'NCC-1701-A',     1),
    ('TUC', N'NCC-1701-A',     1),
    ('TUC', N'NCC-2000',       0),
    ('GEN', N'NCC-1701-D',     1),
    ('GEN', N'NCC-1701-B',     0),
    ('FC',  N'NCC-1701-E',     1),
    ('FC',  N'NX-74205',       0),
    ('INS', N'NCC-1701-E',     1),
    ('NEM', N'NCC-1701-E',     1),
    ('ST09',N'NCC-1701 (Kelvin)',   1),
    ('ST09',N'NCC-0514 (Kelvin)',   0),
    ('STID',N'NCC-1701 (Kelvin)',   1),
    ('STID',N'USS Vengeance (Kelvin)', 0),
    ('STB', N'NCC-1701 (Kelvin)',   1),
    ('STB', N'NCC-1701-A (Kelvin)', 0);

IF EXISTS (
    SELECT 1
    FROM #SeriesVesselSource AS s
    WHERE NOT EXISTS (SELECT 1 FROM dbo.Series AS se WHERE se.Abbreviation = s.SeriesAbbreviation)
       OR NOT EXISTS (SELECT 1 FROM dbo.Vessel AS v WHERE v.VesselKey = s.VesselKey))
    THROW 50004, N'Seed.Vessels: unknown series or vessel referenced in SeriesVessel.', 1;

IF EXISTS (
    SELECT 1
    FROM #SeriesVesselSource AS s
    INNER JOIN dbo.Series AS se ON se.Abbreviation = s.SeriesAbbreviation
    INNER JOIN dbo.Vessel AS v ON v.VesselKey = s.VesselKey
    WHERE v.TimelineId <> se.TimelineId)
BEGIN
    SELECT s.SeriesAbbreviation, s.VesselKey
    FROM #SeriesVesselSource AS s
    INNER JOIN dbo.Series AS se ON se.Abbreviation = s.SeriesAbbreviation
    INNER JOIN dbo.Vessel AS v ON v.VesselKey = s.VesselKey
    WHERE v.TimelineId <> se.TimelineId;
    THROW 50008, N'Seed.Vessels: SeriesVessel links a vessel from a different timeline than the production (see result set above).', 1;
END;

-- Clear primary flags that are about to move, so UX_SeriesVessel_OnePrimary is never violated mid-MERGE.
UPDATE sv
SET IsPrimary = 0
FROM dbo.SeriesVessel AS sv
INNER JOIN dbo.Series AS se ON se.SeriesId = sv.SeriesId
INNER JOIN dbo.Vessel AS v ON v.VesselId = sv.VesselId
WHERE sv.IsPrimary = 1
  AND EXISTS (SELECT 1 FROM #SeriesVesselSource AS s
              WHERE s.SeriesAbbreviation = se.Abbreviation AND s.IsPrimary = 1 AND s.VesselKey <> v.VesselKey);

MERGE dbo.SeriesVessel AS tgt
USING (
    SELECT se.SeriesId, v.VesselId, s.IsPrimary
    FROM #SeriesVesselSource AS s
    INNER JOIN dbo.Series AS se ON se.Abbreviation = s.SeriesAbbreviation
    INNER JOIN dbo.Vessel AS v ON v.VesselKey = s.VesselKey
) AS src
    ON tgt.SeriesId = src.SeriesId AND tgt.VesselId = src.VesselId
WHEN MATCHED AND tgt.IsPrimary <> src.IsPrimary
    THEN UPDATE SET IsPrimary = src.IsPrimary
WHEN NOT MATCHED BY TARGET
    THEN INSERT (SeriesId, VesselId, IsPrimary) VALUES (src.SeriesId, src.VesselId, src.IsPrimary);

DROP TABLE #SeriesVesselSource;
