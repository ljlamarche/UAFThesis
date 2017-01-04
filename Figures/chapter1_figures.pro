; chapter1_figures.pro

@C:\IDL\programs\general\radlib.pro
;@C:\IDL\programs\general\Mylib.pro
;@C:\IDL\programs\SolarControl\common_procedures.pro
;@C:\IDL\programs\general\Sollib.pro
;@C:\IDL\programs\general\IGRF.pro
;@C:\IDL\programs\general\gcoords.pro
;@C:\IDL\programs\general\aacgmdefault.pro

@C:\IDL\programs\general\aacgmdefault.pro


PRO densprofile

  year = 2007
  month = 1
  day = 1
  time_flag = 1
  hour = 12
  hour_night = 0
  geo_flag = 0
  latitude = 75.
  longitude = 0.
  height = 100.
  start = 60.
  stop = 600.
  step = 5.
  nstp = (stop-start)/step+1
  dmin = 1e7
  dmax = 1e12

  c = 2.9979e8
  q = 1.6022e-19
  m_e = 9.1094e-31
  m_p = 1.6726e-27
  epsilon0 = 8.8542e-12
  
  ; all density values in m^-3
  nO = fltarr(nstp)
  nN2 = fltarr(nstp)
  nO2 = fltarr(nstp)
  nelec = fltarr(nstp)
  nelec_night = fltarr(nstp)
  nOp = fltarr(nstp)
  nHp = fltarr(nstp)
  nO2p = fltarr(nstp)
  nNOp = fltarr(nstp)
  nNp = fltarr(nstp)
  
  altitude = indgen(nstp,/float)*step+start
  
  ; find neutral densities from MSISE
;  Options:
;  Independent Variables: 0-Year, 1-Month, 2-Day of month, 3-Day of year, 4-Hour of day, 5-Height, 6-Latitude, 7-Longitude
;  Dependent Variables: 8-Atomic Oxygen (O), 9-Nitrogen (N2), 10-Oxygen (O2), 11-Total Mass Density, 12-Neutral Temperature, 13-Exospheric Temperature, 14-Helium (He), 15-Argon (Ar), 16-Hydrogen (H), 17-Nitrogen (N)

;  opts = 'vars=05&vars=08&vars=09&vars=10&'
;  model_parameters = ' "model=msis&year='+string(year,format='(I04)')+'&month='+string(month,format='(I02)')+'&day='+string(day,format='(I02)')+'&time_flag='+string(time_flag,format='(I0)')+'&hour='+string(hour,format='(F0)')+'&geo_flag='+string(geo_flag,format='(I0)')+'&latitude='+string(latitude,format='(F0)')+'&longitude='+string(longitude,format='(F0)')+'&height='+string(height,format='(F0)')+'&profile=1&start='+string(start,format='(F0)')+'&stop='+string(stop,format='(F0)')+'&step='+string(step,format='(F0)')+'&f10_7=&f10_7_3=&ap=&format=0&'+opts+'linestyle=solid&charsize=&symbol=2&symsize=&yscale=Linear&xscale=Linear&imagex=640&imagey=480" '
;;  print, model_parameters
;  spawn, 'curl -d'+model_parameters+'http://omniweb.gsfc.nasa.gov/cgi/vitmo/vitmo_model.cgi > msise.txt', /hide

;  OPENR, lun, 'msise.txt', /GET_LUN
;  header = strarr(19)
;  READF, lun, header
;  FOR i=0, nstp-1 DO BEGIN
;    READF, lun, h, O, N2, O2
;	nO[i] = O*1e6
;	nN2[i] = N2*1e6
;	nO2[i] = O2*1e6
;  ENDFOR
;  CLOSE, lun
;  FREE_LUN, lun

  
  
  ; find ion/electron densities from IRI
