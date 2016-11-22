; chap2_figs.pro

@C:\IDL\programs\general\aacgmdefault.pro


PRO SuperDARNmap

  sdir = 'C:\IDL\data\'
  
  ; define radars that are considered in northern and southern hemisphere
  northrad = ['bks','cly','fhe','fhw','gbr','han','hok','inv','kap','ksr','kod','pyk','pgr','rkn','sas','sto','wal']  
  nrad = n_elements(northrad)
  southrad = ['bpk','dce','hal','ker','mcm','san','sps','sye','sys','tig','unw','zho']
  srad = n_elements(southrad)
  ; define lines of MLAT to plot
  mlatline = [90,80,70,60]
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
  device, filename='C:\Thesis\Figures\SuperDARNmap.ps', /color, /landscape, xsize=20, ysize=10
  !P.MULTI = 0
  !P.MULTI = [0,2,1]
  loadct, 0, /silent
  
  latlim = 30
  orientation = 0
  map_set, 90, 0, orientation, /orthographic, /isotropic, /grid, londel=20, latdel=10, limit=[latlim,-180,90,180];, limit=[latitude,-90+orientation,latitude,180+orientation,latitude,90+orientation,latitude,0+orientation]
  map_continents, mag=0, /continents, /fill_continents, color=150, usa=0
  FOR r=0, nrad-1 DO BEGIN
    oplot, nlon[r,*], nlat[r,*]
  ENDFOR
  FOR n=0, numlat-1 DO BEGIN
    oplot, nmlon[n,*], nmlat[n,*]
  ENDFOR


  map_set, -90, 0, orientation, /orthographic, /isotropic, /grid, londel=20, latdel=10, /advance, limit=[-90,-180,-1*latlim,180];, limit=[latitude,90+orientation,latitude,180+orientation,latitude,-90+orientation,latitude,0+orientation]
  map_continents, mag=0, /continents, /fill_continents, color=150, usa=0
  FOR r=0, srad-1 DO BEGIN
    oplot, slon[r,*], slat[r,*]
  ENDFOR
  FOR n=0, numlat-1 DO BEGIN
    oplot, smlon[n,*], smlat[n,*]
  ENDFOR

  device, /close  

END