/* ANALYZING THE DATA of WHOLE WORLD AND INDIA REGARDING COVID 


SKILSS USED: Aggregate Funactions, JOINS, CTE, Windows Functions, Converting Data Types, DML, DQL, DDL, 
GROUP BY CLAUSE, ORDER BY CLAUSE, HAVING, WHERE, TEMP TABLES


Below is the list of questions we will solve using those commands

1. Select Data that we are going to be starting with
2. Total Cases vs Total Deaths
3. Total Cases vs Population
4. Countries with Highest Infection Rate compared to Population
5. Countries with Highest Death Count 
6. Show contintents with the highest death count per population
7. Show GLOBAL NUMBERS
8. Total Population vs Vaccinations
9. Show Percentage of Population that has recieved at least one Covid Vaccine
10. Use CTE to perform Calculation on Partition By in previous query
11. Using Temp Table to perform Calculation on Partition By in previous query
12. Creating View to store data
13. Total Cases vs Total Deaths Where continent is Asia and country is india
14. Vaccine percentgae in each country 
*/


/* Select Data that we are going to be starting with */



SELECT * FROM CovidDeaths

/*Total Cases vs Total Deaths*/

SELECT location, date,total_cases, total_deaths, ROUND((total_deaths / total_cases) * 100,2) as death_percentage FROM CovidDeaths
WHERE Continent IS NOT NULL
ORDER BY location,date;

/*Total Cases vs Total Deaths Where continent is Asia and country is india*/

SELECT continent,location, date,total_cases, total_deaths, ROUND((total_deaths / total_cases) * 100,2) as death_percentage FROM CovidDeaths
WHERE continent = 'Asia' AND location = 'india' AND continent IS NOT NULL
ORDER BY date;


/* Total Cases vs Population */
SELECT location, date,total_cases, population, ROUND((total_cases / population) * 100,2) as cases_percentage FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date;


/* Total Cases vs Population in india */
 SELECT location, date,total_cases, population, (total_cases / population) * 100 as cases_percentage FROM CovidDeaths
WHERE continent IS NOT NULL AND location = 'india'
ORDER BY date;



 /*Countries with Highest Infection Rate compared to Population*/

SELECT location, MAX(total_cases) AS highest_cases , population, MAX(total_cases / population) * 100 as highest_percentage FROM CovidDeaths
GROUP BY location, population
ORDER BY highest_percentage DESC;



/*Countries with Highest Death Count */

SELECT location, max(CAST(total_deaths as int)) as TOTAL_DEAH_COUNT FROM CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY TOTAL_DEAH_COUNT DESC 


/*Show contintents with the highest death count per population*/

SELECT DISTINCT continent, MAX(CAST(total_deaths as int)) as total_deaths FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_deaths DESC ; 



/*Show GLOBAL NUMBERS*/

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From CovidDeaths
where continent is not null 
order by 1,2


/*Total Population vs Vaccinations*/
 SELECT * FROM CovidVaccinations$;
 SELECT * FROM CovidDeaths;

 SELECT cv.location, cd.date, cv.total_vaccinations, cd.population, (cv.total_vaccinations / cd.population )  * 100 as Vaccine_percent FROM CovidDeaths cd JOIN CovidVaccinations$ cv 
 ON cd.location = cv.location AND cd.continent = cv.continent AND cd.date = cv.date
 ORDER BY Vaccine_percent DESC, cd.date


 /* Vaccine percentgae in each country */
  SELECT DISTINCT cv.location,  MAX(cv.total_vaccinations / cd.population )  * 100 as Vaccine_percent FROM CovidDeaths cd JOIN CovidVaccinations$ cv 
 ON cd.location = cv.location AND cd.continent = cv.continent AND cd.date = cv.date 
 WHERE cd.continent IS NOT NULL
 GROUP BY cv.location
 ORDER BY Vaccine_percent DESC


 /*Show Percentage of Population that has recieved at least one Covid Vaccine*/
 SELECT cd.location, cd.continent, cd.date, cd.population, cv.new_vaccinations, SUM( CONVERT(int,cv.new_vaccinations))
 OVER(Partition BY cd.location ORDER BY cd.location, cd.date) 
 FROM CovidDeaths cd JOIN CovidVaccinations$ cv ON
 cd.location = cv.location AND cd.date = cv.date
 WHERE cd.continent IS NOT NULL 
ORDER BY cd.location, cd.date



 Select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations
, SUM(CONVERT(int,cv.new_vaccinations)) OVER (Partition by cd.Location Order by cd.location, cd.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths cd
Join CovidVaccinations$ cv
	On cd.location = cv.location
	and cd.date = cv.date
where cd.continent is not null 
order by 2,3;


/*Use CTE to perform Calculation on Partition By in previous query*/


With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
	Select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, SUM(CONVERT(int,cv.new_vaccinations)) OVER (Partition by cd.Location Order by cd.location, cd.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
	From CovidDeaths cd
	Join CovidVaccinations$ cv
	On cd.location = cv.location
	and cd.date = cv.date
	where cd.continent is not null)

	SELECT *, (RollingPeopleVaccinated / Population) * 100 AS Vaacine_percentage FROM PopvsVac
	ORDER BY Location



	/*Using Temp Table to perform Calculation on Partition By in previous query*/
	
	DROP TABLE if exists #PercentPopulationVacinated
	CREATE TABLE #PercentPopulationVacinated(
	Continent nvarchar(255),
	Location nvarchar(255),
	Date datetime,
	population numeric,
	New_vaccinations numeric,
	RollingPeopleVaccinated numeric
	)

	INSERT INTO #PercentPopulationVacinated
	 Select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations
, SUM(CONVERT(int,cv.new_vaccinations)) OVER (Partition by cd.Location Order by cd.location, cd.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths cd
Join CovidVaccinations$ cv
	On cd.location = cv.location
	and cd.date = cv.date
--where cd.continent is not null 
order by 2,3;

SELECT *, (RollingPeopleVaccinated / Population) * 100 AS Vaacine_percentage FROM #PercentPopulationVacinated
	ORDER BY Location


	/*Creating View to store data*/

CREATE View PercentPopulationVacinated 
as
 Select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations
, SUM(CONVERT(int,cv.new_vaccinations)) OVER (Partition by cd.Location Order by cd.location, cd.Date) as RollingPeopleVaccinated
From CovidDeaths cd
Join CovidVaccinations$ cv
	On cd.location = cv.location
	and cd.date = cv.date
where cd.continent is not null 



 










