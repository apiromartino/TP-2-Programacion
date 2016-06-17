program Pto3;

uses crt;

type
	tRegCli= record
				numCli:longint;
				nomb:string[30];
				prov:string[50];
				loc:string[50];
				direcc:string[50];
			end;
	tArchCli= file of tRegCli;			

Procedure LeerArchCli(var arch:tArchCli; var reg:tRegCli; var fin:boolean);

begin
	fin:=EOF(arch);
	if not fin then
		read(arch,reg);	
end;



var 
	archCli:tArchCli;
	archCliTxt:text;
	regCli:tRegCli;
	finCli:boolean;
	cantProv,cantLoc,total:longint;
	provAnt,locAnt:string[50];

BEGIN
	assign(archCli,'C:/ArchClientes.dat');
	assign(archCliTxt,'C:/TotCli.txt');
	reset(archCli);
	rewrite(archCliTxt);
	LeerArchCli(archCli,regCli,finCli);
	total:=0;
	writeln(archCliTxt,'Clientes en Argentina');
	while (not finCli) do
		begin
			cantProv:=0;
			provAnt:=regCli.prov;
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
	writeln(archCliTxt,'Hay un total de ',total,' clientes en toda la Argentina');	
	close(archCliTxt);
	close(archCli);	
END.
