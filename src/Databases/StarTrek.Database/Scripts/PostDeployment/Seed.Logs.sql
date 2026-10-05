/*
    Seed.Logs.sql
    LogType lookup plus sample crew logs, cross-references and tags.
    Each log carries a series (SeriesAbbr) because ships and characters span series.
    Log text is short, original paraphrase; stardates are illustrative, not canon-exact.
    Personal logs are Confidential/Private. Re-runnable: MERGE on natural keys.
*/
PRINT N'Seeding LogType...';

MERGE dbo.LogType AS tgt
USING (VALUES
    (N'Personal',                                   'Personal',   'Private'),
    (N'Captain''s',                                 'Command',    'Public'),
    (N'Chief Engineer''s',                          'Department', 'Public'),
    (N'Medical / Chief Medical Officer''s',         'Department', 'Confidential'),
    (N'Science Officer''s',                         'Department', 'Public'),
    (N'Tactical',                                   'Department', 'Classified'),
    (N'Security',                                   'Department', 'Classified'),
    (N'Counselor''s',                               'Department', 'Confidential'),
    (N'Operations',                                 'Department', 'Public')
) AS src (Name, Category, DefaultClassification)
    ON tgt.Name = src.Name
WHEN MATCHED AND (tgt.Category <> src.Category OR tgt.DefaultClassification <> src.DefaultClassification)
    THEN UPDATE SET Category = src.Category, DefaultClassification = src.DefaultClassification
WHEN NOT MATCHED BY TARGET
    THEN INSERT (Name, Category, DefaultClassification)
         VALUES (src.Name, src.Category, src.DefaultClassification);

PRINT N'Seeding Log...';

DROP TABLE IF EXISTS #LogSource;

CREATE TABLE #LogSource
(
    AuthorName      NVARCHAR(100)  NOT NULL,
    VesselKey       NVARCHAR(100)  NOT NULL,
    SeriesAbbr      VARCHAR(10)    NOT NULL,
    LogTypeName     NVARCHAR(50)   NOT NULL,
    Stardate        DECIMAL(10, 2) NOT NULL,
    Title           NVARCHAR(200)  NOT NULL,
    Content         NVARCHAR(MAX)  NOT NULL,
    Classification  VARCHAR(12)    NOT NULL,
    PRIMARY KEY (AuthorName, Stardate, Title),
    -- Tags and references identify a log by author + title, so that pair must be unique in the seed.
    UNIQUE (AuthorName, Title)
);

