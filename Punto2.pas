Procedure OrdenDeIngreso (nomDjs:tvNomDjs;MLDjs:tiDjs);

var
	i:tiDjs;
	
begin
	for i:=1 to MLDjs
		writeln(i,'- ', nomDjs[i]);

end;

Procedure OrdenAlfabetico(nomDjs:tvNomDjs;MLDjs:tiDjs);

var

begin

end;


Procedure OrdenDuracion(listatemas:tmListaTemas);

var

begin
	
end;

Procedure Submenu1(nomDjs:TvNomDjs; MLDjs:tiDjs );


var
	opcionsubmenu1:byte;
	
begin
	writeln('Ingrese la opcion deseada');
	repeat
		writeln('1- Orden en que fueron ingresados');
		writeln('2- Ordenados alfabeticamente en forma ascendente');
		writeln('3- Salir de esta lista');
		readln(opcionsubmenu1);
		case opcionsubmenu1 of
			1: OrdenDeIngreso(nomDjs,MLDjs);
			2: OrdenAlfabetico(nomDjs,MLDjs);
			3: writeln ('Salio del Listado de Djs');
		else writeln('Ingreso una opcion invalida, vuelva a elegir una opcion');
		end;
	until (opcionsubmenu1=3);
end;



Procedure Submenu2 (listatemas:tmListaTemas);

type
	tvNombreTema=array[tiTemas] of string[20];

var
	opcionsubmenu2:byte;
	maxvector:byte;
	i:byte;
	nombreTema:tvNombreTema;
begin
	for i:=1 to MAXTEM do
		nombreTema[i]:=listatemas[i,nombre];
	maxvector:=MAXTEM;
	writeln('Ingrese la opcion deseada');
	repeat
		writeln('1- Orden por duracion en forma descendente');
		writeln('2- Ordenados alfabeticamente en forma ascendente');
		writeln('3- Salir de esta lista');
		readln(opcionsubmenu2);
		case opcionsubmenu2 of
			1: OrdenDuracion(listatemas);
			2: OrdenAlfabetico(listatemas,maxvector);
			3: writeln ('Salio del Listado de Temas');
		else writeln('Ingreso una opcion invalida, vuelva a elegir una opcion');
		end;
	until (opcionsubmenu2=3);
end;


Procedure SalirLista(var opcionsubmenu3:byte);

const
	OPMAX=2;
	OPMIN=1;

begin
	repeat
		writeln('¿Desea salir de esta lista?');
		writeln('1-Si');
		writeln('2-No');
		readln (opcionsubmenu3);
	until ((opcionsubmenu3<=OPMAX) and (opcionsubmenu3>=OPMIN));

end;



Procedure Submenu3 (listatemas:tmListaTemas; temasPorDj:tmTemasPorDj);

const
	OPMAX=2;
	OPMIN=1;

var
	opcionsubmenu3:byte;
	nombre:string;
begin
	repeat
		writeln('Ingrese el nombre del Dj que desee para ver los temas que va a tocar');
		readln(nomDj);
		writeln('Ingrese la opcion deseada');
		repeat
			writeln('1- Temas ordenados por duracion');
			writeln('2- Temas en el orden de ingreso');
			readln(opcionsubmenu3);
			case opcionsubmenu3 of
				1: OrdenDuracion2(listatemas,temasPorDj,nombre);
				2: OrdenDeIngreso2(temasPorDj,nomDj);
			else writeln('Ingreso una opcion invalida, vuelva a elegir una opcion');
			end;
		until ((opcionsubmenu3<=OPMAX) and (opcionsubmenu3>=OPMIN));	
		SalirLista(opcionsubmenu3);
	until (opcionsubmenu3=1);	
		
end;




Procedure Menu2(listatemas:tmListaTemas;nomDjs:tvNomDjs;temasPorDj:tmTemasPorDj;MLDjs:tiDjs);

    
var
	opcionmen2:byte;
	
begin
     writeln('Ingrese la opción deseada');
     repeat
		writeln('1- Listado de Dj');
		writeln('2- Listado de Temas');
		writeln('3- Listado de Temas de un Dj determinado');
		writeln('4- Salir de Listado de Datos');
		readln(opcionmen2);
		case opcionmen2 of
			1: Submenu1(nomDjs,MLDjs);
			2: Submenu2(listatemas);
			3: Submenu3(listatemas,temasPorDj);
			4: writeln('Salio del Listado de Datos');
        else writeln('Ingreso una opcion invalida, vuelva a elegir una opcion');    
        end;     
     until (opcionmen2=4);   
end;



var

BEGIN
	writeln('Listado de Datos');
	Menu2(listatemas,nomDjs,temasPorDj,MLDjs); 

END.
