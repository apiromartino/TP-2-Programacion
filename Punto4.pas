Procedure Inicializarvector (var temasrepetidos:tvTemasRepetidos);

var
	i:byte;
begin
	for i:=1 to MAXTEM do
		temasrepetidos[i]:=0;
end;

Procedure TemasMasTocados(temasPorDj:tmTemasPorDj; listaTemas:tmListaTemas; temasRepetidos:tvTemasRepetidos; MLDjs:tiDjs);
var 	i:byte;
	j:byte;
	k:byte;
	maximoRepetidos:byte;

begin
	i:=1;
	Inicializarvector(temasRepetidos);
	for k:=1 to MLDjs do {Navega el primer vector de la matriz temasPorDj}
		while temasPorDj[k,i]<>'0' do {con este navega el segundo vector, ya que la cantidad de temas por dj varia}
			begin		      {y consecuentemente el maximo logico esta declarado con un cero al terminar el array}
				for j:=1 to MAXTEM do
				{este navega la lista de temas y la compara con el array de temas de la matriz temas por dj}
				{si encuentra el mismo valor en ambos arrays, le suma un uno en la lista/contador temasRepetidos}
				{en la posicion en la cual se encontraba en la lista de temas.}
					if (temasPorDj[k, i]=listaTemas[j,nombre]) then
						temasRepetidos[j]:= temasRepetidos[j] + 1;
				i:=i+1;
			end;		
	maximoRepetidos:=0; {en esta variable almaceno cual/es es el numero de temas mas repetido}
	for i:=1 to MAXTEM do
		if (temasRepetidos[i]>maximoRepetidos) then
			maximoRepetidos:=temasRepetidos[i];
	for i:=1 to MAXTEM do {finalmente comparo este maximo con toda la lista de temasrepetidos, y los de mayor valor}
			      {los digo llamando a la lista de temas en la posicion i. (ya que la lista de temas coincide en ambas listas)}
		if temasRepetidos[i]=maximoRepetidos then
			writeln(listaTemas[i,nombre], ' es de los mas repetidos, esta repetido ', maximoRepetidos, ' veces');
end;		
