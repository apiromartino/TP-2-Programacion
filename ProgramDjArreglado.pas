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
	tiNomTemas=string [20];
	tiNomDjs=string [40];
	tiMinSeg=(minutos,segundos);
	tvNomTemas=array [tiTemas] of tiNomTemas;
	tvNomDjs=array [tiDjs] of tiNomDjs;
	tmTemasPorDj=array [tiDjs,tiTemasPorDj] of tiNomTemas; 
	tmMinSegTemas=array[tiTemas,tiMinSeg] of byte;
	tvDuracion=array[tiTemas] of integer;
	tvTemasRepetidos=array [tiTemas] of byte;
	tvTotalSegPorDj=array[tiDjs] of integer;
	tvPosicion=array[tiDjs] of byte;

Procedure ValidarMinutos(var min:byte);


begin
     repeat
         write('Minutos:');
         readln(min);
         if (min>MAXMIN) then
             writeln('Supera los ',MAXMIN,' minutos, vuelva a ingrasar nuevamente');
     until (min<=MAXMIN);
     
end;

Procedure ValidarSegs(var seg:byte;min:byte); 

var
	correcto:boolean;
	
begin
	 repeat
         correcto:=true;
         write('Segundos:');
         readln(seg);
         if (seg>MAXSEGS) then
               writeln('Los segundos superaron los ',MAXSEGS,' segundos, vuelva a ingresar los segundos resantes del tema');
         if ((min=MAXMIN) and (seg<>0)) then
               begin
					writeln('El tema supera los ',MAXMIN,' minutos, vuelva a ingresar los segundos restantes del tema');
					correcto:=false;
			   end;		   	
     until ((correcto) and (seg<=MAXSEGS));           

end;      


Procedure IngreseListaTemas(var nomTemas:tvNomTemas; var tiempoTemas:tmMinSegTemas);     
var
    i: tiTemas;
    nom: string;
    min: byte;
    seg: byte;
    
begin
    writeln('Ingrese la lista de 200 temas con su duracion');
    for i:=1 to MAXTEM do
       begin
       writeln('Ingrese el nombre del tema');
       readln(nom);
       nomTemas[i]:=nom;
       writeln('Duracion del tema, con un maximo de 10 minutos');
       ValidarMinutos(min);
       tiempoTemas[i,minutos]:= min;
       ValidarSegs(seg,min);
       tiempoTemas[i,segundos]:=seg;
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




Procedure validartema(var tema:string; nomTemas:tvNomTemas);

var 
	i:byte;
	boleano:boolean;

begin
	boleano:=false;
	i:=1;
    repeat
		if  (tema=nomTemas[i]) then
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

Procedure IngreseListaTemasPorDj(nomTemas:tvNomTemas; nomDjs:tvNomDjs; var temasPorDj:tmTemasPorDj; MLDjs:tiDjs);
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
				validartema(tema,nomTemas);
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
Procedure Menu1(var nomTemas:tvNomTemas; var tiempoTemas:tmMinSegTemas; var nomDjs:tvNomDjs; var temasPorDj:tmTemasPorDj;var opcionmen1:byte;var MLDjs:tiDjs);

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
					IngreseListaTemas(nomTemas,tiempoTemas);
					contadorOpcion1:=contadorOpcion1 + 1;
				end;
			2:	 
				begin
					IngreseListaDjs(nomDjs, MLDjs);
					contadorOpcion2:=contadorOpcion2 + 1;
				end;	
			3: 
					if ((contadorOpcion1>=1) AND (contadorOpcion2>=1)) then
						IngreseListaTemasPorDj(nomTemas, nomDjs, temasPorDj, MLDjs)
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
	temporal:tiNomDjs;
 
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

Procedure Duracionminseg(var duracion:tvDuracion; tiempoTemas:tmMinSegTemas);

var
	i:byte;
	total:word;
begin
	for i:=1 to MAXTEM do
		begin
			total:=(tiempoTemas[i,minutos]*60)+tiempoTemas[i,segundos];
			duracion[i]:=total;
		end;

end;

Procedure OrdenDuracion(nomTemas:tvNomTemas; duracion:tvDuracion);

var
	i:byte;
	j:byte;
	temporal:tiNomTemas;

