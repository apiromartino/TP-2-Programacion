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

TiDjs=1..MAXDjs;
TitemasxDj=1..MAXTemasxDj;
Titemas=1..MAXTEM;
Timinseg=(minutos,segundos);
Tvnombre1=array [Tinombre] of char; {este seria le vector con 20 caracteres 
para el nombre de las canciones}
Tvnombre2=array [Tinombre] of char;{este seria le vector con 20 caracteres 
para el nombre de los Djs}
Tvnomtemas=array [Titemas] of Tvnombre1;
Tmdurtemas=array [Titemas,timinseg] of byte;
TvnomDjs=array [TiDjs] of tvnombre2;
TmtemasxDj=array [TiDjs,TitemasxDj] of Tvnomtemas;



var 
MLdj:timaxdjs;
MLtem:timaxtemasxDj;

BEGIN
	
	
END.
