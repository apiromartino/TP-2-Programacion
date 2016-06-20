Program Archivos;



type
	tiAno=1980..2015;
	tRegVentHist= record
					ano:tiAno;
					mes:1..12;
					numSuc:word;
					importe:real;
				  end;
	tArchVentHist=file of tRegVentHist;
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
	tRegCli= record
				numCli:tiCli;
				nomb:string[30];
				prov:string[50];
				loc:string[50];
				direcc:string[50];
			end;
	tArchCli= file of tRegCli;
	tRegSuc= record
			numSuc:word;
			nomb:string[30];
			pais:string[50];
			direcc:string[50];
			tel:string[20];
		  end;
	tArchSuc= file of tRegSuc;		




Procedure LeerArchVentas(var arch:tArchVentas; var reg:tRegVentas; var fin:boolean);

begin
	fin:= EOF(arch);
	if (not fin) then
		read(arch,reg);
end;


Function Mes (mesant:byte):string;

begin
	case mesant of
		1:Mes:='Enero';
		2:Mes:='Febrero';
		3:Mes:='Marzo';
		4:Mes:='Abril';
		5:Mes:='Mayo';
		6:Mes:='Junio';
		7:Mes:='Julio';
		8:Mes:='Agosto';
		9:Mes:='Septiembre';
		10:Mes:='Octubre';
		11:Mes:='Noviembre';
		12:Mes:='Diciembre';
	end;	

end;


Procedure VentasArg2015 (var archVentas:tArchVentas);

var
	regVentas:tRegVentas;
	mesaux,mesant:1..12;
	cod:byte;
	finVentas:boolean;

begin
	reset(archVentas);
	LeerArchVentas(archVentas,regVentas,finVentas);
	val(copy(regVentas.fecha,5,2),mesaux,cod);
	while (not finVentas) do
		begin
			mesant:=mesaux;
			writeln('Ventas en el mes de ',Mes(mesant));
			writeln(' ');
			while ((not finVentas) and (mesant=mesaux)) do
				begin
					writeln('Sucursal numero: ',regVentas.numSuc);
					writeln('Numero de Cliente: ',regVentas.numCli);
					writeln('Codigo Articulo: ',regVentas.artic);
					writeln('Cantidad: ',regVentas.cant);
					writeln('Importe: ',round(regVentas.importe));
					writeln(' ');
					LeerArchVentas(archVentas,regVentas,finVentas);
					val(copy(regVentas.fecha,5,2),mesaux,cod);
				end;
			writeln(' ');		 
		end;	
	close(archVentas);
end;



Procedure LeerArchVentHist(var arch:tArchVentHist; var reg:tRegVentHist; var fin:boolean);

begin
	fin:= EOF(arch);
	if (not fin) then
		read(arch,reg);
end;



Procedure copiarReg (regVentas:tRegVentas; var regVentHistAct:tRegVentHist);
var
	cod1,cod2:byte;
	anoaux:tiAno;
	mesaux:1..12;
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

end;


Procedure PasarDatos(var archVentHist:tArchVentHist; var archVentHistAct:tArchVentHist);

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

Procedure ActualizarArchVentHist(var archVentHist:tArchVentHist; var archVentas:tArchVentas; var archVentHistAct:tArchVentHist);

var
	regVentHist,regVentHistAct:tRegVentHist;
	regVentas:tRegVentas;
	finVentHist,finVentas:boolean;
	
begin
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
			end
			else
				if (regVentHist.numSuc>regVentas.numSuc) then
					begin
						copiarReg(regVentas,regVentHistAct);
						write(archVentHistAct,regVentHistAct);		
						LeerArchVentas(archVentas,regVentas,finVentas);
					end
				else
					begin								
						copiarReg(regVentas,regVentHistAct);			
						if (regVentHistAct.ano>regVentHist.ano) then
							begin
								write(archVentHistAct,regVentHist);
								LeerArchVentHist(archVentHist,regVentHist,finVentHist);
							end
						else
								if (regVentHistAct.ano<regVentHist.ano) then
									begin
										write(archVentHistAct,regVentHistAct);
										LeerArchVentas(archVentas,regVentas,finVentas);
									end
								else 
									if (regVentHistAct.mes>regVentHist.mes) then
										begin
											write(archVentHistAct,regVentHist);
											LeerArchVentHist(archVentHist,regVentHist,finVentHist);
										end
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
			copiarReg(regVentas,regVentHistAct);
			write(archVentHistAct,regVentHistAct);
			LeerArchVentas(archVentas,regVentas,finVentas);
		end;
	close(archVentHistAct);
	close(archVentHist);
	close(archVentas);	
	PasarDatos(archVentHist,archVentHistAct);	
	