;  Options:
;  Independent Variables: 0-Year, 1-Month, 2-Day of month, 3-Day of year, 4-Hour of day, 5-Solar Zenith Angle, 6-Height, 7-Latitude, 8-Longitude, 9-CGM Latitude, 10-CGM Longitude, 11-Magnetic inclination, 12-Modified dip latitude, 13-Declination, 14-InvDip, 15-Dip latitude, 16-MLT
;  Dependent Variables: 17-Electron density, 18-Ratio of Ne and F2 peak density, 19-Neutral Temperature, 20-Ion Temperature, 21-Electron Temperature, 22-Atomic Oxygen % (O+), 23-Atomic Hydrogen % (H+), 24-Atomic Helium % (He+), 25-Molecular Oxygen % (O2+), 26-Nitric Oxide % (NO+), 27-Cluster %, 28-Atomic Nitrogen % (N+), 29-Total Electron Content, 30-TEC top %

  opts = 'vars=06&vars=17&vars=22&vars=23&vars=25&vars=26&vars=28&'  
  model_parameters = ' "model=iri_2012&year='+string(year,format='(I04)')+'&month='+string(month,format='(I02)')+'&day='+string(day,format='(I02)')+'&time_flag='+string(time_flag,format='(I0)')+'&hour='+string(hour,format='(F0)')+'&geo_flag='+string(geo_flag,format='(I0)')+'&latitude='+string(latitude,format='(F0)')+'&longitude='+string(longitude,format='(F0)')+'&height='+string(height,format='(F0)')+'&profile=1&start='+string(start,format='(F0)')+'&stop='+string(stop,format='(F0)')+'&step='+string(step,format='(F0)')+'&sun_n=&ion_n=&radio_f=&radio_f81=&htec_max=&ne_top=0.&imap=0.&ffof2=0.&ib0=2.&probab=0.&ffoE=0.&dreg=0.&tset=0.&icomp=0.&nmf2=0.&hmf2=0.&user_nme=0.&user_hme=0.&format=0&'+opts+'linestyle=solid&charsize=&symbol=2&symsize=&yscale=Linear&xscale=Linear&imagex=640&imagey=480" '
;  print, model_parameters
  spawn, 'curl -d'+model_parameters+'http://omniweb.gsfc.nasa.gov/cgi/vitmo/vitmo_model.cgi > iri.txt', /hide

  OPENR, lun, 'iri.txt', /GET_LUN
  header = strarr(40)
  READF, lun, header
  FOR i=0, nstp-1 DO BEGIN
    READF, lun, h, e, O_p, H_p, O2_p, NO_p, N_p
	nelec[i] = e
	nOp[i] = O_p*e/100.
	nHp[i] = H_p*e/100.
	nO2p[i] = O2_p*e/100.
	nNOp[i] = NO_p*e/100.
	nNp[i] = N_p*e/100.
  ENDFOR
  CLOSE, lun
  FREE_LUN, lun

  ; calculate nighttime density
  opts = 'vars=06&vars=17&vars=22&vars=23&vars=25&vars=26&vars=28&'  
  model_parameters = ' "model=iri_2012&year='+string(year,format='(I04)')+'&month='+string(month,format='(I02)')+'&day='+string(day,format='(I02)')+'&time_flag='+string(time_flag,format='(I0)')+'&hour='+string(hour_night,format='(F0)')+'&geo_flag='+string(geo_flag,format='(I0)')+'&latitude='+string(latitude,format='(F0)')+'&longitude='+string(longitude,format='(F0)')+'&height='+string(height,format='(F0)')+'&profile=1&start='+string(start,format='(F0)')+'&stop='+string(stop,format='(F0)')+'&step='+string(step,format='(F0)')+'&sun_n=&ion_n=&radio_f=&radio_f81=&htec_max=&ne_top=0.&imap=0.&ffof2=0.&ib0=2.&probab=0.&ffoE=0.&dreg=0.&tset=0.&icomp=0.&nmf2=0.&hmf2=0.&user_nme=0.&user_hme=0.&format=0&'+opts+'linestyle=solid&charsize=&symbol=2&symsize=&yscale=Linear&xscale=Linear&imagex=640&imagey=480" '
