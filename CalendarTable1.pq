let
    Source = #date(2022, 1, 1),
    Custom1 = List.Dates(Source, 365*2, #duration(1,0,0,0)),
    #"Converted to Table" = Table.FromList(Custom1, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Changed Type" = Table.TransformColumnTypes(#"Converted to Table",{{"Column1", type date}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "Date"}}),
    #"Inserted Year" = Table.AddColumn(#"Renamed Columns", "Year", each Date.Year([Date]), Int64.Type),
    #"Inserted Month" = Table.AddColumn(#"Inserted Year", "Month", each Date.Month([Date]), Int64.Type),
    #"Inserted Month Name" = Table.AddColumn(#"Inserted Month", "Month Name", each Date.MonthName([Date]), type text),
    #"Inserted Day Name" = Table.AddColumn(#"Inserted Month Name", "Day Name", each Date.DayOfWeekName([Date]), type text),
    #"Inserted Day" = Table.AddColumn(#"Inserted Day Name", "Day", each Date.Day([Date]), Int64.Type),
    #"Inserted Day of Week" = Table.AddColumn(#"Inserted Day", "Day of Week", each Date.DayOfWeek([Date]), Int64.Type)
in
    #"Inserted Day of Week"
