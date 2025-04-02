-- Creazione tabella e tabella backup

CREATE TABLE sustainable_energy_data (
    Entity VARCHAR(255),
    Year INT,
    Access_to_electricity_percentage TEXT,
    Access_to_clean_fuels_for_cooking TEXT,
    Renewable_electricity_generating_capacity_per_capita TEXT,
    Financial_flows_to_developing_countries_usd TEXT,
    Renewable_energy_share_in_total_final_energy_consumption_percentage TEXT,
    Electricity_from_fossil_fuels_TWh TEXT,
    Electricity_from_nuclear_TWh TEXT,
    Electricity_from_renewables_TWh TEXT,
    Low_carbon_electricity_percentage TEXT,
    Primary_energy_consumption_per_capita_kWh_person TEXT,
    Energy_intensity_level_of_primary_energy_MJ_per_dollar TEXT,
    Value_co2_emissions_kt_by_country TEXT,
    Renewables_percentage_equivalent_primary_energy TEXT,
    gdp_growth TEXT,
    gdp_per_capita TEXT,
    Density_P_Km2 VARCHAR(50),
    Land_Area_Km2 TEXT,
    Latitude TEXT,
    Longitude TEXT
);

CREATE TABLE sustainable_energy_data_bckp
AS TABLE sustainable_energy_data;

SELECT * FROM sustainable_energy_data;

/* -- Rimuovere eventuali duplicati con un comando row_number 
per assegnare ad ogni riga il valore 1 che diventa progessivo 
in caso di colonne uguali grazie al partition by su ognuna di esse */

WITH cte_duplicati AS (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY 
		Entity, 
        Year, 
        Access_to_electricity_percentage, 
        Access_to_clean_fuels_for_cooking, 
        Renewable_electricity_generating_capacity_per_capita, 
        Financial_flows_to_developing_countries_usd, 
        Renewable_energy_share_in_total_final_energy_consumption_percentage, 
        Electricity_from_fossil_fuels_TWh, 
        Electricity_from_nuclear_TWh, 
        Electricity_from_renewables_TWh, 
        Low_carbon_electricity_percentage, 
        Primary_energy_consumption_per_capita_kWh_person, 
        Energy_intensity_level_of_primary_energy_MJ_per_dollar, 
        Value_co2_emissions_kt_by_country, 
        Renewables_percentage_equivalent_primary_energy, 
        gdp_growth, 
        gdp_per_capita, 
        Density_P_Km2, 
        Land_Area_Km2, 
        Latitude, 
        Longitude) AS row_num
	FROM sustainable_energy_data
)
SELECT * FROM cte_duplicati
WHERE row_num > 1;

-- Controllo della presenza di virgole che potrebbero creare problemi

SELECT *
FROM sustainable_energy_data
WHERE 
    Access_to_electricity_percentage LIKE '%,%' OR
    Access_to_clean_fuels_for_cooking LIKE '%,%' OR
    Renewable_electricity_generating_capacity_per_capita LIKE '%,%' OR
    Financial_flows_to_developing_countries_usd LIKE '%,%' OR
    Renewable_energy_share_in_total_final_energy_consumption_percentage LIKE '%,%' OR
    Electricity_from_fossil_fuels_TWh LIKE '%,%' OR
    Electricity_from_nuclear_TWh LIKE '%,%' OR
    Electricity_from_renewables_TWh LIKE '%,%' OR
    Low_carbon_electricity_percentage LIKE '%,%' OR
    Primary_energy_consumption_per_capita_kWh_person LIKE '%,%' OR
    Energy_intensity_level_of_primary_energy_MJ_per_dollar LIKE '%,%' OR
    Value_co2_emissions_kt_by_country LIKE '%,%' OR
    Renewables_percentage_equivalent_primary_energy LIKE '%,%' OR
    gdp_growth LIKE '%,%' OR
    gdp_per_capita LIKE '%,%' OR
    Density_P_Km2 LIKE '%,%' OR
    Land_Area_Km2 LIKE '%,%' OR
    Latitude LIKE '%,%' OR
    Longitude LIKE '%,%';

-- Controllo di numeri con due o più punti per evitare più di un separatore nei numeri

SELECT 'Access_to_electricity_percentage' AS column_name, Access_to_electricity_percentage AS value
FROM sustainable_energy_data
WHERE Access_to_electricity_percentage ~ '\..*\..*'

UNION ALL

SELECT 'Access_to_clean_fuels_for_cooking' AS column_name, Access_to_clean_fuels_for_cooking AS value
FROM sustainable_energy_data
WHERE Access_to_clean_fuels_for_cooking ~ '\..*\..*'

