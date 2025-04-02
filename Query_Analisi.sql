
-- 1. Quali Paesi si distinguono per alte emissioni di CO₂? Query per vedere i 10 paesi con maggiori emissioni --

SELECT 
	country, 
	co2_emissions AS emissioni_co2
FROM world_Data_2023
WHERE co2_emissions IS NOT NULL
GROUP BY country, emissioni_co2
ORDER BY emissioni_co2 DESC
LIMIT 10; 

-- 2. Quali Paesi si distinguono per l’uso di energia rinnovabile? Query per i 10 paesi con la media più alta di energia rinnovabile sul totale dell'energia -- 

SELECT 
	country, 
	AVG(renewable_energy_share_in_total_final_energy_consumption_percent) as percent_energia_rinnovabile
FROM sustainable_energy_data
WHERE renewable_energy_share_in_total_final_energy_consumption_percent IS NOT NULL
GROUP BY country
ORDER BY percent_energia_rinnovabile DESC
LIMIT 10;

/* -- 3. Quali Paesi con alti livelli di emissioni di CO₂ investono maggiormente in energie rinnovabili? 
JOIN per vedere come si comportano in termini di energia rinnovabile i paesi con alte emissioni di co2. I dati sono diversi dalla query
con i 10 paesi con più emissioni in quanto ho fatto una INNER JOIN per avere solo i paesi con corrispondenza in entrambe le colonne */

SELECT 
    w.country, 
    w.co2_emissions AS emissioni_co2, 
    ROUND(AVG(s.renewables_percentage_equivalent_primary_energy)::NUMERIC,2) AS media_energia_rinnovabile_percent,
    ROUND(AVG(s.electricity_from_fossil_fuels_twh)::NUMERIC,2) AS energia_da_combustibili_fossili_TWH
FROM world_data_2023 w
JOIN sustainable_energy_data s ON w.country = s.country
WHERE 
    w.co2_emissions IS NOT NULL 
    AND s.renewables_percentage_equivalent_primary_energy IS NOT NULL
    AND s.electricity_from_fossil_fuels_twh IS NOT NULL
GROUP BY w.country, w.co2_emissions
ORDER BY w.co2_emissions DESC
LIMIT 10;


/* -- 4. Quali sono i Paesi meglio o peggio piazzati in termini di sanità ed educazione? 
Presi 3 indicatori relativi ad educazione e sanità e sviluppata una colonna con un "punteggio" */

-- 4.1 Migliori --
SELECT 
	country, 
	life_expectancy, 
	infant_mortality, 
	gross_tertiary_education_enrollment AS iscrizione_università, (life_expectancy - infant_mortality + gross_tertiary_education_enrollment) AS Score
FROM world_data_2023
WHERE life_expectancy IS NOT NULL AND life_expectancy IS NOT NULL AND infant_mortality IS NOT NULL AND gross_tertiary_education_enrollment IS NOT NULL
ORDER BY Score DESC
LIMIT 10;

-- 4.2 Peggiori -- 

SELECT 
	country, 
	life_expectancy, 
	infant_mortality, 
	gross_tertiary_education_enrollment AS iscrizione_università, (life_expectancy - infant_mortality + gross_tertiary_education_enrollment) AS Score
FROM world_data_2023
WHERE life_expectancy IS NOT NULL AND life_expectancy IS NOT NULL AND infant_mortality IS NOT NULL AND gross_tertiary_education_enrollment IS NOT NULL
ORDER BY Score 
LIMIT 10;

/* -- 5 C'è una correlazione tra l'energia rinnovabile , il PIL e la qualità della vita? 
QUERY con JOIN tra due tabelle ordinata per l'energia rinnovabile */

SELECT 
	w.country, 
	ROUND(AVG(s.renewable_energy_share_in_total_final_energy_consumption_percen)::NUMERIC,2) AS energia_rinnovabile,
	w.gdp AS PIL,
	ROUND(AVG(w.life_expectancy)::NUMERIC,0) AS aspettativa_di_vita,
	ROUND(AVG(w.unemployment_rate)::NUMERIC,2) AS tasso_disoccupazione
