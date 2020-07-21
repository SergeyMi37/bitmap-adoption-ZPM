/// demo to show adopted bitmap 
/// base class with compuund index
Class Bmap.Person Extends (%Persistent, %Populate) [ Final ]
{

Property Ctry As %String(VALUELIST = ",RU,DE,AT,CH,FR,IT,SP,PT,BR,US") [ Required ];

Property Int As %Integer(MINVAL = 1) [ InitialExpression = {$I(^Bmap.PersonD)}, Required ];

Property Name As %String(POPSPEC = "Name()") [ Required ];

Property SSN As %String(PATTERN = "3N1""-""2N1""-""4N") [ Required ];

Property DOB As %Date(POPSPEC = "Date()");

Property Home As Bmap.Address;

Property Office As Bmap.Address;

Property FavoriteColors As list Of %String(POPSPEC = "ValueList("",Red,Orange,Yellow,Green,Blue,Purple,Black,White""):2");

Index idx On (Ctry, Int) [ IdKey ];

Index IntKey On Int;

Index SSNKey On SSN [ Data = Name, Type = index, Unique ];

Index HomeState On Home.State;

ClassMethod Load(val As %Integer) As %Integer [ SqlProc ]
{
    quit ..Populate(val)
}
