program CargaImpresionArch;

uses crt;

type
	tRegVentHist= record
					ano:word;
					mes:1..12;
					numSuc:word;
					importe:real;
				  end;
	tArchVentHist=file of tRegVentHist;
	tRegSuc= record
			numSuc:word;
			nomb:string[30];
			pais:string[50];
			direcc:string[50];
			tel:string[20];
		  end;
	tArchSuc= file of tRegSuc;
	tRegCli= record
				numCli:longint;
				nomb:string[30];
				prov:string[50];
				loc:string[50];
				direcc:string[50];
			end;
	tArchCli= file of tRegCli;
	tRegVentas= record
					fecha:string[8];
					numCli:word;
					numSuc:word;
					artic:word;
					cant:word;
					importe:real;
				end;
	tArchVentas= file of tRegVentas;				
					


	
Procedure CargaVentHist (var archVentHIst:tArchVentHist);	

var
	regVentHist:tRegVentHist;

begin
	rewrite(archVentHist);
	writeln('Ingrese el numero de sucursal, si no desea ingresar mas, ingrese el numero 0');
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
			writeln('Ingrese el numero de sucursal, si no desea ingresar mas, ingrese el numero 0');
	        readln(regVentHist.numSuc);
	   end;
	close(archVentHist);  
end;
	
Procedure MostrarVentHist (var archVentHist:tArchVentHist);

var
	regVentHist:tRegVentHist;

begin
	reset(archVentHIst);
	writeln(' ');
	writeln('Contenido de Archivo de Ventas Historicas');
	while (not EOF(archVentHist)) do
		begin
			read(archVentHist,regVentHist);
			writeln('Sucursal numero: ',regVentHist.numSuc);
			writeln('Ano: ',regVentHist.ano);
			writeln('Mes numero: ',regVentHist.mes);
			writeln('Tiene un importe de: ',regVentHist.importe);
			writeln(' ');
		end;	
	close(archVentHist);
end;	


Procedure CargarSucursales(var arch:tArchSuc);

var
	regSuc:tRegSuc;

begin
	rewrite(arch);
	wrtieln('Ingrese el número de sucursal que desee ingresar, si no quiere seguir ingresando coloque el numero 0');
	readln(regSuc.numSuc);
	while (regSuc.numSuc<>0) do
		begin
			writeln('Ingrese el nombre de la sucursal');
			readln(regSuc.nomb);
			writeln('Ingrese el país en donde se encuentra la sucursal');
			readln(regSuc.pais);
			writeln('Ingrese la direccion');
			readln(regSuc.direcc);
			writeln('Ingrese el telefono');
			readln(regSuc.tel);
			write(arch,regSuc);
			wrtieln('Ingrese el número de sucursal que desee ingresar, si no quiere seguir ingresando coloque el numero 0');
			readln(regSuc.numSuc);
		end;
	close(arch);		
end;


Procedure MostrarSucursales(var arch:tArchSuc; lugar:string);

var
	regSuc:tRegSuc
begin
	reset(arch);
	writeln(' ');
	writeln('Contenido de Archivo de Sucursales ',lugar);
	while (not EOF(arch)) do
		begin
			read(arch,regSuc);
			writeln('Sucursal numero: ',regSuc.numSuc);
			writeln('Nombre: ',regSuc.nomb);
			writeln('Pais: ',regSuc.pais);
			writeln('Direccion: ',regSuc.direcc);
			writeln('Telefono: ',regSuc.tel);
			writeln(' ');
		end;	
	close(arch);
end;


Procedure CargarClientes (var arch:tArchCli);

var
	regCli:tRegCli;
begin
	rewrite(arch);
	writeln('Ingrese el numero de cliente, si no desea ingresar mas, coloque el numero 0');
	readln(regCli.numCli);
	while (regCli.numCli<>0) do
		begin
			writeln('Ingrese el nombre');
			readln(regCli.nomb);
			writeln('Ingrese la Provincia');
			readln(regCli.prov);
			writeln('Ingrese la Localidad');
			readln(regCli.loc);
			writeln('Ingrese la Direccion');
			readln(regCli.direcc);
			write(arch,regCli);
			writeln('Ingrese el numero de cliente, si no desea ingresar mas, coloque el numero 0');
			readln(regCli.numCli);
		end;
	close(arch);	
end;

Procedure MostrarClientes (var arch:tArchCli);

var
	regCli:tRegCli;
