data(pnud_muni, package='abjutils')
data(cadmun, package='abjutils')

cadmun <-  select(cadmun, MUNCOD, lon, lat)
pnud_muni <-  inner_join(pnud_muni, cadmun, c('codmun6'='MUNCOD'))
