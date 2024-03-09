let
    Source = #date(2018,1,1),
    Custom1 = List.Dates(Source, Number.From(DateTime.LocalNow())-Number.From(Source),#duration(1,0,0,0)),
    #"Converted to Table" = Table.FromList(Custom1, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Renamed Columns" = Table.RenameColumns(#"Converted to Table",{{"Column1", "Date"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"Date", type date}}),
    #"Inserted Day Name" = Table.AddColumn(#"Changed Type", "Day Name", each Date.DayOfWeekName([Date]), type text),
    #"Inserted Start of Week" = Table.AddColumn(#"Inserted Day Name", "Start of Week", each Date.StartOfWeek([Date],Day.Monday), type date),
    #"Inserted Start of Month" = Table.AddColumn(#"Inserted Start of Week", "Start of Month", each Date.StartOfMonth([Date]), type date),
    #"Inserted Month Name" = Table.AddColumn(#"Inserted Start of Month", "Month Name", each Date.MonthName([Date]), type text),
    #"Inserted Month" = Table.AddColumn(#"Inserted Month Name", "Month", each Date.Month([Date]), Int64.Type),
    #"Inserted Day" = Table.AddColumn(#"Inserted Month", "Day", each Date.Day([Date]), Int64.Type),
    #"Reordered Columns" = Table.ReorderColumns(#"Inserted Day",{"Date", "Day Name", "Day", "Start of Week", "Start of Month", "Month Name", "Month"}),
    #"Inserted Start of Year" = Table.AddColumn(#"Reordered Columns", "Start of Year", each Date.StartOfYear([Date]), type date),
    #"Inserted Year" = Table.AddColumn(#"Inserted Start of Year", "Year", each Date.Year([Start of Year]), Int64.Type),
    #"Inserted Start of Quarter" = Table.AddColumn(#"Inserted Year", "Start of Quarter", each Date.StartOfQuarter([Date]), type date)
in
    #"Inserted Start of Quarter"
