PRO TRANSFORM_DATA,dtime,datax,coorx,facavg,deltat,tdat
   DATA[0:4,*]=DATA[1:5,*]
   DATA=FLTARR(7,N_ELEMENTS(dtime))
   bt=fltarr(n_elements(dtime))
   data(0,*)=dtime
   data(1:3,*)=datax(0:2,*)   ;x,y,z
   data(4:6,*)=coorx(1:3,*)   ;x,y,z
end