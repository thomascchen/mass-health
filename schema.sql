-- DEFINE YOUR DATABASE SCHEMA HERE

DROP TABLE town_health_records;

CREATE TABLE town_health_records (
  id SERIAL PRIMARY KEY,
  town VARCHAR(255),
  total_population INTEGER,
  age_19_and_under INTEGER,
  age_65_and_over INTEGER,
  income MONEY,
  persons_below_200_percent_poverty INTEGER,
  percent_below_200_percent_poverty NUMERIC,
  adequacy_prenatal_care NUMERIC,
  percent_c_section_deliveries NUMERIC,
  infant_deaths INTEGER,
  infant_mortality_rate NUMERIC,
  percent_low_birthweight NUMERIC,
  percent_multiple_births NUMERIC,
  percent_publicly_financed_prenatal_care NUMERIC,
  percent_teen_births NUMERIC
);