;  print, model_parameters
  spawn, 'curl -d'+model_parameters+'http://omniweb.gsfc.nasa.gov/cgi/vitmo/vitmo_model.cgi > iri.txt', /hide

  OPENR, lun, 'iri.txt', /GET_LUN
  header = strarr(40)
  READF, lun, header
  FOR i=0, nstp-1 DO BEGIN
    READF, lun, h, e, O_p, H_p, O2_p, NO_p, N_p
	nelec_night[i] = e
	nOp[i] = O_p*e/100.
	nHp[i] = H_p*e/100.
	nO2p[i] = O2_p*e/100.
	nNOp[i] = NO_p*e/100.
	nNp[i] = N_p*e/100.
  ENDFOR
  CLOSE, lun
  FREE_LUN, lun


  set_plot, 'PS'
  device, filename='C:\UAFThesis\UAFThesis\Figures\densprofile.ps', /color, /portrait, xsize=20, ysize=15, xoffset=-1, yoffset=0 
  !P.MULTI = 0
  !P.FONT = 1
  
  loadct, 0, /silent
  plot, [0,0], [1,1], /nodata, xrange=[dmin,dmax], yrange=[0,stop], xthick=3, ythick=3, /xlog, /color, xtitle='Density (m!E-3!N)', ytitle='Altitude (km)', charsize=1.5, charthick=3

;  loadct, 46, /silent
;  oplot, nOp, altitude, thick=3, color=120
;  oplot, nHp, altitude, thick=3, color=150
;  oplot, nO2p, altitude, thick=3, color=180
;  oplot, nNOp, altitude, thick=3, color=90
;  oplot, nNp, altitude, thick=3, color=250
;  loadct, 0, /silent
;  oplot, nO, altitude, thick=7, color=100
;  oplot, nN2, altitude, thick=7, color=100
;  oplot, nO2, altitude, thick=7, color=100
  oplot, nelec, altitude, thick=4, color=0
  oplot, nelec_night, altitude, thick=4, color=0, linestyle=2
;  loadct, 46, /silent
;  oplot, nO, altitude, thick=3, color=1
;  oplot, nN2, altitude, thick=3, color=30
;  oplot, nO2, altitude, thick=3, color=60
;  oplot, nelec, altitude, thick=3, color=230

  oplot, [dmin,dmax], [80,80], linestyle=1, thick=3
  oplot, [dmin,dmax], [150,150], linestyle=1, thick=3

  xyouts, 1e11, 50, 'D Region', charsize=1.5, charthick=3
  xyouts, 1e11, 100, 'E Region', charsize=1.5, charthick=3
  xyouts, 1e11, 400, 'F Region', charsize=1.5, charthick=3
  
  xyouts, 1.2e11, 250, 'Day', charsize=2, charthick=3
  xyouts, 4e9, 250, 'Night', charsize=2, charthick=3
  
;  xyouts, 1e17, 900, 'O', charsize=1.5, charthick=3, color=1
;  xyouts, 1e17, 850, 'N!D2', charsize=1.5, charthick=3, color=30
;  xyouts, 1e17, 800, 'O!D2', charsize=1.5, charthick=3, color=60
;  xyouts, 1e17, 750, 'e', charsize=1.5, charthick=3, color=230
;  xyouts, 1e17, 700, 'O!E+', charsize=1.5, charthick=3, color=120
;  xyouts, 1e17, 650, 'H!E+', charsize=1.5, charthick=3, color=150
;  xyouts, 1e17, 600, 'O!D2!N!E+', charsize=1.5, charthick=3, color=180
;  xyouts, 1e17, 550, 'NO!E+', charsize=1.5, charthick=3, color=90
;  xyouts, 1e17, 500, 'N!E+', charsize=1.5, charthick=3, color=250
  
  device, /close


END


;;=================================================================================================;;
;;=================================================================================================;;


