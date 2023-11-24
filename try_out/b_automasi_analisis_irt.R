#Automasi IRT Test
#Library

mulai <- Sys.time()

dir_folder <- dirname(parent.frame(2)$ofile)

library(mirt)
library(stats4)
library(lattice)
library(ggmirt)
library(psych)
library(readxl)
library(writexl)

# Transformasi skor siswa
# Bisa diatur sesuai kebutuhan
nilai_terbesar_baru <- 1000
nilai_terkecil_baru <- 0 

delta_baru <- (nilai_terbesar_baru - nilai_terkecil_baru)


# Direktori
direktori_hasil_analisis <- paste0(dir_folder, "/hasil_analisis_irt")
direktori_referensi_probabilitas <- paste0(dir_folder, "/referensi_probabilitas/")

direktori_tps <- paste0(dir_folder, "/ready_data/")
direktori_tl <- direktori_tps

setwd(direktori_hasil_analisis)


subtes_tps <- c("pu", "ppu","pbm", "pk")

#subtes_tps <- c("pk")

subtes_tl <- c("bi", "en", "pm")

#subtes_tl <- c("pm")

main_data_tps <- read_excel((paste0(dir_folder,"/main_database/Database_TPS.xlsx")))
skor_akhir_lengkap <- main_data_tps[, 1:3]


