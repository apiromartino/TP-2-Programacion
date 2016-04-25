program DjsTemas;

uses crt;

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
	tmTemasPorDj=array [TiDjs,tiTemasPorDj] of string[40]; 

Procedure ValidarMinutos(var min:string);

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
         if (codigo<>0) then
			 writeln('Ingreso un valor invalido, vuelva a ingresar nuevamente')	
     until ((codigo=0) and (minnum<=MAXMIN));
     
end;

Procedure ValidarSegs(var seg:string;min:string); 

var
     minnum:byte;
     codigo1:byte;
     segnum:byte;
     codigo2:byte;
     correcto:byte;
begin

     repeat
         correcto:=1;
         write('Segundos:');
         readln(seg);
         VAL(min,minnum,codigo1);
         VAL(seg,segnum,codigo2);
         if (segnum>MAXSEGS) then
               writeln('Los segundos superaron los ',MAXSEGS,' segundos, vuelva a ingresar los segundos resantes del tema');
         if ((minnum=MAXMIN) and (segnum<>0)) then
               begin
					writeln('El tema supera los ',MAXMIN,' minutos, vuelva a ingresar los segundos restantes del tema');
					correcto:=0;
			   end;		
     until ((correcto<>0) and (segnum<=MAXSEGS));           

end;      


Procedure IngreseListaTemas(var listatemas:tmListaTemas);     
var
    i: tiTemas;
    nom: string;
    min: string;
    seg: string;
    
begin
    writeln('Ingrese la lista de 200 temas con su duracion');
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



Procedure IngreseListaDjs(var nomDjs:tvNomDjs; var MLDjs:tiDjs);

var
   i:tiDjs;
   nombre:string;
begin
   writeln('Ingrese la cantidad de Djs que desea agregar en esta lista, con un maximo de 25');
   readln(MLDjs);
   for i:=1 to MLDjs do
      begin
        writeln('Ingrese nombre del Dj');
        readln(nombre);
        nomDjs[i]:=nombre;    
      end;
end;




Procedure validartema(var tema:string; listatemas:tmListaTemas);

var 
	i:byte;
	boleano:boolean;

begin
	boleano:=false;
	i:=1;
    repeat
		if  (tema=listatemas[i,nombre]) then
			boleano:=true
		else
			if (i=MAXTEM) then
                      begin
                       writeln('El tema ingresado no pertenece a la lista de temas.');
                       writeln('Reingrese el tema: ');
                       readln(tema);
                       i:=1;
                      end
			else
				begin
					if (tema='0') then
						boleano:=true
					else i:=i+1;
				end;
	until(boleano=true);
end;


Procedure comparacionTemas(tema:string; temasPorDj:tmTemasPorDj;var aux:boolean; var boleano:boolean; i,j:byte);

var 
	k:byte;

begin
	aux:=true;
	for k:=1 to (j-1) do
		begin
			if tema=temasPorDj[i,k] then
				begin
					aux:=false;
					boleano:=true;
					temasPorDj[i,k+1]:=temasPorDj[i,k];
				end
			else
				begin
					boleano:=true;
					aux:=true;
				end;
		end;
end;

Procedure IngreseListatemasPorDj(listatemas:tmListaTemas; nomDjs:tvNomDjs; var temasPorDj:tmTemasPorDj; MLDjs:tiDjs);
var  
	i,j:byte;
	tema:string;
    boleano,aux:boolean;

Begin
	writeln('Ingrese la lista de temas para cada Dj. ');
	writeln('Ingrese 0 para concluir la lista de cada Dj.');
    for i:=1 to MLDjs do
		Begin
			Write(nomDjs[i],': ');
            j:=1;
            repeat
				write('Tema nro ',j,' ');
				readln(tema);
				validartema(tema,listatemas);
				boleano:=false;
				repeat
					if j=1 then
						begin
							boleano:=true;
                            aux:=true;
						end
                    else comparacionTemas(tema,temasPorDj,aux,boleano,i,j);
                    if aux=true then
						temasPorDj[i,j]:=tema;
				until(boleano=true);
                if aux=true then
                begin
					j:=j+1;
					if (j=MAXTemasPorDj+1) then
						tema:='0';
                end
                    else writeln('Cancion repetida,vuelva a ingresar');
			until(tema='0');

		end;

end;
Procedure Menu1(var listatemas:tmListaTemas; var nomDjs:tvNomDjs; var temasPorDj:tmTemasPorDj;var opcionmen1:byte;var MLDjs:tiDjs);

var
	contadorOpcion1:byte;
	contadorOpcion2:byte;