PRO SuperDARNmap

  sdir = 'C:\IDL\data\'
  
  ; define radars that are considered in northern and southern hemisphere
  northrad = ['bks','cly','fhe','fhw','gbr','han','hok','inv','kap','ksr','kod','pyk','pgr','rkn','sas','sto','wal']  
  nrad = n_elements(northrad)
  southrad = ['bpk','dce','hal','ker','mcm','san','sps','sye','sys','tig','unw','zho']
  srad = n_elements(southrad)
  ; define lines of MLAT to plot
  mlatline = [80,60,40]
  numlat = n_elements(mlatline)
  
  ; find outlines of northern hemisphere radars
  nlon = make_array(nrad,300, /float, value=!VALUES.F_NAN)
  nlat = make_array(nrad,300, /float, value=!VALUES.F_NAN)
  FOR r=0, nrad-1 DO BEGIN
    filetest = 0
    filename = sdir+'SuperDARN_FoV\FoV'+northrad[r]+'400.sav'
    n = file_search(filename, count=filetest)
    IF filetest EQ 0 THEN BEGIN
      print, filename, 'DOES NOT EXIST'
      CONTINUE
    ENDIF
    restore, filename  
    nbin = sr.bin_num
    nbeam = sr.beam_num
    lon = [reform(afov[0,0:nbin,1]),reform(afov[0:nbeam,nbin,1]),reverse(reform(afov[nbeam,0:nbin,1])),reverse(reform(afov[0:nbeam,0,1])),afov[0,0,1]]
    lat = [reform(afov[0,0:nbin,0]),reform(afov[0:nbeam,nbin,0]),reverse(reform(afov[nbeam,0:nbin,0])),reverse(reform(afov[0:nbeam,0,0])),afov[0,0,0]]
    nlon[r,0:n_elements(lon)-1] = lon
    nlat[r,0:n_elements(lat)-1] = lat
  ENDFOR
  
  ; find northern hemisphere MLAT outlines
  lon = indgen(361, /float)
  nmlat = fltarr(numlat,361)
  nmlon = fltarr(numlat,361)
  FOR n=0, numlat-1 DO BEGIN
    lat = make_array(361, /float, value=mlatline[n])
    FOR i=0, 360 DO BEGIN
      a = AACGMConvert(lat[i], lon[i], 400., mlat, mlon, r, geo=1)
	  nmlat[n,i] = mlat
	  nmlon[n,i] = mlon
    ENDFOR
  ENDFOR

  ; find outlines of southern hemisphere radars
  slon = make_array(srad,300, /float, value=!VALUES.F_NAN)
  slat = make_array(srad,300, /float, value=!VALUES.F_NAN)
  FOR r=0, srad-1 DO BEGIN
    filetest = 0
    filename = sdir+'SuperDARN_FoV\FoV'+southrad[r]+'400.sav'
    n = file_search(filename, count=filetest)
    IF filetest EQ 0 THEN BEGIN
      print, filename, 'DOES NOT EXIST'
      CONTINUE
    ENDIF
    restore, filename  
    nbin = sr.bin_num
    nbeam = sr.beam_num
    lon = [reform(afov[0,0:nbin,1]),reform(afov[0:nbeam,nbin,1]),reverse(reform(afov[nbeam,0:nbin,1])),reverse(reform(afov[0:nbeam,0,1])),afov[0,0,1]]
    lat = [reform(afov[0,0:nbin,0]),reform(afov[0:nbeam,nbin,0]),reverse(reform(afov[nbeam,0:nbin,0])),reverse(reform(afov[0:nbeam,0,0])),afov[0,0,0]]
    slon[r,0:n_elements(lon)-1] = lon
	slat[r,0:n_elements(lat)-1] = lat
  ENDFOR

  ; find southern hemisphere MLAT outlines
  lon = indgen(361, /float)
  smlat = fltarr(numlat,361)
  smlon = fltarr(numlat,361)
  FOR n=0, numlat-1 DO BEGIN
    lat = make_array(361, /float, value=-1*mlatline[n])
    FOR i=0, 360 DO BEGIN
      a = AACGMConvert(lat[i], lon[i], 400., mlat, mlon, r, geo=1)
	  smlat[n,i] = mlat
	  smlon[n,i] = mlon
    ENDFOR
  ENDFOR

  
  ; plot
  set_plot, 'PS'
  device, filename='C:\UAFThesis\UAFThesis\Figures\SuperDARNmap.ps', /color, /landscape, xsize=18, ysize=10, xoffset=0, yoffset=18.3
  !P.MULTI = 0
  !P.MULTI = [0,2,1]
  loadct, 0, /silent
  
  latlim = 35
  orientation = 0
  shift = 10
  map_set, 90-shift, -90, orientation, /azimuthal, /isotropic, limit=[latlim,-180,latlim+shift,90,latlim,0,latlim-shift,-90]
  loadct, 1, /silent
  polyfill, indgen(360), fltarr(360)+2, color=220
  loadct, 0, /silent
  map_continents, mag=0, /continents, /fill_continents, color=150
  map_grid, londel=30, latdel=20, glinethick=2 

  loadct, 4, /silent
  FOR n=0, numlat-1 DO BEGIN
    oplot, nmlon[n,*], nmlat[n,*], thick=5, color=240
  ENDFOR
  loadct, 3, /silent
  FOR r=0, nrad-1 DO BEGIN
    c = 0
    IF (northrad[r] EQ 'rkn') OR (northrad[r] EQ 'cly') OR (northrad[r] EQ 'inv') OR (northrad[r] EQ 'lyr') THEN c = 120
    oplot, nlon[r,*], nlat[r,*], thick=3, color=c
  ENDFOR
  polyfill, nlon[WHERE(northrad EQ 'rkn'),*], nlat[WHERE(northrad EQ 'rkn'),*], /line_fill, spacing=0.05, color=120


