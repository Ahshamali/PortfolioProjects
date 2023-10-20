/* Data Cleaning using sql commands 

Sklls Used: DDL, DML, DQL, JOINS, CTE, Substring, parsename, charindex, CASE

*/

SELECT * FROM nashvilleHousing;

/* Converting datetime datatype into date data type */

SELECT saledate, convert(date, saledate) FROM NashvilleHousing;

/* Now adding the converted date into the table */

ALTER TABLE nashvilleHousing ADD dateConverted date;

UPDATE NashvilleHousing SET dateConverted = convert(date, saledate) 

SELECT dateconverted FROM NashvilleHousing;

ALTER TABLE nashvilleHousing DROP column date


/* Populating the Property addresss as are there nulls present in it */

Select propertyAddress From NashvilleHousing where PropertyAddress is null

SELECT a.parcelId, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.propertyAddress, b.propertyAddress)
FROM NashvilleHousing a JOIN NashvilleHousing b ON a.ParcelID = b.ParcelID AND a.[UniqueID ] <> b.[UniqueID ] 
WHERE a.propertyAddress is null

UPDATE a
SET propertyAddress = ISNULL(a.propertyAddress, b.propertyAddress)
FROM NashvilleHousing a JOIN NashvilleHousing b ON a.ParcelID = b.ParcelID AND a.[UniqueID ] <> b.[UniqueID ] 
WHERE a.propertyAddress is null


/* Breaking out Address into different columns (Address, city, state)*/

SELECT PropertyAddress FROM NashvilleHousing


SELECT SUBSTRING(propertyAddress, 1, CHARINDEX(',', propertyAddress) - 1) as address,
SUBSTRING (propertyAddress, CHARINDEX(',', propertyAddress) + 1, LEN(PropertyAddress)) as address
FROM NashvilleHousing

ALTER TABLE nashvilleHousing  ADD propertySplitAddress nvarchar(255);

UPDATE  NashvilleHousing 
SET propertySplitAddress = SUBSTRING(propertyAddress, 1, CHARINDEX(',', propertyAddress) - 1)

ALTER TABLE nashvilleHousing ADD propertySplitCity nvarchar(255);

UPDATE NashvilleHousing 
SET propertySplitCity = SUBSTRING (propertyAddress, CHARINDEX(',', propertyAddress) + 1, LEN(PropertyAddress))

/* Now we will split the OwnerAddress by using PARSENAME method */

SELECT OwnerAddress FROM NashvilleHousing ;

SELECT PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM nashvilleHousing

ALTER TABLE nashvilleHousing ADD OwnerSplitAddress varchar(255);

UPDATE NashvilleHousing 
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3);

ALTER TABLE nashvilleHousing ADD OwnerSplitCity varchar(255);

UPDATE NashvilleHousing 
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2);

ALTER TABLE nashvilleHousing ADD OwnerSplitState nvarchar(255);

UPDATE NashvilleHousing 
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1);


/* we will now change  y AND n to YES and NO using CASE statement on soldasvacant */

SELECT DISTINCT soldasvacant, COUNT(soldasvacant) FROM NashvilleHousing
GROUP BY SoldAsVacant


SELECT CASE
			WHEN soldasvacant = 'Y' THEN 'Yes'
			WHEN soldasvacant = 'N' THEN 'No'
			ELSE soldasvacant
			END 
FROM NashvilleHousing

UPDATE NashvilleHousing SET SoldAsVacant = CASE
			WHEN soldasvacant = 'Y' THEN 'Yes'
			WHEN soldasvacant = 'N' THEN 'No'
			ELSE soldasvacant
			END 

/*DELETING ALL THE Columns we dont need*/
ALTER TABLE nashvilleHousing 
DROP COLUMN OwnerAddress, PropertyAddress, saleDate  










