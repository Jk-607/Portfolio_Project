SELECT COUNT(*) AS total_rows
FROM nashville_housing.`nashville housing data for data cleaning`;


SELECT *
FROM nashville_housing.`nashville housing data for data cleaning`;

-- Standardize sale date Format
SELECT SaleDate, CONVERT(Date, SaleDate)
FROM nashville_housing.`nashville housing data for data cleaning`; ---Convert function not supporetd in workbench.

SELECT SaleDate, STR_TO_DATE(SaleDate, '%m/%d/%Y') AS ConvertedSaleDate
FROM nashville_housing.`nashville housing data for data cleaning`;  ---SaleDate format is not match with our query which we provide.

SELECT SaleDate, STR_TO_DATE(SaleDate, '%M %e, %Y') AS ConvertedSaleDate
FROM nashville_housing.`nashville housing data for data cleaning`;   ---- This is the correct format

Update nashville_housing.`nashville housing data for data cleaning`
SET SaleDate = STR_TO_DATE(SaleDate, '%M %e, %Y')

-- Populate property address data

SELECT PropertyAddress
FROM nashville_housing.`nashville housing data for data cleaning`; 

SELECT *
FROM nashville_housing.`nashville housing data for data cleaning`;
ORDER BY Parcel ID

SELECT a.ParecelID, a.PreopertyAddress, b.ParcelID, b.PropertyAddress
FROM nashville_housing.`nashville housing data for data cleaning`a
JOIN  nashville_housing.`nashville housing data for data cleaning`b
      on a.ParcelID = b.ParcelID
      AND a.'UniqueID' = b.'UniqueID'
      
---Breaking out property address columns into (Address, city, state)

SELECT PropertyAddress
FROM nashville_housing.`nashville housing data for data cleaning`;

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) AS Address

SELECT 
PARSENAME(OwnerAddress, 1)
FROM nashville_housing.`nashville housing data for data cleaning`;


--change Y and N to yes and no in 'Sold As Vacant' field

SELECT DISTINCT(SoldAsVacant), Count(SoldAsVacant)
FROM nashville_housing.`nashville housing data for data cleaning`;
Order by 2 


      
SELECT DISTINCT(SoldAsVacant)
FROM nashville_housing.`nashville housing data for data cleaning`;

SELECT SoldAsVacant,
CASE
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
	    ELSE
        END
FROM nashville_housing.`nashville housing data for data cleaning`;

--Remove Duplicates

with RowNumCTE As(
SELECT *
     ROW_NUMBER() OVER (
     PARTITION BY ParcelID,
                  PropertyAddress,
                  SalePrice,
                  SaleDate,
                  LegelReference
                  ORDER BY 
                     UniqueID
                     ) row_num
FROM nashville_housing.`nashville housing data for data cleaning`; 
)

--delete unused columns
SELECT *
FROM nashville_housing.`nashville housing data for data cleaning`;

ALTER TABLE nashville_housing.`nashville housing data for data cleaning`
DROP COLUMN OwnerAddress,
DROP COLUMN PropertyAddress;