for (i in subtes_tps){
  print(paste0("Analisis Awal Soal ", i))
  referensi <- read.csv(paste(direktori_referensi_probabilitas, i, ".csv", sep = ""), header = TRUE, sep = ",")
  data_mentah <- read_excel(paste0(direktori_tps, "data_", i,".xlsx"))

  nama_peserta_tes <- subset(data_mentah, select = c(No, Nama_Siswa, Asal_Sekolah, Tanggal_Tes))

  data_mentah <- data.frame(subset(data_mentah, select = -c(No, Nama_Siswa, Asal_Sekolah, Tanggal_Tes)))

  profil_tes_3PL <- mirt(data_mentah, 1, itemtype = "3PL", technical = list(NCYCLES = 500000))

  df_profil_tes_3PL <- data.frame(coef(profil_tes_3PL, simplify = TRUE))

  #print(df_profil_tes_3PL)

  guessing_parameter <- data.frame(subset(df_profil_tes_3PL, select = c(3)))

  # Menyeleksi soal berdasarkan parameter guessing
  data_soal <- c()

  for (j in 1:nrow(guessing_parameter)) {
     if (guessing_parameter[j,] > referensi[j, 2]) {
       data_soal <- c(data_soal, j)
     }
  }

  print("Soal yang tidak terpakai: ")
  print(data_soal)

  # Menyiapkan data yang digunakan dalam analisis IRT 1PL, 2PL, dan 3PL
  if (!(is.null(data_soal))){
    data_mentah <- data_mentah[, -c(data_soal)]
  }

  print(paste("Analisis", i, "menggunakan model 1PL, 2PL, & 3PL"))

  # Uji Menggunakan Model 1PL

  profil_tes_1PL <- mirt(data_mentah, 1, itemtype = 'Rasch', technical = list(NCYCLES = 500000))

  skor_1PL <- fscores(profil_tes_1PL, method = 'EAP')

  df_skor_1PL <- data.frame(skor_1PL)/1.7

  nilai_terbesar_lama_1PL <- max(df_skor_1PL)
  nilai_terkecil_lama_1PL <- min(df_skor_1PL)

  delta_lama_1PL <- (nilai_terbesar_lama_1PL - nilai_terkecil_lama_1PL)

  df_skor_1PL_transformasi <- transform(df_skor_1PL, F1 = delta_baru*(F1 - nilai_terkecil_lama_1PL)/delta_lama_1PL + nilai_terkecil_baru)

  df_skor_1PL_transformasi <- cbind(nama_peserta_tes, df_skor_1PL_transformasi)

  df_skor_1PL_transformasi$Tanggal_Tes <- as.Date(df_skor_1PL_transformasi$Tanggal_Tes, format = "%Y/%m/%d")


  write_xlsx(df_skor_1PL_transformasi, paste0("Skor_", i, "_1PL.xlsx"))



  # Uji Menggunakan Model 2PL
  profil_tes_2PL <- mirt(data_mentah, 1, itemtype = '2PL', technical = list(NCYCLES = 500000))

  skor_2PL <- fscores(profil_tes_2PL,  method = 'EAP')

  df_skor_2PL <- data.frame(skor_2PL)

  nilai_terbesar_lama_2PL <- max(df_skor_2PL)
  nilai_terkecil_lama_2PL <- min(df_skor_2PL)

  delta_lama_2PL <- (nilai_terbesar_lama_2PL - nilai_terkecil_lama_2PL)

  df_skor_2PL_transformasi <- transform(df_skor_2PL, F1 = delta_baru*(F1 - nilai_terkecil_lama_2PL)/delta_lama_2PL + nilai_terkecil_baru)

  df_skor_2PL_transformasi <- cbind(nama_peserta_tes, df_skor_2PL_transformasi)

  df_skor_2PL_transformasi$Tanggal_Tes <- as.Date(df_skor_2PL_transformasi$Tanggal_Tes, format = "%Y/%m/%d")

  write_xlsx(df_skor_2PL_transformasi, paste0("Skor_", i, "_2PL.xlsx"))



  # Uji Menggunakan Model 3PL
  profil_tes_3PL <- mirt(data_mentah, 1, itemtype = '3PL', technical = list(NCYCLES = 500000))

  skor_3PL <- fscores(profil_tes_3PL,  method = 'EAP')

  df_skor_3PL <- data.frame(skor_3PL)

  nilai_terbesar_lama_3PL <- max(df_skor_3PL)
  nilai_terkecil_lama_3PL <- min(df_skor_3PL)

  delta_lama_3PL <- (nilai_terbesar_lama_3PL - nilai_terkecil_lama_3PL)

  df_skor_3PL_transformasi <- transform(df_skor_3PL, F1 = delta_baru*(F1 - nilai_terkecil_lama_3PL)/delta_lama_3PL + nilai_terkecil_baru)

  df_skor_3PL_transformasi <- cbind(nama_peserta_tes, df_skor_3PL_transformasi)

  df_skor_3PL_transformasi$Tanggal_Tes <- as.Date(df_skor_3PL_transformasi$Tanggal_Tes, format = "%Y/%m/%d")

  write_xlsx(df_skor_3PL_transformasi, paste0("Skor_", i, "_3PL.xlsx"))

  # Uji Anova untuk mencari nilai AIC & BIC

  uji_anova <- anova(profil_tes_1PL, profil_tes_2PL, profil_tes_3PL)

  Uji <- c("1PL", "2PL", "3PL")

  uji_anova <- cbind(Uji, uji_anova)

  write_xlsx(uji_anova, paste("Uji Anova_", i, ".xlsx", sep = ""))

  nilai_AIC <- uji_anova[1, 2]

  if (nilai_AIC < uji_anova[2, 2]){
    skor_akhir <- df_skor_1PL_transformasi[, 5]
  } else {
    nilai_AIC <- uji_anova[2, 2]
    skor_akhir <- df_skor_2PL_transformasi[, 5]
  }

  if (nilai_AIC > uji_anova[3, 2]){
    nilai_AIC <- uji_anova[3, 2]
    skor_akhir <- df_skor_3PL_transformasi[, 5]
  }

  skor_akhir_lengkap <- cbind(skor_akhir_lengkap, skor_akhir)
  colnames(skor_akhir_lengkap)[ncol(skor_akhir_lengkap)] <- i

  #skor_akhir_lengkap$Tanggal_Tes <- as.Date(skor_akhir_lengkap$Tanggal_Tes, format = "%Y/%m/%d")

  #write_xlsx(skor_akhir_lengkap, "nilai_akhir_lengkap.xlsx")

}



