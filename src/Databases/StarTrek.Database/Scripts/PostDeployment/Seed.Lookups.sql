/*
    Seed.Lookups.sql
    Timeline, Series (TV series and films), Affiliation, Rank and VesselClass reference data.
    Re-runnable: MERGE on natural keys (inserts new rows, updates changed rows).
*/
PRINT N'Seeding Timeline...';

-- Fixed ids (not IDENTITY) so column defaults can safely point at Prime (1).
MERGE dbo.Timeline AS tgt
USING (VALUES
    (CAST(1 AS TINYINT), N'Prime',           N'The main continuity of TOS, TNG, DS9, VOY, ENT, DIS, PIC, LD, SNW, SFA and the TOS/TNG films.'),
    (2,                  N'Kelvin',          N'Alternate reality created in 2233 when Nero''s ship destroyed the USS Kelvin (Star Trek 2009, Into Darkness, Beyond).'),
    (3,                  N'Mirror Universe', N'Parallel universe ruled by the Terran Empire.')
) AS src (TimelineId, Name, [Description])
    ON tgt.TimelineId = src.TimelineId
WHEN MATCHED AND EXISTS (SELECT tgt.Name, tgt.[Description] EXCEPT SELECT src.Name, src.[Description])
    THEN UPDATE SET Name = src.Name, [Description] = src.[Description]
WHEN NOT MATCHED BY TARGET
    THEN INSERT (TimelineId, Name, [Description]) VALUES (src.TimelineId, src.Name, src.[Description]);

PRINT N'Seeding Series...';

-- Series and films share dbo.Series. Films have no network, seasons, episodes or finale; PremiereDate is the US release date.
DROP TABLE IF EXISTS #SeriesSource;

CREATE TABLE #SeriesSource
(
    Abbreviation     VARCHAR(5)    NOT NULL PRIMARY KEY,
    Name             NVARCHAR(100) NOT NULL,
    ProductionType   VARCHAR(10)   NOT NULL,
    [Format]         VARCHAR(12)   NOT NULL,
    TimelineName     NVARCHAR(50)  NOT NULL,
    PremiereDate     DATE          NOT NULL,
    FinaleDate       DATE          NULL,
    SeasonCount      TINYINT       NULL,
    EpisodeCount     SMALLINT      NULL,
    OriginalNetwork  NVARCHAR(50)  NULL,
    SettingStartYear SMALLINT      NULL,
    SettingEndYear   SMALLINT      NULL
);

