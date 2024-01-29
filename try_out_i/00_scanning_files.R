#Scanning Downloaded Files
#IMPORTANT: PASTIKAN NAMA FILE TIDAK MENGANDUNG SPASI


#Direktori folder, nanti disesuaikan dengan lokasi folder default
dir_folder <- "/Users/windusara/Downloads/tryout_january_2024/tl" # Disesuaikan dengan kebutuhan: folder tl & tps

# Library List
library(openxlsx)
library(readxl)
library(writexl)
library(tidyr)
library(dplyr)
library(wrapr)

setwd(dir_folder)


# Mendata file-file dengan format xlsx
files <- list.files(pattern = "xlsx")

# Mengekstrak info file
info_files <- file.info(files)

# Membuat data frame dari files
files <- data.frame(files)

# Memisahkan 1 kolom menjadi 6 kolom
files <- separate(files, col = files, into = c("Nama", "Tes", "Hari", "Bulan", "Tahun", "Kode"), sep = '-')


# Menautkan info file (waktu modifikasi file)
files <- cbind(files, info_files[4])

# Mengubah nama kolom
colnames(files)[1] <- "Nama"
colnames(files)[7] <- "Waktu_Unduh"

# Mengurutkan item pada dataframe
files_ready <- files[order(files$Tes, files$Nama, files$Waktu_Unduh), ]

# Membuat data frame yang tidak mengandung duplikasi item
file_ready_1 <- files_ready[duplicated(files_ready$Nama, fromLast = T),]
duplicated(files_ready$Nama, fromLast = T)

# Membuat data frame dari file_ready_1; hanya terdiri dari kolom 1 sampai 6
file_ready_1 <- file_ready_1[, 1:6]

# membuat data frame yang berisi nama file-file yang memiliki duplikasi
daftar_file_terhapus <- data.frame(row.names(file_ready_1))


# menghapus file duplikasi
for (i in 1 : nrow(daftar_file_terhapus)){
  nama_file <- daftar_file_terhapus[i,]
  file.remove(paste0(dir_folder, "/", nama_file))
}



