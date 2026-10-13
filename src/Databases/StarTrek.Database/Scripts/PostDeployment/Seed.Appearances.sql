/*
    Seed.Appearances.sql
    Which actor played which character, in which series or film, and in what capacity.
    ActorCharacter rows are derived from the distinct (actor, character) pairs below.
    Season ranges are the span of appearances in that series (Main/Recurring/Guest).
    Films have no seasons and use Main/Supporting/Cameo.
*/
PRINT N'Seeding ActorCharacter and SeriesAppearance...';

DROP TABLE IF EXISTS #AppearanceSource;

CREATE TABLE #AppearanceSource
(
    ActorFullName  NVARCHAR(201) NOT NULL,
    CharacterName  NVARCHAR(100) NOT NULL,
    SeriesAbbr     VARCHAR(10)   NOT NULL,
    RoleType       VARCHAR(10)   NOT NULL,
    FirstSeason    TINYINT       NULL,
    LastSeason     TINYINT       NULL,
    Notes          NVARCHAR(200) NULL,
    -- NULL = derive from the production (Animated -> Voice, otherwise On-screen).
    PerformanceType VARCHAR(10)  NULL,
    -- NULL = the production's timeline. Set to override (e.g. Spock Prime in the Kelvin films).
    TimelineName   NVARCHAR(50)  NULL,
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

-- Discovery, Picard, Lower Decks, Starfleet Academy and the films.
-- PerformanceType NULL = derived from the production format; TimelineName NULL = the production's timeline.
INSERT INTO #AppearanceSource (ActorFullName, CharacterName, SeriesAbbr, RoleType, FirstSeason, LastSeason, PerformanceType, TimelineName, Notes)
VALUES
    -- Star Trek: Discovery
    (N'Sonequa Martin-Green', N'Michael Burnham',      'DIS', 'Main',      1, 5, NULL, NULL, NULL),
    (N'Doug Jones',           N'Saru',                 'DIS', 'Main',      1, 5, NULL, NULL, NULL),
    (N'Anthony Rapp',         N'Paul Stamets',         'DIS', 'Main',      1, 5, NULL, NULL, NULL),
    (N'Mary Wiseman',         N'Sylvia Tilly',         'DIS', 'Main',      1, 5, NULL, NULL, NULL),
    (N'Wilson Cruz',          N'Hugh Culber',          'DIS', 'Main',      1, 5, NULL, NULL, NULL),
    (N'Michelle Yeoh',        N'Philippa Georgiou',    'DIS', 'Main',      1, 1, NULL, NULL, NULL),
    (N'Michelle Yeoh',        N'Philippa Georgiou (Mirror)', 'DIS', 'Main', 1, 3, NULL, N'Mirror Universe', NULL),
    (N'Jason Isaacs',         N'Gabriel Lorca (Mirror)', 'DIS', 'Main',    1, 1, NULL, N'Mirror Universe', N'Posed as his Prime counterpart aboard Discovery'),
    (N'Shazad Latif',         N'Ash Tyler',            'DIS', 'Main',      1, 2, NULL, NULL, NULL),
    (N'David Ajala',          N'Cleveland Booker',     'DIS', 'Main',      3, 5, NULL, NULL, NULL),
    (N'Blu del Barrio',       N'Adira Tal',            'DIS', 'Main',      3, 5, NULL, NULL, NULL),
    (N'Callum Keith Rennie',  N'Rayner',               'DIS', 'Main',      4, 5, NULL, NULL, NULL),
    (N'Ian Alexander',        N'Gray Tal',             'DIS', 'Recurring', 3, 5, NULL, NULL, NULL),
    (N'Tig Notaro',           N'Jett Reno',            'DIS', 'Recurring', 2, 5, NULL, NULL, NULL),
    (N'Oded Fehr',            N'Charles Vance',        'DIS', 'Recurring', 3, 5, NULL, NULL, NULL),
    (N'David Cronenberg',     N'Kovich',               'DIS', 'Recurring', 3, 5, NULL, NULL, NULL),
    (N'Annabelle Wallis',     N'Zora',                 'DIS', 'Recurring', 3, 5, 'Voice', NULL, N'Voice of the ship''s sentient computer'),
    (N'Mary Chieffo',         N'L''Rell',              'DIS', 'Recurring', 1, 2, NULL, NULL, NULL),
    (N'Emily Coutts',         N'Keyla Detmer',         'DIS', 'Recurring', 1, 3, NULL, NULL, NULL),
    (N'Oyin Oladejo',         N'Joann Owosekun',       'DIS', 'Recurring', 1, 3, NULL, NULL, NULL),
    (N'Hannah Cheesman',      N'Airiam',               'DIS', 'Recurring', 2, 2, NULL, NULL, NULL),
    (N'James Frain',          N'Sarek',                'DIS', 'Recurring', 1, 2, NULL, NULL, NULL),
    (N'Mia Kirshner',         N'Amanda Grayson',       'DIS', 'Recurring', 1, 2, NULL, NULL, NULL),
    (N'Rainn Wilson',         N'Harcourt Fenton Mudd', 'DIS', 'Recurring', 1, 1, NULL, NULL, NULL),
    (N'Anson Mount',          N'Christopher Pike',     'DIS', 'Recurring', 2, 2, NULL, NULL, NULL),
    (N'Ethan Peck',           N'Spock',                'DIS', 'Recurring', 2, 2, NULL, NULL, NULL),
    (N'Rebecca Romijn',       N'Una Chin-Riley',       'DIS', 'Recurring', 2, 2, NULL, NULL, NULL),

    -- Star Trek: Picard
    (N'Patrick Stewart',      N'Jean-Luc Picard',      'PIC', 'Main',      1, 3, NULL, NULL, NULL),
    (N'Alison Pill',          N'Agnes Jurati',         'PIC', 'Main',      1, 2, NULL, NULL, NULL),
    (N'Isa Briones',          N'Soji Asha',            'PIC', 'Main',      1, 2, NULL, NULL, NULL),
    (N'Isa Briones',          N'Dahj Asha',            'PIC', 'Guest',     1, 1, NULL, NULL, NULL),
    (N'Isa Briones',          N'Kore Soong',           'PIC', 'Recurring', 2, 2, NULL, NULL, NULL),
    (N'Michelle Hurd',        N'Raffi Musiker',        'PIC', 'Main',      1, 3, NULL, NULL, NULL),
    (N'Santiago Cabrera',     N'Cristóbal Rios',       'PIC', 'Main',      1, 2, NULL, NULL, NULL),
    (N'Evan Evagora',         N'Elnor',                'PIC', 'Main',      1, 2, NULL, NULL, NULL),
    (N'Harry Treadaway',      N'Narek',                'PIC', 'Main',      1, 1, NULL, NULL, NULL),
    (N'Jeri Ryan',            N'Seven of Nine',        'PIC', 'Main',      1, 3, NULL, NULL, NULL),
    (N'Orla Brady',           N'Laris',                'PIC', 'Main',      1, 2, NULL, NULL, NULL),
    (N'Jamie McShane',        N'Zhaban',               'PIC', 'Recurring', 1, 1, NULL, NULL, NULL),
    (N'Peyton List',          N'Narissa Rizzo',        'PIC', 'Recurring', 1, 1, NULL, NULL, NULL),
    (N'Tamlyn Tomita',        N'Oh',                   'PIC', 'Recurring', 1, 1, NULL, NULL, NULL),
    (N'Brent Spiner',         N'Data',                 'PIC', 'Main',      1, 3, NULL, NULL, NULL),
    (N'Brent Spiner',         N'Altan Inigo Soong',    'PIC', 'Main',      1, 1, NULL, NULL, NULL),
    (N'Brent Spiner',         N'Adam Soong',           'PIC', 'Main',      2, 2, NULL, NULL, NULL),
    (N'Brent Spiner',         N'Lore',                 'PIC', 'Recurring', 3, 3, NULL, NULL, NULL),
    (N'Jonathan Del Arco',    N'Hugh',                 'PIC', 'Recurring', 1, 1, NULL, NULL, NULL),
    (N'John de Lancie',       N'Q',                    'PIC', 'Recurring', 2, 3, NULL, NULL, NULL),
    (N'Annie Wersching',      N'Borg Queen',           'PIC', 'Recurring', 2, 2, NULL, NULL, NULL),
    (N'Sol Rodriguez',        N'Teresa Ramirez',       'PIC', 'Recurring', 2, 2, NULL, NULL, NULL),
    (N'Ito Aghayere',         N'Guinan',               'PIC', 'Recurring', 2, 2, NULL, NULL, N'Younger Guinan in 2024'),
    (N'Whoopi Goldberg',      N'Guinan',               'PIC', 'Guest',     2, 2, NULL, NULL, NULL),
    (N'Wil Wheaton',          N'Wesley Crusher',       'PIC', 'Guest',     2, 2, NULL, NULL, NULL),
    (N'Kate Mulgrew',         N'Kathryn Janeway',      'PIC', 'Guest',     2, 2, NULL, NULL, NULL),
    (N'Jonathan Frakes',      N'William Riker',        'PIC', 'Main',      1, 3, NULL, NULL, NULL),
    (N'Marina Sirtis',        N'Deanna Troi',          'PIC', 'Main',      1, 3, NULL, NULL, NULL),
    (N'LeVar Burton',         N'Geordi La Forge',      'PIC', 'Main',      3, 3, NULL, NULL, NULL),
    (N'Michael Dorn',         N'Worf',                 'PIC', 'Main',      3, 3, NULL, NULL, NULL),
    (N'Gates McFadden',       N'Beverly Crusher',      'PIC', 'Main',      3, 3, NULL, NULL, NULL),
    (N'Ed Speleers',          N'Jack Crusher',         'PIC', 'Main',      3, 3, NULL, NULL, NULL),
    (N'Todd Stashwick',       N'Liam Shaw',            'PIC', 'Recurring', 3, 3, NULL, NULL, NULL),
    (N'Ashlei Sharpe Chestnut', N'Sidney La Forge',    'PIC', 'Recurring', 3, 3, NULL, NULL, NULL),
    (N'Mica Burton',          N'Alandra La Forge',     'PIC', 'Recurring', 3, 3, NULL, NULL, NULL),
    (N'Amanda Plummer',       N'Vadic',                'PIC', 'Recurring', 3, 3, NULL, NULL, NULL),
    (N'Tim Russ',             N'Tuvok',                'PIC', 'Recurring', 3, 3, NULL, NULL, NULL),
    (N'Dwight Schultz',       N'Reginald Barclay',     'PIC', 'Guest',     3, 3, NULL, NULL, NULL),
    (N'Michelle Forbes',      N'Ro Laren',             'PIC', 'Guest',     3, 3, NULL, NULL, NULL),
    (N'Elizabeth Dennehy',    N'Elizabeth Shelby',     'PIC', 'Guest',     3, 3, NULL, NULL, NULL),

    -- Star Trek: Lower Decks (animated: voice performances)
    (N'Tawny Newsome',        N'Beckett Mariner',      'LD',  'Main',      1, 5, NULL, NULL, NULL),
    (N'Jack Quaid',           N'Brad Boimler',         'LD',  'Main',      1, 5, NULL, NULL, NULL),
    (N'Noël Wells',           N'D''Vana Tendi',        'LD',  'Main',      1, 5, NULL, NULL, NULL),
    (N'Eugene Cordero',       N'Sam Rutherford',       'LD',  'Main',      1, 5, NULL, NULL, NULL),
    (N'Dawnn Lewis',          N'Carol Freeman',        'LD',  'Main',      1, 5, NULL, NULL, NULL),
    (N'Jerry O''Connell',     N'Jack Ransom',          'LD',  'Main',      1, 5, NULL, NULL, NULL),
    (N'Fred Tatasciore',      N'Shaxs',                'LD',  'Main',      1, 5, NULL, NULL, NULL),
    (N'Gillian Vigman',       N'T''Ana',               'LD',  'Main',      1, 5, NULL, NULL, NULL),
    (N'Paul Scheer',          N'Andy Billups',         'LD',  'Recurring', 1, 5, NULL, NULL, NULL),
    (N'Jonathan Frakes',      N'William Riker',        'LD',  'Guest',     1, 1, NULL, NULL, NULL),
    (N'Marina Sirtis',        N'Deanna Troi',          'LD',  'Guest',     1, 1, NULL, NULL, NULL),
    (N'John de Lancie',       N'Q',                    'LD',  'Guest',     1, 1, NULL, NULL, NULL),
    (N'Robert Duncan McNeill', N'Tom Paris',           'LD',  'Guest',     2, 2, NULL, NULL, NULL),
    (N'Nana Visitor',         N'Kira Nerys',           'LD',  'Guest',     3, 3, NULL, NULL, NULL),
    (N'Armin Shimerman',      N'Quark',                'LD',  'Guest',     3, 3, NULL, NULL, NULL),
    -- Lower Decks crossover into Strange New Worlds ("Those Old Scientists"): live-action
    (N'Tawny Newsome',        N'Beckett Mariner',      'SNW', 'Guest',     2, 2, NULL, NULL, NULL),
    (N'Jack Quaid',           N'Brad Boimler',         'SNW', 'Guest',     2, 2, NULL, NULL, NULL),

    -- Star Trek: Starfleet Academy (season 1; low confidence)
    (N'Holly Hunter',         N'Nahla Ake',            'SFA', 'Main',      1, 1, NULL, NULL, NULL),
    (N'Sandro Rosta',         N'Caleb Mir',            'SFA', 'Main',      1, 1, NULL, NULL, NULL),
    (N'Karim Diané',          N'Jay-Den Kraag',        'SFA', 'Main',      1, 1, NULL, NULL, NULL),
    (N'Bella Shepard',        N'Genesis Lythe',        'SFA', 'Main',      1, 1, NULL, NULL, NULL),
    (N'George Hawkins',       N'Darem Reymi',          'SFA', 'Main',      1, 1, NULL, NULL, NULL),
    (N'Zoë Steiner',          N'Tarima Sadal',         'SFA', 'Main',      1, 1, NULL, NULL, NULL),
    (N'Robert Picardo',       N'The Doctor',           'SFA', 'Main',      1, 1, NULL, NULL, NULL),
    (N'Paul Giamatti',        N'Nus Braka',            'SFA', 'Recurring', 1, 1, NULL, NULL, NULL),
    (N'Tig Notaro',           N'Jett Reno',            'SFA', 'Recurring', 1, 1, NULL, NULL, NULL),
    (N'Mary Wiseman',         N'Sylvia Tilly',         'SFA', 'Recurring', 1, 1, NULL, NULL, NULL),

    -- TOS-era films: the TOS bridge crew stars in all six
    (N'William Shatner',      N'James T. Kirk',        'TMP',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Leonard Nimoy',        N'Spock',                'TMP',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'DeForest Kelley',      N'Leonard McCoy',        'TMP',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'James Doohan',         N'Montgomery Scott',     'TMP',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Nichelle Nichols',     N'Nyota Uhura',          'TMP',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'George Takei',         N'Hikaru Sulu',          'TMP',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Walter Koenig',        N'Pavel Chekov',         'TMP',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Persis Khambatta',     N'Ilia',                 'TMP',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Stephen Collins',      N'Willard Decker',       'TMP',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Majel Barrett',        N'Christine Chapel',     'TMP',  'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Grace Lee Whitney',    N'Janice Rand',          'TMP',  'Supporting', NULL, NULL, NULL, NULL, NULL),

    (N'William Shatner',      N'James T. Kirk',        'TWOK', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Leonard Nimoy',        N'Spock',                'TWOK', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'DeForest Kelley',      N'Leonard McCoy',        'TWOK', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'James Doohan',         N'Montgomery Scott',     'TWOK', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Nichelle Nichols',     N'Nyota Uhura',          'TWOK', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'George Takei',         N'Hikaru Sulu',          'TWOK', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Walter Koenig',        N'Pavel Chekov',         'TWOK', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Ricardo Montalbán',    N'Khan Noonien Singh',   'TWOK', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Kirstie Alley',        N'Saavik',               'TWOK', 'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Bibi Besch',           N'Carol Marcus',         'TWOK', 'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Merritt Butrick',      N'David Marcus',         'TWOK', 'Supporting', NULL, NULL, NULL, NULL, NULL),

    (N'William Shatner',      N'James T. Kirk',        'TSFS', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Leonard Nimoy',        N'Spock',                'TSFS', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'DeForest Kelley',      N'Leonard McCoy',        'TSFS', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'James Doohan',         N'Montgomery Scott',     'TSFS', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Nichelle Nichols',     N'Nyota Uhura',          'TSFS', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'George Takei',         N'Hikaru Sulu',          'TSFS', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Walter Koenig',        N'Pavel Chekov',         'TSFS', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Christopher Lloyd',    N'Kruge',                'TSFS', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Robin Curtis',         N'Saavik',               'TSFS', 'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Merritt Butrick',      N'David Marcus',         'TSFS', 'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Mark Lenard',          N'Sarek',                'TSFS', 'Supporting', NULL, NULL, NULL, NULL, NULL),

    (N'William Shatner',      N'James T. Kirk',        'TVH',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Leonard Nimoy',        N'Spock',                'TVH',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'DeForest Kelley',      N'Leonard McCoy',        'TVH',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'James Doohan',         N'Montgomery Scott',     'TVH',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Nichelle Nichols',     N'Nyota Uhura',          'TVH',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'George Takei',         N'Hikaru Sulu',          'TVH',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Walter Koenig',        N'Pavel Chekov',         'TVH',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Catherine Hicks',      N'Gillian Taylor',       'TVH',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Mark Lenard',          N'Sarek',                'TVH',  'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Jane Wyatt',           N'Amanda Grayson',       'TVH',  'Cameo', NULL, NULL, NULL, NULL, NULL),
    (N'Robin Curtis',         N'Saavik',               'TVH',  'Cameo', NULL, NULL, NULL, NULL, NULL),

    (N'William Shatner',      N'James T. Kirk',        'TFF',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Leonard Nimoy',        N'Spock',                'TFF',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'DeForest Kelley',      N'Leonard McCoy',        'TFF',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'James Doohan',         N'Montgomery Scott',     'TFF',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Nichelle Nichols',     N'Nyota Uhura',          'TFF',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'George Takei',         N'Hikaru Sulu',          'TFF',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Walter Koenig',        N'Pavel Chekov',         'TFF',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Laurence Luckinbill',  N'Sybok',                'TFF',  'Main', NULL, NULL, NULL, NULL, NULL),

    (N'William Shatner',      N'James T. Kirk',        'TUC',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Leonard Nimoy',        N'Spock',                'TUC',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'DeForest Kelley',      N'Leonard McCoy',        'TUC',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'James Doohan',         N'Montgomery Scott',     'TUC',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Nichelle Nichols',     N'Nyota Uhura',          'TUC',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'George Takei',         N'Hikaru Sulu',          'TUC',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Walter Koenig',        N'Pavel Chekov',         'TUC',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Kim Cattrall',         N'Valeris',              'TUC',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Christopher Plummer',  N'Chang',                'TUC',  'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'David Warner',         N'Gorkon',               'TUC',  'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Brock Peters',         N'Cartwright',           'TUC',  'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Mark Lenard',          N'Sarek',                'TUC',  'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Michael Dorn',         N'Colonel Worf',         'TUC',  'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Grace Lee Whitney',    N'Janice Rand',          'TUC',  'Cameo', NULL, NULL, NULL, NULL, NULL),

    -- TNG-era films: the TNG main cast stars in all four
    (N'Patrick Stewart',      N'Jean-Luc Picard',      'GEN',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Jonathan Frakes',      N'William Riker',        'GEN',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Brent Spiner',         N'Data',                 'GEN',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'LeVar Burton',         N'Geordi La Forge',      'GEN',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Michael Dorn',         N'Worf',                 'GEN',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Gates McFadden',       N'Beverly Crusher',      'GEN',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Marina Sirtis',        N'Deanna Troi',          'GEN',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'William Shatner',      N'James T. Kirk',        'GEN',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Malcolm McDowell',     N'Tolian Soran',         'GEN',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'James Doohan',         N'Montgomery Scott',     'GEN',  'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Walter Koenig',        N'Pavel Chekov',         'GEN',  'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Alan Ruck',            N'John Harriman',        'GEN',  'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Whoopi Goldberg',      N'Guinan',               'GEN',  'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Barbara March',        N'Lursa',                'GEN',  'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Gwynyth Walsh',        N'B''Etor',              'GEN',  'Supporting', NULL, NULL, NULL, NULL, NULL),

    (N'Patrick Stewart',      N'Jean-Luc Picard',      'FC',   'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Jonathan Frakes',      N'William Riker',        'FC',   'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Brent Spiner',         N'Data',                 'FC',   'Main', NULL, NULL, NULL, NULL, NULL),
    (N'LeVar Burton',         N'Geordi La Forge',      'FC',   'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Michael Dorn',         N'Worf',                 'FC',   'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Gates McFadden',       N'Beverly Crusher',      'FC',   'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Marina Sirtis',        N'Deanna Troi',          'FC',   'Main', NULL, NULL, NULL, NULL, NULL),
    (N'James Cromwell',       N'Zefram Cochrane',      'FC',   'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Alfre Woodard',        N'Lily Sloane',          'FC',   'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Alice Krige',          N'Borg Queen',           'FC',   'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Dwight Schultz',       N'Reginald Barclay',     'FC',   'Cameo', NULL, NULL, NULL, NULL, NULL),
    (N'Robert Picardo',       N'The Doctor',           'FC',   'Cameo', NULL, NULL, NULL, NULL, NULL),

    (N'Patrick Stewart',      N'Jean-Luc Picard',      'INS',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Jonathan Frakes',      N'William Riker',        'INS',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Brent Spiner',         N'Data',                 'INS',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'LeVar Burton',         N'Geordi La Forge',      'INS',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Michael Dorn',         N'Worf',                 'INS',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Gates McFadden',       N'Beverly Crusher',      'INS',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Marina Sirtis',        N'Deanna Troi',          'INS',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'F. Murray Abraham',    N'Ru''afo',              'INS',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Donna Murphy',         N'Anij',                 'INS',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Anthony Zerbe',        N'Matthew Dougherty',    'INS',  'Supporting', NULL, NULL, NULL, NULL, NULL),

    (N'Patrick Stewart',      N'Jean-Luc Picard',      'NEM',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Jonathan Frakes',      N'William Riker',        'NEM',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Brent Spiner',         N'Data',                 'NEM',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'LeVar Burton',         N'Geordi La Forge',      'NEM',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Michael Dorn',         N'Worf',                 'NEM',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Gates McFadden',       N'Beverly Crusher',      'NEM',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Marina Sirtis',        N'Deanna Troi',          'NEM',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Tom Hardy',            N'Shinzon',              'NEM',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Brent Spiner',         N'B-4',                  'NEM',  'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Dina Meyer',           N'Donatra',              'NEM',  'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Kate Mulgrew',         N'Kathryn Janeway',      'NEM',  'Cameo', NULL, NULL, NULL, NULL, NULL),
    (N'Whoopi Goldberg',      N'Guinan',               'NEM',  'Cameo', NULL, NULL, NULL, NULL, NULL),
    (N'Wil Wheaton',          N'Wesley Crusher',       'NEM',  'Cameo', NULL, NULL, NULL, NULL, NULL),

    -- Kelvin timeline films: new actors play the Kelvin versions of the TOS crew.
    (N'Chris Pine',           N'James T. Kirk',        'ST09', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Zachary Quinto',       N'Spock',                'ST09', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Karl Urban',           N'Leonard McCoy',        'ST09', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Simon Pegg',           N'Montgomery Scott',     'ST09', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Zoe Saldaña',          N'Nyota Uhura',          'ST09', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'John Cho',             N'Hikaru Sulu',          'ST09', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Anton Yelchin',        N'Pavel Chekov',         'ST09', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Eric Bana',            N'Nero',                 'ST09', 'Main', NULL, NULL, NULL, N'Prime', N'Came back in time from the Prime timeline, creating the Kelvin timeline'),
    (N'Leonard Nimoy',        N'Spock',                'ST09', 'Supporting', NULL, NULL, NULL, N'Prime', NULL),
    (N'Bruce Greenwood',      N'Christopher Pike',     'ST09', 'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Ben Cross',            N'Sarek',                'ST09', 'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Winona Ryder',         N'Amanda Grayson',       'ST09', 'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Chris Hemsworth',      N'George Kirk',          'ST09', 'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Jennifer Morrison',    N'Winona Kirk',          'ST09', 'Supporting', NULL, NULL, NULL, NULL, NULL),

    (N'Chris Pine',           N'James T. Kirk',        'STID', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Zachary Quinto',       N'Spock',                'STID', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Karl Urban',           N'Leonard McCoy',        'STID', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Simon Pegg',           N'Montgomery Scott',     'STID', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Zoe Saldaña',          N'Nyota Uhura',          'STID', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'John Cho',             N'Hikaru Sulu',          'STID', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Anton Yelchin',        N'Pavel Chekov',         'STID', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Benedict Cumberbatch', N'Khan Noonien Singh',   'STID', 'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Alice Eve',            N'Carol Marcus',         'STID', 'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Peter Weller',         N'Alexander Marcus',     'STID', 'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Bruce Greenwood',      N'Christopher Pike',     'STID', 'Supporting', NULL, NULL, NULL, NULL, NULL),
    (N'Leonard Nimoy',        N'Spock',                'STID', 'Cameo', NULL, NULL, NULL, N'Prime', NULL),

    (N'Chris Pine',           N'James T. Kirk',        'STB',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Zachary Quinto',       N'Spock',                'STB',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Karl Urban',           N'Leonard McCoy',        'STB',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Simon Pegg',           N'Montgomery Scott',     'STB',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Zoe Saldaña',          N'Nyota Uhura',          'STB',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'John Cho',             N'Hikaru Sulu',          'STB',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Anton Yelchin',        N'Pavel Chekov',         'STB',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Idris Elba',           N'Krall',                'STB',  'Main', NULL, NULL, NULL, NULL, NULL),
    (N'Sofia Boutella',       N'Jaylah',               'STB',  'Main', NULL, NULL, NULL, NULL, NULL);

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

IF EXISTS (SELECT 1 FROM #AppearanceSource AS s WHERE s.TimelineName IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Timeline AS t WHERE t.Name = s.TimelineName))
BEGIN
    SELECT DISTINCT s.TimelineName AS UnknownTimeline FROM #AppearanceSource AS s WHERE s.TimelineName IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Timeline AS t WHERE t.Name = s.TimelineName);
    THROW 50023, N'Seed.Appearances: unknown timeline referenced.', 1;
END;

-- Series need a season range within the series' season count and a TV role; films need no seasons and a film role.
IF EXISTS (
    SELECT 1
    FROM #AppearanceSource AS s
    INNER JOIN dbo.Series AS sr ON sr.Abbreviation = s.SeriesAbbr
    WHERE (sr.ProductionType = 'Series' AND (s.FirstSeason IS NULL OR s.LastSeason IS NULL OR s.LastSeason > sr.SeasonCount
                                             OR s.RoleType NOT IN ('Main', 'Recurring', 'Guest')))
       OR (sr.ProductionType = 'Film'   AND (s.FirstSeason IS NOT NULL OR s.LastSeason IS NOT NULL
                                             OR s.RoleType NOT IN ('Main', 'Supporting', 'Cameo'))))
BEGIN
    SELECT s.ActorFullName, s.CharacterName, s.SeriesAbbr, sr.ProductionType, s.RoleType, s.FirstSeason, s.LastSeason, sr.SeasonCount
    FROM #AppearanceSource AS s
    INNER JOIN dbo.Series AS sr ON sr.Abbreviation = s.SeriesAbbr
    WHERE (sr.ProductionType = 'Series' AND (s.FirstSeason IS NULL OR s.LastSeason IS NULL OR s.LastSeason > sr.SeasonCount
                                             OR s.RoleType NOT IN ('Main', 'Recurring', 'Guest')))
       OR (sr.ProductionType = 'Film'   AND (s.FirstSeason IS NOT NULL OR s.LastSeason IS NOT NULL
                                             OR s.RoleType NOT IN ('Main', 'Supporting', 'Cameo')));
    THROW 50024, N'Seed.Appearances: role type or season range does not fit the production type (see result set above).', 1;
END;

IF EXISTS (SELECT 1 FROM #AppearanceSource AS s WHERE s.PerformanceType IS NOT NULL AND s.PerformanceType NOT IN ('On-screen', 'Voice'))
    THROW 50025, N'Seed.Appearances: unknown performance type.', 1;

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
    SELECT ac.ActorCharacterId, sr.SeriesId, s.RoleType, s.FirstSeason, s.LastSeason,
           ISNULL(s.PerformanceType, CASE sr.[Format] WHEN 'Animated' THEN 'Voice' ELSE 'On-screen' END) AS PerformanceType,
           ISNULL(t.TimelineId, sr.TimelineId) AS TimelineId
    FROM #AppearanceSource AS s
    INNER JOIN dbo.Actor AS a ON a.FullName = s.ActorFullName
    INNER JOIN dbo.[Character] AS c ON c.Name = s.CharacterName
    INNER JOIN dbo.ActorCharacter AS ac ON ac.ActorId = a.ActorId AND ac.CharacterId = c.CharacterId
    INNER JOIN dbo.Series AS sr ON sr.Abbreviation = s.SeriesAbbr
    LEFT JOIN dbo.Timeline AS t ON t.Name = s.TimelineName
) AS src
    ON tgt.ActorCharacterId = src.ActorCharacterId AND tgt.SeriesId = src.SeriesId
WHEN MATCHED AND EXISTS (
        SELECT tgt.RoleType, tgt.FirstSeason, tgt.LastSeason, tgt.PerformanceType, tgt.TimelineId
        EXCEPT
        SELECT src.RoleType, src.FirstSeason, src.LastSeason, src.PerformanceType, src.TimelineId)
    THEN UPDATE SET
        RoleType        = src.RoleType,
        FirstSeason     = src.FirstSeason,
        LastSeason      = src.LastSeason,
        PerformanceType = src.PerformanceType,
        TimelineId      = src.TimelineId
WHEN NOT MATCHED BY TARGET
    THEN INSERT (ActorCharacterId, SeriesId, RoleType, FirstSeason, LastSeason, PerformanceType, TimelineId)
         VALUES (src.ActorCharacterId, src.SeriesId, src.RoleType, src.FirstSeason, src.LastSeason, src.PerformanceType, src.TimelineId);

DROP TABLE #AppearanceSource;