UNION ALL

SELECT 'Renewable_electricity_generating_capacity_per_capita' AS column_name, Renewable_electricity_generating_capacity_per_capita AS value
FROM sustainable_energy_data
WHERE Renewable_electricity_generating_capacity_per_capita ~ '\..*\..*'

UNION ALL

SELECT 'Financial_flows_to_developing_countries_usd' AS column_name, Financial_flows_to_developing_countries_usd AS value
FROM sustainable_energy_data
WHERE Financial_flows_to_developing_countries_usd ~ '\..*\..*'

UNION ALL

SELECT 'Renewable_energy_share_in_total_final_energy_consumption_percentage' AS column_name, Renewable_energy_share_in_total_final_energy_consumption_percentage AS value
FROM sustainable_energy_data
WHERE Renewable_energy_share_in_total_final_energy_consumption_percentage ~ '\..*\..*'

UNION ALL

SELECT 'Electricity_from_fossil_fuels_TWh' AS column_name, Electricity_from_fossil_fuels_TWh AS value
FROM sustainable_energy_data
WHERE Electricity_from_fossil_fuels_TWh ~ '\..*\..*'

UNION ALL

SELECT 'Electricity_from_nuclear_TWh' AS column_name, Electricity_from_nuclear_TWh AS value
FROM sustainable_energy_data
WHERE Electricity_from_nuclear_TWh ~ '\..*\..*'

UNION ALL

SELECT 'Electricity_from_renewables_TWh' AS column_name, Electricity_from_renewables_TWh AS value
FROM sustainable_energy_data
WHERE Electricity_from_renewables_TWh ~ '\..*\..*'

UNION ALL

SELECT 'Low_carbon_electricity_percentage' AS column_name, Low_carbon_electricity_percentage AS value
FROM sustainable_energy_data
WHERE Low_carbon_electricity_percentage ~ '\..*\..*'

UNION ALL

SELECT 'Primary_energy_consumption_per_capita_kWh_person' AS column_name, Primary_energy_consumption_per_capita_kWh_person AS value
FROM sustainable_energy_data
WHERE Primary_energy_consumption_per_capita_kWh_person ~ '\..*\..*'

UNION ALL

SELECT 'Energy_intensity_level_of_primary_energy_MJ_per_dollar' AS column_name, Energy_intensity_level_of_primary_energy_MJ_per_dollar AS value
FROM sustainable_energy_data
WHERE Energy_intensity_level_of_primary_energy_MJ_per_dollar ~ '\..*\..*'

UNION ALL

SELECT 'Value_co2_emissions_kt_by_country' AS column_name, Value_co2_emissions_kt_by_country AS value
FROM sustainable_energy_data
WHERE Value_co2_emissions_kt_by_country ~ '\..*\..*'

UNION ALL

SELECT 'Renewables_percentage_equivalent_primary_energy' AS column_name, Renewables_percentage_equivalent_primary_energy AS value
FROM sustainable_energy_data
WHERE Renewables_percentage_equivalent_primary_energy ~ '\..*\..*'

UNION ALL

SELECT 'gdp_growth' AS column_name, gdp_growth AS value
FROM sustainable_energy_data
WHERE gdp_growth ~ '\..*\..*'

UNION ALL

SELECT 'gdp_per_capita' AS column_name, gdp_per_capita AS value
FROM sustainable_energy_data
WHERE gdp_per_capita ~ '\..*\..*'

UNION ALL

SELECT 'Density_P_Km2' AS column_name, Density_P_Km2 AS value
FROM sustainable_energy_data
WHERE Density_P_Km2 ~ '\..*\..*'

UNION ALL

SELECT 'Land_Area_Km2' AS column_name, Land_Area_Km2 AS value
FROM sustainable_energy_data
WHERE Land_Area_Km2 ~ '\..*\..*'

UNION ALL

SELECT 'Latitude' AS column_name, Latitude AS value
FROM sustainable_energy_data
WHERE Latitude ~ '\..*\..*'

UNION ALL

SELECT 'Longitude' AS column_name, Longitude AS value
FROM sustainable_energy_data
WHERE Longitude ~ '\..*\..*';

-- TRIM per togliere eventuali spazi bianchi all'inizio o alla fine 

