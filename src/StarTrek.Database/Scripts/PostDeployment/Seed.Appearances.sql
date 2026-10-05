/*
    Seed.Appearances.sql
    Which actor played which character, in which series, and in what capacity.
    ActorCharacter rows are derived from the distinct (actor, character) pairs below.
    Season ranges are the span of appearances in that series (Main/Recurring/Guest).
*/
PRINT N'Seeding ActorCharacter and SeriesAppearance...';

DROP TABLE IF EXISTS #AppearanceSource;

CREATE TABLE #AppearanceSource
(
    ActorFullName  NVARCHAR(201) NOT NULL,
    CharacterName  NVARCHAR(100) NOT NULL,
    SeriesAbbr     VARCHAR(10)   NOT NULL,
    RoleType       VARCHAR(10)   NOT NULL,
    FirstSeason    TINYINT       NOT NULL,
    LastSeason     TINYINT       NOT NULL,
    Notes          NVARCHAR(200) NULL,
    PRIMARY KEY (ActorFullName, CharacterName, SeriesAbbr)
);

INSERT INTO #AppearanceSource (ActorFullName, CharacterName, SeriesAbbr, RoleType, FirstSeason, LastSeason, Notes)
VALUES
    -- The Original Series
    (N'William Shatner',      N'James T. Kirk',        'TOS', 'Main',      1, 3, NULL),
    (N'Leonard Nimoy',        N'Spock',                'TOS', 'Main',      1, 3, NULL),
    (N'DeForest Kelley',      N'Leonard McCoy',        'TOS', 'Main',      1, 3, NULL),
    (N'James Doohan',         N'Montgomery Scott',     'TOS', 'Main',      1, 3, NULL),
    (N'Nichelle Nichols',     N'Nyota Uhura',          'TOS', 'Main',      1, 3, NULL),
    (N'George Takei',         N'Hikaru Sulu',          'TOS', 'Main',      1, 3, NULL),
    (N'Walter Koenig',        N'Pavel Chekov',         'TOS', 'Main',      2, 3, NULL),
    (N'Majel Barrett',        N'Christine Chapel',     'TOS', 'Recurring', 1, 3, NULL),
    (N'Grace Lee Whitney',    N'Janice Rand',          'TOS', 'Main',      1, 1, NULL),
    (N'Jeffrey Hunter',       N'Christopher Pike',     'TOS', 'Guest',     1, 1, N'Original Pike in "The Cage"'),
    (N'Sean Kenney',          N'Christopher Pike',     'TOS', 'Guest',     1, 1, N'Injured Pike in "The Menagerie"'),
    (N'Majel Barrett',        N'Una Chin-Riley',       'TOS', 'Guest',     1, 1, N'Credited as "Number One"'),
    (N'Booker Bradshaw',      N'Joseph M''Benga',      'TOS', 'Recurring', 2, 3, NULL),
    (N'Jane Wyatt',           N'Amanda Grayson',       'TOS', 'Guest',     2, 2, NULL),
    (N'Mark Lenard',          N'Sarek',                'TOS', 'Guest',     2, 2, NULL),
    (N'Celia Lovsky',         N'T''Pau',               'TOS', 'Guest',     2, 2, NULL),
    (N'Arlene Martel',        N'T''Pring',             'TOS', 'Guest',     2, 2, NULL),
    (N'Ricardo Montalbán',    N'Khan Noonien Singh',   'TOS', 'Guest',     1, 1, NULL),
    (N'Roger C. Carmel',      N'Harcourt Fenton Mudd', 'TOS', 'Recurring', 1, 2, NULL),
    (N'John Colicos',         N'Kor',                  'TOS', 'Guest',     1, 1, NULL),
    (N'Michael Ansara',       N'Kang',                 'TOS', 'Guest',     3, 3, NULL),
    (N'William Campbell',     N'Koloth',               'TOS', 'Guest',     2, 2, NULL),
    (N'William Campbell',     N'Trelane',              'TOS', 'Guest',     1, 1, NULL),
    (N'John Winston',         N'Kyle',                 'TOS', 'Recurring', 1, 2, NULL),
    (N'Bruce Hyde',           N'Kevin Riley',          'TOS', 'Recurring', 1, 1, NULL),
    (N'Eddie Paskey',         N'Leslie',               'TOS', 'Recurring', 1, 3, NULL),
    (N'Glenn Corbett',        N'Zefram Cochrane',      'TOS', 'Guest',     2, 2, NULL),
    (N'Gary Lockwood',        N'Gary Mitchell',        'TOS', 'Guest',     1, 1, NULL),
    (N'Joan Collins',         N'Edith Keeler',         'TOS', 'Guest',     1, 1, NULL),
    (N'Stanley Adams',        N'Cyrano Jones',         'TOS', 'Guest',     2, 2, NULL),

    -- The Next Generation
    (N'Patrick Stewart',      N'Jean-Luc Picard',      'TNG', 'Main',      1, 7, NULL),
    (N'Jonathan Frakes',      N'William Riker',        'TNG', 'Main',      1, 7, NULL),
    (N'Jonathan Frakes',      N'Thomas Riker',         'TNG', 'Guest',     6, 6, N'Transporter duplicate of William Riker'),
    (N'LeVar Burton',         N'Geordi La Forge',      'TNG', 'Main',      1, 7, NULL),
    (N'Michael Dorn',         N'Worf',                 'TNG', 'Main',      1, 7, NULL),
    (N'Gates McFadden',       N'Beverly Crusher',      'TNG', 'Main',      1, 7, N'Absent from season 2'),
    (N'Marina Sirtis',        N'Deanna Troi',          'TNG', 'Main',      1, 7, NULL),
    (N'Brent Spiner',         N'Data',                 'TNG', 'Main',      1, 7, NULL),
    (N'Brent Spiner',         N'Lore',                 'TNG', 'Recurring', 1, 7, NULL),
    (N'Brent Spiner',         N'Noonien Soong',        'TNG', 'Recurring', 4, 7, NULL),
    (N'Hallie Todd',          N'Lal',                  'TNG', 'Guest',     3, 3, NULL),
    (N'Wil Wheaton',          N'Wesley Crusher',       'TNG', 'Main',      1, 4, NULL),
    (N'Denise Crosby',        N'Tasha Yar',            'TNG', 'Main',      1, 1, NULL),
    (N'Denise Crosby',        N'Sela',                 'TNG', 'Recurring', 4, 5, NULL),
    (N'Diana Muldaur',        N'Katherine Pulaski',    'TNG', 'Main',      2, 2, NULL),
    (N'Whoopi Goldberg',      N'Guinan',               'TNG', 'Recurring', 2, 6, NULL),
    (N'Colm Meaney',          N'Miles O''Brien',       'TNG', 'Recurring', 1, 6, NULL),
    (N'Rosalind Chao',        N'Keiko O''Brien',       'TNG', 'Recurring', 4, 6, NULL),
    (N'Hana Hatae',           N'Molly O''Brien',       'TNG', 'Recurring', 5, 6, NULL),
    (N'Majel Barrett',        N'Lwaxana Troi',         'TNG', 'Recurring', 1, 7, NULL),
    (N'Carel Struycken',      N'Mr. Homn',             'TNG', 'Recurring', 1, 4, NULL),
    (N'John de Lancie',       N'Q',                    'TNG', 'Recurring', 1, 7, NULL),
    (N'Dwight Schultz',       N'Reginald Barclay',     'TNG', 'Recurring', 3, 7, NULL),
    (N'Michelle Forbes',      N'Ro Laren',             'TNG', 'Recurring', 5, 7, NULL),
    (N'Robert O''Reilly',     N'Gowron',               'TNG', 'Recurring', 4, 6, NULL),
    (N'Tony Todd',            N'Kurn',                 'TNG', 'Recurring', 3, 4, NULL),
    (N'Suzie Plakson',        N'K''Ehleyr',            'TNG', 'Recurring', 2, 4, NULL),
    (N'Brian Bonsall',        N'Alexander Rozhenko',   'TNG', 'Recurring', 5, 7, N'Child Alexander'),
    (N'Barbara March',        N'Lursa',                'TNG', 'Recurring', 4, 7, NULL),
    (N'Gwynyth Walsh',        N'B''Etor',              'TNG', 'Recurring', 4, 7, NULL),
    (N'Patti Yasutake',       N'Alyssa Ogawa',         'TNG', 'Recurring', 4, 7, NULL),
    (N'Ashley Judd',          N'Robin Lefler',         'TNG', 'Recurring', 5, 5, NULL),
    (N'Jonathan Del Arco',    N'Hugh',                 'TNG', 'Recurring', 5, 6, NULL),
    (N'Andreas Katsulas',     N'Tomalak',              'TNG', 'Recurring', 1, 7, NULL),
    (N'Elizabeth Dennehy',    N'Elizabeth Shelby',     'TNG', 'Guest',     3, 4, NULL),
    (N'Natalia Nogulich',     N'Alynna Nechayev',      'TNG', 'Recurring', 6, 7, NULL),
    (N'Jennifer Hetrick',     N'Vash',                 'TNG', 'Recurring', 3, 5, NULL),
    (N'Susan Gibney',         N'Leah Brahms',          'TNG', 'Recurring', 3, 4, NULL),
    (N'Daniel Davis',         N'James Moriarty',       'TNG', 'Recurring', 2, 6, NULL),
    (N'Eric Menyuk',          N'The Traveler',         'TNG', 'Recurring', 1, 4, NULL),
    (N'Leonard Nimoy',        N'Spock',                'TNG', 'Guest',     5, 5, NULL),
    (N'DeForest Kelley',      N'Leonard McCoy',        'TNG', 'Guest',     1, 1, NULL),
    (N'James Doohan',         N'Montgomery Scott',     'TNG', 'Guest',     6, 6, NULL),
    (N'Mark Lenard',          N'Sarek',                'TNG', 'Recurring', 3, 5, NULL),

    -- Deep Space Nine
    (N'Avery Brooks',         N'Benjamin Sisko',       'DS9', 'Main',      1, 7, NULL),
    (N'René Auberjonois',     N'Odo',                  'DS9', 'Main',      1, 7, NULL),
    (N'Nana Visitor',         N'Kira Nerys',           'DS9', 'Main',      1, 7, NULL),
    (N'Terry Farrell',        N'Jadzia Dax',           'DS9', 'Main',      1, 6, NULL),
    (N'Nicole de Boer',       N'Ezri Dax',             'DS9', 'Main',      7, 7, NULL),
    (N'Alexander Siddig',     N'Julian Bashir',        'DS9', 'Main',      1, 7, N'Credited as Siddig El Fadil in early seasons'),
    (N'Armin Shimerman',      N'Quark',                'DS9', 'Main',      1, 7, NULL),
    (N'Cirroc Lofton',        N'Jake Sisko',           'DS9', 'Main',      1, 7, NULL),
    (N'Tony Todd',            N'Jake Sisko',           'DS9', 'Guest',     4, 4, N'Older Jake in "The Visitor"'),
    (N'Colm Meaney',          N'Miles O''Brien',       'DS9', 'Main',      1, 7, NULL),
    (N'Michael Dorn',         N'Worf',                 'DS9', 'Main',      4, 7, NULL),
    (N'Max Grodénchik',       N'Rom',                  'DS9', 'Recurring', 1, 7, NULL),
    (N'Aron Eisenberg',       N'Nog',                  'DS9', 'Recurring', 1, 7, NULL),
    (N'Rosalind Chao',        N'Keiko O''Brien',       'DS9', 'Recurring', 1, 7, NULL),
    (N'Hana Hatae',           N'Molly O''Brien',       'DS9', 'Recurring', 1, 7, NULL),
    (N'Andrew J. Robinson',   N'Elim Garak',           'DS9', 'Recurring', 1, 7, NULL),
    (N'Marc Alaimo',          N'Dukat',                'DS9', 'Recurring', 1, 7, NULL),
    (N'Chase Masterson',      N'Leeta',                'DS9', 'Recurring', 3, 7, NULL),
    (N'Louise Fletcher',      N'Winn Adami',           'DS9', 'Recurring', 2, 7, NULL),
    (N'Philip Anglim',        N'Bareil Antos',         'DS9', 'Recurring', 1, 4, NULL),
    (N'Camille Saviola',      N'Opaka Sulan',          'DS9', 'Guest',     1, 1, NULL),
    (N'Duncan Regehr',        N'Shakaar Edon',         'DS9', 'Recurring', 3, 4, NULL),
    (N'Jeffrey Combs',        N'Weyoun',               'DS9', 'Recurring', 4, 7, NULL),
    (N'Jeffrey Combs',        N'Brunt',                'DS9', 'Recurring', 3, 7, NULL),
    (N'Salome Jens',          N'Female Changeling',    'DS9', 'Recurring', 3, 7, NULL),
    (N'Casey Biggs',          N'Damar',                'DS9', 'Recurring', 4, 7, NULL),
    (N'Paul Dooley',          N'Enabran Tain',         'DS9', 'Recurring', 2, 4, NULL),
    (N'J. G. Hertzler',       N'Martok',               'DS9', 'Recurring', 4, 7, NULL),
    (N'Penny Johnson Jerald', N'Kasidy Yates',         'DS9', 'Recurring', 3, 7, NULL),
    (N'Brock Peters',         N'Joseph Sisko',         'DS9', 'Recurring', 4, 7, NULL),
    (N'Felecia M. Bell',      N'Jennifer Sisko',       'DS9', 'Recurring', 1, 3, NULL),
    (N'Wallace Shawn',        N'Zek',                  'DS9', 'Recurring', 1, 7, NULL),
    (N'Andrea Martin',        N'Ishka',                'DS9', 'Guest',     3, 3, N'Original Ishka in "Family Business"'),
    (N'Cecily Adams',         N'Ishka',                'DS9', 'Recurring', 4, 7, N'Recast from season 4'),
    (N'Mark Allen Shepherd',  N'Morn',                 'DS9', 'Recurring', 1, 7, NULL),
    (N'James Darren',         N'Vic Fontaine',         'DS9', 'Recurring', 6, 7, NULL),
    (N'Barry Jenner',         N'William Ross',         'DS9', 'Recurring', 6, 7, NULL),
    (N'Kenneth Marshall',     N'Michael Eddington',    'DS9', 'Recurring', 3, 5, NULL),
    (N'William Sadler',       N'Luther Sloan',         'DS9', 'Recurring', 6, 7, NULL),
    (N'James Sloyan',         N'Mora Pol',             'DS9', 'Recurring', 2, 5, NULL),
    (N'Cyia Batten',          N'Tora Ziyal',           'DS9', 'Guest',     4, 4, N'First of three Ziyal actors'),
    (N'Tracy Middendorf',     N'Tora Ziyal',           'DS9', 'Guest',     5, 5, N'Second of three Ziyal actors'),
    (N'Melanie Smith',        N'Tora Ziyal',           'DS9', 'Recurring', 5, 6, N'Third of three Ziyal actors'),
    (N'Marc Worden',          N'Alexander Rozhenko',   'DS9', 'Recurring', 5, 6, N'Adult Alexander'),
    (N'Robert O''Reilly',     N'Gowron',               'DS9', 'Recurring', 4, 7, NULL),
    (N'John Colicos',         N'Kor',                  'DS9', 'Recurring', 2, 7, NULL),
    (N'Michael Ansara',       N'Kang',                 'DS9', 'Guest',     2, 2, NULL),
    (N'William Campbell',     N'Koloth',               'DS9', 'Guest',     2, 2, NULL),
    (N'Barbara March',        N'Lursa',                'DS9', 'Guest',     2, 2, NULL),
    (N'Gwynyth Walsh',        N'B''Etor',              'DS9', 'Guest',     2, 2, NULL),
    (N'Natalia Nogulich',     N'Alynna Nechayev',      'DS9', 'Guest',     2, 2, NULL),
    (N'Patrick Stewart',      N'Jean-Luc Picard',      'DS9', 'Guest',     1, 1, NULL),
    (N'Jonathan Frakes',      N'Thomas Riker',         'DS9', 'Guest',     3, 3, NULL),
    (N'Majel Barrett',        N'Lwaxana Troi',         'DS9', 'Recurring', 1, 4, NULL),
    (N'John de Lancie',       N'Q',                    'DS9', 'Guest',     1, 1, NULL),
    (N'Jennifer Hetrick',     N'Vash',                 'DS9', 'Guest',     1, 1, NULL),

    -- Voyager
    (N'Kate Mulgrew',         N'Kathryn Janeway',      'VOY', 'Main',      1, 7, NULL),
    (N'Robert Beltran',       N'Chakotay',             'VOY', 'Main',      1, 7, NULL),
    (N'Roxann Dawson',        N'B''Elanna Torres',     'VOY', 'Main',      1, 7, NULL),
    (N'Robert Duncan McNeill',N'Tom Paris',            'VOY', 'Main',      1, 7, NULL),
    (N'Ethan Phillips',       N'Neelix',               'VOY', 'Main',      1, 7, NULL),
    (N'Robert Picardo',       N'The Doctor',           'VOY', 'Main',      1, 7, NULL),
    (N'Tim Russ',             N'Tuvok',                'VOY', 'Main',      1, 7, NULL),
    (N'Jennifer Lien',        N'Kes',                  'VOY', 'Main',      1, 4, NULL),
    (N'Garrett Wang',         N'Harry Kim',            'VOY', 'Main',      1, 7, NULL),
    (N'Jeri Ryan',            N'Seven of Nine',        'VOY', 'Main',      4, 7, NULL),
    (N'Martha Hackett',       N'Seska',                'VOY', 'Recurring', 1, 3, NULL),
    (N'Alexander Enberg',     N'Vorik',                'VOY', 'Recurring', 3, 6, NULL),
    (N'Tarik Ergin',          N'Ayala',                'VOY', 'Recurring', 1, 7, NULL),
    (N'Josh Clark',           N'Joe Carey',            'VOY', 'Recurring', 1, 7, NULL),
    (N'Brad Dourif',          N'Lon Suder',            'VOY', 'Recurring', 2, 2, NULL),
    (N'Raphael Sbarge',       N'Michael Jonas',        'VOY', 'Recurring', 2, 2, NULL),
    (N'Nancy Hower',          N'Samantha Wildman',     'VOY', 'Recurring', 1, 6, NULL),
    (N'Scarlett Pomers',      N'Naomi Wildman',        'VOY', 'Recurring', 4, 7, NULL),
    (N'Manu Intiraymi',       N'Icheb',                'VOY', 'Recurring', 6, 7, NULL),
    (N'Susanna Thompson',     N'Borg Queen',           'VOY', 'Recurring', 5, 6, N'Recast; Alice Krige originated the role on film'),
    (N'Alice Krige',          N'Borg Queen',           'VOY', 'Guest',     7, 7, N'Series finale "Endgame"'),
    (N'Richard Herd',         N'Owen Paris',           'VOY', 'Recurring', 6, 7, NULL),
    (N'John Savage',          N'Rudolph Ransom',       'VOY', 'Guest',     6, 6, NULL),
    (N'Keegan de Lancie',     N'Q Junior',             'VOY', 'Guest',     7, 7, NULL),
    (N'John de Lancie',       N'Q',                    'VOY', 'Recurring', 2, 7, NULL),
    (N'Jonathan Frakes',      N'William Riker',        'VOY', 'Guest',     2, 2, NULL),
    (N'Marina Sirtis',        N'Deanna Troi',          'VOY', 'Recurring', 7, 7, NULL),
    (N'Dwight Schultz',       N'Reginald Barclay',     'VOY', 'Recurring', 6, 7, NULL),
    (N'George Takei',         N'Hikaru Sulu',          'VOY', 'Guest',     3, 3, NULL),
    (N'Grace Lee Whitney',    N'Janice Rand',          'VOY', 'Guest',     3, 3, NULL),
    (N'Armin Shimerman',      N'Quark',                'VOY', 'Guest',     1, 1, NULL),

    -- Enterprise
    (N'Scott Bakula',         N'Jonathan Archer',      'ENT', 'Main',      1, 4, NULL),
    (N'Jolene Blalock',       N'T''Pol',               'ENT', 'Main',      1, 4, NULL),
    (N'Connor Trinneer',      N'Charles Tucker III',   'ENT', 'Main',      1, 4, NULL),
    (N'Dominic Keating',      N'Malcolm Reed',         'ENT', 'Main',      1, 4, NULL),
    (N'Anthony Montgomery',   N'Travis Mayweather',    'ENT', 'Main',      1, 4, NULL),
    (N'Linda Park',           N'Hoshi Sato',           'ENT', 'Main',      1, 4, NULL),
    (N'John Billingsley',     N'Phlox',                'ENT', 'Main',      1, 4, NULL),
    (N'Vaughn Armstrong',     N'Maxwell Forrest',      'ENT', 'Recurring', 1, 4, NULL),
    (N'Gary Graham',          N'Soval',                'ENT', 'Recurring', 1, 4, NULL),
    (N'Jeffrey Combs',        N'Shran',                'ENT', 'Recurring', 1, 4, NULL),
    (N'Matt Winston',         N'Daniels',              'ENT', 'Recurring', 1, 4, NULL),
    (N'John Fleck',           N'Silik',                'ENT', 'Recurring', 1, 3, NULL),
    (N'Randy Oglesby',        N'Degra',                'ENT', 'Recurring', 3, 3, NULL),
    (N'Scott MacDonald',      N'Dolim',                'ENT', 'Recurring', 3, 3, NULL),
    (N'Steven Culp',          N'J. Hayes',             'ENT', 'Recurring', 3, 3, NULL),
    (N'Ada Maris',            N'Erika Hernandez',      'ENT', 'Guest',     4, 4, NULL),
    (N'Brent Spiner',         N'Arik Soong',           'ENT', 'Recurring', 4, 4, NULL),
    (N'Peter Weller',         N'John Frederick Paxton','ENT', 'Recurring', 4, 4, NULL),
    (N'James Cromwell',       N'Zefram Cochrane',      'ENT', 'Guest',     1, 1, NULL),
    (N'Jonathan Frakes',      N'William Riker',        'ENT', 'Guest',     4, 4, NULL),
    (N'Marina Sirtis',        N'Deanna Troi',          'ENT', 'Guest',     4, 4, NULL),

    -- Strange New Worlds (through season 3)
    (N'Anson Mount',          N'Christopher Pike',     'SNW', 'Main',      1, 3, NULL),
    (N'Ethan Peck',           N'Spock',                'SNW', 'Main',      1, 3, NULL),
    (N'Rebecca Romijn',       N'Una Chin-Riley',       'SNW', 'Main',      1, 3, NULL),
    (N'Christina Chong',      N'La''an Noonien-Singh', 'SNW', 'Main',      1, 3, NULL),
    (N'Celia Rose Gooding',   N'Nyota Uhura',          'SNW', 'Main',      1, 3, NULL),
    (N'Melissa Navia',        N'Erica Ortegas',        'SNW', 'Main',      1, 3, NULL),
    (N'Jess Bush',            N'Christine Chapel',     'SNW', 'Main',      1, 3, NULL),
    (N'Babs Olusanmokun',     N'Joseph M''Benga',      'SNW', 'Main',      1, 3, NULL),
    (N'Bruce Horak',          N'Hemmer',               'SNW', 'Main',      1, 1, NULL),
    (N'Martin Quinn',         N'Montgomery Scott',     'SNW', 'Main',      2, 3, N'Recurring in season 2, main from season 3'),
    (N'Carol Kane',           N'Pelia',                'SNW', 'Main',      2, 3, NULL),
    (N'Paul Wesley',          N'James T. Kirk',        'SNW', 'Recurring', 1, 3, NULL),
    (N'Dan Jeannotte',        N'Sam Kirk',             'SNW', 'Recurring', 1, 2, NULL),
    (N'Melanie Scrofano',     N'Marie Batel',          'SNW', 'Recurring', 1, 3, NULL),
    (N'Rong Fu',              N'Jenna Mitchell',       'SNW', 'Recurring', 1, 3, NULL),
    (N'Adrian Holmes',        N'Robert April',         'SNW', 'Recurring', 1, 3, NULL),
    (N'Gia Sandhu',           N'T''Pring',             'SNW', 'Recurring', 1, 3, NULL),
    (N'Mia Kirshner',         N'Amanda Grayson',       'SNW', 'Recurring', 1, 2, NULL);

