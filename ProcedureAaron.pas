function validarTema (tema:string;listaTemas:tmListaTemas):boolean;
var
	i:tiTemasPorDjs;
begin
	for i:=1 to MAXTEM do					
		if tema=listaTemas[i] then
		validarTema:=true;
			else
			validarTema:=false;
end;
	


Procedure IngreseListaTemasPorDj(listatemas:tmListaTemas; nomDjs:tvNomDjs; var temasPorDj:tmTemasPorDj; MLDjs:tiDjs); 
 var 
 	j:tiTemasPorDj; 
 	i:tiDjs; 
 	tema:string; 
 	corte:byte; 
 	codigo:byte; 
	MLTemas:tiTemasPorDj;


 begin 
 	for i:=1 to MLDjs do 
 	begin 
 		writeln('ingrese la cantidad de temas que tocara' nomDjs[i]);
 		read(MLTemas);
 		repeat
			writeln('debe ser menor o igual a 35 temas');
			readln(MLTemas);
			until MLTemas<=35;
 		writeln('Agregue los temas para el Dj ', nomDjs[i], ', que ocupa el puesto numero ', i, ' en la lista.','el tema debe estar en la lista de 200 temas'); 
 		writeln('Si no desea colocar mas temas, ingrese 0. Hay un maximo de 35 por Dj'); 
		j:=0;	
			repeat
			j:=j+1;
			writeln('Nombre del tema ',j); 
			readln(tema); 
			validarTema(tema,listaTemas)
			if validarTema=true then
				temasPorDj[i,j]:=tema;		 
					else
						repeat
							writeln('el tema no se encuentra en la lista','ingrese nuevamente el tema');
							read(tema);
						until validarTema=true;
			VAL(tema,corte,codigo); 
			until (corte=0) or (j=MLTemas);	
	end;		 
 end; 