INSERT INTO #SeriesSource (Abbreviation, Name, ProductionType, [Format], TimelineName, PremiereDate, FinaleDate, SeasonCount, EpisodeCount, OriginalNetwork, SettingStartYear, SettingEndYear)
VALUES
    -- Television series
    ('TOS',  N'Star Trek: The Original Series',             'Series', 'Live-action', N'Prime',  '1966-09-08', '1969-06-03', 3,    79,   N'NBC',                   2266, 2269),
    ('TNG',  N'Star Trek: The Next Generation',             'Series', 'Live-action', N'Prime',  '1987-09-28', '1994-05-23', 7,    178,  N'First-run syndication', 2364, 2370),
    ('DS9',  N'Star Trek: Deep Space Nine',                 'Series', 'Live-action', N'Prime',  '1993-01-03', '1999-06-02', 7,    176,  N'First-run syndication', 2369, 2375),
    ('VOY',  N'Star Trek: Voyager',                         'Series', 'Live-action', N'Prime',  '1995-01-16', '2001-05-23', 7,    172,  N'UPN',                   2371, 2378),
    ('ENT',  N'Star Trek: Enterprise',                      'Series', 'Live-action', N'Prime',  '2001-09-26', '2005-05-13', 4,    98,   N'UPN',                   2151, 2161),
    ('DIS',  N'Star Trek: Discovery',                       'Series', 'Live-action', N'Prime',  '2017-09-24', '2024-05-30', 5,    65,   N'CBS All Access',        2256, 3191),
    ('PIC',  N'Star Trek: Picard',                          'Series', 'Live-action', N'Prime',  '2020-01-23', '2023-04-20', 3,    30,   N'CBS All Access',        2399, 2402),
    ('LD',   N'Star Trek: Lower Decks',                     'Series', 'Animated',    N'Prime',  '2020-08-06', '2024-12-19', 5,    50,   N'CBS All Access',        2380, NULL),
    ('SNW',  N'Star Trek: Strange New Worlds',              'Series', 'Live-action', N'Prime',  '2022-05-05', NULL,         3,    30,   N'Paramount+',            2259, NULL),
    ('SFA',  N'Star Trek: Starfleet Academy',               'Series', 'Live-action', N'Prime',  '2026-01-15', NULL,         1,    NULL, N'Paramount+',            NULL, NULL),
    -- TOS-era films
    ('TMP',  N'Star Trek: The Motion Picture',              'Film',   'Live-action', N'Prime',  '1979-12-07', NULL,         NULL, NULL, NULL,                     2273, 2273),
    ('TWOK', N'Star Trek II: The Wrath of Khan',            'Film',   'Live-action', N'Prime',  '1982-06-04', NULL,         NULL, NULL, NULL,                     2285, 2285),
    ('TSFS', N'Star Trek III: The Search for Spock',        'Film',   'Live-action', N'Prime',  '1984-06-01', NULL,         NULL, NULL, NULL,                     2285, 2285),
    ('TVH',  N'Star Trek IV: The Voyage Home',              'Film',   'Live-action', N'Prime',  '1986-11-26', NULL,         NULL, NULL, NULL,                     2286, 2286),
    ('TFF',  N'Star Trek V: The Final Frontier',            'Film',   'Live-action', N'Prime',  '1989-06-09', NULL,         NULL, NULL, NULL,                     2287, 2287),
    ('TUC',  N'Star Trek VI: The Undiscovered Country',     'Film',   'Live-action', N'Prime',  '1991-12-06', NULL,         NULL, NULL, NULL,                     2293, 2293),
    -- TNG-era films
    ('GEN',  N'Star Trek Generations',                      'Film',   'Live-action', N'Prime',  '1994-11-18', NULL,         NULL, NULL, NULL,                     2293, 2371),
    ('FC',   N'Star Trek: First Contact',                   'Film',   'Live-action', N'Prime',  '1996-11-22', NULL,         NULL, NULL, NULL,                     2063, 2373),
    ('INS',  N'Star Trek: Insurrection',                    'Film',   'Live-action', N'Prime',  '1998-12-11', NULL,         NULL, NULL, NULL,                     2375, 2375),
    ('NEM',  N'Star Trek: Nemesis',                         'Film',   'Live-action', N'Prime',  '2002-12-13', NULL,         NULL, NULL, NULL,                     2379, 2379),
    -- Kelvin timeline films
    ('ST09', N'Star Trek (2009)',                           'Film',   'Live-action', N'Kelvin', '2009-05-08', NULL,         NULL, NULL, NULL,                     2233, 2258),
    ('STID', N'Star Trek Into Darkness',                    'Film',   'Live-action', N'Kelvin', '2013-05-16', NULL,         NULL, NULL, NULL,                     2259, 2259),
    ('STB',  N'Star Trek Beyond',                           'Film',   'Live-action', N'Kelvin', '2016-07-22', NULL,         NULL, NULL, NULL,                     2263, 2263);

