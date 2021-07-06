#/bin/bash

# ----------------- Example of the process ----------------- #
# Steps: 1) get file locally, unzip, copy to s3, delete locally
# wget https://biogeo.ucdavis.edu/data/worldclim/v2.1/base/wc2.1_2.5m_bio.zip
# unzip wc2.1_2.5m_bio.zip -d ./world_clim_2_5m
# aws s3 cp world_clim_2_5m s3://democluster/world_clim_2_5m --recursive
# rm -r world_clim_2_5m
# -----------------------------------------------------------#

# ---------------- Description of variables ---------------- #
# version - 2.1
# time - fut
# res - 10m
# var - bioc
# GCM -
# SSP -
# YEARS -
# ---------------------------------------------------------- #

SSPS=("ssp126" "ssp245" "ssp370" "ssp585")
GCMS=("BCC-CSM2-MR" "CNRM-CM6-1" "CNRM-ESM2-1" "CanESM5" "GFDL-ESM4" "IPSL-CM6A-LR" "MIROC-ES2L" "MIROC6" "MRI-ESM2-0")
GCM="BCC-CSM2-MR"
YEARS=("2021-2040" "2041-2060" "2061-2080" "2081-2100")


outdir=s3://democluster/future-clim-10m-t

for YEAR in "${YEARS[@]}"
do
  echo ${YEAR}
  #for GCM in "${GCMS[@]}"
  #do
    for SSP in "${SSPS[@]}"
    do
      wget "https://biogeo.ucdavis.edu/data/worldclim/v2.1/fut/10m/wc2.1_10m_bioc_${GCM}_${SSP}_${YEAR}.zip" -P ./temp-data/
      unzip -j ./temp-data/wc2.1_10m_bioc_${GCM}_${SSP}_${YEAR}.zip -d ./unzip-data
      aws s3 cp unzip-data ${outdir}/${YEAR}/${SSP} --recursive
      rm ./temp-data/* ./unzip-data/*
    done
  #done
done

exit 0
