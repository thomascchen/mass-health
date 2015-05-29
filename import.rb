require 'csv'
require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: "mass_health")
    yield(connection)
  ensure
    connection.close
  end
end

def clear_na(value)
  if value == "NA"
    return nil
  else
    return value
  end
end

def format_integer(integer)
  integer.delete(",").to_i unless integer == nil
end

db_connection do |conn|

  CSV.foreach("mass-chip-data.csv", headers: true ) do |row|

    result = conn.exec("SELECT id FROM town_health_records WHERE town = $1", [row["Geography"]])
    if result.to_a.empty?
      total_population = clear_na(row["total pop, year 2005"])
      age_19_and_under = clear_na(row["age 0-19, year 2005"])
      age_65_and_over = clear_na(row["age 65+, year 2005"])
      persons_below_200_percent_poverty = clear_na(row["Persons Living Below 200% Poverty, year 2000 "])
      percent_below_200_percent_poverty = clear_na(row["% all Persons Living Below 200% Poverty Level, year 2000"])
      adequacy_prenatal_care = clear_na(row["% adequacy prenatal care (kotelchuck)"])
      percent_c_section_deliveries = clear_na(row["% C-section deliveries, 2005-2008"])
      infant_deaths = clear_na(row["Number of infant deaths, 2005-2008"])
      infant_mortality_rate = clear_na(row["Infant mortality rate (deaths per 1000 live births), 2005-2008"])
      percent_low_birthweight = clear_na(row["% low birthweight 2005-2008"])
      percent_multiple_births = clear_na(row["% multiple births, 2005-2008"])
      percent_publicly_financed_prenatal_care = clear_na(row["% publicly financed prenatal care, 2005-2008"])
      percent_teen_births = clear_na(row["% teen births, 2005-2008"])

      total_population = format_integer(total_population)
      age_19_and_under = format_integer(age_19_and_under)
      age_65_and_over = format_integer(age_65_and_over)
      persons_below_200_percent_poverty = format_integer(persons_below_200_percent_poverty)
      infant_deaths = format_integer(infant_deaths)

      conn.exec("INSERT INTO town_health_records(
      town,
      total_population,
      age_19_and_under,
      age_65_and_over,
      income,
      persons_below_200_percent_poverty,
      percent_below_200_percent_poverty,
      adequacy_prenatal_care,
      percent_c_section_deliveries,
      infant_deaths,
      infant_mortality_rate,
      percent_low_birthweight,
      percent_multiple_births,
      percent_publicly_financed_prenatal_care,
      percent_teen_births
      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15)",
        [row["Geography"],
        total_population,
        age_19_and_under,
        age_65_and_over,
        row["Per Capita Income, year 2000"],
        persons_below_200_percent_poverty,
        percent_below_200_percent_poverty,
        adequacy_prenatal_care,
        percent_c_section_deliveries,
        infant_deaths,
        infant_mortality_rate,
        percent_low_birthweight,
        percent_multiple_births,
        percent_publicly_financed_prenatal_care,
        percent_teen_births])
    end
  end
end
