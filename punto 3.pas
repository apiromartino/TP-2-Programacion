procedure DjsQueMasToca(var VecTotalsegPordj:tvTotalsegPorDj; listatemas:tmListaTemas; temasPorDj:tmTemasPorDj; MLDjs:tiDjs; var VecPosicion:tvPosicion; nomDjs:tvNomDjs);


  var i,j,k,minnum,segnum,codigo,posicion,Hor,Min,Seg:byte;
      Total,Parcial,SegsTotal,maxdVector:integer;
      st1:string[10];
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
       Total:=0;
     End;
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
            write(nomDjs[VecPosicion[1]],' tocara ')
            {ConversordeSeg(maxdVector);}
            {CombersordeSeg es el procedimiento que hace el pasaje de los segundos a HH:MM.SS  }
          else
            Write(nomDjs[VecPosicion[i]],' tocara ')
            {ConversordeSeg(maxdVector);}
         End
   end;
