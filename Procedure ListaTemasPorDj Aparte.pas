{Falta validar que la cancion este en la lista de los 200 temas y que no se repita la cancion el mismo Dj, 
el unico problema es que si ponen un tema de 1 letra sale del while
y le pregunta el otro el primer tema. Pero Funciona!!
Tambien no fuciona lo de que si pone 35 temas pase al Dj siguiente}



Procedure IngreseListaTemasPorDj(listatemas:tmListaTemas; nomDjs:tvNomDjs; var temasPorDj:tmTemasPorDj; MLDjs:tiDjs);
var
	j:tiTemasPorDj;
	i:tiDjs;
	tema:string;
	corte:byte;
	codigo:byte;
begin
	for i:=1 to MLDjs do
	begin
		j:=1;
		writeln('Agregue los temas para el Dj ', nomDjs[i], ', que ocupa el puesto numero ', i, ' en la lista.');
		writeln('Si no desea colocar mas temas, ingrese 0. Hay un maximo de 35 por Dj');
		writeln('Nombre del tema ',j);
		readln(tema);
		temasPorDj[i,j]:=tema;		
		VAL(tema,corte,codigo);
		while ((corte<>0) or (LENGTH(tema)>1)) do 
			begin
				j:=j+1;
				writeln('Nombre del tema ',j);
				readln(tema);
				temasPorDj[i,j]:=tema;		
				VAL(tema,corte,codigo);
			end;
	end;		
end;
