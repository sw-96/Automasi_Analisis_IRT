#DATA PREPARATION

mulai <- Sys.time()

dir_folder <- dirname(parent.frame(2)$ofile)


#Library List
library(openxlsx)
library(readxl)
library(writexl)

#DIREKTORI=======================================================================================
#Tes Potensi Skolastik

dir_database_tps <- paste0(dir_folder, "/main_database/Database_TPS.xlsx")
dir_tps <- paste0(dir_folder, "/input_tps")
dir_tidak_menjawab_tps <- paste0(dir_folder, "/daftar_peserta_tidak_menjawab/1_list_siswa_yang_tidak_menjawab_TPS.xlsx")

#Tes Literasi

dir_database_tl <- paste0(dir_folder, "/main_database/Database_TL.xlsx")
dir_tl <- paste0(dir_folder, "/input_tl")
dir_tidak_menjawab_tl <- paste0(dir_folder, "/daftar_peserta_tidak_menjawab/2_list_siswa_yang_tidak_menjawab_TL.xlsx")

#Ready Data
dir_ready_data <- paste0(dir_folder, "/ready_data")

#===============================================================================================

##Generator Respon Siswa yang tidak ikut Tes

## Membaca list data siswa yang tidak menjawab TPS
list_siswa <- read_excel(dir_tidak_menjawab_tps)


## Menambahkan respon siswa ke data frame list_siswa
for (i in 1:85){
  baru <- rep(0, nrow(list_siswa))
  list_siswa[, ncol(list_siswa)+1] <- baru
  colnames(list_siswa)[ncol(list_siswa)] <- paste0("soal_", i)
}

list_siswa$Tanggal_Tes <- as.Date(list_siswa$Tanggal_Tes, format = "%Y/%m/%d")


## Ekspor file excel
write_xlsx(list_siswa, paste0(dir_tps, "/tidak_menjawab_TPS.xlsx"))


## Membaca list data siswa yang tidak menjawab TL
list_siswa <- read_excel(dir_tidak_menjawab_tl)

## Menambahkan respon siswa ke data frame list_siswa
for (i in 1:70){
  baru <- rep(0, nrow(list_siswa))
  list_siswa[,ncol(list_siswa)+1] <- baru
  colnames(list_siswa)[ncol(list_siswa)] <- paste0("soal_", i)
}

list_siswa$Tanggal_Tes <- as.Date(list_siswa$Tanggal_Tes, format = "%Y/%m/%d")

## Ekspor file excel
write_xlsx(list_siswa, paste0(dir_tl, "/tidak_menjawab_TL.xlsx"))



#Program Untuk Menggabungkan Data Peserta
#1. Menggabungkan Data Tes Potensi Skolastik
setwd(dir_tps)
files <- list.files(pattern = "xlsx")


database_tps <- data.frame(read_excel(dir_database_tps))


for (i in files){
   input_baru <- data.frame(read_excel(i))
   colnames(input_baru) <- colnames(database_tps)
   database_tps <- rbind(database_tps, input_baru)
}

database_tps$Tanggal_Tes <- as.Date(database_tps$Tanggal_Tes, format = "%Y/%m/%d")

database_tps <- database_tps[!duplicated(database_tps),]


database_tps <- database_tps[order(database_tps$Tanggal_Tes, database_tps$Nama.Siswa), ]


write.xlsx(database_tps, file = dir_database_tps)



#2. Menggabungkan Data Tes Literasi
setwd(dir_tl)
files <- list.files(pattern = "xlsx")

database_tl <- data.frame(read_excel(dir_database_tl))

for (i in files){
   input_baru <- data.frame(read_excel(i))
   colnames(input_baru) <- colnames(database_tl)
   database_tl <- rbind(database_tl, input_baru)
}

database_tl$Tanggal_Tes <- as.Date(database_tl$Tanggal_Tes, format = "%Y/%m/%d")

database_tl <- database_tl[!duplicated(database_tl),]

database_tl <- database_tl[order(database_tl$Tanggal_Tes, database_tl$Nama.Siswa), ]



write.xlsx(database_tl, file = dir_database_tl)





#Program Untuk Split Hasil Try Out menjadi 7 subtes

#Membaca File Excel
df <- read_excel(dir_database_tps)



#Menambahkan ID baris
row_id <- seq(1, nrow(df))
df <- cbind(row_id, df)


#Data Frame Identitas Peserta
data_peserta <- subset(df, select = c(1:4))
colnames(data_peserta) <- c("No", "Nama_Siswa", "Asal_Sekolah", "Tanggal_Tes")


#1. PU
#Data Frame PU
data_pu <- subset(df, select = c(5:34))
colnames(data_pu) <- c("pu_1", "pu_2", "pu_3", "pu_4", "pu_5", "pu_6", "pu_7", "pu_8", "pu_9", "pu_10", "pu_11", "pu_12", "pu_13", "pu_14", "pu_15", "pu_16", "pu_17", "pu_18", "pu_19", "pu_20", "pu_21", "pu_22", "pu_23", "pu_24", "pu_25", "pu_26", "pu_27", "pu_28", "pu_29", "pu_30") # nolint: line_length_linter.

#Data Frame Identitas Peserta & PU
data_pu <- cbind(data_peserta, data_pu)

data_pu$Tanggal_Tes <- as.Date(data_pu$Tanggal_Tes, format = "%Y/%m/%d")

#Ekspor Data Frame Identitas Peserta & PU ke format xlsx
write_xlsx(data_pu, paste(dir_ready_data, "data_pu.xlsx", sep = "/"))