FROM world_data_2023 w
JOIN sustainable_energy_data s ON w.country = s.country
WHERE w.gdp IS NOT NULL
	AND w.life_expectancy IS NOT NULL 
	AND w.unemployment_rate IS NOT NULL
	AND s.renewable_energy_share_in_total_final_energy_consumption_percen IS NOT NULL
	AND s.access_to_electricity_percentage IS NOT NULL
GROUP BY w.country, w.gdp
ORDER BY energia_rinnovabile DESC
LIMIT 10;

-- 5.1 QUERY a supporto della prima per capire il picco massimo di disoccupazione --

SELECT 
	country, 
	ROUND(MAX(unemployment_rate),2) AS tasso_disoccupazione
FROM world_data_2023
WHERE unemployment_rate IS NOT NULL
GROUP BY country
ORDER BY tasso_disoccupazione DESC
LIMIT 1;

/* -- 6. Query per un'eventuale correlazione tra il numero di migranti dispersi o morti e 
due variabili come mortalità e scarsa sanità */

SELECT 
	m.country_of_origin, 
	w.life_expectancy, 
	w.infant_mortality, 
	w.physicians_ter_thousand, 
	SUM(m.total_number_of_dead_and_missing) AS totale_migranti_morti_dispersi
FROM migrants m 
JOIN world_data_2023 w ON w.country = m.country_of_origin
WHERE w.life_expectancy IS NOT NULL 
	AND w.infant_mortality IS NOT NULL
	AND w.physicians_ter_thousand IS NOT NULL
GROUP BY m.country_of_origin,w.life_expectancy, w.infant_mortality,w.infant_mortality, w.physicians_ter_thousand
ORDER BY totale_migranti_morti_dispersi DESC
LIMIT 10;

/* -- 7. Query analizzare se i paesi con un alto numeri di migranti abbiano un'economia più fragile */

SELECT 
    m.country_of_origin,
    w.gdp AS PIL,
    w.unemployment_rate AS tasso_disoccupazione,
    w.minimum_wage AS salario_minimo_orario,
    SUM(m.total_number_of_dead_and_missing) AS totale_migranti_morti_dispersi
FROM migrants m
JOIN world_data_2023 w ON w.country = m.country_of_origin
WHERE w.gdp IS NOT NULL
    AND w.unemployment_rate IS NOT NULL
    AND w.minimum_wage IS NOT NULL
    AND m.total_number_of_dead_and_missing IS NOT NULL
GROUP BY m.country_of_origin, w.gdp, w.unemployment_rate, w.minimum_wage
ORDER BY totale_migranti_morti_dispersi DESC
LIMIT 10;

/* -- 8. Query per analizzare se i paesi con più PIL abbiano meno Migranti e meno disoccupazione */

SELECT
	w.country,
	w.gdp AS PIL,
	ROUND(AVG(w.unemployment_rate)::NUMERIC,2) AS tasso_di_disoccupazione,
	COALESCE(SUM(m.total_number_of_dead_and_missing),0) AS totale_migranti_dispersi_o_morti
FROM world_data_2023 w
LEFT JOIN migrants m ON m.country_of_origin = w. country
WHERE w.gdp IS NOT NULL
	AND w.unemployment_rate IS NOT NULL
GROUP BY w.country, w.gdp
ORDER BY PIL DESC
LIMIT 10;

/* -- 9. Query per analizzare l'evoluzione temporale della crescita del PIL e dell'energia rinnovabile Italiana */

SELECT
	s.country,
	s.year,
	ROUND(AVG(s.gdp_growth)::NUMERIC,2) AS crescita_PIL
FROM sustainable_energy_data s
WHERE s.country = 'Italy' 
	AND s.gdp_growth IS NOT NULL 
GROUP BY s.country, s.year
ORDER BY s.country, s.year;