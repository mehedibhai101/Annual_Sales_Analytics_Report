### Key Calculated Columns and Formulas:

* **Hour Cat**: Categorizes the order time into specific 3-hour dayparts for peak-hour analysis.
* **Formula**:
```dax
Hour Cat = 
SWITCH(
    TRUE(),
    pizza_sales[Time] >= TIME(9,0,0)  && pizza_sales[Time] < TIME(12,0,0), " 9AM - 12PM ",
    pizza_sales[Time] >= TIME(12,0,0) && pizza_sales[Time] < TIME(15,0,0), "12PM - 3PM",
    pizza_sales[Time] >= TIME(15,0,0) && pizza_sales[Time] < TIME(18,0,0), "3PM - 6PM",
    pizza_sales[Time] >= TIME(18,0,0) && pizza_sales[Time] < TIME(21,0,0), "6PM - 9PM",
    pizza_sales[Time] >= TIME(21,0,0) && pizza_sales[Time] < TIME(23,59,59), "9PM - 12AM",
    "Other"
)

```

---

### 🔍 Logical Breakdown

This column uses a `SWITCH(TRUE())` pattern, which functions as an optimized "If-Else" ladder. It evaluates the `[Time]` column to bucket transactions into these specific windows:

* **Morning (9AM - 12PM)**: Pre-lunch prep and early orders.
* **Lunch Peak (12PM - 3PM)**: High-volume midday traffic.
* **Afternoon (3PM - 6PM)**: Transition period.
* **Dinner Peak (6PM - 9PM)**: Primary revenue window for pizza sales.
* **Late Night (9PM - 12AM)**: Closing shift orders.

### 💡 Pro-Tip for Sorting

By default, these text ranges will sort alphabetically (e.g., 12PM will come before 3PM, but 6PM might come before 9AM). Sort the calculated column by pizza_sales[Time] column to display these time buckets in the correct chronological order.