INSERT INTO #LogSource (AuthorName, VesselKey, SeriesAbbr, LogTypeName, Stardate, Title, Content, Classification)
VALUES
    -- TOS: USS Enterprise NCC-1701 (one incident: a survey of an uncharted system)
    (N'James T. Kirk',        N'NCC-1701', 'TOS',   N'Captain''s',                           2713.5, N'Survey of an uncharted system',
        N'Entered an unmapped system to begin a routine survey. The crew is in good spirits, though the sensors are picking up odd readings from the third planet.', 'Public'),
    (N'Spock',                N'NCC-1701', 'TOS',   N'Science Officer''s',                   2713.6, N'Anomalous readings from the survey',
        N'The third planet emits a faint, regular energy pattern that does not match any natural source in our records. I recommend further scans before any landing party is sent down.', 'Public'),
    (N'Montgomery Scott',     N'NCC-1701', 'TOS',   N'Chief Engineer''s',                    2713.7, N'Warp drive strain after survey',
        N'Holding station at the edge of the system has put extra strain on the warp coils. I have scheduled a full inspection and want the ship kept at low power until it is done.', 'Public'),
    (N'Leonard McCoy',        N'NCC-1701', 'TOS',   N'Medical / Chief Medical Officer''s',   2713.8, N'Crew fatigue report',
        N'Several crew members have reported headaches and poor sleep since we arrived. Nothing alarming yet, but I am logging every case in case it turns out to be linked to the planet.', 'Confidential'),
    (N'James T. Kirk',        N'NCC-1701', 'TOS',   N'Personal',                             2714.0, N'Late-night reflections',
        N'Hard to switch off tonight. Command means making calls that cannot be taken back, and I am not sure I always make the right ones. Writing it down helps.', 'Private'),

    -- SNW: USS Enterprise NCC-1701 (same ship as TOS, earlier era under Captain Pike)
    (N'Christopher Pike',     N'NCC-1701',   'SNW', N'Captain''s',                           2259.4, N'First weeks on a new mission',
        N'The crew is settling into a new survey rotation. Morale is high and the ship is running well. I want regular check-ins with each department head.', 'Public'),
    (N'Spock',                N'NCC-1701',   'SNW', N'Science Officer''s',                   2259.6, N'Calibrating the science labs',
        N'Recalibrated the stellar cartography and sensor labs after the refit. Readings are consistent, and I have documented the settings for the next shift.', 'Public'),

    -- TNG: USS Enterprise NCC-1701-D (one incident: a diplomatic escort mission)
    (N'Jean-Luc Picard',      N'NCC-1701-D', 'TNG', N'Captain''s',                           41153.7, N'Diplomatic escort underway',
        N'We are escorting a delegation to a sensitive summit. The ambassadors disagree on nearly everything, so I expect a long and delicate journey.', 'Public'),
    (N'Data',                 N'NCC-1701-D', 'TNG', N'Operations',                           41154.1, N'Sensor array recalibration',
        N'I recalibrated the main sensor array to improve long-range accuracy for the escort route. Error margins are down eleven percent, and all departments have the updated calibration tables.', 'Public'),
    (N'Deanna Troi',          N'NCC-1701-D', 'TNG', N'Counselor''s',                         41154.5, N'Crew stress after escort mission',
        N'Tension among the delegates is spilling over into the crew. I held two group sessions and will keep individual appointments open. No one is at risk, but morale needs attention.', 'Confidential'),
    (N'Worf',                 N'NCC-1701-D', 'TNG', N'Security',                             41155.0, N'Boarding drill and access audit',
        N'Ran a boarding drill and audited access to the guest quarters. Two door-lock weaknesses were found and fixed. Additional guards now cover the delegation decks.', 'Classified'),
    (N'Jean-Luc Picard',      N'NCC-1701-D', 'TNG', N'Personal',                             41156.2, N'On duty and diplomacy',
        N'Diplomacy tests patience more than any battle does. I find myself longing for a quiet hour with a book and a cup of tea.', 'Private'),

    -- DS9: Deep Space 9
    (N'Benjamin Sisko',       N'Deep Space 9', 'DS9', N'Captain''s',                         46000.1, N'Station defense readiness',
        N'Reviewed the station''s defensive readiness with senior staff. Several systems need repair, and I have asked for all available resources to be directed to the work.', 'Public'),
    (N'Julian Bashir',        N'Deep Space 9', 'DS9', N'Medical / Chief Medical Officer''s', 46000.5, N'Infirmary supply shortfall',
        N'Infirmary stocks of several common medicines are running low. I am rationing carefully and have filed a supply request. Patient records are attached to the restricted file.', 'Confidential'),
    (N'Miles O''Brien',       N'Deep Space 9', 'DS9', N'Operations',                         46001.2, N'Replicator and power grid repairs',
        N'Spent the shift rerouting power around a failing grid node and rebuilding a replicator that keeps dropping out. Everything is holding for now. Nothing here is built to spec.', 'Public'),

    -- VOY: USS Voyager (one incident: crossing uncharted space)
    (N'Kathryn Janeway',      N'NCC-74656', 'VOY',  N'Captain''s',                           48315.6, N'Course through uncharted space',
        N'We are charting a route through unexplored territory. Resources are limited, so every stop has to count. The crew is adapting well to the pressure.', 'Public'),
    (N'B''Elanna Torres',     N'NCC-74656', 'VOY',  N'Chief Engineer''s',                    48316.0, N'Power conservation measures',
        N'Implemented power rationing across non-essential systems. Engineering is running leaner, and I have asked every department to cut its replicator use.', 'Public'),
    (N'The Doctor',           N'NCC-74656', 'VOY',  N'Medical / Chief Medical Officer''s',   48316.4, N'Emergency holographic program notes',
        N'My program has been running for days with few breaks. I have asked the Captain to make time for a program check, and I have updated patient files for the crew.', 'Confidential'),
    (N'Tuvok',                N'NCC-74656', 'VOY',  N'Tactical',                             48317.0, N'Defensive posture review',
        N'Reviewed shield and weapons status against likely threats in this region. Phaser capacity is adequate, but torpedo reserves are limited. I advise caution before any engagement.', 'Classified'),
    (N'Harry Kim',            N'NCC-74656', 'VOY',  N'Operations',                           48317.5, N'Long-range sensor scheduling',
        N'Reworked the long-range sensor schedule so the array scans in rotation and shares power with other systems. Coverage drops slightly, but the savings are worth it.', 'Public'),
    (N'Kathryn Janeway',      N'NCC-74656', 'VOY',  N'Personal',                             48318.0, N'Weight of the journey',
        N'Everyone aboard depends on my decisions, and the way home is long. I try to show confidence. In private I allow myself a few doubts.', 'Private'),
    (N'Harry Kim',            N'NCC-74656', 'VOY',  N'Personal',                             48318.4, N'A letter I cannot send',
        N'Wrote another letter to my family tonight, knowing it will not reach them for years. It is still easier to carry the distance when I put it into words.', 'Confidential');

