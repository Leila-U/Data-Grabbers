#!/bin/bash


outdir=s3://democluster/cropscape

for year in {2008..2020}
do
  wget "https://www.nass.usda.gov/Research_and_Science/Cropland/Release/datasets/${year}_30m_cdls.zip" -P ./temp-data/
  unzip -j ./temp-data/${year}_30m_cdls.zip -d ./unzip-data
  aws s3 cp unzip-data ${outdir}/${year}_30m_cdls --recursive
  rm ./temp-data/* ./unzip-data/*
done

exit 0
