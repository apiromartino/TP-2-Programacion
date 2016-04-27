Procedure Inicializarvector (var temasrepetidos:tvTemasRepetidos);

var
	i:byte;
begin
	for i:=1 to MAXTEM do
		temasrepetidos[i]:=0;
end;

Procedure TemasMasTocados(temasPorDj:tmTemasPorDj; listaTemas:tmListaTemas; temasRepetidos:tvTemasRepetidos; MLDjs:tiDjs); {AGREGAR TIPOS}
var 	i:byte;
	j:byte;
	k:byte;
	maximoRepetidos:byte;

begin
	i:=1;
	Inicializarvector(temasRepetidos);
	for k:=1 to MLDjs do
		while temasPorDj[k,i]<>'0' do
			begin
				for j:=1 to MAXTEM do
					if (temasPorDj[k, i]=listaTemas[j,nombre]) then
						temasRepetidos[j]:= temasRepetidos[j] + 1;
				i:=i+1;
			end;		
	maximoRepetidos:=0;
	for i:=1 to MAXTEM do
		if (temasRepetidos[i]>maximoRepetidos) then
			maximoRepetidos:=temasRepetidos[i];
	for i:=1 to MAXTEM do
		if temasRepetidos[i]=maximoRepetidos then
			writeln(listaTemas[i,nombre], ' es de los mas repetidos, esta repetido ', maximoRepetidos, ' veces');
end;		
