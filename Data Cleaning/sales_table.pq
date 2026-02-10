let
    // 1. Extract: Load data from CSV source
    Source = Csv.Document(File.Contents("your_file_path.csv"), [Delimiter=",", Columns=12, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    
    // 2. Transform: Promote headers and define explicit data types
    Promoted_Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    Typed_Table = Table.TransformColumnTypes(Promoted_Headers, {
        {"pizza_id", Int64.Type}, {"order_id", Int64.Type}, {"pizza_name_id", type text}, 
        {"quantity", Int64.Type}, {"order_date", type date}, {"order_time", type datetime}, 
        {"unit_price", type number}, {"total_price", type number}, {"pizza_size", type text}, 
        {"pizza_category", type text}, {"pizza_ingredients", type text}, {"pizza_name", type text}
    }),

    // 3. Enrichment: Add Time and Short Month Name
    Add_Time_Column = Table.AddColumn(Typed_Table, "Time", each DateTime.Time([order_time]), type time),
    Add_Month_Column = Table.AddColumn(Add_Time_Column, "Month", each Text.Start(Date.MonthName([order_date]), 3), type text),

    // 4. Normalization: Batch update Pizza Size abbreviations
    Standardize_Pizza_Sizes = Table.TransformColumns(Add_Month_Column, {
        {"pizza_size", each List.ReplaceMatchingItems({_}, {
            {"L", "Large"}, 
            {"M", "Medium"}, 
            {"S", "Small"}, 
            {"XLarge", "XL"}, 
            {"XXLarge", "XXL"}
        }){0}}
    }),

    // 5. Text_Cleaning: Consolidate ingredient formatting
    Clean_Ingredients_List = Table.TransformColumns(Standardize_Pizza_Sizes, {
        {"pizza_ingredients", each Text.Replace(Text.Replace(_, ",", ""), "_", " "), type text}
    })

in
    Clean_Ingredients_List
