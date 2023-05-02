# Nashvile Housing Data exploration using SQL
Using Sql to clean Nashville housing data and explore data.

# Following are the observations and task performed on this project :

1) The dataset consist of information regarding Nashville Housing data that consist of information regarding Property address, sale date, sale price,owner address, no of bedrooms, sold as vacant etc.

2) The total number of records present in the dataset are 56477.
3) By using a SELF JOIN, populated the PropertyAddress fields where the value is NULL.
3) Standardized date format using CAST and updated the table.
4) Splitted out PropertyAddress and OwnerAddress fields into individual columns to make it more readable using SUBSTRING and PARSENAME functions.
5) Changing Y and N to Yes and No in the SoldAsVacant field using CASE statement.
6) Deleted unused fields.
7) Created a view to fetch required columns from table.
8) Using view to explore data.

# Data Exploration results :

1) Among top 10 cities Nashville city sold maximum properties compared to Antioch ,Hermitage ,Madison etc.
2) Explored the distinct areas where the land were used and found out that land was mostly used by single family.
3) Found out that number of bedrooms range between 0 to 11 with an average number of bedrooms as 3.
4) Maximum property sale was in 2015 followed by 2014, 2016 ,2013 ,2019.
5) Month wise analysis shows that top 4 months with maximum property sales are June followed by May, August, July. Least sales were during December, January, November      and March so we can conclude that middle of the year property sales tend to be maximum.
6) Sale Price of Properties range between 50 to 54278060 with an average sale price of 327226.
7) Total count of Properties sold as vacant were 4675.
