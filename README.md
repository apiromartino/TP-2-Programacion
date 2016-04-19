program DjsTemas;

const
MAXDjs=25;
MAXTemasxDj=35;
MAXTEM=200;
MAXMIN=10;
MAXSEGS=59;
type

Tinombre=1..20;
{No se si va a ser necesario este indice para hacer que nos e pase ni el 
nombre de la cancion ni el nombre de los djs de 20}

Tidjs=1..MAXDjs;
TitemasxDj=1..MAXTemasxDj;
Titemas=1..MAXTEM;
Timinseg=(minutos,segundos);
Tvnombres=array [Tinombre] of char; {este seria le vector con 20 caracteres 
para el nombre de los Djs y de las canciones}
Tvnomtemas=array [Titemas] of Tvnombres;
Tmdurtemas=array [Titemas,timinseg] of byte;




var 
MLdj:timaxdjs;
MLtem:timaxtemasxDj;

BEGIN
	
	
END.