begin
	reset(arch);
	writeln(' ');
	writeln('Contenido de Archivo de Clientes');
	while (not EOF(arch)) do
		begin
			read(arch,regCli);
			writeln('Numero de cliente: ',regCli.numCli);
			writeln('Nombre: ',regCli.nomb);
			writeln('Provincia: ',regCli.prov);
			writeln('Localidad: ',regCli.loc);
			writeln('Direccion: ',regCli.direcc);
			writeln(' ');
		end;	
	close(arch);
end;



Procedure CargarVentas(var arch:tArchVentas);

var
	regVentas:tRegVentas;
begin
	rewrite(arch);
	wrtieln('Ingrese el numero de sucursal en el que se realizo la venta, si no desea agregar mas, coloque el numero 0');
	readln(regVentas.numSuc);
	while (regVentas.numSuc<>0) do
		begin
			writeln('Ingrese la fecha con el formato AAAAMMDD');
			readln(regVentas.fecha);
			writeln('Ingrese el numero de cliente');
			readln(regVentas.numCli);
			writeln('Ingrese el codigo del articulo';
			readln(regVentas.artic);
			writeln('Ingrese la cantidad vendida');
			readln(regVentas.cant);
			writeln('Ingrese el importe realizado');
			readln(regVentas.importe):
			write(arch,regVentas);
			wrtieln('Ingrese el numero de sucursal en el que se realizo la venta, si no desea agregar mas, coloque el numero 0');
			readln(regVentas.numSuc);
		end;
	close(arch);		
end;


Procedure MostrarVentas(var arch:tArchVentas);

var
	regVentas:tRegVentas;
begin
	reset(arch);
	writeln(' ');
	writeln('Contenido de Archivo de Ventas de las sucursales Argentinas del 2015');
	while (not EOF(arch)) do
		begin
			read(arch,regVentas);
			writeln('Sucursal numero: ',regVentas.numSuc);
			writeln('Fecha: ',regVentas.fecha);
			writeln('Numero de Cliente: ',regVentas.numCli);
			writeln('Codigo Articulo: ',regVentas.artic);
			writeln('Cantidad: ',regVentas.cant);
			writeln('Importe: ',regVentas.importe);
			writeln(' ');
		end;	
	close(arch);
end;



Procedure SeguirEnCarga(var salir:boolean);

var
	opcion:byte;
begin
	repeat
		writeln('Desea seguir cargando Archivos');
		writeln('1-SI');
		writeln('2-NO');
		readln(opcion);
		case opcion of
			1: salir:=false;
			2: salir:=true;
		else writeln ('Ingreso una opcion invalida, vuelva a ingresar');
		end;
	until ((opcion<=2) and (opcion>=1));	
end;


var 
	opcion:byte;
	opmax:byte;
	opmin:byte;
	salir:boolean;
	archVentHist:tArchVentHist;
	archSucMund,archSucArg:tArchSuc;
	archCli:tArhcCli;
	archVentas:tArchVentas;
	
BEGIN
	assign(archVentHist,'C:/ArchVentHistorico.dat');
	assign(archSucMund,'C:/ArchSucMund.dat');
	assign(archSucArg,'C:/ArchSucArg.dat');
	assign(archCli,'C:/ArchClientes');
	assign(archVentas,'C:/ArchVentas');
	opmax:=5;
	opmin:=1;
	writeln('Carga e impresion de Archivos');
	writeln(' ');
	repeat
		repeat
			writeln('Ingrese la opcion deseada');
			writeln('1- Carga e Impresion de Ventas Historicas');
			writeln('2- Carga e Impresion de Sucursales Mundiales');
			writeln('3- Carga e Impresion de Sucursales Argentinas');
			writeln('4- Carga e Impresion de Clientes');
			writeln('5- Carga e Impresion de Ventas de sucursales Argentinas en 2015');
			readln(opcion);
			case opcion of
				1: begin
						CargaVentHist(archVentHist);
						MostrarVentHist(archVentHist);
			       end;	
				
				2: begin
						CargarSucursales(archSucMund);
						MostrarSucursales(archSucMund, 'del Mundo');	
				   end;
			
				3: begin
						CargarSucursales(archSucArg);
						MostrarSucursales(archSucArg, 'de Argentina');
				   end;
			
				4: begin
						CargaClientes(archCli);
						MostrarClientes(archCli);
				   end;	
			
				5: begin
						CargarVentas(archVentas);
						MostrarVentas(archVentas);
				   end;
			else 	
				writeln('Ingreso una opcion invalida, vuelva a ingresar');
			end;		
		until ((opcion<=opmax) and (opcion>=opmin));
		SeguirEnCarga(salir);
	until salir ;	
		
END.

