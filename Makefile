ORIGINAL_SHPFILES := $(wildcard *.shp) 
NEW_SHAPEFILES := $(patsubst %.shp, simplified/%.simplified.shp, $(ORIGINAL_SHPFILES))
CARTODB_ZIPS := $(patsubst simplified/%.simplified.shp, cartodb/%.zip, $(NEW_SHAPEFILES))

all : $(CARTODB_ZIPS)

.SECONDARY : $(NEW_SHAPFILES)

reprojected/%.reprojected.shp : %.shp
	mkdir -p reprojected
	ogr2ogr $@ $^ -t_srs EPSG:4326

simplified/%.simplified.shp : reprojected/%.reprojected.shp
	mkdir -p simplified
	mapshaper $^ -simplify interval=5000 -o $@ force

cartodb/%.zip : simplified/%.simplified.shp
	mkdir -p cartodb
	zip $@ $ $(basename $<)*

clobber :
	rm -rf simplified
	rm -rf cartodb
