SELECT productname, 
		sum(fact_sales.salesSubtotal) as Subtotal, 
		sum(fact_sales.salesAfterDiscount) as AfterDiscount,
		sum(fact_sales.salesQuantity) as Quanity
From DIM_CUSTOMER
Left join Fact_sales
on dim_customer.customerID=fact_sales.customerID
Left join dim_location on dim_customer.locationID = dim_location.locationID
group by productname
order by subtotal desc
LIMIT 5;

SELECT fact_sales.productname, extract(month from fact_sales.salesDate) as month, 
		sum(fact_sales.salesSubtotal) as SalesAmount
From fact_sales
group by cube(month, fact_sales.productname);

SELECT fact_sales.productname, extract(month from fact_sales.salesDate) as month, 
		sum(fact_sales.salesQuantity) as Quantity
From fact_sales
group by cube(month, fact_sales.productname);

SELECT fact_sales.productname, dim_location.region, 
		sum(fact_sales.salesQuantity) as Quantity
From dim_product
Left join Fact_sales on fact_sales.productID = dim_product.productID
Left join dim_location on fact_sales.customerLocation = dim_location.locationID
group by rollup(dim_location.region, fact_sales.productName );

SELECT fact_sales.productname, dim_location.region, 
		sum(fact_sales.salesSubtotal) as SalesAmount
From dim_product
Left join Fact_sales on fact_sales.productID = dim_product.productID
Left join dim_location on fact_sales.customerLocation = dim_location.locationID
group by rollup(dim_location.region, fact_sales.productName );


SELECT fact_sales.productname, dim_location.region, 
		sum(fact_sales.salesQuantity) as Quantity
From dim_product
Left join Fact_sales on fact_sales.productID = dim_product.productID
Left join dim_location on fact_sales.customerLocation = dim_location.locationID
group by CUBE(dim_location.region, fact_sales.productName );




