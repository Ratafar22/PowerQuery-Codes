let
    Source = #date(2018,1,1),
    Custom1 = List.Dates(Source, Number.From(DateTime.LocalNow())-Number.From(Source),#duration(1,0,0,0)),
    #"Converted to Table" = Table.FromList(Custom1, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Renamed Columns" = Table.RenameColumns(#"Converted to Table",{{"Column1", "Date"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"Date", type date}})
in
    #"Changed Type"
