/*
    Seed.Lookups.sql
    Series, Affiliation, Rank and VesselClass reference data.
    Re-runnable: MERGE on natural keys (inserts new rows, updates changed rows).
*/
PRINT N'Seeding Series...';

MERGE dbo.Series AS tgt
USING (VALUES
    ('TOS', N'Star Trek: The Original Series',    CAST('1966-09-08' AS DATE), CAST('1969-06-03' AS DATE), 3, 79,   N'NBC',                   2266, 2269),
    ('TNG', N'Star Trek: The Next Generation',    '1987-09-28',               '1994-05-23',               7, 178,  N'First-run syndication', 2364, 2370),
    ('DS9', N'Star Trek: Deep Space Nine',        '1993-01-03',               '1999-06-02',               7, 176,  N'First-run syndication', 2369, 2375),
    ('VOY', N'Star Trek: Voyager',                '1995-01-16',               '2001-05-23',               7, 172,  N'UPN',                   2371, 2378),
    ('ENT', N'Star Trek: Enterprise',             '2001-09-26',               '2005-05-13',               4, 98,   N'UPN',                   2151, 2161),
    ('SNW', N'Star Trek: Strange New Worlds',     '2022-05-05',               NULL,                       3, 30,   N'Paramount+',            2259, NULL)
) AS src (Abbreviation, Name, PremiereDate, FinaleDate, SeasonCount, EpisodeCount, OriginalNetwork, SettingStartYear, SettingEndYear)
    ON tgt.Abbreviation = src.Abbreviation
WHEN MATCHED AND EXISTS (
        SELECT tgt.Name, tgt.PremiereDate, tgt.FinaleDate, tgt.SeasonCount, tgt.EpisodeCount, tgt.OriginalNetwork, tgt.SettingStartYear, tgt.SettingEndYear
        EXCEPT
        SELECT src.Name, src.PremiereDate, src.FinaleDate, src.SeasonCount, src.EpisodeCount, src.OriginalNetwork, src.SettingStartYear, src.SettingEndYear)
    THEN UPDATE SET
        Name             = src.Name,
        PremiereDate     = src.PremiereDate,
        FinaleDate       = src.FinaleDate,
        SeasonCount      = src.SeasonCount,
        EpisodeCount     = src.EpisodeCount,
        OriginalNetwork  = src.OriginalNetwork,
        SettingStartYear = src.SettingStartYear,
        SettingEndYear   = src.SettingEndYear
WHEN NOT MATCHED BY TARGET
    THEN INSERT (Abbreviation, Name, PremiereDate, FinaleDate, SeasonCount, EpisodeCount, OriginalNetwork, SettingStartYear, SettingEndYear)
         VALUES (src.Abbreviation, src.Name, src.PremiereDate, src.FinaleDate, src.SeasonCount, src.EpisodeCount, src.OriginalNetwork, src.SettingStartYear, src.SettingEndYear);

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
    (N'Civilian')
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
    (N'B''rel')
) AS src (Name)
    ON tgt.Name = src.Name
WHEN NOT MATCHED BY TARGET
    THEN INSERT (Name) VALUES (src.Name);
