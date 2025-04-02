--Creazione tabella
CREATE TABLE World_Data_2023 (
    Country TEXT,
    Density_P_Km2 TEXT, 
    Abbreviation TEXT,
    Agricultural_Land TEXT,
    Land_Area_Km2 TEXT,
    Armed_Forces_Size TEXT,
    Birth_Rate TEXT,
    Calling_Code TEXT,
    Capital_or_Major_City TEXT,
    CO2_Emissions TEXT,
    CPI TEXT,
    CPI_Change_Percent TEXT,
    Currency_Code TEXT,
    Fertility_Rate TEXT,
    Forested_Area_Percent TEXT,
    Gasoline_Price TEXT,
    GDP TEXT,
    Gross_Primary_Education_Enrollment TEXT,
    Gross_Tertiary_Education_Enrollment TEXT,
    Infant_mortality TEXT,
    Largest_city TEXT,
    Life_expectancy TEXT,
    Maternal_mortality_ratio TEXT,
    Minimum_wage TEXT,
    Official_language TEXT,
    Out_Of_Pocket_Health_Expenditure TEXT,
    Physicians_Ter_Thousand TEXT,
    Population TEXT,
    Labor_Force_Participation TEXT,
    Tax_revenue_percent TEXT,
    Total_Tax_Rate TEXT,
    Unemployment_Rate TEXT,
    Urban_Population TEXT,
    Latitude TEXT,
    Longitude TEXT
);

-- Creazione Tabella1 di copia per lavorare
CREATE TABLE World_Data_2023_Copy (
LIKE World_Data_2023 INCLUDING ALL
);

INSERT INTO World_Data_2023_copy 
SELECT * 
FROM World_Data_2023;

SELECT *
FROM world_data_2023;


/* -- Rimuovere eventuali duplicati con un comando row_number 
per assegnare ad ogni riga il valore 1 che diventa progessivo 
in caso di colonne uguali grazie al partition by su ognuna di esse */

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY Country, 
        Density_P_Km2, 
        Abbreviation, 
        Agricultural_Land, 
        Land_Area_Km2, 
        Armed_Forces_Size, 
        Birth_Rate, 
        Calling_Code, 
        Capital_or_Major_City, 
        CO2_Emissions, 
        CPI, 
        CPI_Change_Percent, 
        Currency_Code, 
        Fertility_Rate, 
        Forested_Area_Percent, 
        Gasoline_Price, 
        GDP, 
        Gross_Primary_Education_Enrollment, 
        Gross_Tertiary_Education_Enrollment, 
        Infant_mortality, 
        Largest_city, 
        Life_expectancy, 
        Maternal_mortality_ratio, 
        Minimum_wage, 
        Official_language, 
        Out_Of_Pocket_Health_Expenditure, 
        Physicians_Ter_Thousand, 
        Population, 
        Labor_Force_Participation, 
        Tax_revenue_percent, 
        Total_Tax_Rate, 
        Unemployment_Rate, 
        Urban_Population, 
        Latitude, 
        Longitude
) AS row_num
FROM world_data_2023;

-- Modifica delimitatore numeri (da virgola a punto)

UPDATE World_Data_2023
SET 
	density_p_km2 = REPLACE(density_p_km2, ',','.'),
	land_area_km2 = REPLACE(land_area_km2, ',','.'),
	cpi = REPLACE(cpi, ',','.'),
	armed_forces_size = REPLACE(armed_forces_size, ',','.'),
	co2_emissions = REPLACE(co2_emissions, ',','.'),
	gdp = REPLACE(gdp, ',','.'),
	population = REPLACE(population, ',','.'),
	urban_population = REPLACE(urban_population, ',','.');

WITH CTE_duplicati AS (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY Country, 
        Density_P_Km2, 
        Abbreviation, 
        Agricultural_Land, 
        Land_Area_Km2, 
        Armed_Forces_Size, 
        Birth_Rate, 
        Calling_Code, 
        Capital_or_Major_City, 
        CO2_Emissions, 
        CPI, 
        CPI_Change_Percent, 
        Currency_Code, 
        Fertility_Rate, 
        Forested_Area_Percent, 
        Gasoline_Price, 
        GDP, 
        Gross_Primary_Education_Enrollment, 
        Gross_Tertiary_Education_Enrollment, 
        Infant_mortality, 
        Largest_city, 
        Life_expectancy, 
        Maternal_mortality_ratio, 
        Minimum_wage, 
        Official_language, 
        Out_Of_Pocket_Health_Expenditure, 
        Physicians_Ter_Thousand, 
        Population, 
        Labor_Force_Participation, 
        Tax_revenue_percent, 
        Total_Tax_Rate, 
        Unemployment_Rate, 
        Urban_Population, 
        Latitude, 
        Longitude) AS row_num
