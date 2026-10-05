/*
    Seed.Characters.sql
    Characters plus their species (CharacterSpecies). Hybrids list a secondary species.
*/
PRINT N'Seeding Character...';

DROP TABLE IF EXISTS #CharacterSource;

CREATE TABLE #CharacterSource
(
    Name              NVARCHAR(100) NOT NULL PRIMARY KEY,
    Gender            VARCHAR(10)   NOT NULL,
    HomePlanetName    NVARCHAR(100) NULL,
    AffiliationName   NVARCHAR(100) NULL,
    PrimarySpecies    NVARCHAR(100) NULL,
    SecondarySpecies  NVARCHAR(100) NULL
);

INSERT INTO #CharacterSource (Name, Gender, HomePlanetName, AffiliationName, PrimarySpecies, SecondarySpecies)
VALUES
    -- The Original Series
    (N'James T. Kirk',          'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Spock',                  'Male',   N'Vulcan',          N'Starfleet',              N'Vulcan',     N'Human'),
    (N'Leonard McCoy',          'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Montgomery Scott',       'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Nyota Uhura',            'Female', N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Hikaru Sulu',            'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Pavel Chekov',           'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Christine Chapel',       'Female', N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Janice Rand',            'Female', N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Christopher Pike',       'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Una Chin-Riley',         'Female', NULL,               N'Starfleet',              N'Illyrian',   NULL),
    (N'Joseph M''Benga',        'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Amanda Grayson',         'Female', N'Earth',           N'Civilian',               N'Human',      NULL),
    (N'Sarek',                  'Male',   N'Vulcan',          NULL,                      N'Vulcan',     NULL),
    (N'T''Pau',                 'Female', N'Vulcan',          NULL,                      N'Vulcan',     NULL),
    (N'T''Pring',               'Female', N'Vulcan',          NULL,                      N'Vulcan',     NULL),
    (N'Khan Noonien Singh',     'Male',   N'Earth',           NULL,                      N'Human',      NULL),
    (N'Harcourt Fenton Mudd',   'Male',   N'Earth',           N'Civilian',               N'Human',      NULL),
    (N'Kor',                    'Male',   N'Qo''noS',         N'Klingon Empire',         N'Klingon',    NULL),
    (N'Kang',                   'Male',   N'Qo''noS',         N'Klingon Empire',         N'Klingon',    NULL),
    (N'Koloth',                 'Male',   N'Qo''noS',         N'Klingon Empire',         N'Klingon',    NULL),
    (N'Kyle',                   'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Kevin Riley',            'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Leslie',                 'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Zefram Cochrane',        'Male',   N'Earth',           N'Civilian',               N'Human',      NULL),
    (N'Gary Mitchell',          'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Trelane',                'Male',   NULL,               NULL,                      NULL,          NULL),
    (N'Edith Keeler',           'Female', N'Earth',           N'Civilian',               N'Human',      NULL),
    (N'Cyrano Jones',           'Male',   NULL,               N'Civilian',               N'Human',      NULL),
    -- The Next Generation
    (N'Jean-Luc Picard',        'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'William Riker',          'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Thomas Riker',           'Male',   N'Earth',           N'Maquis',                 N'Human',      NULL),
    (N'Geordi La Forge',        'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Worf',                   'Male',   N'Qo''noS',         N'Starfleet',              N'Klingon',    NULL),
    (N'Beverly Crusher',        'Female', N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Deanna Troi',            'Female', N'Betazed',         N'Starfleet',              N'Betazoid',   N'Human'),
    (N'Data',                   'Male',   N'Omicron Theta',   N'Starfleet',              N'Android',    NULL),
    (N'Lore',                   'Male',   N'Omicron Theta',   NULL,                      N'Android',    NULL),
    (N'Noonien Soong',          'Male',   N'Earth',           N'Civilian',               N'Human',      NULL),
    (N'Lal',                    'Female', NULL,               N'Starfleet',              N'Android',    NULL),
    (N'Wesley Crusher',         'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Tasha Yar',              'Female', N'Turkana IV',      N'Starfleet',              N'Human',      NULL),
    (N'Sela',                   'Female', N'Romulus',         N'Romulan Star Empire',    N'Romulan',    N'Human'),
    (N'Katherine Pulaski',      'Female', N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Guinan',                 'Female', N'El-Auria',        N'Civilian',               N'El-Aurian',  NULL),
    (N'Miles O''Brien',         'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Keiko O''Brien',         'Female', N'Earth',           N'Civilian',               N'Human',      NULL),
    (N'Molly O''Brien',         'Female', NULL,               N'Civilian',               N'Human',      NULL),
    (N'Lwaxana Troi',           'Female', N'Betazed',         N'Civilian',               N'Betazoid',   NULL),
    (N'Mr. Homn',               'Male',   N'Betazed',         N'Civilian',               NULL,          NULL),
    (N'Q',                      'Male',   NULL,               N'Q Continuum',            N'Q',          NULL),
    (N'Reginald Barclay',       'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Ro Laren',               'Female', N'Bajor',           N'Maquis',                 N'Bajoran',    NULL),
    (N'Gowron',                 'Male',   N'Qo''noS',         N'Klingon Empire',         N'Klingon',    NULL),
    (N'Kurn',                   'Male',   N'Qo''noS',         N'Klingon Empire',         N'Klingon',    NULL),
    (N'K''Ehleyr',              'Female', NULL,               N'Klingon Empire',         N'Klingon',    N'Human'),
    (N'Alexander Rozhenko',     'Male',   NULL,               N'Klingon Empire',         N'Klingon',    N'Human'),
    (N'Lursa',                  'Female', N'Qo''noS',         N'Klingon Empire',         N'Klingon',    NULL),
    (N'B''Etor',                'Female', N'Qo''noS',         N'Klingon Empire',         N'Klingon',    NULL),
    (N'Alyssa Ogawa',           'Female', N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Robin Lefler',           'Female', N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Hugh',                   'Male',   NULL,               N'Borg Collective',        N'Borg',       NULL),
    (N'Tomalak',                'Male',   N'Romulus',         N'Romulan Star Empire',    N'Romulan',    NULL),
    (N'Elizabeth Shelby',       'Female', N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Alynna Nechayev',        'Female', N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Vash',                   'Female', N'Earth',           N'Civilian',               N'Human',      NULL),
    (N'Leah Brahms',            'Female', N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'James Moriarty',         'Male',   NULL,               NULL,                      N'Hologram',   NULL),
    (N'The Traveler',           'Male',   NULL,               NULL,                      NULL,          NULL),
    -- Deep Space Nine
    (N'Benjamin Sisko',         'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Odo',                    'Male',   NULL,               N'Bajoran Militia',        N'Changeling', NULL),
    (N'Kira Nerys',             'Female', N'Bajor',           N'Bajoran Militia',        N'Bajoran',    NULL),
    (N'Jadzia Dax',             'Female', N'Trill',           N'Starfleet',              N'Trill',      NULL),
    (N'Ezri Dax',               'Female', N'Trill',           N'Starfleet',              N'Trill',      NULL),
    (N'Julian Bashir',          'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Quark',                  'Male',   N'Ferenginar',      N'Ferengi Alliance',       N'Ferengi',    NULL),
    (N'Jake Sisko',             'Male',   N'Earth',           N'Civilian',               N'Human',      NULL),
    (N'Rom',                    'Male',   N'Ferenginar',      N'Ferengi Alliance',       N'Ferengi',    NULL),
    (N'Nog',                    'Male',   N'Ferenginar',      N'Starfleet',              N'Ferengi',    NULL),
    (N'Elim Garak',             'Male',   N'Cardassia Prime', N'Cardassian Union',       N'Cardassian', NULL),
    (N'Dukat',                  'Male',   N'Cardassia Prime', N'Cardassian Union',       N'Cardassian', NULL),
    (N'Tora Ziyal',             'Female', N'Cardassia Prime', N'Civilian',               N'Cardassian', N'Bajoran'),
    (N'Leeta',                  'Female', N'Bajor',           N'Civilian',               N'Bajoran',    NULL),
    (N'Winn Adami',             'Female', N'Bajor',           N'Civilian',               N'Bajoran',    NULL),
    (N'Bareil Antos',           'Male',   N'Bajor',           N'Civilian',               N'Bajoran',    NULL),
    (N'Opaka Sulan',            'Female', N'Bajor',           N'Civilian',               N'Bajoran',    NULL),
    (N'Shakaar Edon',           'Male',   N'Bajor',           N'Civilian',               N'Bajoran',    NULL),
    (N'Weyoun',                 'Male',   NULL,               N'The Dominion',           N'Vorta',      NULL),
    (N'Female Changeling',      'Female', NULL,               N'The Dominion',           N'Changeling', NULL),
    (N'Brunt',                  'Male',   N'Ferenginar',      N'Ferengi Alliance',       N'Ferengi',    NULL),
    (N'Zek',                    'Male',   N'Ferenginar',      N'Ferengi Alliance',       N'Ferengi',    NULL),
    (N'Ishka',                  'Female', N'Ferenginar',      N'Ferengi Alliance',       N'Ferengi',    NULL),
    (N'Damar',                  'Male',   N'Cardassia Prime', N'Cardassian Union',       N'Cardassian', NULL),
    (N'Enabran Tain',           'Male',   N'Cardassia Prime', N'Cardassian Union',       N'Cardassian', NULL),
    (N'Martok',                 'Male',   N'Qo''noS',         N'Klingon Empire',         N'Klingon',    NULL),
    (N'Kasidy Yates',           'Female', N'Earth',           N'Civilian',               N'Human',      NULL),
    (N'Joseph Sisko',           'Male',   N'Earth',           N'Civilian',               N'Human',      NULL),
    (N'Jennifer Sisko',         'Female', N'Earth',           N'Civilian',               N'Human',      NULL),
    (N'Morn',                   'Male',   NULL,               N'Civilian',               N'Lurian',     NULL),
    (N'Vic Fontaine',           'Male',   NULL,               N'Civilian',               N'Hologram',   NULL),
    (N'William Ross',           'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Michael Eddington',      'Male',   N'Earth',           N'Maquis',                 N'Human',      NULL),
    (N'Luther Sloan',           'Male',   N'Earth',           N'Section 31',             N'Human',      NULL),
    (N'Mora Pol',               'Male',   N'Bajor',           N'Civilian',               N'Bajoran',    NULL),
    -- Voyager
    (N'Kathryn Janeway',        'Female', N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Chakotay',               'Male',   NULL,               N'Starfleet',              N'Human',      NULL),
    (N'B''Elanna Torres',       'Female', NULL,               N'Starfleet',              N'Klingon',    N'Human'),
    (N'Tom Paris',              'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Neelix',                 'Male',   N'Talax',           N'Civilian',               N'Talaxian',   NULL),
    (N'The Doctor',             'Male',   NULL,               N'Starfleet',              N'Hologram',   NULL),
    (N'Tuvok',                  'Male',   N'Vulcan',          N'Starfleet',              N'Vulcan',     NULL),
    (N'Kes',                    'Female', N'Ocampa',          N'Civilian',               N'Ocampa',     NULL),
    (N'Harry Kim',              'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Seven of Nine',          'Female', NULL,               N'Civilian',               N'Human',      NULL),
    (N'Seska',                  'Female', N'Cardassia Prime', N'Cardassian Union',       N'Cardassian', NULL),
    (N'Vorik',                  'Male',   N'Vulcan',          N'Starfleet',              N'Vulcan',     NULL),
    (N'Ayala',                  'Male',   NULL,               N'Starfleet',              N'Human',      NULL),
    (N'Joe Carey',              'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Lon Suder',              'Male',   N'Betazed',         N'Starfleet',              N'Betazoid',   NULL),
    (N'Michael Jonas',          'Male',   NULL,               N'Starfleet',              N'Human',      NULL),
    (N'Samantha Wildman',       'Female', N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Naomi Wildman',          'Female', NULL,               N'Civilian',               N'Human',      N'Ktarian'),
    (N'Icheb',                  'Male',   NULL,               N'Civilian',               N'Brunali',    NULL),
    (N'Borg Queen',             'Female', NULL,               N'Borg Collective',        N'Borg',       NULL),
    (N'Owen Paris',             'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Rudolph Ransom',         'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Q Junior',               'Male',   NULL,               N'Q Continuum',            N'Q',          NULL),
    -- Enterprise
    (N'Jonathan Archer',        'Male',   N'Earth',           N'United Earth Starfleet', N'Human',      NULL),
    (N'T''Pol',                 'Female', N'Vulcan',          N'United Earth Starfleet', N'Vulcan',     NULL),
    (N'Charles Tucker III',     'Male',   N'Earth',           N'United Earth Starfleet', N'Human',      NULL),
    (N'Malcolm Reed',           'Male',   N'Earth',           N'United Earth Starfleet', N'Human',      NULL),
    (N'Travis Mayweather',      'Male',   NULL,               N'United Earth Starfleet', N'Human',      NULL),
    (N'Hoshi Sato',             'Female', N'Earth',           N'United Earth Starfleet', N'Human',      NULL),
    (N'Phlox',                  'Male',   N'Denobula',        N'Civilian',               N'Denobulan',  NULL),
    (N'Maxwell Forrest',        'Male',   N'Earth',           N'United Earth Starfleet', N'Human',      NULL),
    (N'Erika Hernandez',        'Female', N'Earth',           N'United Earth Starfleet', N'Human',      NULL),
    (N'J. Hayes',               'Male',   N'Earth',           N'United Earth Starfleet', N'Human',      NULL),
    (N'Soval',                  'Male',   N'Vulcan',          N'Vulcan High Command',    N'Vulcan',     NULL),
    (N'Shran',                  'Male',   N'Andoria',         N'Andorian Imperial Guard',N'Andorian',   NULL),
    (N'Daniels',                'Male',   NULL,               N'Temporal Integrity Commission', N'Human', NULL),
    (N'Silik',                  'Male',   NULL,               N'Suliban Cabal',          N'Suliban',    NULL),
    (N'Degra',                  'Male',   NULL,               NULL,                      N'Xindi-Primate', NULL),
    (N'Dolim',                  'Male',   NULL,               NULL,                      N'Xindi-Reptilian', NULL),
    (N'Arik Soong',             'Male',   N'Earth',           N'Civilian',               N'Human',      NULL),
    (N'John Frederick Paxton',  'Male',   N'Earth',           N'Terra Prime',            N'Human',      NULL),
    -- Strange New Worlds
    (N'La''an Noonien-Singh',   'Female', NULL,               N'Starfleet',              N'Human',      NULL),
    (N'Erica Ortegas',          'Female', NULL,               N'Starfleet',              N'Human',      NULL),
    (N'Hemmer',                 'Male',   N'Andoria',         N'Starfleet',              N'Aenar',      NULL),
    (N'Pelia',                  'Female', NULL,               N'Starfleet',              N'Lanthanite', NULL),
    (N'Sam Kirk',               'Male',   N'Earth',           N'Starfleet',              N'Human',      NULL),
    (N'Marie Batel',            'Female', NULL,               N'Starfleet',              N'Human',      NULL),
    (N'Jenna Mitchell',         'Female', NULL,               N'Starfleet',              N'Human',      NULL),
    (N'Robert April',           'Male',   NULL,               N'Starfleet',              N'Human',      NULL);

IF EXISTS (SELECT 1 FROM #CharacterSource AS s WHERE s.HomePlanetName IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Planet AS p WHERE p.Name = s.HomePlanetName))
    THROW 50010, N'Seed.Characters: unknown home planet referenced.', 1;

IF EXISTS (SELECT 1 FROM #CharacterSource AS s WHERE s.AffiliationName IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Affiliation AS a WHERE a.Name = s.AffiliationName))
    THROW 50011, N'Seed.Characters: unknown affiliation referenced.', 1;

IF EXISTS (
    SELECT 1
    FROM #CharacterSource AS s
    CROSS APPLY (VALUES (s.PrimarySpecies), (s.SecondarySpecies)) AS x (SpeciesName)
    WHERE x.SpeciesName IS NOT NULL
      AND NOT EXISTS (SELECT 1 FROM dbo.Species AS sp WHERE sp.Name = x.SpeciesName))
    THROW 50012, N'Seed.Characters: unknown species referenced.', 1;

MERGE dbo.[Character] AS tgt
USING (
    SELECT s.Name, s.Gender, p.PlanetId AS HomePlanetId, a.AffiliationId
    FROM #CharacterSource AS s
    LEFT JOIN dbo.Planet AS p ON p.Name = s.HomePlanetName
    LEFT JOIN dbo.Affiliation AS a ON a.Name = s.AffiliationName
) AS src
    ON tgt.Name = src.Name
WHEN MATCHED AND EXISTS (SELECT tgt.Gender, tgt.HomePlanetId, tgt.AffiliationId EXCEPT SELECT src.Gender, src.HomePlanetId, src.AffiliationId)
    THEN UPDATE SET Gender = src.Gender, HomePlanetId = src.HomePlanetId, AffiliationId = src.AffiliationId
WHEN NOT MATCHED BY TARGET
    THEN INSERT (Name, Gender, HomePlanetId, AffiliationId) VALUES (src.Name, src.Gender, src.HomePlanetId, src.AffiliationId);

PRINT N'Seeding CharacterSpecies...';

-- Clear primary flags that are about to move so the one-primary filtered unique index is never violated mid-merge.
UPDATE cs
SET IsPrimary = 0
FROM dbo.CharacterSpecies AS cs
INNER JOIN dbo.[Character] AS c ON c.CharacterId = cs.CharacterId
INNER JOIN dbo.Species AS sp ON sp.SpeciesId = cs.SpeciesId
INNER JOIN #CharacterSource AS s ON s.Name = c.Name
WHERE cs.IsPrimary = 1
  AND sp.Name <> ISNULL(s.PrimarySpecies, N'');

MERGE dbo.CharacterSpecies AS tgt
USING (
    SELECT c.CharacterId, sp.SpeciesId, x.IsPrimary
    FROM #CharacterSource AS s
    CROSS APPLY (VALUES (s.PrimarySpecies, CAST(1 AS BIT)), (s.SecondarySpecies, CAST(0 AS BIT))) AS x (SpeciesName, IsPrimary)
    INNER JOIN dbo.[Character] AS c ON c.Name = s.Name
    INNER JOIN dbo.Species AS sp ON sp.Name = x.SpeciesName
) AS src
    ON tgt.CharacterId = src.CharacterId AND tgt.SpeciesId = src.SpeciesId
WHEN MATCHED AND tgt.IsPrimary <> src.IsPrimary
    THEN UPDATE SET IsPrimary = src.IsPrimary
WHEN NOT MATCHED BY TARGET
    THEN INSERT (CharacterId, SpeciesId, IsPrimary) VALUES (src.CharacterId, src.SpeciesId, src.IsPrimary);

DROP TABLE #CharacterSource;
