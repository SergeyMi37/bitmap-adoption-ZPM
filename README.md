 ~~~
 This is a coding example working on IRIS 2020.2 and on Caché 2018.1.3 
 It will not be kept in sync with new versions      
 It is also NOT serviced by InterSystems Support !   
~~~ 

This is a running example of the article in DC on [Bitmap Adoption](https://community.intersystems.com/post/adopted-bitmap)   

The full background story is found there.  

The base class Bmap.Person defines persons within an organization distributed  
by various countries. All records are indexed by (Country, PersonalId).  
this structure doesn't allow use of bitmaps.  

So a wrapper class Bmap.PersonQ around the data eliminates the top level of  
the index (Country) and isolates the PersonalId (%Integer, MINVAL=1).  
We are ready to use a Bitmap index.  

A few performance figures on 300010 generated records.  
You see that Relative Cost are sometimes quite misleading.  

__base__ 
~~~
  select count(*) from Bmap.Person  
  300010 global references 1600446 lines executed   
~~~

__demo 1__  
~~~
  select count(*) from Bmap.Person where Ctry='RU'  
  Relative cost = 197762  
  10015 global references 70474 lines executed    
      
  select count(*) from Bmap.PersonQ where Bmap.Ctry('RU')=1  
  Relative cost = 401400  
  10 global references 424 lines executed   
~~~

__demo2__  
~~~
  select count(*) from Bmap.Person   
     where Ctry='RU' and home_state='MA'   
  Relative cost = 457.96    
  218 Global references 2335 lines executed   
   
  select count(*) from Bmap.PersonQ   
     where Bmap.Ctry('RU')=1 and home_state='MA'   
  Relative cost = 2012.8   
  16 global references 478 lines executed  
~~~

__demo3__  
~~~
  select home_state,count(*) from Bmap.Person   
     where Ctry='RU' group by home_state  
  Relative cost = 372162   
  Row count: 50 Performance: 0.027 seconds   
  10420 global references 153708 lines  
      
  select home_state,count(*) from Bmap.PersonQ   
     where Bmap.Ctry('RU')=1 group by home_state    
  Relative cost = 453400    
  Row count: 50 Performance: 0.018 seconds    
  817 global references 155475 lines executed    

~~~

[Article in DC](https://community.intersystems.com/post/adopted-bitmap)