FROM world_data_2023
)

SELECT * FROM CTE_duplicati
WHERE row_num > 1;

-- Modificare il separatore dei numeri da virgola a punto ed eliminare i punti se sono più di uno e possono creare problemi 

UPDATE World_Data_2023
SET 
    Density_P_Km2 = REPLACE(Density_P_Km2, ',', '.'),
    Agricultural_Land = REPLACE(Agricultural_Land, ',', '.'),
    Land_Area_Km2 = REPLACE(Land_Area_Km2, ',', '.'),
    Armed_Forces_Size = REPLACE(Armed_Forces_Size, ',', '.'),
    Birth_Rate = REPLACE(Birth_Rate, ',', '.'),
    CO2_Emissions = REPLACE(CO2_Emissions, ',', '.'),
    CPI = REPLACE(CPI, ',', '.'),
    CPI_Change_Percent = REPLACE(CPI_Change_Percent, ',', '.'),
    Fertility_Rate = REPLACE(Fertility_Rate, ',', '.'),
    Forested_Area_Percent = REPLACE(Forested_Area_Percent, ',', '.'),
    Gasoline_Price = REPLACE(Gasoline_Price, ',', '.'),
    GDP = REPLACE(GDP, ',', '.'),
    Gross_Primary_Education_Enrollment = REPLACE(Gross_Primary_Education_Enrollment, ',', '.'),
    Gross_Tertiary_Education_Enrollment = REPLACE(Gross_Tertiary_Education_Enrollment, ',', '.'),
    Infant_mortality = REPLACE(Infant_mortality, ',', '.'),
	Life_Expectancy = REPLACE(Life_Expectancy, ',', '.'),
    Maternal_mortality_ratio = REPLACE(Maternal_mortality_ratio, ',', '.'),
    Minimum_wage = REPLACE(Minimum_wage, ',', '.'),
    Out_Of_Pocket_Health_Expenditure = REPLACE(Out_Of_Pocket_Health_Expenditure, ',', '.'),
    Physicians_Ter_Thousand = REPLACE(Physicians_Ter_Thousand, ',', '.'),
    Population = REPLACE(Population, ',', '.'),
    Labor_Force_Participation = REPLACE(Labor_Force_Participation, ',', '.'),
    Tax_revenue_percent = REPLACE(Tax_revenue_percent, ',', '.'),
    Total_Tax_Rate = REPLACE(Total_Tax_Rate, ',', '.'),
    Unemployment_Rate = REPLACE(Unemployment_Rate, ',', '.'),
    Urban_Population = REPLACE(Urban_Population, ',', '.'),
    Latitude = REPLACE(Latitude, ',', '.'),
    Longitude = REPLACE(Longitude, ',', '.');

UPDATE World_Data_2023
SET 
	land_area_km2 = REPLACE(land_area_km2, '.', ''),
 	armed_forces_size = REPLACE(armed_forces_size, '.', ''),
	co2_emissions = REPLACE(co2_emissions, '.', ''),
 	gdp = REPLACE(gdp, '.', ''),
	population = REPLACE(population, '.', ''),
	urban_population = REPLACE(urban_population, '.', '');

-- Eliminazione del primo punto nei numeri con il secondo che funge da separatore decimale

UPDATE World_Data_2023
SET cpi = REGEXP_REPLACE(cpi, '\.(?=.*\.)', '')
WHERE cpi LIKE '%.%.%';
	
-- Modificare valori speciali non visibili o che potrebbero creare problemi

UPDATE World_Data_2023
SET 
    Country = CASE
        WHEN Country = 'S�����������' THEN 'São Tomé e Príncipe'
        ELSE Country
    END,
    
    Capital_or_Major_City = CASE
        WHEN Capital_or_Major_City = 'Bras���' THEN 'Brasilia'
		WHEN Capital_or_Major_City = 'Yaound�' THEN 'Yaoundé'
		WHEN Capital_or_Major_City = 'Bogot�' THEN 'Bogotà'
		WHEN Capital_or_Major_City = 'San Jos������' THEN 'San José'
		WHEN Capital_or_Major_City = 'Reykjav��' THEN 'Reykjavík'
		WHEN Capital_or_Major_City = 'Mal�' THEN 'Malé'
		WHEN Capital_or_Major_City = 'Chi����' THEN 'Chișinău'
		WHEN Capital_or_Major_City = 'Asunci��' THEN 'Asunción'
		WHEN Capital_or_Major_City = 'S����' THEN 'San Josè'
		WHEN Capital_or_Major_City = 'Lom�' THEN 'Lomé'
		WHEN Capital_or_Major_City = 'Nuku����' THEN 'Nukuʻalofa'
    	ELSE Capital_or_Major_City
    END,

	Largest_city = CASE
		WHEN Largest_city = 'S����' THEN 'São Paulo'
		WHEN Largest_city = 'Bogot�' THEN 'Bogotà'
		WHEN Largest_city = 'Statos�������' THEN 'Nicosia'
		WHEN Largest_city = 'San Jos������' THEN 'San José'
		WHEN Largest_city = 'Reykjav��' THEN 'Reykjavík'
		WHEN Largest_city = 'Mal�' THEN 'Malé'
		WHEN Largest_city = 'Chi����' THEN 'Chișinău'
		WHEN Largest_city = 'S����' THEN 'São Tomé'
		WHEN Largest_city = 'S�����' THEN 'Stokholm'
		WHEN Largest_city = 'Z���' THEN 'Zurigo'
		WHEN Largest_city = 'Lom�' THEN 'Lomé'
		WHEN Largest_city = 'Nuku����' THEN 'Nukuʻalofa'
		ELSE Largest_city
	END;

