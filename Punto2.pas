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
		1:
		2:
		3:writeln ('Salio del Listado de Djs');
	else writeln('Ingreso una opcion invalida, vuelva a elegir una opcion');
	end;

end;



Procedure Submenu2 (listatemas:tmListaTemas);

var

begin

end;



Procedure Submenu3 (listatemas:tmListaTemas; temasPorDj:tmTemasPorDj);

var

begin

end;




Procedure Menu2(listatemas:tmListaTemas;nomDjs:tvNomDjs;temasPorDj:tmTemasPorDj,MLDjs);

    
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
