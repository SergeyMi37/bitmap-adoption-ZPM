/// demo to show adopted bitmap 
/// query class on bitmap index
Class Bmap.PersonQ Extends %Persistent [ Final ]
{

Parameter MANAGEDEXTENT = 0;

// Property Ctry As %String(VALUELIST = ",RU,DE,AT,CH,FR,IT,SP,PT,BR,US") [ Required ];

Property Int As %Integer(MINVAL = 1) [ InitialExpression = {$I(^Bmap.PersonD)}, ReadOnly, Required ];

Property Name As %String [ ReadOnly, Required ];

Property SSN As %String(PATTERN = "3N1""-""2N1""-""4N") [ ReadOnly, Required ];

Property DOB As %Date [ ReadOnly ];

Property Home As Bmap.Address [ ReadOnly ];

Property Office As Bmap.Address [ ReadOnly ];

Property FavoriteColors As list Of %String [ ReadOnly ];

Index IntKey On Int [ IdKey ];

Index HS On Home.State [ Type = bitmap ];

ClassMethod Ctry(ct As %String = "*") As %Boolean [ SqlName = Ctry, SqlProc ]
{
 set ^Bmap($username)=ct quit $$$OK
}

ClassMethod IdxB(ct As %String = "*") As %Boolean [ SqlName = IdxB, SqlProc ]
{
 set ^Bmap($username)=ct quit ..%BuildIndices()
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
<DataLocation>^Bmap.PersonD(^Bmap($username))</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<ExtentSize>100000</ExtentSize>
<IdLocation>^Bmap.PersonD</IdLocation>
<IndexLocation>^Bmap.PersonQ(^Bmap($username))</IndexLocation>
<StreamLocation>^Bmap.PersonS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
