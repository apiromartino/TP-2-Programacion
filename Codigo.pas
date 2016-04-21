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
	tiNomMinSeg=(nombre,minutos,segundos);
	tmListaTemas=array [tiTemas,tiNomMinSeg] of string[20];
	tvNomDjs=array [tiDjs] of string[40];
	tmTemasxDj=array [TiDjs,tiTemasxDj] of tvNomTemas;


Procedure IngreseListaTemas(var listatemas:tmListaTemas);     
var
    i: tiTemas;
    jj: 
    ii:
begin
    for i:=1 to MAXTEM do
       begin
       writeln('Ingrese nombre del tema que quiere en su lista');
       readln(nombretemas);
       tvNomTemas[i]:= nombretemas;
       
           

end;





Procedure IngreseListaDjs();







Procedure IngreseListaTemasxDj();


Procedure Menu1(var listatemas:tmListaTemas; var nomDjs:tvNomDjs; var temasxDj:tmTemasxDj );
const 
     OPMAX=1;
     OPMIN=3;
var
     opcionmen1:byte;
begin
     writeln('Ingrese la opción deseada');
     writeln('1- Ingresar lista de temas');
     writeln('2- Ingresar lista de Djs');
     writeln('3- Ingresat temas que va a tocar cada Dj');
     repeat
        readln(opcionmen1);
        case opcionmen1 of
            1: IngreseListaTemas(listatemas);
            2: IngreseListaDjs(nomDjs);
            3: IngreseListaTemasxDj(temasxDj,MLdj,MLtem);
        else writeln('Ingreso una opción inválida, vuelva a elegir una opción');    
        end;
     until ((opcionmen1>=OPMIN) and (opcionmen<=OPMAX));   
end;

var 
    MLdj:tiDjs; {maximo logico de DJs, no se si se va a necesitar, por ahi inicializando en 0 es mejor}
	MLtem:tiTemasxDj; {maximo logico de temas, no se si se va a necesitar, por ahi inicializando en 0 es mejor}
	listatemas:tmListaTemas
	nomDjs:tvNomDjs;
	temasxDj:tmTemasxDj;

BEGIN 
    Inicializarmatriztemasxdj(temasxDj){si inicializamos esta matiz en 0 creo que no son necesarios los ML}
    Menu1(

END.
