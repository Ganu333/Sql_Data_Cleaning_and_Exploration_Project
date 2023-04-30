-- Selecting the database
USE sql_project;

-- Observing the data
SELECT * FROM sql_project.nashville_housing;

-- Finding total number of records present
SELECT COUNT(*) FROM nashville_housing;

----------------------------------------------- Standardize Date Format---------------------------------------------------------------------------------------------------

SELECT SaleDate , CAST(SaleDate AS DATE) AS SaleDateConverted FROM Nashville_Housing;

-- Adding new column 
ALTER TABLE Nashville_Housing ADD SaleDateConverted DATE;
-- updating the newly added date column 
UPDATE Nashville_Housing
SET SaleDateConverted = CAST(SaleDate AS DATE);

---------------------------------------------- Observing & Populate Property Address data where it is null ---------------------------------------------------------------
SELECT PropertyAddress FROM Nashville_Housing WHERE PropertyAddress IS NULL ;


---------------------------------------------- Splitting out PropertyAddress into Individual Columns (Address, City) -----------------------------------------------------
SELECT * FROM Nashville_Housing;

-- Using substring we are fetching the address and city from Property Address

SELECT PropertyAddress ,SUBSTRING(PropertyAddress, 1 , CHAR_INDEX(',',PropertyAddress) - 1 ) AS PropertyAddressNew ,
SUBSTRING(PropertyAddress,CHAR_INDEX(',',PropertyAddress) + 1 , len(PropertyAddress))AS PropertyCityN
FROM Nashville_Housing;

-- Adding 2 new columns in Nashville Housing Data
ALTER TABLE Nashville_Housing ADD PropertyAddressNew VARCHAR(255), ADD PropertyCityN VARCHAR(255);

-- Updating those newly added columns with the values of Property address and property city
UPDATE Nashville_Housing SET PropertyAddressNew = SUBSTRING(PropertyAddress, 1 , CHARINDEX(',',PropertyAddress) - 1 );

UPDATE Nashville_Housing SET PropertyCityN = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) + 1 , len(PropertyAddress));
 
SELECT * FROM Nashville_Housing;

----------------------------------------------- Splitting out OwnerAddress into Individual Columns (Address, City, State)------------------------------------------------

SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3) as OwnerAddressN
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2) as OwnerCityN
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1) as OwnerStateN
FROM Nashville_Housing;

-- Add 3 new columns in Nashville housing data 
ALTER TABLE Nashville_Housing ADD OwnerAddressN VARCHAR(255), ADD OwnerCityN VARCHAR(255),ADD OwnerStateN VARCHAR(255);

-- Updating those newly added columns with the values of owner address, city & state

UPDATE Nashville_Housing SET OwnerAddressN = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3);

UPDATE Nashville_Housing SET OwnerCityN = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2);

UPDATE Nashville_Housing SET OwnerStateN = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1);



--------------------------------------------------- Change Y and N to Yes and No in "Sold as Vacant" field---------------------------------------------------------------


SELECT * FROM Nashville_Housing; 

SELECT SoldAsVacant, COUNT(SoldAsVacant) AS total FROM Nashville_Housing GROUP BY SoldAsVacant ORDER BY total DESC ; 

SELECT SoldAsVacant , 
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes' 
     WHEN SoldAsVacant = 'N' THEN 'No' 
	 ELSE SoldAsVacant
END
FROM Nashville_Housing;

UPDATE Nashville_Housing
SET SoldAsVacant = 
     CASE WHEN SoldAsVacant = 'Y' THEN 'Yes' 
     WHEN SoldAsVacant = 'N' THEN 'No' 
	 ELSE SoldAsVacant
END;

------------------------------------------------------------ Remove Duplicates --------------------------------------------------------------------------------------------

WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

FROM Nashville_Housing
ORDER BY ParcelID
)
SELECT *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress;



SELECT * FROM Nashville_Housing;
---------------------------------------------------------------------- Creating a View-----------------------------------------------------------------------------------


CREATE OR ALTER VIEW PropertyDetails AS
SELECT PropertyAddressNew, PropertyCityN,OwnerName,LandUse,YearBuilt,Bedrooms,year(SaleDateConverted) as Year,Format(SaleDateConverted,'MMMM') as Month,SalePrice,SoldAsVacant  from [Nashville Housing Data];

----------------------------------------------------------- Exploring data to get some useful insights-------------------------------------------------------------------

SELECT * FROM PropertyDetails;

SELECT Top10 PropertyCityN , COUNT(PropertyCityN) AS total FROM PropertyDetails GROUP BY PropertyCityN ORDER BY total DESC;

SELECT  LandUse,COUNT(LandUse) AS total FROM PropertyDetails GROUP BY LandUse ORDER BY total DESC;

SELECT MIN(Bedrooms) AS Minimum_Bedrooms,MAX(Bedrooms) AS Maximum_Bedrooms,ROUND(AVG(Bedrooms),0) AS Average_Bedrooms FROM PropertyInfo;

SELECT YEAR,COUNT(YEAR) AS total FROM PropertyDetails GROUP BY YEAR ORDER BY total DESC;

SELECT MONTH,COUNT(Month) as total from PropertyDetails group by Month order by total desc;

SELECT MIN(SalePrice) AS Min_SalePrice,MAX(SalePrice) AS Max_Saleprice,ROUND(AVG(SalePrice),2) AS Average_Sale_Price FROM PropertyDetails ;

SELECT SoldAsVacant,COUNT(SoldAsVacant) AS total FROM PropertyDetails GROUP BY SoldAsVacant ORDER BY total DESC;







