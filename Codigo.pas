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

Procedure ValidarMinutos(min:string);

var
     minnum:byte;
     codigo:byte;

begin
     repeat
         write('Minutos:');
         readln(min);
         VAL(min,minnum,codigo);
         if (minnum>MAXMIN) then
             writeln('Supera los ',MAXMIN,' minutos, vuelva a ingrasar nuevamente');
         until (minnum<=MAXMIN);
     
end;

Procedure ValidarSegs(seg:string;min:string); {no pude hacer funcionar que si ponen 10 minutos  y agregan mas segundos les vulva a pedir lso segundos}

var
     minnum:byte;
     codigo1:byte;
     segnum:byte;
     codigo2:byte;
     
begin

     repeat
         write('Segundos:');
         readln(seg);
         VAL(min,minnum,codigo1);
         VAL(seg,segnum,codigo2);
         if (segnum>MAXSEGS) then
               writeln('Los segundos superaron los ',MAXSEGS,' segundos, vuelva a ingresar los segundos resantes del tema');
         if ((minnum=MAXMIN) and (segnum<>0)) then
               writeln('El tema supera los ',MAXMIN,' minutos, vuelva a ingresar los segundos restantes del tema')
     until (((minnum<=MAXMIN) and (segnum=0)) and (segnum<=MAXSEGS));           

end;      


Procedure IngreseListaTemas(var listatemas:tmListaTemas);     
var
    i: tiTemas;
    nom: string;
    min: string;
    seg: string;
    
begin
    writeln('Ingrese la lista de 200 temas con su duración');
    for i:=1 to MAXTEM do
       begin
       writeln('Ingrese tema');
       readln(nom);
       listatemas[i,nombre]:= nom;
       writeln('Duracion del tema');
       ValidarMinutos(min);
       listatemas[i,minutos]:= min;
       ValidarSegs(seg,min);
       listatemas[i,segundos]:=seg;
       end;
end;



Procedure IngreseListaDjs(var nomDjs:tvNomDjs);

var
   i:tiDjs

begin
   writeln('Ingrese los nombres de los Djs que van a tocar y en el momento en el que no quiera agregar más coloque un 0 y pulse enter');
      
end;







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
	listatemas:tmListaTemas;
	nomDjs:tvNomDjs;
	temasxDj:tmTemasxDj;

BEGIN 
    Inicializarmatriztemasxdj(temasxDj);{si inicializamos esta matiz en 0 creo que no son necesarios los ML}
    Menu1(

END.

