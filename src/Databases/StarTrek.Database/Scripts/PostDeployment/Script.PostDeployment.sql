/*
    Post-deployment script: seeds the Star Trek reference data.
    Every seed file is idempotent (MERGE on natural keys, no deletes), so publishing repeatedly is safe.
    Files are included in dependency order.
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

:r .\Seed.Lookups.sql
:r .\Seed.PlanetsSpecies.sql
:r .\Seed.Vessels.sql
:r .\Seed.Actors.sql
:r .\Seed.Characters.sql
:r .\Seed.Appearances.sql
:r .\Seed.Assignments.sql
:r .\Seed.Logs.sql

COMMIT TRANSACTION;

PRINT N'Star Trek seed data loaded.';
