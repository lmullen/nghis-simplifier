# Makefile to convert NHGIS shapfiles for CartoDB

[NHGIS](https://www.nhgis.org/) is awesome for providing high quality shapefiles keyed to each U.S. Census. But these are too high-resolution and in the wrong projection to upload to [CartoDB](https://cartodb.com/), which is often useful for teaching. This is a Makefile which will convert those NHGIS shapefiles into a format that you can use in CartoDB.

Make sure you have the geospatial tools you need. On a Mac:

```
brew install gdal
brew install node
npm -g install mapshaper
```

On Ubuntu:

```
sudo apt-get install gdal-bin
sudo apt-get install node npm
sudo npm -g install mapshaper
```

Then download all the NGHIS shapefiles that you want, including unzipping the zip files for individual shapefiles. In other words, all the `*.shp`, `.dbf`, `*.prj` etc., etc., etc., in the same directory as this Makefile.

Then run `make` and you'll get a directory `simplified` with the simplified shapefiles and `cartodb` with zipfiles of those simplified shapefiles that you can upload to CartoDB.
