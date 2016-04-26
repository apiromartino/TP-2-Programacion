Function PosicionTema(listatemas:tmListaTemas; temasPorDj:tmTemasPorDj; i:byte;j:byte):byte;

var
	k:byte;

begin
	k:=1;
	while (listatemas[k,nombre]<>temasPorDj[i,j]) do
		k:=k+1;
	PosicionTema:=k;
end; 


Function SumParcial(MLTemas:byte;listatemas:tmListaTemas;i:byte):word;

var
	minnum:byte;
	segnum:byte;
	codigo1:byte;
	codigo2:byte;
	j:byte;
	aux:word;
	Pos:byte;
begin
	aux:=0;
	for j:=1 to MLTemas do
	begin
		Pos:=PosicionTema2(listatemas,temasPorDj,i,j);
		VAL(listatemas[Pos,minutos],minnum,codigo1);
		VAL(listatemas[Pos,segundos],segnum,codigo2);
		aux:=(minnum*60)+segnum+aux;
	end;
	SumParcial:=aux;
end;

Procedure DjMaxDuracion(MLDjs:tiDjs;temasPorDj:tmTemasPorDj;sumaduracion:tvSumaDuracion;listatemas:tmListatemas );

var
	i:byte;
	Max:word;
	j:byte;
	MLTema:byte;
	Total:word;
	k:byte;
begin
	for i:=1 to MLDjs do
		begin
			MLTema:=Cantidadtemas(i,temasPorDj);
			Total:=SumParcial(MLTemas,listatemas,i);
			sumaduracion[i]:=Total;	
		end;	
	Max:=0;
	for k:=1 to MLDjs do
		if (sumaduracion[k]>Max) then 
			Max:=sumaduracion[k];
			
			
end;

