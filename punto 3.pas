{type tvTotalSegPorDjs=array[tiDjs] o integer;
      tvPosicion=arrary[tiDjs] of byte;
      
 var VecTotalsegPordj:tvTotalsegPorDj;
     VecPosicion:tvPosicion;                       aca agregue los tipos y las variables que use para el punto 3,
                                                   obviamente use mas pero las demas ya fueron declaradas}}
      
       
Procedure ConversordeSeg(maxdVector:integer);
  var Hor,Min,Seg,cero:string[4];
      HorAux,MinAux,SegAux:byte;

  BEGIN
   cero:='0';
   HorAux:=(maxdVector div 3600);
   Str(HorAux,Hor);
     if HorAux<10 then
      insert(cero,Hor,1);
   MinAux:=(maxdVector mod 3600) div 60;
   Str(Minaux,Min);
     if MinAux<10 then
      insert(cero,Min,1);
   SegAux:=(maxdVector mod 3600) mod 60;
   Str(SegAux,Seg);
     if SegAux<10 then
      insert(cero,Seg,1);
    writeln(Hor,':',Min,':',Seg);

  END;
Procedure  MaxdVector(MLDjs:tiDjs; VecTotalsegPordj:tvTotalsegPorDj; VecPosicion:tvPosicion; nomDjs:tvNomDjs);
     Var i,j,k:byte;
         maxdVector:integer;

     BEGIN
      for i:=1 to MLDjs do
        begin
          if (VecTotalsegPorDj[i]>maxdVector) then
           begin
             maxdVector:=VecTotalsegPorDj[i];

            k:=1;
            for j:=i to MLDjs do
             if VecTotalsegPorDj[j]=maxdVector then
               begin
                 VecPosicion[k]:=j;
                 VecPosicion[k+1]:=0;
                 k:=k+1;
               end
           end
        end;
       i:=1;
       while VecPosicion[i]<>0 do
         Begin
          if (VecPosicion[2]=0) then
           begin
            write(nomDjs[VecPosicion[1]],' tocara ');
            ConversordeSeg(maxdVector);
           end
          else
           begin
            Write(nomDjs[VecPosicion[i]],' tocara ');
            ConversordeSeg(maxdVector);
           end;
          i:=i+1
         End;
       readln
     END;

procedure VsegTtalporDj(var VecTotalsegPordj:tvTotalsegPorDj; listatemas:tmListaTemas; temasPorDj:tmTemasPorDj; MLDjs:tiDjs; VecPosicion:tvPosicion; nomDjs:tvNomDjs);


  var i,j,k,minnum,segnum,codigo:byte;
      Total,Parcial:integer;

  BEGIN
   begin
     for i:=1 to MLDjs do
     Begin
      j:=1;
       repeat
          for k:=1 to MAXTEM do
            if temasPorDj[i,j]=listatemas[k,nombre] then
              begin
                 VAL(listatemas[k,minutos],minnum,codigo);
                 VAL(listatemas[k,segundos],segnum,codigo);
                 Parcial:=((minnum*60)+segnum);
              end;
          Total:=Total+Parcial;
        j:=j+1;

       until(temasPorDj[i,j]='0');
       VecTotalsegPorDj[i]:=Total;
       Total:=0
     End;
     MaxdVector(MLDjs,VecTotalsegPordj,VecPosicion,nomDjs);
    end;
   END;
