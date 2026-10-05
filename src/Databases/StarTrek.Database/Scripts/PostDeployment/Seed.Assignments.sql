/*
    Seed.Assignments.sql
    Postings of characters to ships/stations, per series. RankName is the rank most associated
    with that posting. The runabout USS Rio Grande intentionally has no crew (LEFT JOIN demos).
*/
PRINT N'Seeding CharacterAssignment...';

DROP TABLE IF EXISTS #AssignmentSource;

CREATE TABLE #AssignmentSource
(
    CharacterName  NVARCHAR(100) NOT NULL,
    VesselKey      NVARCHAR(100) NOT NULL,
    SeriesAbbr     VARCHAR(10)   NOT NULL,
    Position       NVARCHAR(100) NOT NULL,
    RankName       NVARCHAR(50)  NULL,
    PRIMARY KEY (CharacterName, VesselKey, SeriesAbbr, Position)
);

INSERT INTO #AssignmentSource (CharacterName, VesselKey, SeriesAbbr, Position, RankName)
VALUES
    -- TOS: USS Enterprise NCC-1701
    (N'James T. Kirk',        N'NCC-1701',     'TOS', N'Commanding Officer',           N'Captain'),
    (N'Spock',                N'NCC-1701',     'TOS', N'First Officer / Science Officer', N'Commander'),
    (N'Leonard McCoy',        N'NCC-1701',     'TOS', N'Chief Medical Officer',        N'Lieutenant Commander'),
    (N'Montgomery Scott',     N'NCC-1701',     'TOS', N'Chief Engineer',               N'Lieutenant Commander'),
    (N'Nyota Uhura',          N'NCC-1701',     'TOS', N'Communications Officer',       N'Lieutenant'),
    (N'Hikaru Sulu',          N'NCC-1701',     'TOS', N'Helmsman',                     N'Lieutenant'),
    (N'Pavel Chekov',         N'NCC-1701',     'TOS', N'Navigator',                    N'Ensign'),
    (N'Christine Chapel',     N'NCC-1701',     'TOS', N'Head Nurse',                   NULL),
    (N'Janice Rand',          N'NCC-1701',     'TOS', N'Captain''s Yeoman',            N'Petty Officer'),
    (N'Joseph M''Benga',      N'NCC-1701',     'TOS', N'Physician',                    N'Lieutenant'),
    (N'Kyle',                 N'NCC-1701',     'TOS', N'Transporter Chief',            N'Lieutenant'),
    (N'Kevin Riley',          N'NCC-1701',     'TOS', N'Navigator',                    N'Lieutenant'),
    (N'Leslie',               N'NCC-1701',     'TOS', N'Security Officer',             N'Crewman'),
    (N'Gary Mitchell',        N'NCC-1701',     'TOS', N'Helmsman',                     N'Lieutenant Commander'),
    (N'Christopher Pike',     N'NCC-1701',     'TOS', N'Commanding Officer',           N'Captain'),
    (N'Una Chin-Riley',       N'NCC-1701',     'TOS', N'First Officer',                N'Lieutenant Commander'),

    -- SNW: USS Enterprise NCC-1701
    (N'Christopher Pike',     N'NCC-1701',     'SNW', N'Commanding Officer',           N'Captain'),
    (N'Una Chin-Riley',       N'NCC-1701',     'SNW', N'First Officer',                N'Commander'),
    (N'Spock',                N'NCC-1701',     'SNW', N'Science Officer',              N'Lieutenant'),
    (N'La''an Noonien-Singh', N'NCC-1701',     'SNW', N'Chief of Security',            N'Lieutenant'),
    (N'Erica Ortegas',        N'NCC-1701',     'SNW', N'Helmsman',                     N'Lieutenant'),
    (N'Nyota Uhura',          N'NCC-1701',     'SNW', N'Communications Officer',       N'Cadet'),
    (N'Christine Chapel',     N'NCC-1701',     'SNW', N'Nurse',                        NULL),
    (N'Joseph M''Benga',      N'NCC-1701',     'SNW', N'Chief Medical Officer',        N'Lieutenant Commander'),
    (N'Hemmer',               N'NCC-1701',     'SNW', N'Chief Engineer',               N'Lieutenant Commander'),
    (N'Pelia',                N'NCC-1701',     'SNW', N'Chief Engineer',               N'Lieutenant Commander'),
    (N'Montgomery Scott',     N'NCC-1701',     'SNW', N'Engineer',                     N'Lieutenant'),
    (N'Sam Kirk',             N'NCC-1701',     'SNW', N'Science Officer',              N'Lieutenant'),
    (N'Jenna Mitchell',       N'NCC-1701',     'SNW', N'Navigator',                    N'Lieutenant'),

    -- TNG: USS Enterprise NCC-1701-D (plus Picard's earlier command)
    (N'Jean-Luc Picard',      N'NCC-1701-D',   'TNG', N'Commanding Officer',           N'Captain'),
    (N'Jean-Luc Picard',      N'NCC-2893',     'TNG', N'Commanding Officer',           N'Captain'),
    (N'William Riker',        N'NCC-1701-D',   'TNG', N'First Officer',                N'Commander'),
    (N'Data',                 N'NCC-1701-D',   'TNG', N'Second Officer / Operations Officer', N'Lieutenant Commander'),
    (N'Geordi La Forge',      N'NCC-1701-D',   'TNG', N'Chief Engineer',               N'Lieutenant Commander'),
    (N'Worf',                 N'NCC-1701-D',   'TNG', N'Chief of Security',            N'Lieutenant'),
    (N'Beverly Crusher',      N'NCC-1701-D',   'TNG', N'Chief Medical Officer',        N'Commander'),
    (N'Katherine Pulaski',    N'NCC-1701-D',   'TNG', N'Chief Medical Officer',        N'Commander'),
    (N'Deanna Troi',          N'NCC-1701-D',   'TNG', N'Ship''s Counselor',            N'Lieutenant Commander'),
    (N'Tasha Yar',            N'NCC-1701-D',   'TNG', N'Chief of Security',            N'Lieutenant'),
    (N'Wesley Crusher',       N'NCC-1701-D',   'TNG', N'Helm Officer',                 N'Ensign'),
    (N'Miles O''Brien',       N'NCC-1701-D',   'TNG', N'Transporter Chief',            N'Chief Petty Officer'),
    (N'Guinan',               N'NCC-1701-D',   'TNG', N'Ten Forward Bartender',        NULL),
    (N'Reginald Barclay',     N'NCC-1701-D',   'TNG', N'Systems Diagnostic Engineer',  N'Lieutenant'),
    (N'Ro Laren',             N'NCC-1701-D',   'TNG', N'Flight Controller',            N'Ensign'),
    (N'Alyssa Ogawa',         N'NCC-1701-D',   'TNG', N'Nurse',                        N'Ensign'),
    (N'Robin Lefler',         N'NCC-1701-D',   'TNG', N'Mission Specialist',           N'Ensign'),
    (N'Keiko O''Brien',       N'NCC-1701-D',   'TNG', N'Botanist',                     NULL),

    -- DS9: Deep Space 9 and its ships
    (N'Benjamin Sisko',       N'Deep Space 9', 'DS9', N'Commanding Officer',           N'Captain'),
    (N'Benjamin Sisko',       N'NCC-31911',    'DS9', N'First Officer',                N'Lieutenant Commander'),
    (N'Benjamin Sisko',       N'NX-74205',     'DS9', N'Commanding Officer',           N'Captain'),
    (N'Kira Nerys',           N'Deep Space 9', 'DS9', N'First Officer',                N'Major'),
    (N'Odo',                  N'Deep Space 9', 'DS9', N'Chief of Security',            NULL),
    (N'Jadzia Dax',           N'Deep Space 9', 'DS9', N'Science Officer',              N'Lieutenant Commander'),
    (N'Ezri Dax',             N'Deep Space 9', 'DS9', N'Counselor',                    N'Ensign'),
    (N'Julian Bashir',        N'Deep Space 9', 'DS9', N'Chief Medical Officer',        N'Lieutenant'),
    (N'Miles O''Brien',       N'Deep Space 9', 'DS9', N'Chief of Operations',          N'Chief Petty Officer'),
    (N'Miles O''Brien',       N'NX-74205',     'DS9', N'Chief Engineer',               N'Chief Petty Officer'),
    (N'Worf',                 N'Deep Space 9', 'DS9', N'Strategic Operations Officer', N'Lieutenant Commander'),
    (N'Worf',                 N'NX-74205',     'DS9', N'First Officer',                N'Lieutenant Commander'),
    (N'Worf',                 N'IKS Rotarran', 'DS9', N'First Officer',                N'Lieutenant Commander'),
    (N'Martok',               N'IKS Rotarran', 'DS9', N'Commanding Officer',           N'General'),
    (N'Quark',                N'Deep Space 9', 'DS9', N'Bar Owner',                    NULL),
    (N'Rom',                  N'Deep Space 9', 'DS9', N'Maintenance Engineer',         NULL),
    (N'Nog',                  N'Deep Space 9', 'DS9', N'Engineering Officer',          N'Ensign'),
    (N'Nog',                  N'NX-74205',     'DS9', N'Engineering Officer',          N'Ensign'),
    (N'Elim Garak',           N'Deep Space 9', 'DS9', N'Tailor',                       NULL),
    (N'Leeta',                N'Deep Space 9', 'DS9', N'Dabo Girl',                    NULL),
    (N'Morn',                 N'Deep Space 9', 'DS9', N'Patron',                       NULL),
    (N'Jake Sisko',           N'Deep Space 9', 'DS9', N'Journalist',                   NULL),
    (N'Keiko O''Brien',       N'Deep Space 9', 'DS9', N'Schoolteacher',                NULL),
    (N'Michael Eddington',    N'Deep Space 9', 'DS9', N'Starfleet Security Officer',   N'Lieutenant Commander'),

    -- VOY: USS Voyager, the Maquis Val Jean and the Delta Flyer
    (N'Kathryn Janeway',      N'NCC-74656',    'VOY', N'Commanding Officer',           N'Captain'),
    (N'Chakotay',             N'NCC-74656',    'VOY', N'First Officer',                N'Commander'),
    (N'Chakotay',             N'Val Jean',     'VOY', N'Commanding Officer',           NULL),
    (N'Tuvok',                N'NCC-74656',    'VOY', N'Chief of Security / Tactical Officer', N'Lieutenant Commander'),
    (N'Tom Paris',            N'NCC-74656',    'VOY', N'Chief Helm Officer',           N'Lieutenant'),
    (N'Tom Paris',            N'Delta Flyer',  'VOY', N'Pilot / Designer',             N'Lieutenant'),
    (N'B''Elanna Torres',     N'NCC-74656',    'VOY', N'Chief Engineer',               N'Lieutenant'),
    (N'B''Elanna Torres',     N'Val Jean',     'VOY', N'Engineer',                     NULL),
    (N'Harry Kim',            N'NCC-74656',    'VOY', N'Operations Officer',           N'Ensign'),
    (N'The Doctor',           N'NCC-74656',    'VOY', N'Chief Medical Officer',        NULL),
    (N'Neelix',               N'NCC-74656',    'VOY', N'Chef / Morale Officer',        NULL),
    (N'Kes',                  N'NCC-74656',    'VOY', N'Medical Assistant',            NULL),
    (N'Seven of Nine',        N'NCC-74656',    'VOY', N'Astrometrics Officer',         NULL),
    (N'Seska',                N'Val Jean',     'VOY', N'Crew',                         NULL),
    (N'Seska',                N'NCC-74656',    'VOY', N'Crew',                         N'Crewman'),
    (N'Ayala',                N'Val Jean',     'VOY', N'Crew',                         NULL),
    (N'Ayala',                N'NCC-74656',    'VOY', N'Security Officer',             N'Lieutenant'),
    (N'Vorik',                N'NCC-74656',    'VOY', N'Engineer',                     N'Ensign'),
    (N'Joe Carey',            N'NCC-74656',    'VOY', N'Assistant Chief Engineer',     N'Lieutenant'),
    (N'Samantha Wildman',     N'NCC-74656',    'VOY', N'Xenobiologist',                N'Ensign'),
    (N'Lon Suder',            N'NCC-74656',    'VOY', N'Engineer',                     N'Crewman'),
    (N'Michael Jonas',        N'NCC-74656',    'VOY', N'Engineer',                     N'Crewman'),

    -- ENT: Enterprise NX-01
    (N'Jonathan Archer',      N'NX-01',        'ENT', N'Commanding Officer',           N'Captain'),
    (N'T''Pol',               N'NX-01',        'ENT', N'First Officer / Science Officer', N'Sub-Commander'),
    (N'Charles Tucker III',   N'NX-01',        'ENT', N'Chief Engineer',               N'Commander'),
    (N'Malcolm Reed',         N'NX-01',        'ENT', N'Armory Officer',               N'Lieutenant'),
    (N'Travis Mayweather',    N'NX-01',        'ENT', N'Helmsman',                     N'Ensign'),
    (N'Hoshi Sato',           N'NX-01',        'ENT', N'Communications Officer',       N'Ensign'),
    (N'Phlox',                N'NX-01',        'ENT', N'Chief Medical Officer',        NULL),
    (N'J. Hayes',             N'NX-01',        'ENT', N'MACO Commander',               N'Major');

IF EXISTS (SELECT 1 FROM #AssignmentSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.[Character] AS c WHERE c.Name = s.CharacterName))
    THROW 50030, N'Seed.Assignments: unknown character referenced.', 1;

IF EXISTS (SELECT 1 FROM #AssignmentSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.Vessel AS v WHERE v.VesselKey = s.VesselKey))
    THROW 50031, N'Seed.Assignments: unknown vessel referenced.', 1;

IF EXISTS (SELECT 1 FROM #AssignmentSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.Series AS sr WHERE sr.Abbreviation = s.SeriesAbbr))
    THROW 50032, N'Seed.Assignments: unknown series referenced.', 1;

IF EXISTS (SELECT 1 FROM #AssignmentSource AS s WHERE s.RankName IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.[Rank] AS r WHERE r.Name = s.RankName))
    THROW 50033, N'Seed.Assignments: unknown rank referenced.', 1;

MERGE dbo.CharacterAssignment AS tgt
USING (
    SELECT c.CharacterId, v.VesselId, sr.SeriesId, s.Position, r.RankId
    FROM #AssignmentSource AS s
    INNER JOIN dbo.[Character] AS c ON c.Name = s.CharacterName
    INNER JOIN dbo.Vessel AS v ON v.VesselKey = s.VesselKey
    INNER JOIN dbo.Series AS sr ON sr.Abbreviation = s.SeriesAbbr
    LEFT JOIN dbo.[Rank] AS r ON r.Name = s.RankName
) AS src
    ON  tgt.CharacterId = src.CharacterId
    AND tgt.VesselId = src.VesselId
    AND tgt.SeriesId = src.SeriesId
    AND tgt.Position = src.Position
WHEN MATCHED AND EXISTS (SELECT tgt.RankId EXCEPT SELECT src.RankId)
    THEN UPDATE SET RankId = src.RankId
WHEN NOT MATCHED BY TARGET
    THEN INSERT (CharacterId, VesselId, SeriesId, Position, RankId)
         VALUES (src.CharacterId, src.VesselId, src.SeriesId, src.Position, src.RankId);

DROP TABLE #AssignmentSource;
