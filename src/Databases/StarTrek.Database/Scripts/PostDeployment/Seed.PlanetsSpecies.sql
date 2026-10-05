/*
    Seed.PlanetsSpecies.sql
    Planets, then species (which reference a homeworld planet).
*/
PRINT N'Seeding Planet...';

MERGE dbo.Planet AS tgt
USING (VALUES
    (N'Earth',           'Alpha', 'M'),
    (N'Vulcan',          'Alpha', 'M'),
    (N'Andoria',         'Alpha', 'M'),
    (N'Tellar Prime',    'Alpha', 'M'),
    (N'Denobula',        NULL,    'M'),
    (N'Qo''noS',         'Beta',  'M'),
    (N'Romulus',         'Beta',  'M'),
    (N'Bajor',           'Alpha', 'M'),
    (N'Cardassia Prime', 'Alpha', 'M'),
    (N'Ferenginar',      'Alpha', 'M'),
    (N'Betazed',         'Alpha', 'M'),
    (N'Trill',           'Alpha', 'M'),
    (N'Risa',            'Alpha', 'M'),
    (N'Omicron Theta',   NULL,    NULL),
    (N'Turkana IV',      NULL,    NULL),
    (N'Ktaris',          NULL,    NULL),
    (N'El-Auria',        NULL,    NULL),
    (N'Talax',           'Delta', 'M'),
    (N'Ocampa',          'Delta', 'M')
) AS src (Name, Quadrant, PlanetClass)
    ON tgt.Name = src.Name
WHEN MATCHED AND EXISTS (SELECT tgt.Quadrant, tgt.PlanetClass EXCEPT SELECT src.Quadrant, src.PlanetClass)
    THEN UPDATE SET Quadrant = src.Quadrant, PlanetClass = src.PlanetClass
WHEN NOT MATCHED BY TARGET
    THEN INSERT (Name, Quadrant, PlanetClass) VALUES (src.Name, src.Quadrant, src.PlanetClass);

PRINT N'Seeding Species...';

DROP TABLE IF EXISTS #SpeciesSource;

CREATE TABLE #SpeciesSource
(
    Name          NVARCHAR(100) NOT NULL PRIMARY KEY,
    HomeworldName NVARCHAR(100) NULL,
    IsHumanoid    BIT           NOT NULL
);

INSERT INTO #SpeciesSource (Name, HomeworldName, IsHumanoid)
VALUES
    (N'Human',             N'Earth',           1),
    (N'Vulcan',            N'Vulcan',          1),
    (N'Andorian',          N'Andoria',         1),
    (N'Aenar',             N'Andoria',         1),
    (N'Tellarite',         N'Tellar Prime',    1),
    (N'Denobulan',         N'Denobula',        1),
    (N'Klingon',           N'Qo''noS',         1),
    (N'Romulan',           N'Romulus',         1),
    (N'Bajoran',           N'Bajor',           1),
    (N'Cardassian',        N'Cardassia Prime', 1),
    (N'Ferengi',           N'Ferenginar',      1),
    (N'Betazoid',          N'Betazed',         1),
    (N'Trill',             N'Trill',           1),
    (N'Ktarian',           N'Ktaris',          1),
    (N'El-Aurian',         N'El-Auria',        1),
    (N'Talaxian',          N'Talax',           1),
    (N'Ocampa',            N'Ocampa',          1),
    (N'Changeling',        NULL,               0),
    (N'Vorta',             NULL,               1),
    (N'Borg',              NULL,               1),
    (N'Android',           N'Omicron Theta',   1),
    (N'Hologram',          NULL,               1),
    (N'Q',                 NULL,               0),
    (N'Suliban',           NULL,               1),
    (N'Xindi-Reptilian',   NULL,               1),
    (N'Xindi-Primate',     NULL,               1),
    (N'Brunali',           NULL,               1),
    (N'Illyrian',          NULL,               1),
    (N'Lurian',            NULL,               1),
    (N'Lanthanite',        NULL,               1);

IF EXISTS (
    SELECT 1
    FROM #SpeciesSource AS s
    WHERE s.HomeworldName IS NOT NULL
      AND NOT EXISTS (SELECT 1 FROM dbo.Planet AS p WHERE p.Name = s.HomeworldName))
    THROW 50001, N'Seed.PlanetsSpecies: unknown homeworld planet referenced.', 1;

MERGE dbo.Species AS tgt
USING (
    SELECT s.Name, p.PlanetId AS HomeworldPlanetId, s.IsHumanoid
    FROM #SpeciesSource AS s
    LEFT JOIN dbo.Planet AS p ON p.Name = s.HomeworldName
) AS src
    ON tgt.Name = src.Name
WHEN MATCHED AND EXISTS (SELECT tgt.HomeworldPlanetId, tgt.IsHumanoid EXCEPT SELECT src.HomeworldPlanetId, src.IsHumanoid)
    THEN UPDATE SET HomeworldPlanetId = src.HomeworldPlanetId, IsHumanoid = src.IsHumanoid
WHEN NOT MATCHED BY TARGET
    THEN INSERT (Name, HomeworldPlanetId, IsHumanoid) VALUES (src.Name, src.HomeworldPlanetId, src.IsHumanoid);

DROP TABLE #SpeciesSource;