#2. PPU
#Data Frame PPU
data_ppu <- subset(df, select = c(35:54))
colnames(data_ppu) <- c("ppu_1", "ppu_2", "ppu_3", "ppu_4", "ppu_5", "ppu_6", "ppu_7", "ppu_8", "ppu_9", "ppu_10", "ppu_11", "ppu_12", "ppu_13", "ppu_14", "ppu_15", "ppu_16", "ppu_17", "ppu_18", "ppu_19", "ppu_20") # nolint


#Data Frame Identitas Peserta & PPU
data_ppu <- cbind(data_peserta, data_ppu)

data_ppu$Tanggal_Tes <- as.Date(data_ppu$Tanggal_Tes, format = "%Y/%m/%d")

#Ekspor Data Frame Identitas Peserta & PPU ke format xlsx
write_xlsx(data_ppu, paste(dir_ready_data, "data_ppu.xlsx", sep = "/"))


#3. PBM
#Data Frame PBM
data_pbm <- subset(df, select = c(55:74))
colnames(data_pbm) <- c("pbm_1", "pbm_2", "pbm_3", "pbm_4", "pbm_5", "pbm_6", "pbm_7", "pbm_8", "pbm_9", "pbm_10", "pbm_11", "pbm_12", "pbm_13", "pbm_14", "pbm_15", "pbm_16", "pbm_17", "pbm_18", "pbm_19", "pbm_20") # nolint: line_length_linter.

#Data Frame Identitas Peserta & PBM
data_pbm <- cbind(data_peserta, data_pbm)

data_pbm$Tanggal_Tes <- as.Date(data_pbm$Tanggal_Tes, format = "%Y/%m/%d")

# #Ekspor Data Frame Identitas Peserta & PBM ke format xlsx
write_xlsx(data_pbm, paste(dir_ready_data, "data_pbm.xlsx", sep = "/"))


#4. PK
#Data Frame PK
data_pk <- subset(df, select = c(75:89))
colnames(data_pk) <- c("pk_1", "pk_2", "pk_3", "pk_4", "pk_5", "pk_6", "pk_7", "pk_8", "pk_9", "pk_10", "pk_11", "pk_12", "pk_13", "pk_14", "pk_15") # nolint: line_length_linter.

#Data Frame Identitas Peserta & PK
data_pk <- cbind(data_peserta, data_pk)

data_pk$Tanggal_Tes <- as.Date(data_pk$Tanggal_Tes, format = "%Y/%m/%d")

#Ekspor Data Frame Identitas Peserta & PK ke format xlsx
write_xlsx(data_pk, paste(dir_ready_data, "data_pk.xlsx", sep = "/"))


#Membaca File Excel
df <- read_excel(dir_database_tl)



#Menambahkan ID baris
row_id <- seq(1, nrow(df))
df <- cbind(row_id, df)

#Data Frame Identitas Peserta
data_peserta <- subset(df, select = c(1:4))
colnames(data_peserta) <- c("No", "Nama_Siswa", "Asal_Sekolah", "Tanggal_Tes")


#1. BI
#Data Frame BI
data_bi <- subset(df, select = c(5:34))
colnames(data_bi) <- c("bi_1", "bi_2", "bi_3", "bi_4", "bi_5", "bi_6", "bi_7", "bi_8", "bi_9", "bi_10", "bi_11", "bi_12", "bi_13", "bi_14", "bi_15", "bi_16", "bi_17", "bi_18", "bi_19", "bi_20", "bi_21", "bi_22", "bi_23", "bi_24", "bi_25", "bi_26", "bi_27", "bi_28", "bi_29", "bi_30") # nolint: line_length_linter.

#Data Frame Identitas Peserta & BI
data_bi <- cbind(data_peserta, data_bi)

data_bi$Tanggal_Tes <- as.Date(data_bi$Tanggal_Tes, format = "%Y/%m/%d")

#Ekspor Data Frame Identitas Peserta & BI ke format xlsx
write_xlsx(data_bi, paste(dir_ready_data, "data_bi.xlsx", sep = "/"))

#2. EN
#Data Frame EN
data_en <- subset(df, select = c(35:54))
colnames(data_en) <- c("en_1", "en_2", "en_3", "en_4", "en_5", "en_6", "en_7", "en_8", "en_9", "en_10", "en_11", "en_12", "en_13", "en_14", "en_15", "en_16", "en_17", "en_18", "en_19", "en_20") # nolint: line_length_linter.

#Data Frame Identitas Peserta & EN
data_en <- cbind(data_peserta, data_en)

data_en$Tanggal_Tes <- as.Date(data_en$Tanggal_Tes, format = "%Y/%m/%d")

#Ekspor Data Frame Identitas Peserta & EN ke format xlsx
write_xlsx(data_en, paste(dir_ready_data, "data_en.xlsx", sep = "/"))

#3. PM
#Data Frame PM
data_pm <- subset(df, select = c(55:74))
colnames(data_pm) <- c("pm_1", "pm_2", "pm_3", "pm_4", "pm_5", "pm_6", "pm_7", "pm_8", "pm_9", "pm_10", "pm_11", "pm_12", "pm_13", "pm_14", "pm_15", "pm_16", "pm_17", "pm_18", "pm_19", "pm_20") # nolint: line_length_linter.

#Data Frame Identitas Peserta & PM
data_pm <- cbind(data_peserta, data_pm)

data_pm$Tanggal_Tes <- as.Date(data_pm$Tanggal_Tes, format = "%Y/%m/%d")

#Ekspor Data Frame Identitas Peserta & PM ke format xlsx
write_xlsx(data_pm, paste(dir_ready_data, "data_pm.xlsx", sep = "/"))

print("Selamat, proses persiapan data selesai :)")
print(Sys.time() - mulai)
