program pto2;

type
	tiAno=1980..2015;
	tRegVentHist= record
					ano:tiAno;
					mes:1..12;
					numSuc:word;
					importe:real;
				  end;
	tArchVentHist=file of tRegVentHist;
	tiCli=1..90000;
	tRegVentas= record
					fecha:string[8];
					numCli:tiCli;
					numSuc:word;
					artic:word;
					cant:word;
					importe:real;
				end;
	tArchVentas= file of tRegVentas;	



Procedure LeerArchVentHist(var arch:tArchVentHist; var reg:tRegVentHist; var fin:boolean);

begin
	fin:= EOF(arch);
	if (not fin) then
		read(arch,reg);
end;

Procedure LeerArchVentas(var arch:tArchVentas; var reg:tRegVentas; var fin:boolean);

begin
	fin:= EOF(arch);
	if (not fin) then
		read(arch,reg);
end;


Procedure copiarReg (regVentas:tRegVentas; var regVentHistAct:tRegVentHist);
var
	cod1,cod2,anoaux,mesaux:integer;
begin
	val(copy(regVentas.fecha,1,4),anoaux,cod1);
	val(copy(regVentas.fecha,5,2),mesaux,cod2);
	with regVentHistAct do
		begin
			ano:=anoaux;							
			mes:=mesaux;
			numSuc:=regVentas.numSuc;
			importe:=regVentas.importe;
		end;

end


Procedure ActualizarArchVentHist(var archVentHist:tArchVentHist; var archVentHistAct:tArchVentHist);

var
	regAux:tRegVentHist;
begin
	reset(archVentHistAct);
	rewrite(archVentHist);
	while (not EOF(archVentHistAct)) do
		begin
			read(archVentHistAct,regAux);
			write(archVentHist,regAux);
		end;	
	close(archVentHist);
	close(archVentHistAct);	
end;


var
	archVentHist,archVentHistAct:tArchVentHist;
	archVentas:tArchVentas;
	regVentHist,regVentHistAct:tRegVentHist;
	regVentas:tRegVentas;
	finVentHist,finVentas:boolean;

begin
	assign(archVentHist,'C:/ArchVentHistorico.dat');
	assign(archVentas,'C:/ArchVentas.dat');
	assign(archVentHistAct,'C:/ArchVentHistActual.dat');
	reset(archVentas);
	reset(archVentHist);
	rewrite(archVentHistAct);
	LeerArchVentHist(archVentHist,regVentHist,finVentHist);
	LeerArchVentas(archVentas,regVentas,finVentas);
	while ((not finVentHist) and (not finVentas)) do
		if (regVentHist.numSuc<regVentas.numSuc) then
			begin
				write(archVentHistAct,regVentHist);
				LeerArchVentHist(archVentHist,regVentHist,finVentHist);
			end;
			else
				if (regVentHist.numSuc>regVentas.numSuc) then
					begin
						copiarReg(regVentas,regVentHistAct);
						write(archVentHistAct,regVentHistAct);		
						LeerArchVentas(archVentas,regVentas,finVentas);
					end;
				else
					begin								
						copiarReg(regVentHist,regVentHistAct);			
						if (regVentHistAct.ano>regVentHist.ano) then
							begin
								write(archVentHistAct,regVentHist);
								LeerArchVentHist(archVentHist,regVentHist,finVentHist);
							end;
						else
								if (regVentHistAct.ano<regVentHist.ano) then
									begin
										write(archVentHistAct,regVentHistAct)
										LeerArchVentas(archVentas,regVentas,finVentas);
									end;
								else 
									if (regVentHistAct.mes>regVentHist.mes) then
										begin
											write(archVentHistAct,regVentHist);
											LeerArchVentHist(archVentHist,regVentHist,finVentHist);
										end;
										else 
											begin
												write(archVentHistAct,regVentHistAct);
												LeerArchVentas(archVentas,regVentas,finVentas);
											end;		
					end;		
						
						
	while (not finVentHist) do
		begin
			write(archVentHistAct,regVentHist);
			LeerArchVentHist(archVentHist,regVentHist,finVentHist);
		end;
	while (not finVentas) do	 				
		begin
			copiarReg(regVentHist,regVentHistAct);
			write(archVentHistAct,regVentHistAct);
			LeerArchVentas(archVentas,regVentas,finVentas);
		end;
	ActualizarArchVentHist(archVentHist,archVentHistAct);	
end;
