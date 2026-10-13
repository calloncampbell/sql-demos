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
    VesselKey      NVARCHAR(120) NOT NULL,
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
    (N'J. Hayes',             N'NX-01',        'ENT', N'MACO Commander',               N'Major'),

    -- DIS: USS Shenzhou NCC-1227 and USS Discovery NCC-1031
    (N'Philippa Georgiou',    N'NCC-1227',     'DIS', N'Commanding Officer',           N'Captain'),
    (N'Michael Burnham',      N'NCC-1227',     'DIS', N'First Officer',                N'Lieutenant Commander'),
    (N'Saru',                 N'NCC-1227',     'DIS', N'Science Officer',              N'Lieutenant'),
    (N'Gabriel Lorca (Mirror)', N'NCC-1031',   'DIS', N'Commanding Officer',           N'Captain'),
    (N'Christopher Pike',     N'NCC-1031',     'DIS', N'Commanding Officer',           N'Captain'),
    (N'Michael Burnham',      N'NCC-1031',     'DIS', N'Commanding Officer',           N'Captain'),
    (N'Saru',                 N'NCC-1031',     'DIS', N'First Officer',                N'Commander'),
    (N'Rayner',               N'NCC-1031',     'DIS', N'First Officer',                N'Commander'),
    (N'Paul Stamets',         N'NCC-1031',     'DIS', N'Spore Drive Engineer',         N'Lieutenant Commander'),
    (N'Sylvia Tilly',         N'NCC-1031',     'DIS', N'Engineer',                     N'Ensign'),
    (N'Hugh Culber',          N'NCC-1031',     'DIS', N'Chief Medical Officer',        N'Lieutenant Commander'),
    (N'Ash Tyler',            N'NCC-1031',     'DIS', N'Chief of Security',            N'Lieutenant'),
    (N'Jett Reno',            N'NCC-1031',     'DIS', N'Engineer',                     N'Lieutenant Commander'),
    (N'Keyla Detmer',         N'NCC-1031',     'DIS', N'Helmsman',                     N'Lieutenant'),
    (N'Joann Owosekun',       N'NCC-1031',     'DIS', N'Operations Officer',           N'Lieutenant'),
    (N'Airiam',               N'NCC-1031',     'DIS', N'Science Officer',              N'Lieutenant Commander'),
    (N'Adira Tal',            N'NCC-1031',     'DIS', N'Engineer',                     N'Ensign'),
    (N'Spock',                N'NCC-1701',     'DIS', N'Science Officer',              N'Lieutenant'),
    (N'Una Chin-Riley',       N'NCC-1701',     'DIS', N'First Officer',                N'Lieutenant Commander'),

    -- PIC: La Sirena, USS Stargazer NCC-82893, USS Titan-A, USS Enterprise-G, restored Enterprise-D
    (N'Cristóbal Rios',       N'La Sirena',    'PIC', N'Captain',                      NULL),
    (N'Cristóbal Rios',       N'NCC-82893',    'PIC', N'Commanding Officer',           N'Captain'),
    (N'Liam Shaw',            N'NCC-80102-A',  'PIC', N'Commanding Officer',           N'Captain'),
    (N'Seven of Nine',        N'NCC-80102-A',  'PIC', N'First Officer',                N'Commander'),
    (N'Sidney La Forge',      N'NCC-80102-A',  'PIC', N'Helmsman',                     N'Ensign'),
    (N'Seven of Nine',        N'NCC-1701-G',   'PIC', N'Commanding Officer',           N'Captain'),
    (N'Raffi Musiker',        N'NCC-1701-G',   'PIC', N'First Officer',                N'Commander'),
    (N'Jack Crusher',         N'NCC-1701-G',   'PIC', N'Special Counselor to the Captain', N'Ensign'),
    (N'Jean-Luc Picard',      N'NCC-1701-D',   'PIC', N'Commanding Officer',           N'Admiral'),
    (N'William Riker',        N'NCC-1701-D',   'PIC', N'First Officer',                N'Captain'),
    (N'Geordi La Forge',      N'NCC-1701-D',   'PIC', N'Chief Engineer',               N'Commodore'),
    (N'Worf',                 N'NCC-1701-D',   'PIC', N'Tactical Officer',             NULL),
    (N'Beverly Crusher',      N'NCC-1701-D',   'PIC', N'Chief Medical Officer',        NULL),
    (N'Deanna Troi',          N'NCC-1701-D',   'PIC', N'Counselor',                    N'Commander'),
    (N'Data',                 N'NCC-1701-D',   'PIC', N'Operations Officer',           NULL),

    -- LD: USS Cerritos NCC-75567 (and the Titan)
    (N'Carol Freeman',        N'NCC-75567',    'LD',  N'Commanding Officer',           N'Captain'),
    (N'Jack Ransom',          N'NCC-75567',    'LD',  N'First Officer',                N'Commander'),
    (N'Shaxs',                N'NCC-75567',    'LD',  N'Chief of Security',            N'Lieutenant'),
    (N'T''Ana',               N'NCC-75567',    'LD',  N'Chief Medical Officer',        N'Lieutenant Commander'),
    (N'Andy Billups',         N'NCC-75567',    'LD',  N'Chief Engineer',               N'Lieutenant Commander'),
    (N'Beckett Mariner',      N'NCC-75567',    'LD',  N'Lower Decks Crew',             N'Ensign'),
    (N'Brad Boimler',         N'NCC-75567',    'LD',  N'Lower Decks Crew',             N'Ensign'),
    (N'D''Vana Tendi',        N'NCC-75567',    'LD',  N'Medical / Science',            N'Ensign'),
    (N'Sam Rutherford',       N'NCC-75567',    'LD',  N'Engineer',                     N'Ensign'),
    (N'Brad Boimler',         N'NCC-80102',    'LD',  N'Bridge Officer',               N'Lieutenant Junior Grade'),
    (N'William Riker',        N'NCC-80102',    'LD',  N'Commanding Officer',           N'Captain'),

    -- SFA: USS Athena (Starfleet Academy's ship-campus). Low confidence on positions.
    (N'Nahla Ake',            N'USS Athena',   'SFA', N'Chancellor / Commanding Officer', N'Captain'),
    (N'The Doctor',           N'USS Athena',   'SFA', N'Instructor',                   NULL),
    (N'Caleb Mir',            N'USS Athena',   'SFA', N'Cadet',                        N'Cadet'),
    (N'Jay-Den Kraag',        N'USS Athena',   'SFA', N'Cadet',                        N'Cadet'),
    (N'Genesis Lythe',        N'USS Athena',   'SFA', N'Cadet',                        N'Cadet'),
    (N'Darem Reymi',          N'USS Athena',   'SFA', N'Cadet',                        N'Cadet'),
    (N'Tarima Sadal',         N'USS Athena',   'SFA', N'Cadet',                        N'Cadet'),

    -- TOS-era films
    (N'James T. Kirk',        N'NCC-1701',     'TMP', N'Commanding Officer',           N'Admiral'),
    (N'Willard Decker',       N'NCC-1701',     'TMP', N'First Officer',                N'Commander'),
    (N'Ilia',                 N'NCC-1701',     'TMP', N'Navigator',                    N'Lieutenant'),
    (N'Spock',                N'NCC-1701',     'TMP', N'Science Officer',              N'Commander'),
    (N'Leonard McCoy',        N'NCC-1701',     'TMP', N'Chief Medical Officer',        N'Lieutenant Commander'),
    (N'Montgomery Scott',     N'NCC-1701',     'TMP', N'Chief Engineer',               N'Commander'),
    (N'Nyota Uhura',          N'NCC-1701',     'TMP', N'Communications Officer',       N'Lieutenant Commander'),
    (N'Hikaru Sulu',          N'NCC-1701',     'TMP', N'Helmsman',                     N'Lieutenant Commander'),
    (N'Pavel Chekov',         N'NCC-1701',     'TMP', N'Tactical Officer',             N'Lieutenant'),
    (N'Spock',                N'NCC-1701',     'TWOK', N'Commanding Officer',          N'Captain'),
    (N'James T. Kirk',        N'NCC-1701',     'TWOK', N'Commanding Officer',          N'Admiral'),
    (N'Saavik',               N'NCC-1701',     'TWOK', N'Navigator',                   N'Lieutenant'),
    (N'Pavel Chekov',         N'NCC-1864',     'TWOK', N'First Officer',               N'Commander'),
    (N'James T. Kirk',        N'NCC-1701',     'TSFS', N'Commanding Officer',          N'Admiral'),
    (N'James T. Kirk',        N'HMS Bounty',   'TVH',  N'Commanding Officer',          N'Admiral'),
    (N'Hikaru Sulu',          N'HMS Bounty',   'TVH',  N'Helmsman',                    N'Commander'),
    (N'James T. Kirk',        N'NCC-1701-A',   'TFF',  N'Commanding Officer',          N'Captain'),
    (N'James T. Kirk',        N'NCC-1701-A',   'TUC',  N'Commanding Officer',          N'Captain'),
    (N'Spock',                N'NCC-1701-A',   'TUC',  N'Science Officer',             N'Captain'),
    (N'Leonard McCoy',        N'NCC-1701-A',   'TUC',  N'Chief Medical Officer',       N'Commander'),
    (N'Montgomery Scott',     N'NCC-1701-A',   'TUC',  N'Chief Engineer',              N'Captain'),
    (N'Nyota Uhura',          N'NCC-1701-A',   'TUC',  N'Communications Officer',      N'Commander'),
    (N'Pavel Chekov',         N'NCC-1701-A',   'TUC',  N'Navigator',                   N'Commander'),
    (N'Valeris',              N'NCC-1701-A',   'TUC',  N'Helmsman',                    N'Lieutenant'),
    (N'Hikaru Sulu',          N'NCC-2000',     'TUC',  N'Commanding Officer',          N'Captain'),

    -- TNG-era films
    (N'John Harriman',        N'NCC-1701-B',   'GEN',  N'Commanding Officer',          N'Captain'),
    (N'Jean-Luc Picard',      N'NCC-1701-D',   'GEN',  N'Commanding Officer',          N'Captain'),
    (N'William Riker',        N'NCC-1701-D',   'GEN',  N'First Officer',               N'Commander'),
    (N'Data',                 N'NCC-1701-D',   'GEN',  N'Second Officer',              N'Lieutenant Commander'),
    (N'Geordi La Forge',      N'NCC-1701-D',   'GEN',  N'Chief Engineer',              N'Lieutenant Commander'),
    (N'Worf',                 N'NCC-1701-D',   'GEN',  N'Chief of Security',           N'Lieutenant Commander'),
    (N'Beverly Crusher',      N'NCC-1701-D',   'GEN',  N'Chief Medical Officer',       N'Commander'),
    (N'Deanna Troi',          N'NCC-1701-D',   'GEN',  N'Counselor',                   N'Commander'),
    (N'Jean-Luc Picard',      N'NCC-1701-E',   'FC',   N'Commanding Officer',          N'Captain'),
    (N'William Riker',        N'NCC-1701-E',   'FC',   N'First Officer',               N'Commander'),
    (N'Data',                 N'NCC-1701-E',   'FC',   N'Second Officer',              N'Lieutenant Commander'),
    (N'Geordi La Forge',      N'NCC-1701-E',   'FC',   N'Chief Engineer',              N'Lieutenant Commander'),
    (N'Beverly Crusher',      N'NCC-1701-E',   'FC',   N'Chief Medical Officer',       N'Commander'),
    (N'Deanna Troi',          N'NCC-1701-E',   'FC',   N'Counselor',                   N'Commander'),
    (N'Worf',                 N'NX-74205',     'FC',   N'Commanding Officer',          N'Lieutenant Commander'),
    (N'Jean-Luc Picard',      N'NCC-1701-E',   'INS',  N'Commanding Officer',          N'Captain'),
    (N'William Riker',        N'NCC-1701-E',   'INS',  N'First Officer',               N'Commander'),
    (N'Data',                 N'NCC-1701-E',   'INS',  N'Second Officer',              N'Lieutenant Commander'),
    (N'Geordi La Forge',      N'NCC-1701-E',   'INS',  N'Chief Engineer',              N'Lieutenant Commander'),
    (N'Worf',                 N'NCC-1701-E',   'INS',  N'Tactical Officer',            N'Lieutenant Commander'),
    (N'Beverly Crusher',      N'NCC-1701-E',   'INS',  N'Chief Medical Officer',       N'Commander'),
    (N'Deanna Troi',          N'NCC-1701-E',   'INS',  N'Counselor',                   N'Commander'),
    (N'Jean-Luc Picard',      N'NCC-1701-E',   'NEM',  N'Commanding Officer',          N'Captain'),
    (N'William Riker',        N'NCC-1701-E',   'NEM',  N'First Officer',               N'Commander'),
    (N'Data',                 N'NCC-1701-E',   'NEM',  N'Second Officer',              N'Lieutenant Commander'),
    (N'Geordi La Forge',      N'NCC-1701-E',   'NEM',  N'Chief Engineer',              N'Lieutenant Commander'),
    (N'Worf',                 N'NCC-1701-E',   'NEM',  N'Tactical Officer',            N'Lieutenant Commander'),
    (N'Beverly Crusher',      N'NCC-1701-E',   'NEM',  N'Chief Medical Officer',       N'Commander'),
    (N'Deanna Troi',          N'NCC-1701-E',   'NEM',  N'Counselor',                   N'Commander'),

    -- Kelvin timeline films: vessel keys carry the " (Kelvin)" suffix
    (N'George Kirk',          N'NCC-0514 (Kelvin)', 'ST09', N'First Officer',          N'Lieutenant Commander'),
    (N'Christopher Pike',     N'NCC-1701 (Kelvin)', 'ST09', N'Commanding Officer',     N'Captain'),
    (N'Spock',                N'NCC-1701 (Kelvin)', 'ST09', N'First Officer',          N'Commander'),
    (N'James T. Kirk',        N'NCC-1701 (Kelvin)', 'ST09', N'Commanding Officer',     N'Captain'),
    (N'Leonard McCoy',        N'NCC-1701 (Kelvin)', 'ST09', N'Chief Medical Officer',  NULL),
    (N'Montgomery Scott',     N'NCC-1701 (Kelvin)', 'ST09', N'Chief Engineer',         NULL),
    (N'Nyota Uhura',          N'NCC-1701 (Kelvin)', 'ST09', N'Communications Officer', N'Cadet'),
    (N'Hikaru Sulu',          N'NCC-1701 (Kelvin)', 'ST09', N'Helmsman',               N'Lieutenant'),
    (N'Pavel Chekov',         N'NCC-1701 (Kelvin)', 'ST09', N'Navigator',              N'Ensign'),
    (N'James T. Kirk',        N'NCC-1701 (Kelvin)', 'STID', N'Commanding Officer',     N'Captain'),
    (N'Spock',                N'NCC-1701 (Kelvin)', 'STID', N'First Officer',          N'Commander'),
    (N'Leonard McCoy',        N'NCC-1701 (Kelvin)', 'STID', N'Chief Medical Officer',  NULL),
    (N'Montgomery Scott',     N'NCC-1701 (Kelvin)', 'STID', N'Chief Engineer',         NULL),
    (N'Nyota Uhura',          N'NCC-1701 (Kelvin)', 'STID', N'Communications Officer', N'Lieutenant'),
    (N'Hikaru Sulu',          N'NCC-1701 (Kelvin)', 'STID', N'Helmsman',               N'Lieutenant'),
    (N'Pavel Chekov',         N'NCC-1701 (Kelvin)', 'STID', N'Navigator',              N'Ensign'),
    (N'Carol Marcus',         N'NCC-1701 (Kelvin)', 'STID', N'Science Officer',        N'Lieutenant'),
    (N'Alexander Marcus',     N'USS Vengeance (Kelvin)', 'STID', N'Commanding Officer', N'Admiral'),
    (N'James T. Kirk',        N'NCC-1701 (Kelvin)', 'STB',  N'Commanding Officer',     N'Captain'),
    (N'Spock',                N'NCC-1701 (Kelvin)', 'STB',  N'First Officer',          N'Commander'),
    (N'Leonard McCoy',        N'NCC-1701 (Kelvin)', 'STB',  N'Chief Medical Officer',  NULL),
    (N'Montgomery Scott',     N'NCC-1701 (Kelvin)', 'STB',  N'Chief Engineer',         NULL),
    (N'Nyota Uhura',          N'NCC-1701 (Kelvin)', 'STB',  N'Communications Officer', N'Lieutenant'),
    (N'Hikaru Sulu',          N'NCC-1701 (Kelvin)', 'STB',  N'Helmsman',               N'Lieutenant'),
    (N'Pavel Chekov',         N'NCC-1701 (Kelvin)', 'STB',  N'Navigator',              N'Ensign');

-- A posting's vessel must exist in the production's timeline (Kelvin films use Kelvin ships).
IF EXISTS (
    SELECT 1
    FROM #AssignmentSource AS s
    INNER JOIN dbo.Vessel AS v ON v.VesselKey = s.VesselKey
    INNER JOIN dbo.Series AS sr ON sr.Abbreviation = s.SeriesAbbr
    WHERE v.TimelineId <> sr.TimelineId)
BEGIN
    SELECT s.CharacterName, s.VesselKey, s.SeriesAbbr
    FROM #AssignmentSource AS s
    INNER JOIN dbo.Vessel AS v ON v.VesselKey = s.VesselKey
    INNER JOIN dbo.Series AS sr ON sr.Abbreviation = s.SeriesAbbr
    WHERE v.TimelineId <> sr.TimelineId;
    THROW 50034, N'Seed.Assignments: vessel timeline does not match the production timeline (see result set above).', 1;
END;

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