IF EXISTS (SELECT 1 FROM #LogSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.[Character] AS c WHERE c.Name = s.AuthorName))
    THROW 50040, N'Seed.Logs: unknown author referenced.', 1;

IF EXISTS (SELECT 1 FROM #LogSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.Vessel AS v WHERE v.VesselKey = s.VesselKey))
    THROW 50041, N'Seed.Logs: unknown vessel referenced.', 1;

IF EXISTS (SELECT 1 FROM #LogSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.LogType AS lt WHERE lt.Name = s.LogTypeName))
    THROW 50042, N'Seed.Logs: unknown log type referenced.', 1;

IF EXISTS (SELECT 1 FROM #LogSource AS s WHERE NOT EXISTS (SELECT 1 FROM dbo.Series AS sr WHERE sr.Abbreviation = s.SeriesAbbr))
    THROW 50046, N'Seed.Logs: unknown series referenced.', 1;

-- The author must have been posted to that vessel in that series.
IF EXISTS (
    SELECT 1
    FROM #LogSource AS s
    WHERE NOT EXISTS (
        SELECT 1
        FROM dbo.CharacterAssignment AS ca
        INNER JOIN dbo.[Character] AS c  ON c.CharacterId = ca.CharacterId
        INNER JOIN dbo.Vessel      AS v  ON v.VesselId = ca.VesselId
        INNER JOIN dbo.Series      AS sr ON sr.SeriesId = ca.SeriesId
        WHERE c.Name = s.AuthorName AND v.VesselKey = s.VesselKey AND sr.Abbreviation = s.SeriesAbbr))
    THROW 50047, N'Seed.Logs: author has no assignment on that vessel in that series.', 1;

-- Personal logs must never be Public or Classified.
IF EXISTS (SELECT 1 FROM #LogSource AS s WHERE s.LogTypeName = N'Personal' AND s.Classification NOT IN ('Confidential', 'Private'))
    THROW 50043, N'Seed.Logs: personal logs must be Confidential or Private.', 1;

MERGE dbo.[Log] AS tgt
USING (
    SELECT lt.LogTypeId, v.VesselId, sr.SeriesId, c.CharacterId AS AuthorCharacterId, s.Stardate, s.Title, s.Content, s.Classification
    FROM #LogSource AS s
    INNER JOIN dbo.LogType     AS lt ON lt.Name = s.LogTypeName
    INNER JOIN dbo.Vessel      AS v  ON v.VesselKey = s.VesselKey
    INNER JOIN dbo.Series      AS sr ON sr.Abbreviation = s.SeriesAbbr
    INNER JOIN dbo.[Character] AS c  ON c.Name = s.AuthorName
) AS src
    ON  tgt.AuthorCharacterId = src.AuthorCharacterId
    AND tgt.SeriesId = src.SeriesId
    AND tgt.Stardate = src.Stardate
    AND tgt.Title = src.Title
WHEN MATCHED AND EXISTS (
        SELECT tgt.LogTypeId, tgt.VesselId, tgt.Content, tgt.Classification
        EXCEPT
        SELECT src.LogTypeId, src.VesselId, src.Content, src.Classification)
    THEN UPDATE SET
        LogTypeId      = src.LogTypeId,
        VesselId       = src.VesselId,
        Content        = src.Content,
        Classification = src.Classification
WHEN NOT MATCHED BY TARGET
    THEN INSERT (LogTypeId, VesselId, SeriesId, AuthorCharacterId, Stardate, Title, Content, Classification)
         VALUES (src.LogTypeId, src.VesselId, src.SeriesId, src.AuthorCharacterId, src.Stardate, src.Title, src.Content, src.Classification);

-- Resolve each seed log to its exact row (full natural key, including series and stardate).
DROP TABLE IF EXISTS #LogKey;

SELECT l.LogId, s.AuthorName, s.Title
INTO #LogKey
FROM #LogSource AS s
INNER JOIN dbo.[Character] AS c  ON c.Name = s.AuthorName
INNER JOIN dbo.Series      AS sr ON sr.Abbreviation = s.SeriesAbbr
INNER JOIN dbo.[Log]       AS l  ON l.AuthorCharacterId = c.CharacterId AND l.SeriesId = sr.SeriesId AND l.Stardate = s.Stardate AND l.Title = s.Title;

PRINT N'Seeding LogReference...';

DROP TABLE IF EXISTS #LogReferenceSource;

CREATE TABLE #LogReferenceSource
(
    AuthorName            NVARCHAR(100) NOT NULL,
    Title                 NVARCHAR(200) NOT NULL,
    ReferencedAuthorName  NVARCHAR(100) NOT NULL,
    ReferencedTitle       NVARCHAR(200) NOT NULL,
    PRIMARY KEY (AuthorName, Title, ReferencedAuthorName, ReferencedTitle)
);

INSERT INTO #LogReferenceSource (AuthorName, Title, ReferencedAuthorName, ReferencedTitle)
VALUES
    (N'Spock',            N'Anomalous readings from the survey',  N'James T. Kirk',   N'Survey of an uncharted system'),
    (N'Montgomery Scott', N'Warp drive strain after survey',      N'James T. Kirk',   N'Survey of an uncharted system'),
    (N'Leonard McCoy',    N'Crew fatigue report',                 N'Spock',           N'Anomalous readings from the survey'),
    (N'Data',             N'Sensor array recalibration',          N'Jean-Luc Picard', N'Diplomatic escort underway'),
    (N'Deanna Troi',      N'Crew stress after escort mission',    N'Jean-Luc Picard', N'Diplomatic escort underway'),
    (N'Worf',             N'Boarding drill and access audit',     N'Jean-Luc Picard', N'Diplomatic escort underway'),
    (N'B''Elanna Torres', N'Power conservation measures',         N'Kathryn Janeway', N'Course through uncharted space'),
    (N'The Doctor',       N'Emergency holographic program notes', N'Kathryn Janeway', N'Course through uncharted space'),
    (N'Tuvok',            N'Defensive posture review',            N'Kathryn Janeway', N'Course through uncharted space'),
    (N'Harry Kim',        N'Long-range sensor scheduling',        N'B''Elanna Torres', N'Power conservation measures');

IF EXISTS (
    SELECT 1
    FROM #LogReferenceSource AS r
    WHERE NOT EXISTS (SELECT 1 FROM #LogKey AS k WHERE k.AuthorName = r.AuthorName AND k.Title = r.Title)
       OR NOT EXISTS (SELECT 1 FROM #LogKey AS k WHERE k.AuthorName = r.ReferencedAuthorName AND k.Title = r.ReferencedTitle))
    THROW 50044, N'Seed.Logs: unknown log referenced in LogReference.', 1;

MERGE dbo.LogReference AS tgt
USING (
    SELECT k.LogId, rk.LogId AS ReferencedLogId
    FROM #LogReferenceSource AS r
    INNER JOIN #LogKey AS k  ON k.AuthorName = r.AuthorName AND k.Title = r.Title
    INNER JOIN #LogKey AS rk ON rk.AuthorName = r.ReferencedAuthorName AND rk.Title = r.ReferencedTitle
) AS src
    ON tgt.LogId = src.LogId AND tgt.ReferencedLogId = src.ReferencedLogId
WHEN NOT MATCHED BY TARGET
    THEN INSERT (LogId, ReferencedLogId) VALUES (src.LogId, src.ReferencedLogId);

PRINT N'Seeding LogTag...';

DROP TABLE IF EXISTS #LogTagSource;

CREATE TABLE #LogTagSource
(
    AuthorName  NVARCHAR(100) NOT NULL,
    Title       NVARCHAR(200) NOT NULL,
    Tag         NVARCHAR(50)  NOT NULL,
    PRIMARY KEY (AuthorName, Title, Tag)
);

INSERT INTO #LogTagSource (AuthorName, Title, Tag)
VALUES
    (N'James T. Kirk',        N'Survey of an uncharted system',       N'survey'),
    (N'Spock',                N'Anomalous readings from the survey',  N'survey'),
    (N'Spock',                N'Anomalous readings from the survey',  N'anomaly'),
    (N'Montgomery Scott',     N'Warp drive strain after survey',      N'warp-core'),
    (N'Montgomery Scott',     N'Warp drive strain after survey',      N'survey'),
    (N'Leonard McCoy',        N'Crew fatigue report',                 N'crew-health'),
    (N'Leonard McCoy',        N'Crew fatigue report',                 N'survey'),
    (N'Christopher Pike',     N'First weeks on a new mission',        N'survey'),
    (N'Spock',                N'Calibrating the science labs',        N'sensors'),
    (N'Jean-Luc Picard',      N'Diplomatic escort underway',          N'diplomacy'),
    (N'Data',                 N'Sensor array recalibration',          N'sensors'),
    (N'Data',                 N'Sensor array recalibration',          N'diplomacy'),
    (N'Deanna Troi',          N'Crew stress after escort mission',    N'crew-health'),
    (N'Deanna Troi',          N'Crew stress after escort mission',    N'diplomacy'),
    (N'Worf',                 N'Boarding drill and access audit',     N'security'),
    (N'Worf',                 N'Boarding drill and access audit',     N'diplomacy'),
    (N'Benjamin Sisko',       N'Station defense readiness',           N'defense'),
    (N'Julian Bashir',        N'Infirmary supply shortfall',          N'supplies'),
    (N'Miles O''Brien',       N'Replicator and power grid repairs',   N'repairs'),
    (N'Kathryn Janeway',      N'Course through uncharted space',      N'exploration'),
    (N'B''Elanna Torres',     N'Power conservation measures',         N'power'),
    (N'B''Elanna Torres',     N'Power conservation measures',         N'exploration'),
    (N'The Doctor',           N'Emergency holographic program notes', N'crew-health'),
    (N'Tuvok',                N'Defensive posture review',            N'defense'),
    (N'Harry Kim',            N'Long-range sensor scheduling',        N'sensors'),
    (N'Harry Kim',            N'Long-range sensor scheduling',        N'power');

IF EXISTS (
    SELECT 1
    FROM #LogTagSource AS t
    WHERE NOT EXISTS (SELECT 1 FROM #LogKey AS k WHERE k.AuthorName = t.AuthorName AND k.Title = t.Title))
    THROW 50045, N'Seed.Logs: unknown log referenced in LogTag.', 1;

MERGE dbo.LogTag AS tgt
USING (
    SELECT k.LogId, t.Tag
    FROM #LogTagSource AS t
    INNER JOIN #LogKey AS k ON k.AuthorName = t.AuthorName AND k.Title = t.Title
) AS src
    ON tgt.LogId = src.LogId AND tgt.Tag = src.Tag
WHEN NOT MATCHED BY TARGET
    THEN INSERT (LogId, Tag) VALUES (src.LogId, src.Tag);

DROP TABLE #LogTagSource;
DROP TABLE #LogReferenceSource;
DROP TABLE #LogKey;
DROP TABLE #LogSource;