IF EXISTS (SELECT 1 FROM #AppearanceSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.Actor AS a WHERE a.FullName = s.ActorFullName))
BEGIN
    SELECT DISTINCT s.ActorFullName AS UnknownActor FROM #AppearanceSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.Actor AS a WHERE a.FullName = s.ActorFullName);
    THROW 50020, N'Seed.Appearances: unknown actor referenced.', 1;
END;

IF EXISTS (SELECT 1 FROM #AppearanceSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.[Character] AS c WHERE c.Name = s.CharacterName))
BEGIN
    SELECT DISTINCT s.CharacterName AS UnknownCharacter FROM #AppearanceSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.[Character] AS c WHERE c.Name = s.CharacterName);
    THROW 50021, N'Seed.Appearances: unknown character referenced.', 1;
END;

IF EXISTS (SELECT 1 FROM #AppearanceSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.Series AS sr WHERE sr.Abbreviation = s.SeriesAbbr))
    THROW 50022, N'Seed.Appearances: unknown series referenced.', 1;

MERGE dbo.ActorCharacter AS tgt
USING (
    SELECT a.ActorId, c.CharacterId, NULLIF(MAX(ISNULL(s.Notes, N'')), N'') AS Notes
    FROM #AppearanceSource AS s
    INNER JOIN dbo.Actor AS a ON a.FullName = s.ActorFullName
    INNER JOIN dbo.[Character] AS c ON c.Name = s.CharacterName
    GROUP BY a.ActorId, c.CharacterId
) AS src
    ON tgt.ActorId = src.ActorId AND tgt.CharacterId = src.CharacterId
WHEN MATCHED AND EXISTS (SELECT tgt.Notes EXCEPT SELECT src.Notes)
    THEN UPDATE SET Notes = src.Notes
WHEN NOT MATCHED BY TARGET
    THEN INSERT (ActorId, CharacterId, Notes) VALUES (src.ActorId, src.CharacterId, src.Notes);

MERGE dbo.SeriesAppearance AS tgt
USING (
    SELECT ac.ActorCharacterId, sr.SeriesId, s.RoleType, s.FirstSeason, s.LastSeason
    FROM #AppearanceSource AS s
    INNER JOIN dbo.Actor AS a ON a.FullName = s.ActorFullName
    INNER JOIN dbo.[Character] AS c ON c.Name = s.CharacterName
    INNER JOIN dbo.ActorCharacter AS ac ON ac.ActorId = a.ActorId AND ac.CharacterId = c.CharacterId
    INNER JOIN dbo.Series AS sr ON sr.Abbreviation = s.SeriesAbbr
) AS src
    ON tgt.ActorCharacterId = src.ActorCharacterId AND tgt.SeriesId = src.SeriesId
WHEN MATCHED AND EXISTS (SELECT tgt.RoleType, tgt.FirstSeason, tgt.LastSeason EXCEPT SELECT src.RoleType, src.FirstSeason, src.LastSeason)
    THEN UPDATE SET RoleType = src.RoleType, FirstSeason = src.FirstSeason, LastSeason = src.LastSeason
WHEN NOT MATCHED BY TARGET
    THEN INSERT (ActorCharacterId, SeriesId, RoleType, FirstSeason, LastSeason)
         VALUES (src.ActorCharacterId, src.SeriesId, src.RoleType, src.FirstSeason, src.LastSeason);

DROP TABLE #AppearanceSource;
