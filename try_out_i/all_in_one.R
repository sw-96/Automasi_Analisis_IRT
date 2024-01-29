direktori <- dirname(parent.frame(2)$ofile)


source(paste0(direktori, "/0_penambah_tanggal_tes.R")) #digunakan jika datanya tidak ada kolom tanggal pelaksaan tes
source(paste0(direktori, "/a_data_preparation.R"))
source(paste0(direktori, "/b_automasi_analisis_irt.R"))

