SELECT location, total_deaths, total_cases
FROM covid_19.covid_19_world_cases_deaths_testing;

#looking at death rate#
SELECT location,date, total_deaths, total_cases, round(total_deaths/total_cases,5) as death_rate
FROM covid_19.covid_19_world_cases_deaths_testing
order by 1,2;

#looking at total cases vs population
SELECT location,date,population, total_cases, round(total_cases/population,5) as get_covid
FROM covid_19.covid_19_world_cases_deaths_testing
order by 1,2;

#looking at countries with highest infection rate compared to population
SELECT location,population, max(total_cases) as highestinfectioncount, round(max(total_cases/population)*100,3) as get_covid_percentage
FROM covid_19.covid_19_world_cases_deaths_testing
group by location,population
order by get_covid_percentage desc;

#showing countries with highest death count per population
SELECT location, max(total_deaths) as totaldeathcount
FROM covid_19.covid_19_world_cases_deaths_testing
group by location
order by totaldeathcount desc;

#let's break things down by continent
SELECT continent, max(total_deaths) as totaldeathcount
FROM covid_19.covid_19_world_cases_deaths_testing
group by continent
order by totaldeathcount desc;

#global number
Select date, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
From covid_19.covid_19_world_cases_deaths_testing
#group by date
order by 1,2;

#total population vs vaccinations
#shows percentage of population that has recieved at least on vaccine
with popvsvac (continent, location, date, population, new_vaccinations,rollingpeoplevaccinated)
as(
Select continent, location, date, population, new_vaccinations,
	   sum(new_vaccinations) over(partition by location order by location, date) as rollingpeoplevaccinated
From covid_19.covid_19_world_cases_deaths_testing
#order by 2,3
)
select *, (RollingPeopleVaccinated/Population)*100 as populationvsvaccinations
from popvsvac


#
