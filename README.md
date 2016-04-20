program DjsTemas;

const 
	MAXDjs=25; 
	MAXTemasxDj=35; 
	MAXTEM=200; 
	MAXMIN=10; 
	MAXSEGS=59;

type
	tiNombre=1..20; {No se si va a ser necesario este indice para hacer que nos e pase ni el nombre de la cancion ni el nombre de los djs de 20}
	tiDjs=1..MAXDjs;
	tiTemasxDj=1..MAXTemasxDj;
	tiTemas=1..MAXTEM;
	tiMinSeg=(minutos,segundos);
	tvNombre1=array [tiNombre] of char; {este seria el vector con 20 caracteres para el nombre de las canciones}
	tvNombre2=array [tiNombre] of char;{este seria el vector con 20 caracteres para el nombre de los Djs}
	tvNomTemas=array [tiTemas] of Tvnombre1;
	tmDurTemas=array [tiTemas,tiMinSeg] of byte;
	tvNomDjs=array [tiDjs] of tvNombre2;
	tmTemasxDj=array [TiDjs,tiTemasxDj] of tvNomTemas;

var MLdj:Timaxdjs; {maximo logico de DJs. donde esta declarado timaxdjs?}
	MLtem:TimaxtemasxDj; {maximo logico de temas. el tipo de esta variable no puede ser una constante!}
	nombretemas:tvNomTemas;
	durtemas:tmDurTemas;
	nomDjs:tvNomDjs;
	temasxDj:tmTemasxDj;

BEGIN IngresarListaDeTemas (

END.