;  map_set, -90, 0, orientation, /azimuthal, /isotropic, /advance, limit=[-90,-180,-1*latlim,180]
  map_set, -90+shift, -90, orientation, /azimuthal, /isotropic, /advance, limit=[-1*latlim,-180,-1*latlim-shift,-90,-1*latlim,0,-1*latlim+shift,90]
  loadct, 1, /silent
  polyfill, indgen(360), fltarr(360)-2, color=220
  loadct, 0, /silent
  map_continents, mag=0, /continents, /fill_continents, color=150
  map_grid, londel=30, latdel=20, glinethick=2 

  loadct, 4, /silent
  FOR n=0, numlat-1 DO BEGIN
    oplot, smlon[n,*], smlat[n,*], thick=4, color=240
  ENDFOR
  loadct, 3, /silent
  FOR r=0, srad-1 DO BEGIN
    c = 0
	IF (southrad[r] EQ 'mcm') THEN c = 120
    oplot, slon[r,*], slat[r,*], thick=3, color=c
  ENDFOR
  polyfill, slon[WHERE(southrad EQ 'mcm'),*], slat[WHERE(southrad EQ 'mcm'),*], /line_fill, spacing=0.05, color=120

  device, /close  

END


;====================================================================================


PRO ISRmap

  ; get coordinates for AACGM model
  unit = 1
  openr, unit, 'C:\IDL\programs\general\aacgm_coeffs2010.asc'
  s = AACGMLoadCoef(unit)
  close, unit

  
  sdir = 'C:\IDL\data\'
  
  ; define radars that are considered in northern and southern hemisphere