begin
	for i:=1 to MAXTEM do
	begin
		for j:=i+1 to MAXTEM do
		begin
			if (duracion[i]<duracion[j]) then  
			begin
				temporal:=nomTemas[i];
				nomTemas[i]:=nomTemas[j];
				nomTemas[j]:=temporal;
			end;
		end;	
	end;
	for i:=1 to MAXTEM do
		writeln(nomTemas[i]);
		
end;

Procedure OrdenAlfabetico2(nomTemas:tvNomTemas);

var 
	i:byte;
	j:byte;
	temporal:tiNomTemas;
 
begin
	for i:=1 to MAXTEM do
	begin
		for j:=i+1 to MAXTEM do
		begin
			if (nomTemas[i]>nomTemas[j]) then
			begin
				temporal:=nomTemas[i];
				nomTemas[i]:=nomTemas[j];
				nomTemas[j]:=temporal;
			end;
		end;
	end;
	for i:=1 to MAXTEM do
		writeln(nomTemas[i]);
end;

Function PosicionDj (nombre:string; nomDjs:tvNomDjs):byte;

var
	i:byte;
begin
	i:=1;
	while nomDjs[i]<>nombre do
		i:=i+1;
	PosicionDj:=i;

end;

Function PosicionTema(nomTemas:tvNomTemas; temasPorDj:tmTemasPorDj;j:byte; i:byte):byte;

var
	k:byte;

begin
	k:=1;
	while (nomTemas[k]<>temasPorDj[i,j]) do
		k:=k+1;
	PosicionTema:=k;
end; 
	



Function Cantidadtemas(i:byte; temasPorDj:tmTemasPorDj):byte;

var
	j:byte;
begin
	j:=1;
	while (temasPorDj[i,j]<>'0') do
		j:=j+1;
	Cantidadtemas:=j-1;
end;

Procedure OrdenDuracion2(nomTemas:tvNomTemas; temasPorDj:tmTemasPorDj; nombre:string; nomDjs:tvNomDjs; duracion:tvDuracion);

var
	i:byte;
	temporal:tiNomTemas;
	l:byte;
	j:byte;
	g:byte;
	MLTemas:byte;
	posiciontema1:byte;
	posiciontema2:byte;
begin
	i:=PosicionDj(nombre,nomDjs);
	MLTemas:=Cantidadtemas(i,temasPorDj);
	for j:=1 to MLTemas do
		begin
			for g:=j+1 to MLTemas do
				begin	
					posiciontema1:=PosicionTema(nomTemas,temasPorDj,j,i);
					posiciontema2:=PosicionTema(nomTemas,temasPorDj,g,i);
					if (duracion[posiciontema1]>duracion[posiciontema2]) then  
					begin
						temporal:=temasPorDj[i,j];
						temasPorDj[i,j]:=temasPorDj[i,g];
						temasPorDj[i,g]:=temporal;
					end;
				end;	
		end;
    for l:=1 to MLTemas do
		writeln(temasPorDj[i,l]);
		
end;



Procedure OrdenDeIngreso2(temasPorDj:tmTemasPorDj; nombre:string;nomDjs:tvNomDjs);

var
	i:byte;
	k:byte;
	j:byte;
begin
	i:=PosicionDj(nombre,nomDjs);
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



Procedure Submenu2 (nomTemas:tvNomTemas; tiempoTemas:tmMinSegTemas; duracion:tvDuracion);

var
	opcionsubmenu2:byte;
begin
	writeln('Ingrese la opcion deseada');
	repeat
		writeln('1- Orden por duracion en forma descendente');
		writeln('2- Ordenados alfabeticamente en forma ascendente');
		writeln('3- Salir de esta lista');
		readln(opcionsubmenu2);
		case opcionsubmenu2 of
			1: OrdenDuracion(nomTemas,duracion);
			2: OrdenAlfabetico2(nomTemas);
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

Procedure ValidarNombre(var nombre:string; nomDjs:tvNomDjs; MLDjs:tiDjs);

var
	i:byte;
	boleano:boolean;
begin
	repeat
		boleano:=false;
		writeln('Ingrese el nombre del Dj que desee para ver los temas que va a tocar');
		readln(nombre);
		for i:=1 to MLDjs do
				if nombre=nomDjs[i] then boleano:=true;
		until (boleano=true);		
		
end;


Procedure Submenu3 (nomTemas:tvNomTemas; temasPorDj:tmTemasPorDj;nomDjs:tvNomDjs; MLDjs:tiDjs; duracion:tvDuracion);

const
	OPMAX=2;
	OPMIN=1;

