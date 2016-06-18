program Punto1;

uses crt;

type

	tiCli=0..90000;
	tRegVentas= record
					fecha:string[8];
					numCli:tiCli;
					numSuc:word;
					artic:longint;
					cant:word;
					importe:real;
				end;
	tArchVentas= file of tRegVentas;
	tRegVentas2= record
					mes:1..12;
					cant:word;
					importe:integer;
				 end;
	tiVentas=1..8000;			 
	tmVentas=array [1..12,tiVentas] of tRegVentas2;				
				 		 	

Procedure LeerArchVentas(var arch:tArchVentas; var reg:tRegVentas; var fin:boolean);

begin
	fin:= EOF(arch);
	if (not fin) then
		read(arch,reg);
end;

Procedure CopiarRegVentas(regVentas:tRegVentas; var regVentas2:tRegVentas2);

var
	mesaux:1..12;
	importeaux:integer;
	cod:byte;

begin
	val(copy(regVentas.fecha,5,2),mesaux,cod);
	importeaux:=round(regVentas.importe);
	regVentas2.mes:=mesaux;
	regVentas2.importe:=importeaux;
	regVentas2.cant:=regVentas.cant;
end;



var 
	regVentas:tRegVentas;
	archVentas:tArchVentas;
	regVentas2:tRegVentas2;
	finVentas:boolean;
	mVentas:tmVentas;
	i:1..12;
	j:tiVentas;
	mesant:1..12;

BEGIN
	assign(archVentas,'C:/ArchVentas.dat');
	reset(archVentas);
	LeerArchVentas(archVentas,regVentas,finVentas);
	CopiarRegVentas(regVentas,regVentas2);
	i:=1;
	while (not finVentas) do
		begin
			mesant:=regVentas2.mes;
			j:=1;
			while ((not finVentas) and (mesant=regVentas2.mes)) do
				begin
					mVentas[i,j]:=regVentas2;
					inc(j);
					LeerArchVentas(archVentas,regVentas,finVentas);
					CopiarRegVentas(regVentas,regVentas2);
				end;
			inc(i);		
		end;	
	
	
	for i:=1 to 12 do
		for j:=1 to 8000 do
              begin
                 writeln(mVentas[i,j].mes);
	             writeln(mVentas[i,j].importe);
                 writeln(mVentas[i,j].cant);
              end;

	close(archVentas);
END.


