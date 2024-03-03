use Hosuing;
select * from house;


--Standardize date format

select saledate, CONVERT(Date,SaleDate)
from house


alter table house 
add SalesDate Date;

update house set SalesDate=CONVERT(Date,SaleDate);

-------------------------------------------------------------

--Populate property address Data

Select *
from house
where PropertyAddress is null;

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.propertyaddress,b.PropertyAddress)
from house a
join house b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

update a
set Propertyaddress=ISNULL(a.propertyaddress,b.PropertyAddress)
from house a
join house b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null



--------------------------

--Splitting address into individual columns
select propertyaddress
from house

select 
substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address
,substring(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,Len(PropertyAddress)) as Address
from house 

alter table house
add PropertySplitAddress nvarchar(255);

update house 
set PropertySplitAddress=substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

alter table house
add City varchar(50)

update house
set City=substring(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,Len(PropertyAddress))
select * from house


--------------------------

--now Owner's address

select substring(OwnerAddress,1,CHARINDEX(',',OwnerAddress)-1) 
from house

alter table house
add OwnerSplitAddress varchar(100);

update house
set ownerSplitaddress=substring(OwnerAddress,1,CHARINDEX(',',OwnerAddress)-1);

select substring(Owneraddress,Charindex(',',Owneraddress)+1,Len(Owneraddress)) 
from house;

alter table house
add Ownerscity varchar(90)

update house
set ownerscity=substring(Owneraddress,Charindex(',',Owneraddress)+1,Len(Owneraddress)) 

---------------------------------------------------------------------------------------------

--Change Y and N as Yes and No in sold as vacant


select SoldAsVacant,
Case
	when SoldAsVacant='N' then 'No'
	when SoldAsVacant='Y' then 'Yes'
	else SoldAsVacant
End
from house;

Update house
set SoldAsVacant=
Case
	when SoldAsVacant='N' then 'No'
	when SoldAsVacant='Y' then 'Yes'
	else SoldAsVacant
End
from house;


select distinct(soldasvacant),count(soldasvacant)
from house
group by SoldAsVacant;



--------------------------------------------------------------------------------------

--Remove Duplicates
with RDCTE as(
Select *,
ROW_NUMBER() OVER (
Partition by ParcelID,
			 Propertyaddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 Order by UniqueId
			 )row_num
from house
)
delete	
from RDCTE
where row_num>1


--we selected duplicate values from the data , put them under a cte , then ran a delete command , now you can run a select command in place of delete and you'll see that the duplicates no longer exists


-------------------------------------------------------------------------------------------------

--removing unused columns
--lets remove the property address column as we already split it

select * 
from house


alter table house
drop column PropertyAddress,OwnerAddress,TaxDistrict

alter table house
drop column SaleDate