UPDATE sustainable_energy_data
SET 
    Access_to_electricity_percentage = TRIM(Access_to_electricity_percentage),
    Access_to_clean_fuels_for_cooking = TRIM(Access_to_clean_fuels_for_cooking),
    Renewable_electricity_generating_capacity_per_capita = TRIM(Renewable_electricity_generating_capacity_per_capita),
    Financial_flows_to_developing_countries_usd = TRIM(Financial_flows_to_developing_countries_usd),
    Renewable_energy_share_in_total_final_energy_consumption_percentage = TRIM(Renewable_energy_share_in_total_final_energy_consumption_percentage),
    Electricity_from_fossil_fuels_TWh = TRIM(Electricity_from_fossil_fuels_TWh),
    Electricity_from_nuclear_TWh = TRIM(Electricity_from_nuclear_TWh),
    Electricity_from_renewables_TWh = TRIM(Electricity_from_renewables_TWh),
    Low_carbon_electricity_percentage = TRIM(Low_carbon_electricity_percentage),
    Primary_energy_consumption_per_capita_kWh_person = TRIM(Primary_energy_consumption_per_capita_kWh_person),
    Energy_intensity_level_of_primary_energy_MJ_per_dollar = TRIM(Energy_intensity_level_of_primary_energy_MJ_per_dollar),
    Value_co2_emissions_kt_by_country = TRIM(Value_co2_emissions_kt_by_country),
    Renewables_percentage_equivalent_primary_energy = TRIM(Renewables_percentage_equivalent_primary_energy),
    gdp_growth = TRIM(gdp_growth),
    gdp_per_capita = TRIM(gdp_per_capita),
    Density_P_Km2 = TRIM(Density_P_Km2),
    Land_Area_Km2 = TRIM(Land_Area_Km2),
    Latitude = TRIM(Latitude),
    Longitude = TRIM(Longitude);

-- Modifica Datatype Colonne e valori null a record vuoti

ALTER TABLE sustainable_energy_data
	ALTER COLUMN access_to_electricity_percentage TYPE FLOAT USING NULLIF(access_to_electricity_percentage,'')::FLOAT,
	ALTER COLUMN access_to_clean_fuels_for_cooking TYPE FLOAT USING NULLIF(access_to_clean_fuels_for_cooking,'')::FLOAT,
	ALTER COLUMN renewable_electricity_generating_capacity_per_capita TYPE FLOAT USING NULLIF(renewable_electricity_generating_capacity_per_capita,'')::FLOAT,
	ALTER COLUMN financial_flows_to_developing_countries_usd TYPE BIGINT USING NULLIF(financial_flows_to_developing_countries_usd,'')::BIGINT,
	ALTER COLUMN renewable_energy_share_in_total_final_energy_consumption_percen TYPE FLOAT USING NULLIF(renewable_energy_share_in_total_final_energy_consumption_percen,'')::FLOAT,
	ALTER COLUMN electricity_from_fossil_fuels_twh TYPE FLOAT USING NULLIF(electricity_from_fossil_fuels_twh,'')::FLOAT,
	ALTER COLUMN electricity_from_nuclear_twh TYPE FLOAT USING NULLIF(electricity_from_nuclear_twh,'')::FLOAT,
	ALTER COLUMN electricity_from_renewables_twh TYPE FLOAT USING NULLIF(electricity_from_renewables_twh,'')::FLOAT,
	ALTER COLUMN low_carbon_electricity_percentage TYPE FLOAT USING NULLIF(low_carbon_electricity_percentage,'')::FLOAT,
	ALTER COLUMN primary_energy_consumption_per_capita_kwh_person TYPE FLOAT USING NULLIF(primary_energy_consumption_per_capita_kwh_person,'')::FLOAT,
	ALTER COLUMN energy_intensity_level_of_primary_energy_mj_per_dollar TYPE FLOAT USING NULLIF(energy_intensity_level_of_primary_energy_mj_per_dollar,'')::FLOAT,
	ALTER COLUMN value_co2_emissions_kt_by_country TYPE FLOAT USING NULLIF(value_co2_emissions_kt_by_country,'')::FLOAT,
	ALTER COLUMN renewables_percentage_equivalent_primary_energy TYPE FLOAT USING NULLIF(renewables_percentage_equivalent_primary_energy,'')::FLOAT,
	ALTER COLUMN gdp_growth TYPE FLOAT USING NULLIF(gdp_growth,'')::FLOAT,
	ALTER COLUMN gdp_per_capita TYPE FLOAT USING NULLIF(gdp_per_capita,'')::FLOAT,
	ALTER COLUMN density_p_km2 TYPE FLOAT USING NULLIF(density_p_km2,'')::FLOAT,
	ALTER COLUMN land_area_km2 TYPE INT USING NULLIF(land_area_km2,'')::FLOAT,
	ALTER COLUMN latitude TYPE FLOAT USING NULLIF(latitude,'')::FLOAT,
	ALTER COLUMN longitude TYPE FLOAT USING NULLIF(longitude,'')::FLOAT;





