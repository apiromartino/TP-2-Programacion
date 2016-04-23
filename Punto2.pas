Procedure Submenu1(nomDjs:TvNomDjs; MLDjs:tiDjs );

var

begin


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
        else writeln('Ingreso una opcion invalida, vuelva a elegir una opción');    
        end;     
     until (opcionmen2=4);   
end;



var

BEGIN
writeln('Listado de Datos');

Menu2(listatemas,nomDjs,temasPorDj,MLDjs); {Hay que hace que pueda elegir estas opciones y ver la lista hasta el punto que quiera, una vez que no quere seguira con otro procedimiento que sera el pto 3 y 4.
                                             pero la idea es que pueda ver las listas todas las veces que quiera}

END.
