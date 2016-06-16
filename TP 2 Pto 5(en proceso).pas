program Punto5VentasHistorico;

uses crt;

type
	tRegVentHist= record
					ano:word;
					mes:1..12;
					numSuc:word;
					importe:real;
				  end;
	tArchVentHist=file of tRegVentHist;
	
	
Procedure Carga (var archVentHIst:tArchVentHist);	

var
	regVentHist:tRegVentHist;

begin
	rewrite(archVentHist);
	writeln('Ingrese el numero de sucursal, si no quiere ingresar mas, ingrese el numero 0');
	readln(regVentHist.numSuc);
	while (regVentHist.numSuc<>0) do
		begin
			writeln('Ingrese el ano del importe');
			readln(regVentHist.ano);
			writeln('Ingrese el nùmero de mes del importe');
			readln(regVentHist.mes);
			writeln('Ingrese el importe correspondiente');
			readln(regVentHist.importe);
			write(archVentHist,regVentHist);
			writeln('Ingrese el numero de sucursal, si no quiere ingresar mas, ingrese el numero 0');
	        readln(regVentHist.numSuc);
	   end;
	close(archVentHist);  
end;
	
Procedure Mostrar (var archVentHist:tArchVentHist);

var
	regVentHist:tRegVentHist;

begin
	reset(archVentHIst);
	while (not EOF(archVentHist)) do
		begin
			read(archVentHist,regVentHist);
			writeln('Sucursal numero ',regVentHist.numSuc);
			writeln('Ano ',regVentHist.ano);
			writeln('Mes numero ',regVentHist.mes);
			writeln('Tiene un importe de ',regVentHist.importe);
			writeln();
		end;	
	close(archVentHist);
end;	
				  	
var 
	archVentHist:tArchVentHist;
	
BEGIN
	assign(archVentHist,'C:/ArchVentHist.dat');
	Carga(archVentHist);
	Mostrar(archVentHist);      			
END.