for (i in subtes_tl){
  print(paste0("Analisis Awal Soal ", i))
  referensi <- read.csv(paste(direktori_referensi_probabilitas, i, ".csv", sep = ""), header = TRUE, sep = ",")
  data_mentah <- read_excel(paste0(direktori_tl, "data_", i,".xlsx"))

  nama_peserta_tes <- subset(data_mentah, select = c(No, Nama_Siswa, Asal_Sekolah, Tanggal_Tes))

  data_mentah <- data.frame(subset(data_mentah, select = -c(No, Nama_Siswa, Asal_Sekolah, Tanggal_Tes)))


  profil_tes_3PL <- mirt(data_mentah, 1, itemtype = "3PL", technical = list(NCYCLES = 500000))

  df_profil_tes_3PL <- data.frame(coef(profil_tes_3PL, simplify = TRUE))

  #print(df_profil_tes_3PL)

  guessing_parameter <- data.frame(subset(df_profil_tes_3PL, select = c(3)))

  # Menyeleksi soal berdasarkan parameter guessing
  data_soal <- c()

  for (j in 1:nrow(guessing_parameter)) {
    if (guessing_parameter[j,] > referensi[j, 2]) {
      data_soal <- c(data_soal, j)
    }
  }

  print("Soal yang tidak terpakai: ")
  print(data_soal)

  # Menyiapkan data yang digunakan dalam analisis IRT 1PL, 2PL, dan 3PL
  if (!(is.null(data_soal))){
    data_mentah <- data_mentah[, -c(data_soal)]
  }

  print(paste("Analisis", i, "menggunakan model 1PL, 2PL, & 3PL"))

  # Uji Menggunakan Model 1PL

  profil_tes_1PL <- mirt(data_mentah, 1, itemtype = 'Rasch', technical = list(NCYCLES = 500000))

  skor_1PL <- fscores(profil_tes_1PL, method = 'EAP')

  df_skor_1PL <- data.frame(skor_1PL)/1.7

  nilai_terbesar_lama_1PL <- max(df_skor_1PL)
  nilai_terkecil_lama_1PL <- min(df_skor_1PL)

  delta_lama_1PL <- (nilai_terbesar_lama_1PL - nilai_terkecil_lama_1PL)

  df_skor_1PL_transformasi <- transform(df_skor_1PL, F1 = delta_baru*(F1 - nilai_terkecil_lama_1PL)/delta_lama_1PL + nilai_terkecil_baru)

  df_skor_1PL_transformasi <- cbind(nama_peserta_tes, df_skor_1PL_transformasi)

  df_skor_1PL_transformasi$Tanggal_Tes <- as.Date(df_skor_1PL_transformasi$Tanggal_Tes, format = "%Y/%m/%d")


  write_xlsx(df_skor_1PL_transformasi, paste0("Skor_", i, "_1PL.xlsx"))



  # Uji Menggunakan Model 2PL
  profil_tes_2PL <- mirt(data_mentah, 1, itemtype = '2PL', technical = list(NCYCLES = 500000))

  skor_2PL <- fscores(profil_tes_2PL,  method = 'EAP')

  df_skor_2PL <- data.frame(skor_2PL)

  nilai_terbesar_lama_2PL <- max(df_skor_2PL)
  nilai_terkecil_lama_2PL <- min(df_skor_2PL)

  delta_lama_2PL <- (nilai_terbesar_lama_2PL - nilai_terkecil_lama_2PL)

  df_skor_2PL_transformasi <- transform(df_skor_2PL, F1 = delta_baru*(F1 - nilai_terkecil_lama_2PL)/delta_lama_2PL + nilai_terkecil_baru)

  df_skor_2PL_transformasi <- cbind(nama_peserta_tes, df_skor_2PL_transformasi)

  df_skor_2PL_transformasi$Tanggal_Tes <- as.Date(df_skor_2PL_transformasi$Tanggal_Tes, format = "%Y/%m/%d")

  write_xlsx(df_skor_2PL_transformasi, paste0("Skor_", i, "_2PL.xlsx"))



  # Uji Menggunakan Model 3PL
  profil_tes_3PL <- mirt(data_mentah, 1, itemtype = '3PL', technical = list(NCYCLES = 500000))

  skor_3PL <- fscores(profil_tes_3PL,  method = 'EAP')

  df_skor_3PL <- data.frame(skor_3PL)

  nilai_terbesar_lama_3PL <- max(df_skor_3PL)
  nilai_terkecil_lama_3PL <- min(df_skor_3PL)

  delta_lama_3PL <- (nilai_terbesar_lama_3PL - nilai_terkecil_lama_3PL)

  df_skor_3PL_transformasi <- transform(df_skor_3PL, F1 = delta_baru*(F1 - nilai_terkecil_lama_3PL)/delta_lama_3PL + nilai_terkecil_baru)

  df_skor_3PL_transformasi <- cbind(nama_peserta_tes, df_skor_3PL_transformasi)

  df_skor_3PL_transformasi$Tanggal_Tes <- as.Date(df_skor_3PL_transformasi$Tanggal_Tes, format = "%Y/%m/%d")

  write_xlsx(df_skor_3PL_transformasi, paste0("Skor_", i, "_3PL.xlsx"))

  # Uji Anova untuk mencari nilai AIC & BIC

  uji_anova <- anova(profil_tes_1PL, profil_tes_2PL, profil_tes_3PL)

  Uji <- c("1PL", "2PL", "3PL")

  uji_anova <- cbind(Uji, uji_anova)

  write_xlsx(uji_anova, paste("Uji Anova_", i, ".xlsx", sep = ""))
  
  nilai_AIC <- uji_anova[1, 2]
  
  if (nilai_AIC < uji_anova[2, 2]){
    skor_akhir <- df_skor_1PL_transformasi[, 5]
  } else {
    nilai_AIC <- uji_anova[2, 2]
    skor_akhir <- df_skor_2PL_transformasi[, 5]
  }
  
  if (nilai_AIC > uji_anova[3, 2]){
    nilai_AIC <- uji_anova[3, 2]
    skor_akhir <- df_skor_3PL_transformasi[, 5]
  }
  
  skor_akhir_lengkap <- cbind(skor_akhir_lengkap, skor_akhir)
  colnames(skor_akhir_lengkap)[ncol(skor_akhir_lengkap)] <- i
  
  #skor_akhir_lengkap$Tanggal_Tes <- as.Date(skor_akhir_lengkap$Tanggal_Tes, format = "%Y/%m/%d")
  
  #write_xlsx(skor_akhir_lengkap, "nilai_akhir_lengkap.xlsx")

}


# Menghitung rerata nilai subtes

nilai_final <- skor_akhir_lengkap[, 4:ncol(skor_akhir_lengkap)]


rerata <- rowMeans(nilai_final)


skor_akhir_lengkap[, ncol(skor_akhir_lengkap)+1] <- rerata
colnames(skor_akhir_lengkap)[ncol(skor_akhir_lengkap)] <- "rerata"
skor_akhir_lengkap$Tanggal_Tes <- as.Date(skor_akhir_lengkap$Tanggal_Tes, format = "%Y/%m/%d")

nomor <- seq(1:nrow(skor_akhir_lengkap))

skor_akhir_lengkap <- cbind(nomor, skor_akhir_lengkap)

colnames(skor_akhir_lengkap)[1] <- "No"


write_xlsx(skor_akhir_lengkap, "nilai_akhir_lengkap.xlsx")


print("Selamat proses analisis IRT selesai :)")
print(Sys.time() - mulai)

 












