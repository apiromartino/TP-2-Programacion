program DjsTemas;

const 
	MAXDjs=25; 
	MAXTemasxDj=35; 
	MAXTEM=10; {Ahora tiene 10 para cuando probamos no tener que poner los 200 temas, despues hay que cambiarlo} 
	MAXMIN=10; 
	MAXSEGS=59;

type
	tiDjs=1..MAXDjs;
	tiTemasxDj=1..MAXTemasxDj;
	tiTemas=1..MAXTEM;
	tiMinSeg=(minutos,segundos);
	tvNomTemas=array [tiTemas] of string[20];
	tmDurTemas=array [tiTemas,tiMinSeg] of byte;
	tvNomDjs=array [tiDjs] of string[40];
	tmTemasxDj=array [TiDjs,tiTemasxDj] of tvNomTemas;

var 
    MLdj:tiDjs; {maximo logico de DJs, no se si se va a necesitar, por ahi inicializando en 0 es mejor}
	MLtem:tiTemasxDj; {maximo logico de temas, no se si se va a necesitar, por ahi inicializando en 0 es mejor}
	nombretemas:tvNomTemas;
	durtemas:tmDurTemas;
	nomDjs:tvNomDjs;
	temasxDj:tmTemasxDj;
	opcionmen1:byte;
     
Procedure



BEGIN 
    IngreseListaTemas(nombretemas,durtemas);
    IngreseListaDjs(nomDjs);
    IngreseListaTemasxDj(temaszDj,MLdj,MLtem);

END.
