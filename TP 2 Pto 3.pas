program Pto3;

uses crt;

type
	tReg= record
			numSuc:word;
			nomb:string[30];
			pais:string[50];
			direcc:string[50];
			tel:string[20];
		  end;
	tArch= file of tReg;
 		  
Procedure LeerArch (var arch:tArch; var reg:tReg; var fin:boolean);

begin
	fin:=EOF(arch);
	if not fin then
		read(arch,reg);
end;

Procedure ActualizarArchSucMundo(var archMund:tArch; var archAct:tArch);

var
	regAux:tReg;
begin
	reset(archAct);
	rewrite(archMund);
	while (not eof(arch)) do
		begin
			read(archAct,regAux);
			write(archMund,regAux);
		end;	
	close(archMund);
	close(archAct);	
end;

var 
	archArg,archMund,archAct:tArch;
	regArg,regMund:tReg;
	finArg,finMund:boolean;

BEGIN
	assign(archArg,'C:/ArchSucArg.dat');
	assign(archMund,'C:/ArchSucMund.dat');
	assign(archAct,'C:/ArchActualizado.dat');
	reset(archArg);
	reset(archMund);
	rewrite(archAct);
	LeerArch(archArg,regArg,finArg);
	LeerArch(archMund,regMund,finMund);
	while ((not finArg) and (not finMund)) do
		if (regMund.numSuc<regArg.numSuc) then
			begin
				write(archAct,regMund);
				LeerArch(archMund,regMund,finMund);
			end;
		else 
			begin
				write(archAct,regArg);
				LeerArch(archArg,regArg,finArg);
			end;
	while (not finMund) do
		begin
			write(archAct,regMund);
			LeerArch(archMund,regMund,finMund);
		end;	
	while (no finArg) do
		begin
			write(archAct,regArg);
			LeerArch(archArg,regArg,finArg);
		end;
	close(archAct);		
	close(archArg);
	close(archMund);
	ActualizarArchSucMundo(archMund,archAct);
END.