end;

Procedure LeerArchCli(var arch:tArchCli; var reg:tRegCli; var fin:boolean);

begin
	fin:=EOF(arch);
	if not fin then
		read(arch,reg);	
end;

Procedure GenerarArchTxtClientes(var archCli:tArchCli; var archCliTxt:text);

var
	regCli:tRegCli;
	finCli:boolean;
	cantProv,cantLoc,total:longint;
	provAnt,locAnt:string[50];
begin
	reset(archCli);
	rewrite(archCliTxt);
	LeerArchCli(archCli,regCli,finCli);
	total:=0;
	writeln(archCliTxt,'Clientes en Argentina');
	while (not finCli) do
		begin
			cantProv:=0;
			provAnt:=regCli.prov;
			writeln(archCliTxt,' ');
			writeln(archCliTxt,'Clientes en las distintas localidades de la Provincia ',provAnt);
			while ((not finCli) and (provAnt=regCli.prov)) do
				begin
					cantLoc:=0;
					locAnt:=regCli.loc;
					while ((not finCli) and (provAnt=regCli.prov) and (locAnt=regCli.loc)) do
						begin
							Inc(cantLoc);
							Inc(cantProv);
							Inc(total);
							LeerArchCli(archCli,regCli,finCli);
						end;
					writeln(archCliTxt,'La Localidad ',locAnt,' tiene ',cantLoc,' clientes');		
				end;
			writeln(archCliTxt,'La Provincia ',provAnt,' tiene un total de ',cantProv,' clientes')	
		end;
	writeln(' ');
	writeln(archCliTxt,'Hay un total de ',total,' clientes en toda la Argentina');	
	close(archCliTxt);
	close(archCli);	
end;

Procedure LeerArchSuc (var arch:tArchSuc; var reg:tRegSuc; var fin:boolean);

begin
	fin:=EOF(arch);
	if not fin then
		read(arch,reg);
end;

Procedure PasarDatos2(var archMund:tArchSuc; var archAct:tArchSuc);

var
	regAux:tRegSuc;
begin
	reset(archAct);
	rewrite(archMund);
	while (not EOF(archAct)) do
		begin
			read(archAct,regAux);
			write(archMund,regAux);
		end;	
	close(archMund);
	close(archAct);	
end;


Procedure ActualizarArchSucMund(var archArg:tArchSuc; var archMund:tArchSuc; var archAct:tArchSuc);

var
	regArg,regMund:tRegSuc;
	finArg,finMund:boolean;
begin
	reset(archArg);
	reset(archMund);
	rewrite(archAct);
	LeerArchSuc(archArg,regArg,finArg);
	LeerArchSuc(archMund,regMund,finMund);
	while ((not finArg) and (not finMund)) do
		if (regMund.numSuc<regArg.numSuc) then
			begin
				write(archAct,regMund);
				LeerArchSuc(archMund,regMund,finMund);
			end
		else 
			begin
				write(archAct,regArg);
				LeerArchSuc(archArg,regArg,finArg);
			end;
	while (not finMund) do
		begin
			write(archAct,regMund);
			LeerArchSuc(archMund,regMund,finMund);
		end;	
	while (not finArg) do
		begin
			write(archAct,regArg);
			LeerArchSuc(archArg,regArg,finArg);
		end;
	close(archAct);		
	close(archArg);
	close(archMund);
	PasarDatos2(archMund,archAct);
end;

var
	archVentHist,archVentHistAct:tArchVentHist;
	archVentas:tArchVentas;
	archCli:tArchCli;
	archCliTxt:text;
	archArg,archMund,archAct:tArchSuc;

BEGIN
	assign(archVentHist,'C:/ArchVentHistorico.dat');
	assign(archVentas,'C:/ArchVentas.dat');
	assign(archVentHistAct,'C:/ArchVentHistActual.dat');
	assign(archCli,'C:/ArchClientes.dat');
	assign(archCliTxt,'C:/TotCli.txt');
	assign(archArg,'C:/ArchSucArg.dat');
	assign(archMund,'C:/ArchSucMund.dat');
	assign(archAct,'C:/ArchSucActualizado.dat');
	VentasArg2015(archVentas);
	ActualizarArchVentHist(archVentHist,archVentas,archVentHistAct);
	GenerarArchTxtClientes(archCli,archCliTxt);
	ActualizarArchSucMund(archArg,archMund,archAct);
END.
