use PortfolioProject;

select * from CovidDeaths
select * from CovidVaccinations;


--total cases vs population
--filtered by country

select Location,total_cases,Population,(total_cases/population)*100 as Percentinfected
from CovidDeaths
where location like '%India%'
order by Percentinfected
;

-- countries with max death
select location,max(cast(total_deaths as int)) as deaths from CovidDeaths
where location NOT IN ('Asia', 'Europe', 'Africa', 'North America', 'South America', 'Australia', 'Oceania', 'world')
group by location
order by deaths desc;

select distinct(continent) from CovidDeaths;

--looking at countries with highest infection rate compared to population

select location,population, max(total_cases) as HighestInfectionCount , max((total_cases/population))*100 as PercentofPopulationInfected
from CovidDeaths
group by location,population
order by PercentofPopulationInfected desc;

--showing countries with highest death count per population

SELECT location, Max(cast(total_deaths as int)) as Deaths
from CovidDeaths
group by location
order by Deaths desc;


--Lets break it down by continent
--continents with highest death count

SELECT continent, Max(cast(total_deaths as int)) as Deaths
from CovidDeaths
where continent is not null
group by continent
order by Deaths desc;

-- Global Numbers

-- New cases and deaths on days globally

select date,sum(new_cases) New_Cases,sum(cast(new_deaths as int)) New_deaths
from CovidDeaths
group by date;

--death percentage as per new cases
select date,sum(new_cases) New_Cases,sum(cast(new_deaths as int)) New_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100as Deathpercentage
from CovidDeaths
where continent is not null
group by date;

--join the two tables

select * 
from CovidDeaths dea
join CovidVaccinations vac
on dea.location =vac.location
and dea.date=vac.date;


--Looking at total population vs vaccinations

select dea.continent ,dea.date,dea.location,dea.population,vac.new_vaccinations	,
 sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location , dea.date) as RollingPeopleVaccinated
from CovidDeaths dea
join CovidVaccinations vac
on dea.location =vac.location
and dea.date=vac.date
where dea.continent is not null
--group by dea.location,dea.continent,dea.population,vac.new_vaccinations
order by 2,3;


--using cte for this complex query

with popvac(Continent, Location,date,population,new_vaccinations,RollingPeopleVaccinated) as
(
select dea.continent ,dea.date,dea.location,dea.population,vac.new_vaccinations	,
 sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location , dea.date) as RollingPeopleVaccinated
from CovidDeaths dea
join CovidVaccinations vac
on dea.location =vac.location
and dea.date=vac.date
where dea.continent is not null
--group by dea.location,dea.continent,dea.population,vac.new_vaccinations
)
select * ,(RollingPeopleVaccinated/population)*100 from popvac
order by RollingPeopleVaccinated desc;


--the date with highest vaccinations
select location,date,max(cast(total_vaccinations as int)) total_vaccinations_in_a_day
from CovidVaccinations
where total_vaccinations=(select max(cast(total_vaccinations as int)) from CovidVaccinations)
group by date,location;
  

--similarly the date with highest deaths

select date,max(cast(total_deaths as int)) total_deaths_in_a_day
from CovidDeaths
where total_deaths=(Select max(cast(total_deaths as int)) from CovidDeaths)
group by date;