var
	opcionsubmenu3:byte;
	nombre:string;
begin
	repeat
		ValidarNombre(nombre,nomDjs,MLDjs);
		writeln('Ingrese la opcion deseada');
		repeat
			writeln('1- Temas ordenados por duracion en forma ascendente');
			writeln('2- Temas en el orden de ingreso');
			readln(opcionsubmenu3);
			case opcionsubmenu3 of
				1: OrdenDuracion2(nomTemas,temasPorDj,nombre,nomDjs,duracion);
				2: OrdenDeIngreso2(temasPorDj,nombre,nomDjs);
			else writeln('Ingreso una opcion invalida, vuelva a elegir una opcion');
			end;
		until ((opcionsubmenu3<=OPMAX) and (opcionsubmenu3>=OPMIN));	
		SalirLista(opcionsubmenu3);
	until (opcionsubmenu3=1);	
		
end;




Procedure Menu2(nomTemas:tvNomTemas; tiempoTemas:tmMinSegTemas; nomDjs:tvNomDjs; temasPorDj:tmTemasPorDj; MLDjs:tiDjs; duracion:tvDuracion);

    
var
	opcionmen2:byte;
	
begin
	 Duracionminseg(duracion,tiempoTemas);
     writeln('Ingrese la opción deseada');
     repeat
		writeln('1- Listado de Dj');
		writeln('2- Listado de Temas');
		writeln('3- Listado de Temas de un Dj determinado');
		writeln('4- Salir de Listado de Datos');
		readln(opcionmen2);
		case opcionmen2 of
			1: Submenu1(nomDjs,MLDjs);
			2: Submenu2(nomTemas,tiempoTemas,duracion);
			3: Submenu3(nomTemas,temasPorDj,nomDjs,MLDjs,duracion);
			4: writeln('Salio del Listado de Datos');
        else writeln('Ingreso una opcion invalida, vuelva a elegir una opcion');    
        end;     
     until (opcionmen2=4);   
end;


Procedure ConversordeSeg(maxdVector:integer);
var
	Hor,Min,Seg,cero:string[4];
	HorAux,MinAux,SegAux:byte;

begin
   cero:='0';
   HorAux:=(maxdVector div 3600);
   Str(HorAux,Hor);
   if HorAux<10 then
      insert(cero,Hor,1);
   MinAux:=(maxdVector mod 3600) div 60;
   Str(Minaux,Min);
   if MinAux<10 then
      insert(cero,Min,1);
   SegAux:=(maxdVector mod 3600) mod 60;
   Str(SegAux,Seg);
   if SegAux<10 then
      insert(cero,Seg,1);
    writeln(Hor,':',Min,':',Seg);

end;


Procedure  MaxdVector(MLDjs:tiDjs; VecTotalsegPordj:tvTotalsegPorDj; VecPosicion:tvPosicion; nomDjs:tvNomDjs);

var 
		i,j,k:byte;
        maxdVector:integer;

begin
		for i:=1 to MLDjs do
			begin
				if (VecTotalsegPorDj[i]>maxdVector) then
					begin
						maxdVector:=VecTotalsegPorDj[i];
						k:=1;
						for j:=i to MLDjs do
							if VecTotalsegPorDj[j]=maxdVector then
								begin
									VecPosicion[k]:=j;
									VecPosicion[k+1]:=0;
									k:=k+1;
								end
					end
			end;
		i:=1;
		while VecPosicion[i]<>0 do
			begin
				if (VecPosicion[2]=0) then
					begin
						write(nomDjs[VecPosicion[1]],' tocara ');
							ConversordeSeg(maxdVector);
					end
				else
					begin
						Write(nomDjs[VecPosicion[i]],' tocara ');
						ConversordeSeg(maxdVector);
					end;
				i:=i+1
			end;
end;

Procedure DjsQueMasToca(VecTotalsegPordj:tvTotalsegPorDj; nomTemas:tvNomTemas; tiempoTemas:tmMinSegTemas; temasPorDj:tmTemasPorDj; MLDjs:tiDjs; VecPosicion:tvPosicion; nomDjs:tvNomDjs);

var 
		i,j,k:byte;
		Total,Parcial:integer;

