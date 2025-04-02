SELECT * FROM migrants_bckp;

-- Controllo duplicati attraverso CTE

WITH CTE_Duplicati AS (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY "Incident Type", "Incident year", "Reported Month", "Region of Origin", "Region of Incident", "Country of Origin", 
"Number of Dead", "Minimum Estimated Number of Missing", "Total Number of Dead and Missing", "Number of Survivors", "Number of Females", 
"Number of Males", "Number of Children", "Cause of Death", "Migration route", "Location of death", "Information Source", "Coordinates", 
"UNSD Geographical Grouping") AS row_num 
FROM Migrants)
SELECT * FROM CTE_Duplicati 
WHERE row_num > 1;

/* -- Essendoci duplicati creo un'altra tabella con inclusa la colonna row_num dove poter operare
in quanto sulla CTE non si può operare con operazioni di UPDATE come DELETE, tabella che diventerà quella principale su cui lavorerò */

CREATE TABLE Migrants_bckp_duplicate (
LIKE migrants_bckp INCLUDING ALL);

ALTER TABLE Migrants_bckp_duplicate
ADD COLUMN row_num INT;

INSERT INTO migrants_bckp_duplicate
SELECT *,
ROW_NUMBER() OVER(PARTITION BY "Incident Type", "Incident year", "Reported Month", "Region of Origin", "Region of Incident", "Country of Origin", 
"Number of Dead", "Minimum Estimated Number of Missing", "Total Number of Dead and Missing", "Number of Survivors", "Number of Females", 
"Number of Males", "Number of Children", "Cause of Death", "Migration route", "Location of death", "Information Source", "Coordinates", 
"UNSD Geographical Grouping") AS row_num 
FROM Migrants;

-- Cancello tutte le righe con row_num > 1 ovvero i duplicati, in quanto con partition by solo le righe con tutte le colonne uguali hanno valore progressivo >1 --

DELETE FROM migrants_bckp_duplicate
WHERE row_num > 1;

-- Elimino la colonna row_num perché non mi serve più 

ALTER TABLE migrants_bckp_duplicate
DROP COLUMN row_num;

-- Controllo di eventuali numeri con due delimitatori per decine e migliaia che potrebbero creare problemi 

UNION ALL

SELECT 'Migration_route' AS column_name, "Migration_route" AS value
FROM Migrants
WHERE "Migration_route" ~ '\..*\..*'

UNION ALL

SELECT 'Location_of_death' AS column_name, "Location_of_death" AS value
FROM Migrants
WHERE "Location_of_death" ~ '\..*\..*'

UNION ALL

SELECT 'Information_Source' AS column_name, "Information_Source" AS value
FROM Migrants
WHERE "Information_Source" ~ '\..*\..*'

UNION ALL

SELECT 'Coordinates' AS column_name, "Coordinates" AS value
FROM Migrants
WHERE "Coordinates" ~ '\..*\..*'

UNION ALL

SELECT 'unsd_geographical_grouping' AS column_name, "unsd_geographical_grouping" AS value
FROM Migrants
WHERE "unsd_geographical_grouping" ~ '\..*\..*';

-- Modifica datatype con NULL al posto dei valori vuoti

ALTER TABLE migrants
    ALTER COLUMN incident_type TYPE VARCHAR(255) USING NULLIF(incident_type, '')::VARCHAR(255),
    ALTER COLUMN incident_year TYPE INT USING NULLIF(incident_year, '')::INT,
    ALTER COLUMN reported_month TYPE VARCHAR(50) USING NULLIF(reported_month, '')::VARCHAR(50),
    ALTER COLUMN region_of_origin TYPE VARCHAR(255) USING NULLIF(region_of_origin, '')::VARCHAR(255),
    ALTER COLUMN region_of_incident TYPE VARCHAR(255) USING NULLIF(region_of_incident, '')::VARCHAR(255),
    ALTER COLUMN country_of_origin TYPE VARCHAR(255) USING NULLIF(country_of_origin, '')::VARCHAR(255),
    ALTER COLUMN number_of_dead TYPE INT USING NULLIF(number_of_dead, '')::INT,
    ALTER COLUMN minimum_estimated_number_of_missing TYPE INT USING NULLIF(minimum_estimated_number_of_missing, '')::INT,
    ALTER COLUMN total_number_of_dead_and_missing TYPE INT USING NULLIF(total_number_of_dead_and_missing, '')::INT,
    ALTER COLUMN number_of_survivors TYPE INT USING NULLIF(number_of_survivors, '')::INT,
    ALTER COLUMN number_of_females TYPE INT USING NULLIF(number_of_females, '')::INT,
    ALTER COLUMN number_of_males TYPE INT USING NULLIF(number_of_males, '')::INT,
    ALTER COLUMN number_of_children TYPE INT USING NULLIF(number_of_children, '')::INT,
    ALTER COLUMN cause_of_death TYPE VARCHAR(255) USING NULLIF(cause_of_death, '')::VARCHAR(255),
    ALTER COLUMN migration_route TYPE VARCHAR(255) USING NULLIF(migration_route, '')::VARCHAR(255),
    ALTER COLUMN location_of_death TYPE TEXT USING NULLIF(location_of_death, '')::TEXT,
    ALTER COLUMN information_source TYPE TEXT USING NULLIF(information_source, '')::TEXT,
    ALTER COLUMN coordinates TYPE VARCHAR(50) USING NULLIF(coordinates, '')::VARCHAR(50),
    ALTER COLUMN unsd_geographical_grouping TYPE VARCHAR(255) USING NULLIF(unsd_geographical_grouping, '')::VARCHAR(255);