UPDATE World_Data_2023

SET 
	Gasoline_price = REPLACE(Gasoline_price, '$',''),
	GDP = REPLACE(GDP, '$',''),
	Minimum_wage = REPLACE(Minimum_wage, '$','');

-- TRIM per togliere eventuali spazi bianchi all'inizio o alla fine

UPDATE World_Data_2023
SET 
    Country = TRIM(Country),
    Density_P_Km2 = TRIM(Density_P_Km2),
    Abbreviation = TRIM(Abbreviation),
    Agricultural_Land = TRIM(Agricultural_Land),
    Land_Area_Km2 = TRIM(Land_Area_Km2),
    Armed_Forces_Size = TRIM(Armed_Forces_Size),
    Birth_Rate = TRIM(Birth_Rate),
    Calling_Code = TRIM(Calling_Code),
    Capital_or_Major_City = TRIM(Capital_or_Major_City),
    CO2_Emissions = TRIM(CO2_Emissions),
    CPI = TRIM(CPI),
    CPI_Change_Percent = TRIM(CPI_Change_Percent),
    Currency_Code = TRIM(Currency_Code),
    Fertility_Rate = TRIM(Fertility_Rate),
    Forested_Area_Percent = TRIM(Forested_Area_Percent),
    Gasoline_Price = TRIM(Gasoline_Price),
    GDP = TRIM(GDP),
    Gross_Primary_Education_Enrollment = TRIM(Gross_Primary_Education_Enrollment),
    Gross_Tertiary_Education_Enrollment = TRIM(Gross_Tertiary_Education_Enrollment),
    Infant_mortality = TRIM(Infant_mortality),
    Largest_city = TRIM(Largest_city),
    Life_expectancy = TRIM(Life_expectancy),
    Maternal_mortality_ratio = TRIM(Maternal_mortality_ratio),
    Minimum_wage = TRIM(Minimum_wage),
    Official_language = TRIM(Official_language),
    Out_Of_Pocket_Health_Expenditure = TRIM(Out_Of_Pocket_Health_Expenditure),
    Physicians_Ter_Thousand = TRIM(Physicians_Ter_Thousand),
    Population = TRIM(Population),
    Labor_Force_Participation = TRIM(Labor_Force_Participation),
    Tax_revenue_percent = TRIM(Tax_revenue_percent),
    Total_Tax_Rate = TRIM(Total_Tax_Rate),
    Unemployment_Rate = TRIM(Unemployment_Rate),
    Urban_Population = TRIM(Urban_Population),
    Latitude = TRIM(Latitude),
    Longitude = TRIM(Longitude);

 /* -- Modifica tipo dati da TEXT al 
 tipo che reputo più consono. Uso di NULLIF al posto dei valori bianchi per evitare problemi nella conversione 
 in NUMERIC o INT*/

