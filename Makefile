ORIGINAL_SHPFILES := $(wildcard *.shp) 
NEW_SHAPEFILES := $(patsubst %.shp, simplified/%.simplified.shp, $(ORIGINAL_SHPFILES))
CARTODB_ZIPS := $(patsubst simplified/%.simplified.shp, cartodb/%.zip, $(NEW_SHAPEFILES))

all : $(CARTODB_ZIPS)

simplified/%.simplified.shp : %.reprojected.shp
	mkdir -p simplified
	mapshaper $^ -simplify interval=5000 -o $@ force

%.reprojected.shp : %.shp
	ogr2ogr $@ $^ -t_srs EPSG:4326

cartodb/%.zip : simplified/%.simplified.shp
	mkdir -p cartodb
	zip $@ $ $(basename $<)*

clobber :
	rm -rf simplified
	rm -rf cartodb