;  northrad = ['bks','cly','fhe','fhw','gbr','han','hok','inv','kap','ksr','kod','pyk','pgr','rkn','sas','sto','wal']
  northrad = ['rkn']
  nrad = n_elements(northrad)
  ; define lines of MLAT to plot
  mlatline = [80,60,40]
  numlat = n_elements(mlatline)
  
  ; find outlines of northern hemisphere radars
  nlon = make_array(nrad,300, /float, value=!VALUES.F_NAN)
  nlat = make_array(nrad,300, /float, value=!VALUES.F_NAN)
  FOR r=0, nrad-1 DO BEGIN
    filetest = 0
    filename = sdir+'SuperDARN_FoV\FoV'+northrad[r]+'400.sav'
    n = file_search(filename, count=filetest)
    IF filetest EQ 0 THEN BEGIN
      print, filename, 'DOES NOT EXIST'
      CONTINUE
    ENDIF
    restore, filename  
    nbin = sr.bin_num
    nbeam = sr.beam_num
    lon = [reform(afov[0,0:nbin,1]),reform(afov[0:nbeam,nbin,1]),reverse(reform(afov[nbeam,0:nbin,1])),reverse(reform(afov[0:nbeam,0,1])),afov[0,0,1]]
    lat = [reform(afov[0,0:nbin,0]),reform(afov[0:nbeam,nbin,0]),reverse(reform(afov[nbeam,0:nbin,0])),reverse(reform(afov[0:nbeam,0,0])),afov[0,0,0]]
    nlon[r,0:n_elements(lon)-1] = lon
    nlat[r,0:n_elements(lat)-1] = lat
  ENDFOR
  
  ; find northern hemisphere MLAT outlines
  lon = indgen(361, /float)
  nmlat = fltarr(numlat,361)
  nmlon = fltarr(numlat,361)
  FOR n=0, numlat-1 DO BEGIN
    lat = make_array(361, /float, value=mlatline[n])
    FOR i=0, 360 DO BEGIN
      a = AACGMConvert(lat[i], lon[i], 400., mlat, mlon, r, geo=1)
	  nmlat[n,i] = mlat
	  nmlon[n,i] = mlon
    ENDFOR
  ENDFOR

  
  
  ; Get ISR outline coordinates
  EISCAT_lines = file_lines('C:\IDL\data\ISR_FOV\0eiscat400.txt')
  EISCAT_coords = fltarr(2,EISCAT_lines)
  OPENR, lun, 'C:\IDL\data\ISR_FOV\0eiscat400.txt', /get_lun
  READF, lun, EISCAT_coords
  CLOSE, lun
  free_lun, lun
  
  ESR_lines = file_lines('C:\IDL\data\ISR_FOV\0esr400.txt')
  ESR_coords = fltarr(2,ESR_lines)
  OPENR, lun, 'C:\IDL\data\ISR_FOV\0esr400.txt', /get_lun
  READF, lun, ESR_coords
  CLOSE, lun
  free_lun, lun

  MH_lines = file_lines('C:\IDL\data\ISR_FOV\0mh400.txt')
  MH_coords = fltarr(2,MH_lines)
  OPENR, lun, 'C:\IDL\data\ISR_FOV\0mh400.txt', /get_lun
  READF, lun, MH_coords
  CLOSE, lun
  free_lun, lun

  PFISR_lines = file_lines('C:\IDL\data\ISR_FOV\0pfisr400.txt')
  PFISR_coords = fltarr(2,PFISR_lines)
  OPENR, lun, 'C:\IDL\data\ISR_FOV\0pfisr400.txt', /get_lun
  READF, lun, PFISR_coords
  CLOSE, lun
  free_lun, lun

  RISRC_lines = file_lines('C:\IDL\data\ISR_FOV\0risrc400.txt')
  RISRC_coords = fltarr(2,RISRC_lines)
  OPENR, lun, 'C:\IDL\data\ISR_FOV\0risrc400.txt', /get_lun
  READF, lun, RISRC_coords
  CLOSE, lun
  free_lun, lun

  RISRN_lines = file_lines('C:\IDL\data\ISR_FOV\0risrn400.txt')
  RISRN_coords = fltarr(2,RISRN_lines)
  OPENR, lun, 'C:\IDL\data\ISR_FOV\0risrn400.txt', /get_lun
  READF, lun, RISRN_coords
  CLOSE, lun
  free_lun, lun

  SFJ_lines = file_lines('C:\IDL\data\ISR_FOV\0sfj400.txt')
  SFJ_coords = fltarr(2,SFJ_lines)
  OPENR, lun, 'C:\IDL\data\ISR_FOV\0sfj400.txt', /get_lun
  READF, lun, SFJ_coords
  CLOSE, lun
  free_lun, lun

  ; find northern hemisphere MLAT outlines
  lon = indgen(361, /float)
  nmlat = fltarr(numlat,361)
  nmlon = fltarr(numlat,361)
  FOR n=0, numlat-1 DO BEGIN
    lat = make_array(361, /float, value=mlatline[n])
    FOR i=0, 360 DO BEGIN
      a = AACGMConvert(lat[i], lon[i], 400., mlat, mlon, r, geo=1)
	  nmlat[n,i] = mlat
	  nmlon[n,i] = mlon
    ENDFOR
  ENDFOR
  
  ; plot
  set_plot, 'PS'
  device, filename='C:\UAFThesis\UAFThesis\Figures\ISRmap.ps', /color, /portrait, xsize=18, ysize=18, xoffset=0, yoffset=0
  !P.MULTI = 0
  loadct, 0, /silent
  
  latlim = 60
  orientation = 0
  shift = 10
  map_set, 90-shift, -90, orientation, /azimuthal, /isotropic, limit=[latlim,-180,latlim+shift,90,latlim,0,latlim-shift,-90]
  loadct, 1, /silent
  polyfill, indgen(360), fltarr(360)+latlim-latlim+2, color=220
  loadct, 0, /silent
  map_continents, mag=0, /continents, /fill_continents, color=150
  map_grid, londel=30, latdel=20, glinethick=2 

  loadct, 4, /silent
  FOR n=0, numlat-1 DO BEGIN
    oplot, nmlon[n,*], nmlat[n,*], thick=5, color=240
  ENDFOR
  loadct, 3, /silent
  FOR r=0, nrad-1 DO BEGIN
    c = 0
    IF (northrad[r] EQ 'rkn') OR (northrad[r] EQ 'cly') OR (northrad[r] EQ 'inv') OR (northrad[r] EQ 'lyr') THEN c = 120
    oplot, nlon[r,*], nlat[r,*], thick=3, color=c
  ENDFOR