begin
		for i:=1 to MLDjs do
			begin
				j:=1;
				repeat
					for k:=1 to MAXTEM do
						if temasPorDj[i,j]=nomTemas[k] then
							begin
								Parcial:=((tiempoTemas[k,minutos]*60)+tiempoTemas[k,segundos]);
							end;
					Total:=Total+Parcial;
					j:=j+1;
				until(temasPorDj[i,j]='0');
				VecTotalsegPorDj[i]:=Total;
				Total:=0
			end;
		MaxdVector(MLDjs,VecTotalsegPordj,VecPosicion,nomDjs);
end;
   

Procedure Inicializarvector (var temasRepetidos:tvTemasRepetidos);

var
	i:byte;
begin
	for i:=1 to MAXTEM do
		temasRepetidos[i]:=0;
end;

Function MaxRepetidos(temasRepetidos:tvTemasRepetidos):byte;

var
	i:byte;
	aux:byte;
begin
	aux:=0;
	for i:=1 to MAXTEM do
		if temasRepetidos[i]>aux then
			aux:=temasRepetidos[i];
	MaxRepetidos:=aux;		
end;	


Function CantidadMaximos(temasRepetidos:tvTemasRepetidos; maximoRepetidos:byte):byte;

var
	i:byte;
	aux:byte;
begin
	aux:=0;
	for i:=1 to MAXTEM do
		if temasRepetidos[i]=maximoRepetidos then
			aux:=aux+1;
	CantidadMaximos:=aux;		
end;


Procedure Mostrar(contador:byte; maximoRepetidos:byte; temasRepetidos:tvTemasRepetidos; nomTemas:tvNomTemas; tiempoTemas:tmMinSegTemas);

var
	i:byte;
begin
	if (contador=1) then
		for i:=1 to MAXTEM do
			if temasRepetidos[i]=maximoRepetidos then
				writeln(nomTemas[i], ' es el tema que mas veces sera tocado, con un total de ', maximoRepetidos, ' repeticiones');
	if (contador>1)	then
		for i:=1 to MAXTEM do
			if temasRepetidos[i]=maximoRepetidos then
				begin
					writeln(nomTemas[i],' es uno de los temas que sera mas tocado, con un total de ',maximoRepetidos, ' repeticiones');
					writeln('Este tema dura ',tiempoTemas[i,minutos],':',tiempoTemas[i,segundos]);
					writeln(' ');
				end;	
end;




Procedure TemasMasTocados(temasPorDj:tmTemasPorDj; nomTemas:tvNomTemas; tiempoTemas:tmMinSegTemas; temasRepetidos:tvTemasRepetidos; MLDjs:tiDjs); 
var 
	i:byte;
	j:byte;
	k:byte;
	maximoRepetidos:byte;
	contador:byte;
begin
	Inicializarvector(temasRepetidos);
	for k:=1 to MLDjs do
		begin
			i:=1;
			while temasPorDj[k,i]<>'0' do
				begin
					for j:=1 to MAXTEM do
						if (temasPorDj[k,i]=nomTemas[j]) then
							temasRepetidos[j]:= temasRepetidos[j] + 1;
					i:=i+1;
				end;
		end;		
	maximoRepetidos:=MaxRepetidos(temasRepetidos);
	contador:=CantidadMaximos(temasRepetidos,maximoRepetidos);
	Mostrar(contador,maximoRepetidos,temasRepetidos,nomTemas,tiempoTemas);		
end;

var 
    nomTemas:tvNomTemas;
    tiempoTemas:tmMinSegTemas;
	nomDjs:tvNomDjs;
	temasPorDj:tmTemasPorDj;
    opcionmen1:byte;
    MLDjs:tiDjs;
    duracion:tvDuracion;
	temasRepetidos:tvTemasRepetidos;
	vecTotalSegPorDj:tvTotalSegPorDj;
	vecPosicion:tvPosicion;
BEGIN 
	Menu1(nomTemas,tiempoTemas,nomDjs,temasPorDj,opcionmen1,MLDjs);
	writeln('Listado de Datos');
	Menu2(nomTemas,tiempoTemas,nomDjs,temasPorDj,MLDjs,duracion);
	writeln(' ');
	writeln('Djs que mas tiempo tocaran:');
	DjsQueMasToca(vecTotalsegPordj,nomTemas,tiempoTemas,temasPorDj,MLDjs,vecPosicion,nomDjs);
	writeln(' ');
	writeln('Temas mas tocados:');
	TemasMasTocados(temasPorDj,nomTemas,tiempoTemas,temasRepetidos,MLDjs); 
	readln();	
END.
