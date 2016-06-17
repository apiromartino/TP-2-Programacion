program Pto4;

uses crt;

type
	tRegSuc= record
			numSuc:word;
			nomb:string[30];
			pais:string[50];
			direcc:string[50];
			tel:string[20];
		  end;
	tArchSuc= file of tRegSuc;
 		  
Procedure LeerArchSuc (var arch:tArchSuc; var reg:tRegSuc; var fin:boolean);

begin
	fin:=EOF(arch);
	if not fin then
		read(arch,reg);
end;

Procedure ActualizarArchSucMundo(var archMund:tArchSuc; var archAct:tArchSuc);

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

var 
	archArg,archMund,archAct:tArchSuc;
	regArg,regMund:tRegSuc;
	finArg,finMund:boolean;

BEGIN
	assign(archArg,'C:/ArchSucArg.dat');
	assign(archMund,'C:/ArchSucMund.dat');
	assign(archAct,'C:/ArchActualizado.dat');
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
	ActualizarArchSucMundo(archMund,archAct);
END.