;  polyfill, nlon[WHERE(northrad EQ 'rkn'),*], nlat[WHERE(northrad EQ 'rkn'),*], /line_fill, spacing=0.05, color=120

  loadct, 3, /silent
  color = 0
  oplot, EISCAT_coords[1,*], EISCAT_coords[0,*], color=color, thick=5
  oplot, ESR_coords[1,*], ESR_coords[0,*], color=color, thick=5
  oplot, MH_coords[1,*], MH_coords[0,*], color=color, thick=5
  oplot, PFISR_coords[1,*], PFISR_coords[0,*], color=color, thick=5
  oplot, RISRC_coords[1,*], RISRC_coords[0,*], color=color, thick=5
  oplot, RISRN_coords[1,*], RISRN_coords[0,*], color=200, thick=5
  oplot, SFJ_coords[1,*], SFJ_coords[0,*], color=color, thick=5
  polyfill, RISRN_coords[1,*], RISRN_coords[0,*], /line_fill, spacing=0.05, color=200

  ; print ISR names
  xyouts, (EISCAT_coords[1,0]+EISCAT_coords[1,EISCAT_lines/2])/2.0, (EISCAT_coords[0,0]+EISCAT_coords[0,EISCAT_lines/2])/2.0, 'EISCAT', color=color, charthick=4, alignment=0.5, charsize=0.7
  xyouts, (ESR_coords[1,0]+ESR_coords[1,ESR_lines/2])/2.0, (ESR_coords[0,0]+ESR_coords[0,ESR_lines/2])/2.0, 'ESR', color=color, charthick=4, alignment=0.5, charsize=0.7
  xyouts, (MH_coords[1,0]+MH_coords[1,MH_lines/2])/2.0, (MH_coords[0,0]+MH_coords[0,MH_lines/2])/2.0, 'MH', color=color, charthick=4, alignment=0.5, charsize=0.7
  xyouts, (PFISR_coords[1,0]+PFISR_coords[1,PFISR_lines/2])/2.0, (PFISR_coords[0,0]+PFISR_coords[0,PFISR_lines/2])/2.0, 'PFISR', color=color, charthick=4, alignment=0.5, charsize=0.7
  xyouts, (RISRC_coords[1,RISRC_lines/4]+RISRC_coords[1,3*RISRC_lines/4])/2.0, (RISRC_coords[0,RISRC_lines/4]+RISRC_coords[0,3*RISRC_lines/4])/2.0, 'RISR-C', color=color, charthick=4, alignment=0.5, charsize=0.7
  xyouts, (RISRN_coords[1,RISRN_lines/6]+RISRN_coords[1,5*RISRN_lines/6])/2.0, (RISRN_coords[0,RISRN_lines/6]+RISRN_coords[0,5*RISRN_lines/6])/2.0, 'RISR-N', color=color, charthick=4, alignment=0.5, charsize=0.7
  xyouts, (SFJ_coords[1,0]+SFJ_coords[1,SFJ_lines/2])/2.0, (SFJ_coords[0,0]+SFJ_coords[0,SFJ_lines/2])/2.0, 'SFJ', color=color, charthick=4, alignment=0.5, charsize=0.7


  device, /close

END


;================================================================================================================================
