### Key Metrics and Formulas:

* **Total Sales**: Sum of sales revenue for the selected period.
  * **Formula**: `SUM(pizza_sales[total_price])`
  * **Format String**: `$#,0.###############;($#,0.###############);$#,0.###############`


* **Total Orders**: Total number of distinct orders placed.
  * **Formula**: `DISTINCTCOUNT(pizza_sales[order_id])`
  * **Format String**: `#,0`


* **Total Quantity Sold**: Total number of units sold.
  * **Formula**: `SUM(pizza_sales[quantity])`
  * **Format String**: `#,0`


* **Avg Pizzas Per Order**: The average number of pizzas included in a single transaction.
  * **Formula**: `[Total Pizzas Sold] / [Total Orders]`
  * **Format String**: `0.00`


* **Avg Order Value**: The average dollar amount spent per unique order.
  * **Formula**: `[Total Sales] / [Total Orders]`
  * **Format String**: `$#,0.00;($#,0.00);$#,0.00`


* **Previous Month Sales**: Sales revenue from the previous month.
  * **Formula**: `CALCULATE([Total Sales], DATEADD('Date Table'[Date], -1, MONTH))`
  * **Format String**: `$#,0.00`


* **Previous Month Orders**: Number of unique orders in the previous month.
  * **Formula**: `CALCULATE([Total Orders], DATEADD('Date Table'[Date], -1, MONTH))`
  * **Format String**: `#,0`


* **Previous Month Quantity Sold**: Total units sold in the previous month.
  * **Formula**: `CALCULATE([Total Pizzas Sold], DATEADD('Date Table'[Date], -1, MONTH))`
  * **Format String**: `#,0`