begin
     writeln('Ingrese la opcion deseada');
     contadorOpcion1:=0;
	 contadorOpcion2:=0;
     repeat
		writeln('1- Ingresar lista de temas');
		writeln('2- Ingresar lista de Djs');
		writeln('3- Ingresar temas que va a tocar cada Dj');
		readln(opcionmen1);
		case opcionmen1 of
			1: 
				begin
					IngreseListaTemas(listatemas);
					contadorOpcion1:=contadorOpcion1 + 1;
				end;
			2:	 
				begin
					IngreseListaDjs(nomDjs, MLDjs);
					contadorOpcion2:=contadorOpcion2 + 1;
				end;	
			3: 
					if ((contadorOpcion1>=1) AND (contadorOpcion2>=1)) then
						IngreseListaTemasPorDj(listatemas, nomDjs, temasPorDj, MLDjs)
					else
						begin
							writeln('Tiene que ingresar primero la lista de canciones y la de Djs antes de poder completar esta.');
							opcionmen1:=0;
						end;
        else writeln('Ingreso una opcion invalida, vuelva a elegir una opcion');    
        end;     
     until (opcionmen1=3);   
end;


Procedure OrdenDeIngreso (nomDjs:tvNomDjs;MLDjs:tiDjs);

var
	i:tiDjs;
	
begin
	for i:=1 to MLDjs do
		writeln(i,'- ', nomDjs[i]);

end;

Procedure OrdenAlfabetico(nomDjs:tvNomDjs; MLDjs:tiDjs);

var 
	i:byte;
	j:byte;
	temporal:string[40];
 
begin
	for i:=1 to MLDjs do
	begin
		for j:=i+1 to MLDjs do
		begin
			if (nomDjs[i]>nomDjs[j]) then
			begin
				temporal:=nomDjs[i];
				nomDjs[i]:=nomDjs[j];
				nomDjs[j]:=temporal;
			end;
		end;
	end;
	for i:=1 to MLDjs do
		writeln(nomDjs[i]);
end;

Procedure OrdenDuracion(listatemas:tmListaTemas);

var
	i:=byte;

begin
	
		
	
end;

Procedure OrdenAlfabetico2(listatemas:tmListaTemas);

var 
	i:byte;
	j:byte;
	temporal:string[20];
 
begin
	for i:=1 to MAXTEM do
	begin
		for j:=i+1 to MAXTEM do
		begin
			if (listatemas[i,nombre]>listatemas[j,nombre]) then
			begin
				temporal:=listatemas[i,nombre];
				listatemas[i,nombre]:=listatemas[j,nombre];
				listatemas[j,nombre]:=temporal;
			end;
		end;
	end;
	for i:=1 to MAXTEM do
		writeln(listatemas[i,nombre]);
end;


Procedure OrdenDuracion2(listatemas:tmListaTemas; temasPorDj:tmTemasPorDj; nombre:string);

var

begin

end;



Procedure OrdenDeIngreso2(temasPorDj:tmTemasPorDj; nombre:string;nomDjs:tvNomDjs);

var
	i:byte;
	k:byte;
	j:byte;
begin
	i:=1;
	while nomDjs[i]<>nombre do
		i:=i+1;
	j:=1;
	k:=1;
	while (temasPorDj[i,j]<>'0') do
		begin
			writeln(k,'- ',temasPorDj[i][j]);
			j:=j+1;
			k:=k+1;
		end;	
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

var
	opcionsubmenu2:byte;
	i:byte;
begin
	writeln('Ingrese la opcion deseada');
	repeat
		writeln('1- Orden por duracion en forma descendente');
		writeln('2- Ordenados alfabeticamente en forma ascendente');
		writeln('3- Salir de esta lista');
		readln(opcionsubmenu2);
		case opcionsubmenu2 of
			1: OrdenDuracion(listatemas);
			2: OrdenAlfabetico2(listatemas);
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



Procedure Submenu3 (listatemas:tmListaTemas; temasPorDj:tmTemasPorDj;nomDjs:tvNomDjs);

const
	OPMAX=2;
	OPMIN=1;

var
	opcionsubmenu3:byte;
	nombre:string;
begin
	repeat
		writeln('Ingrese el nombre del Dj que desee para ver los temas que va a tocar');
		readln(nombre);
		writeln('Ingrese la opcion deseada');
		repeat
			writeln('1- Temas ordenados por duracion');
			writeln('2- Temas en el orden de ingreso');
			readln(opcionsubmenu3);
			case opcionsubmenu3 of
				1: OrdenDuracion2(listatemas,temasPorDj,nombre);
				2: OrdenDeIngreso2(temasPorDj,nombre,nomDjs);
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
			3: Submenu3(listatemas,temasPorDj,nomDjs);
			4: writeln('Salio del Listado de Datos');
        else writeln('Ingreso una opcion invalida, vuelva a elegir una opcion');    
        end;     
     until (opcionmen2=4);   
end;



var 
    listatemas:tmListaTemas;
	nomDjs:tvNomDjs;
	temasPorDj:tmTemasPorDj;
    opcionmen1:byte;
    MLDjs:tiDjs;
BEGIN 
	Menu1(listatemas,nomDjs,temasPorDj,opcionmen1,MLDjs);
	writeln('Listado de Datos');
	Menu2(listatemas,nomDjs,temasPorDj,MLDjs);	
END.
