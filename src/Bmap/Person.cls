/// demo to show adopted bitmap 
/// base class with compuund index
Class Bmap.Person Extends (%Persistent, %Populate) [ Final ]
{

Property Ctry As %String(VALUELIST = ",RU,DE,AT,CH,FR,IT,SP,PT,BR,US") [ Required ];

Property Int As %Integer(MINVAL = 1) [ InitialExpression = {$I(^Bmap.PersonD)}, Required ];

Property Name As %String(POPSPEC = "Name()") [ Required ];

Property SSN As %String(PATTERN = "3N1""-""2N1""-""4N") [ Required ];

Property DOB As %Date(POPSPEC = "Date()");

Property Home As Sample.Address;

Property Office As Sample.Address;

Property FavoriteColors As list Of %String(POPSPEC = "ValueList("",Red,Orange,Yellow,Green,Blue,Purple,Black,White""):2");

Index idx On (Ctry, Int) [ IdKey ];

Index IntKey On Int;

Index SSNKey On SSN [ Data = Name, Type = index, Unique ];

Index HomeState On Home.State;

ClassMethod Load(val As %Integer) As %Integer [ SqlProc ]
{
    quit ..Populate(val)
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>Name</Value>
</Value>
<Value name="2">
<Value>SSN</Value>
</Value>
<Value name="3">
<Value>DOB</Value>
</Value>
<Value name="4">
<Value>Home</Value>
</Value>
<Value name="5">
<Value>Office</Value>
</Value>
<Value name="6">
<Value>Spouse</Value>
</Value>
<Value name="7">
<Value>FavoriteColors</Value>
</Value>
</Data>
<DataLocation>^Bmap.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<ExtentSize>100000</ExtentSize>
<IdLocation>^Bmap.PersonD</IdLocation>
<IndexLocation>^Bmap.PersonI</IndexLocation>
<StreamLocation>^Bmap.PersonS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
