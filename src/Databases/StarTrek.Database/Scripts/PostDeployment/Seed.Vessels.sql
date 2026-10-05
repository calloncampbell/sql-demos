/*
    Seed.Vessels.sql
    Ships, stations and small craft, plus which series feature them (SeriesVessel).
    Vessels are identified by VesselKey = Registry, or Name when there is no registry.
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
    [Status]         VARCHAR(15)   NOT NULL
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

IF EXISTS (SELECT 1 FROM #VesselSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.Affiliation AS a WHERE a.Name = s.AffiliationName))
    THROW 50002, N'Seed.Vessels: unknown affiliation referenced.', 1;

IF EXISTS (SELECT 1 FROM #VesselSource AS s WHERE s.VesselClassName IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.VesselClass AS vc WHERE vc.Name = s.VesselClassName))
    THROW 50003, N'Seed.Vessels: unknown vessel class referenced.', 1;

MERGE dbo.Vessel AS tgt
USING (
    SELECT s.Name, s.Registry, s.VesselType, vc.VesselClassId, a.AffiliationId, s.LaunchYear, s.[Status],
           ISNULL(CAST(s.Registry AS NVARCHAR(100)), s.Name) AS VesselKey
    FROM #VesselSource AS s
    INNER JOIN dbo.Affiliation AS a ON a.Name = s.AffiliationName
    LEFT JOIN dbo.VesselClass AS vc ON vc.Name = s.VesselClassName
) AS src
    ON tgt.VesselKey = src.VesselKey
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
    THEN INSERT (Name, Registry, VesselType, VesselClassId, AffiliationId, LaunchYear, [Status])
         VALUES (src.Name, src.Registry, src.VesselType, src.VesselClassId, src.AffiliationId, src.LaunchYear, src.[Status]);

DROP TABLE #VesselSource;

PRINT N'Seeding SeriesVessel...';

DROP TABLE IF EXISTS #SeriesVesselSource;

CREATE TABLE #SeriesVesselSource
(
    SeriesAbbreviation VARCHAR(5)    NOT NULL,
    VesselKey          NVARCHAR(100) NOT NULL,
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
    ('VOY', N'Delta Flyer',    0);

IF EXISTS (
    SELECT 1
    FROM #SeriesVesselSource AS s
    WHERE NOT EXISTS (SELECT 1 FROM dbo.Series AS se WHERE se.Abbreviation = s.SeriesAbbreviation)
       OR NOT EXISTS (SELECT 1 FROM dbo.Vessel AS v WHERE v.VesselKey = s.VesselKey))
    THROW 50004, N'Seed.Vessels: unknown series or vessel referenced in SeriesVessel.', 1;

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
