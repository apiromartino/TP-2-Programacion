program DjsTemas;

const 
	MAXDjs=25; 
	MAXTemasPorDj=35; 
	MAXTEM=10; {Ahora tiene 10 para cuando probamos no tener que poner los 200 temas, despues hay que cambiarlo} 
	MAXMIN=10; 
	MAXSEGS=59;

type
	tiDjs=1..MAXDjs;
	tiTemasPorDj=1..MAXTemasPorDj;
	tiTemas=1..MAXTEM;
	tiNomMinSeg=(nombre,minutos,segundos);
	tmListaTemas=array [tiTemas,tiNomMinSeg] of string[20];
	tvNomDjs=array [tiDjs] of string[40];
	tmTemasPorDj=array [TiDjs,tiTemasPorDj] of string[40]; {esto no se puede declarar asi, no? tira error, tenes que ponerle un nombre al string[40] antes}

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
     until (((minnum<=MAXMIN) or (segnum=0)) and (segnum<=MAXSEGS));           

end;      


Procedure IngreseListaTemas(var listatemas:tmListaTemas);     {NECESITAMOS UN MAXIMO LOGICO DE TEMAS TAMBIEN}
var
    i: tiTemas;
    nom: string;
    min: string;
    seg: string;
    
begin
    writeln('Ingrese la lista de 200 temas con su duración');
    for i:=1 to MAXTEM do
       begin
       writeln('Ingrese el nombre del tema');
       readln(nom);
       listatemas[i,nombre]:= nom;
       writeln('Duracion del tema, con un máximo de 10 minutos');
       ValidarMinutos(min);
       listatemas[i,minutos]:= min;
       ValidarSegs(seg,min);
       listatemas[i,segundos]:=seg;
       end;
end;



Procedure IngreseListaDjs(var nomDjs:tvNomDjs, var ML:tiDjs);

var
   i:tiDjs;
   nombre:string;
begin
   writeln('Ingrese la cantidad de Djs que desea agregar en esta lista, con un máximo de 25');
   readln(ML);
   for i:=1 to ML do
      begin
        writeln('Ingrese nombre del Dj');
        readln(nombre);
        nomDjs[i]:=nombre;    
      end;
end;





listatemas, nomDjs, temasPorDj, MLTemas, MLDjs

Procedure IngreseListaTemasPorDj(listatemas:tmListaTemas; nomDjs:tvNomDjs; var temasPorDj:tmTemasPorDj; MLDjs:tiDjs; MLTemas:tiTemas);
var
	i:byte;
	j:byte;
	k:byte;
	numeroTemaAgregado:tiTemas;
begin
	{writeln('Ingrese el numero de DJ del cual desea armar la lista de temas.')
	for i:=1 to MLDjs do
		writeln(i,': ', nomDjs[i]);
	readln(numeroDJAgregarTemas);
	if (numeroDJAgregarTemas>MLDjs) OR (numeroDJAgregarTemas=<0) then
		while (numeroDJAgregarTemas>MLDjs) OR (numeroDJAgregarTemas=<0) do
			begin
				writeln("Eligio un numero incorrecto. Ingrese un numero nuevamente.");
				readln(numeroDJAgregarTemas);
			end;}
	{Habia hecho esto para que pueda elegir de que dj agregar temas, pero es al pedo, voy a hacer que lo haga uno por uno en un for.}		
	for i:=1 to MLDjs do
	begin
		writeln('Agregue los temas para el dj', nomDjs[i], ', que ocupa el puesto numero ', i, ' en la lista.');
		writeln('Esta es la lista de temas:')
		for j:=1 to MLTemas do {Esto podria ser un procedure la verdad, 'presentarTemas' se podria llamar, alguno que lo escriba y reemplace aca asi queda}
							   {mas modular el codigo. Lo que hace es mostrarle al usuario los temas y el numero que tiene que ingresar para meter ese tema.}
			writeln(j,' ', listatemas[j]);
		for k:=1 to MLTemas do
			begin
				writeln('Ingreses el tema que ocupara el puesto')
				readln(numeroTemaAgregado); {IMPORTANTE: AGREGAR CONDICIONAL PARA QUE CHEQUEE LA LISTA FIJANDOSE SI EL TEMA YA FUE AGREGADO ANTES (NO SE PUEDEN REPETIR TEMAS POR DJ)}
				temasPorDj[i][k] := listatemas[numeroTemaAgregado]; {no estoy seguro si esta bien escrito esto, la idea es que en el lugar k del vector de }
																	{vectores meta el tema. Pero estoy pensando en que estamos equivocados, no tiene que ser un vector de vectores}
			end;													{sino un vector de vectores/strings. FIJENSE.}
	end;			

end;


Procedure Menu1(var listatemas:tmListaTemas; var nomDjs:tvNomDjs; var temasPorDj:tmTemasPorDj );
const 
    OPMAX=1;
    OPMIN=3;
var
    opcionmen1:byte;
	contadorOpcion1:byte;
	contadorOpcion2:byte;
	MLDjs:tiDjs;
	MLTemas:tiTemas;
begin
	contadorOpcion1:= 0;
	contadorOpcion2:= 0;
     writeln('Ingrese la opción deseada');
     writeln('1- Ingresar lista de temas');
     writeln('2- Ingresar lista de Djs');
     writeln('3- Ingresat temas que va a tocar cada Dj');
     repeat
	readln(opcionmen1);
	case opcionmen1 of
	1: 
				begin
					IngreseListaTemas(listatemas, MLTemas);
					contadorOpcion1:=contadorOpcion1 + 1;
				end;
        2: 
				begin
					IngreseListaDjs(nomDjs, MLDjs);
					contadorOpcion2:=contadorOpcion2 + 1;
				end;	
        3: 
				begin
					if (contadorOpcion1=>1) AND (contadorOpcion2=>1) then
						IngreseListaTemasPorDj(listatemas, nomDjs, temasPorDj, MLTemas, MLDjs);
					else
						opcionmen1=0;
					
        else writeln('Ingreso una opción inválida, vuelva a elegir una opción');    
     until ((opcionmen1>=OPMIN) and (opcionmen1<=OPMAX));   
end;

var 
    listatemas:tmListaTemas;
	nomDjs:tvNomDjs;
	temasPorDj:tmTemasPorDj;
    i:byte;
BEGIN 
    Menu1(listatemas,nomDjs,temasPorDj);
    
END.
