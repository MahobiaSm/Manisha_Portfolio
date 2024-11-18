select* from layoffs;

Create table layoffs_staging
like layoffs; 

select* from layoffs_staging;

Insert layoffs_staging 
select * 
from layoffs;

select *,
row_number() over( partition by company,location, industry, total_laid_off, percentage_laid_off, `date`,stage, country, funds_raised_millions) as Row_num
from layoffs_staging;

with duplicate_cte as 	
( select *,
row_number() over( partition by company,location, industry, total_laid_off, percentage_laid_off, `date`,stage, country, funds_raised_millions) as Row_num
from layoffs_staging )
select * from duplicate_cte
where Row_num >1 ;

select * from layoffs_staging
where Row_num > 1 ;

select * from layoffs_staging
where company = ' casper ' ;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `Row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


Insert into layoffs_staging2
select *,
row_number() over( partition by company,location, industry, total_laid_off, percentage_laid_off, `date`,stage, country, funds_raised_millions) as Row_num
from layoffs_staging; 

select * from layoffs_staging2
where Row_num >1 ; 

delete from layoffs_staging2
where Row_num >1 ;

use world_layoffs;

select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select distinct industry 
from layoffs_staging2
order by 1 ;

select * from layoffs_staging2 where industry like 'crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

 select distinct industry 
 from layoffs_staging2
 order by 1;

select distinct location 
 from layoffs_staging2
 order by 1;
select distinct country 
 from layoffs_staging2
 order by 1;

select distinct country, Trim( Trailing '.' from country)
 from layoffs_staging2
 order by 1;

update layoffs_staging2
set country = Trim(Trailing '.' from country)
where country like 'United States%'; 

select `date`, str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;
update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

select `date` from layoffs_staging2;

alter table layoffs_staging2
modify column `date`  Date;
select * from layoffs_staging2;

select * from layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null;

select * from layoffs_staging2
where total_laid_off is null;

select * from layoffs_staging2
 where company like 'Bally%';
 
 select *
 from layoffs_staging2 t1
 join layoffs_staging2 t2
 on t1.company = t2.company
 where ( t1.industry is null or t1.industry = '') and t2.industry is not null;
 
update layoffs_staging2
set industry = null
 where industry = '';
 
update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null and t2.industry is not null;

select * from layoffs_staging2;

delete from layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null;

alter table layoffs_staging2
Drop column Row_num;   

## data cleaning is done ##
-- Project 1 is successfully done --