IF EXISTS (SELECT 1 FROM #SeriesSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.Timeline AS t WHERE t.Name = s.TimelineName))
BEGIN
    SELECT s.Abbreviation, s.TimelineName AS UnknownTimeline
    FROM #SeriesSource AS s
    WHERE NOT EXISTS (SELECT 1 FROM dbo.Timeline AS t WHERE t.Name = s.TimelineName);
    THROW 50005, N'Seed.Lookups: unknown timeline referenced by Series (see result set above).', 1;
END;

MERGE dbo.Series AS tgt
USING (
    SELECT s.Abbreviation, s.Name, s.ProductionType, s.[Format], t.TimelineId, s.PremiereDate, s.FinaleDate,
           s.SeasonCount, s.EpisodeCount, s.OriginalNetwork, s.SettingStartYear, s.SettingEndYear
    FROM #SeriesSource AS s
    INNER JOIN dbo.Timeline AS t ON t.Name = s.TimelineName
) AS src
    ON tgt.Abbreviation = src.Abbreviation
WHEN MATCHED AND EXISTS (
        SELECT tgt.Name, tgt.ProductionType, tgt.[Format], tgt.TimelineId, tgt.PremiereDate, tgt.FinaleDate, tgt.SeasonCount, tgt.EpisodeCount, tgt.OriginalNetwork, tgt.SettingStartYear, tgt.SettingEndYear
        EXCEPT
        SELECT src.Name, src.ProductionType, src.[Format], src.TimelineId, src.PremiereDate, src.FinaleDate, src.SeasonCount, src.EpisodeCount, src.OriginalNetwork, src.SettingStartYear, src.SettingEndYear)
    THEN UPDATE SET
        Name             = src.Name,
        ProductionType   = src.ProductionType,
        [Format]         = src.[Format],
        TimelineId       = src.TimelineId,
        PremiereDate     = src.PremiereDate,
        FinaleDate       = src.FinaleDate,
        SeasonCount      = src.SeasonCount,
        EpisodeCount     = src.EpisodeCount,
        OriginalNetwork  = src.OriginalNetwork,
        SettingStartYear = src.SettingStartYear,
        SettingEndYear   = src.SettingEndYear
WHEN NOT MATCHED BY TARGET
    THEN INSERT (Abbreviation, Name, ProductionType, [Format], TimelineId, PremiereDate, FinaleDate, SeasonCount, EpisodeCount, OriginalNetwork, SettingStartYear, SettingEndYear)
         VALUES (src.Abbreviation, src.Name, src.ProductionType, src.[Format], src.TimelineId, src.PremiereDate, src.FinaleDate, src.SeasonCount, src.EpisodeCount, src.OriginalNetwork, src.SettingStartYear, src.SettingEndYear);

DROP TABLE #SeriesSource;

PRINT N'Seeding Affiliation...';

MERGE dbo.Affiliation AS tgt
USING (VALUES
    (N'Starfleet'),
    (N'United Earth Starfleet'),
    (N'Klingon Empire'),
    (N'Romulan Star Empire'),
    (N'Cardassian Union'),
    (N'Bajoran Militia'),
    (N'Ferengi Alliance'),
    (N'Vulcan High Command'),
    (N'Andorian Imperial Guard'),
    (N'The Dominion'),
    (N'Maquis'),
    (N'Borg Collective'),
    (N'Q Continuum'),
    (N'Suliban Cabal'),
    (N'Temporal Integrity Commission'),
    (N'Section 31'),
    (N'Terra Prime'),
    (N'Civilian'),
    (N'Terran Empire')
) AS src (Name)
    ON tgt.Name = src.Name
WHEN NOT MATCHED BY TARGET
    THEN INSERT (Name) VALUES (src.Name);

PRINT N'Seeding Rank...';

MERGE dbo.[Rank] AS tgt
USING (VALUES
    (N'Crewman',                  10),
    (N'Petty Officer',            20),
    (N'Chief Petty Officer',      30),
    (N'Cadet',                    40),
    (N'Ensign',                   50),
    (N'Lieutenant Junior Grade',  60),
    (N'Lieutenant',               70),
    (N'Lieutenant Commander',     80),
    (N'Major',                    82),
    (N'Sub-Commander',            85),
    (N'Commander',                90),
    (N'Colonel',                  95),
    (N'Captain',                  100),
    (N'Commodore',                110),
    (N'Rear Admiral',             120),
    (N'General',                  125),
    (N'Vice Admiral',             130),
    (N'Admiral',                  140),
    (N'Fleet Admiral',            150)
) AS src (Name, SortOrder)
    ON tgt.Name = src.Name
WHEN MATCHED AND tgt.SortOrder <> src.SortOrder
    THEN UPDATE SET SortOrder = src.SortOrder
WHEN NOT MATCHED BY TARGET
    THEN INSERT (Name, SortOrder) VALUES (src.Name, src.SortOrder);

PRINT N'Seeding VesselClass...';

MERGE dbo.VesselClass AS tgt
USING (VALUES
    (N'NX'),
    (N'Constitution'),
    (N'Constellation'),
    (N'Miranda'),
    (N'Galaxy'),
    (N'Intrepid'),
    (N'Defiant'),
    (N'Danube'),
    (N'Nor'),
    (N'B''rel'),
    (N'Walker'),
    (N'Crossfield'),
    (N'Excelsior'),
    (N'Sovereign'),
    (N'California'),
    (N'Luna'),
    (N'Constitution III')
) AS src (Name)
    ON tgt.Name = src.Name
WHEN NOT MATCHED BY TARGET
    THEN INSERT (Name) VALUES (src.Name);
