##  Project 2 Exploratory Data Analysis ##

select * from layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

select *
 from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc ;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select min(`date`), max(`date`)
from layoffs_staging2;

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select Year(`date`), sum(total_laid_off)
from layoffs_staging2
group by Year(`date`)
order by 1 desc;

select Stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

select substring(`date`, 1,7) as `Month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`, 1,7) is not null
group by `Month`
order by 1 asc ;

with Rolling_Total as 
(
select substring(`date`, 1,7) as `Month`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`, 1,7) is not null
group by `Month`
order by 1 asc )
select `Month`, total_off, sum(total_off) over( order by `Month`) as Rolling_Total
from Rolling_Total;

select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc ;


With Company_year (Company, Years, Total_laid_off) as 
    ( select company, year(`date`), sum(total_laid_off)
      from layoffs_staging2
       group by company, year(`date`)
      ), Company_Year_Rank as 
     (select *, 
      dense_rank() over (partition by Years order by total_laid_off desc ) as Ranking
      from Company_year
      where Years is not null) 
      select * 
      from Company_Year_Rank
      where Ranking <= 5 ;

## Exploring data with lot of query writing ##
## World layoff data 2023 ##















