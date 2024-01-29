# Penambah Tanggal_Tes

dir_folder <- dirname(parent.frame(2)$ofile)
#dir_folder <- "/Users/windusara/Downloads/Automasi_Analisis_IRT-main/try_out_3"


# Library list
library(openxlsx)
library(readxl)
library(writexl)

# Direktori files
dir_files_tps <- (paste0(dir_folder, "/input_tps"))
dir_files_tl <- (paste0(dir_folder, "/input_tl"))

setwd(dir_files_tps)
files <- list.files(pattern = "xlsx")

for (i in files){
  data_siswa <- data.frame(read_excel(i))
  respon_siswa <- data_siswa[, -c(1, 2)]
  data_siswa <- data_siswa[, c(1,2)]
  data_siswa[,3] <- as.Date("2024/01/26", format = "%Y/%m/%d") #Tanggalnya bisa disesuaikan
  colnames(data_siswa)[3] <- "Tanggal_Tes"
  full_data <- cbind(data_siswa, respon_siswa)

  write.xlsx(full_data, file = paste(dir_files_tps, i, sep = "/"))
}


setwd(dir_files_tl)
files <- list.files(pattern = "xlsx")

for (i in files){
  data_siswa <- data.frame(read_excel(i))
  respon_siswa <- data_siswa[, -c(1, 2)]
  data_siswa <- data_siswa[, c(1,2)]
  data_siswa[,3] <- as.Date("2024/01/26", format = "%Y/%m/%d") #Tanggalnya bisa disesuaikan
  colnames(data_siswa)[3] <- "Tanggal_Tes"
  full_data <- cbind(data_siswa, respon_siswa)
  
  write.xlsx(full_data, file = paste(dir_files_tl, i, sep = "/"))
}

print("Proses selesai :)")