ALTER TABLE World_Data_2023
	ALTER COLUMN Country TYPE VARCHAR(50) USING NULLIF(country,'')::VARCHAR(50),
	ALTER COLUMN density_p_km2 TYPE NUMERIC USING NULLIF(density_p_km2,'')::NUMERIC,
	ALTER COLUMN abbreviation TYPE VARCHAR(10) USING NULLIF(abbreviation, '')::VARCHAR(10),
	ALTER COLUMN agricultural_land TYPE NUMERIC USING NULLIF(agricultural_land,'')::NUMERIC,
	ALTER COLUMN land_area_km2 TYPE VARCHAR(255) USING NULLIF(land_area_km2,'')::VARCHAR(255),
	ALTER COLUMN armed_forces_size TYPE VARCHAR(255) USING NULLIF(armed_forces_size,'')::VARCHAR(255),
	ALTER COLUMN birth_rate TYPE NUMERIC USING NULLIF(birth_rate,'')::NUMERIC,
	ALTER COLUMN calling_code TYPE INT USING calling_code::INT,
	ALTER COLUMN capital_or_major_city TYPE VARCHAR(100) USING NULLIF(capital_or_major_city,'')::VARCHAR(100),
	ALTER COLUMN co2_emissions TYPE VARCHAR(50) USING NULLIF(co2_emissions,'')::VARCHAR(50),
	ALTER COLUMN cpi TYPE VARCHAR(20) USING NULLIF(cpi,'')::VARCHAR(20),
	ALTER COLUMN cpi_change_percent TYPE NUMERIC USING NULLIF(cpi_change_percent,'')::NUMERIC,
	ALTER COLUMN currency_code TYPE VARCHAR(10) USING NULLIF(currency_code,'')::VARCHAR(10),
	ALTER COLUMN fertility_rate TYPE NUMERIC USING NULLIF(fertility_rate,'')::NUMERIC,
	ALTER COLUMN forested_area_percent TYPE NUMERIC USING NULLIF(forested_area_percent,'')::NUMERIC,
	ALTER COLUMN gasoline_price TYPE NUMERIC USING NULLIF(gasoline_price,'')::NUMERIC,
	ALTER COLUMN gdp TYPE VARCHAR(30) USING NULLIF(gdp,'')::VARCHAR(30),
	ALTER COLUMN gross_primary_education_enrollment TYPE NUMERIC USING NULLIF(gross_primary_education_enrollment,'')::NUMERIC,
	ALTER COLUMN gross_tertiary_education_enrollment TYPE NUMERIC USING NULLIF(gross_tertiary_education_enrollment,'')::NUMERIC,
	ALTER COLUMN infant_mortality TYPE NUMERIC USING NULLIF(infant_mortality,'')::NUMERIC,
	ALTER COLUMN largest_city TYPE VARCHAR(50) USING NULLIF(infant_mortality,'')::VARCHAR(50),
	ALTER COLUMN life_expectancy TYPE NUMERIC USING NULLIF(life_expectancy,'')::NUMERIC,
	ALTER COLUMN maternal_mortality_ratio TYPE INT USING NULLIF(maternal_mortality_ratio,'')::INT,
	ALTER COLUMN minimum_wage TYPE NUMERIC USING NULLIF(minimum_wage,'')::NUMERIC,
	ALTER COLUMN official_language TYPE VARCHAR(50) USING NULLIF(official_language,'')::VARCHAR(50),
	ALTER COLUMN out_of_pocket_health_expenditure TYPE NUMERIC USING NULLIF(out_of_pocket_health_expenditure,'')::NUMERIC,
	ALTER COLUMN physicians_ter_thousand TYPE NUMERIC USING NULLIF(physicians_ter_thousand,'')::NUMERIC,
	ALTER COLUMN population TYPE VARCHAR(30) USING NULLIF(population,'')::VARCHAR(30),
	ALTER COLUMN labor_force_participation TYPE NUMERIC USING NULLIF(labor_force_participation,'')::NUMERIC,
	ALTER COLUMN tax_revenue_percent TYPE NUMERIC USING NULLIF(tax_revenue_percent,'')::NUMERIC,
	ALTER COLUMN total_tax_rate TYPE NUMERIC USING NULLIF(total_tax_rate,'')::NUMERIC,
	ALTER COLUMN unemployment_rate TYPE NUMERIC USING NULLIF(unemployment_rate,'')::NUMERIC,
	ALTER COLUMN urban_population TYPE VARCHAR(20) USING NULLIF(urban_population,'')::VARCHAR(20),
	ALTER COLUMN latitude TYPE NUMERIC USING NULLIF(latitude,'')::NUMERIC,
	ALTER COLUMN longitude TYPE NUMERIC USING NULLIF(longitude,'')::NUMERIC;

ALTER TABLE World_Data_2023
ALTER COLUMN land_area_km2 TYPE NUMERIC USING land_area_km2::NUMERIC,
ALTER COLUMN armed_forces_size TYPE NUMERIC USING armed_forces_size::NUMERIC,
ALTER COLUMN co2_emissions TYPE NUMERIC USING co2_emissions::NUMERIC,
ALTER COLUMN cpi TYPE NUMERIC USING NULLIF(cpi, '')::NUMERIC,
ALTER COLUMN gdp TYPE BIGINT USING NULLIF(gdp, '')::BIGINT,
ALTER COLUMN population TYPE BIGINT USING NULLIF(population, '')::BIGINT,
ALTER COLUMN urban_population TYPE BIGINT USING NULLIF(urban_population, '')::BIGINT;

