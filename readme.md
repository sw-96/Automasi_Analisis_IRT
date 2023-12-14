# Dokumentasi Automasi Analisis IRT
## Updated: 14 Des 2023

### Pre-IRT analysis
Gunakan 00_scanning_files.R untuk menghapus file duplikasi sebelum dipindahkan ke folder input_tl & input_tps.

### I. Struktur Folder Try Out
#### 1. 0_penambah_tanggal_tes.R
>Script ini berfungsi untuk menambahkan kolom tanggal_tes pada data yang belum berisi tanggal_tes. Tanggal yang digunakan dapat disesuaikan dengan kebutuhan.
#### 2. a_data_preparation.R
>Script ini berfungsi untuk menambahkankan data-data baru ke database utama, menghilangkan duplikasi data, dan membagi respon siswa berdasarkan 7 buah sub tes yang diujikan.
#### 3. b_automasi_analisis_irt.R
>Script ini berfungsi untuk melakukan analisis irt dan uji anova. Skrip ini menghasilkan nilai seluruh siswa dalam database per sub tes, nilai uji anova, dan nilai seluruh siswa untuk tiap subtes beserta reratanya.
#### 4. daftar_peserta_tidak_menjawab
>Berisi:
1_list_siswa_yang_tidak_menjawab_TPS.xlsx; berisi daftar siswa yang tidak menjawab tes potensi skolastik
2_list_siswa_yang_tidak_menjawab_TL.xlsx; berisi daftar siswa yang tidak menjawab tes literasi
#### 5. hasil_analisis_irt
>Berisi:
1 nilai_akhir_lengkap.xlsx; nilai seluruh siswa untuk semua sub tes serta reratanya
2 file-file yang mengandung nilai seluruh siswa tiap uji irt tiap sub tes & uji anova
#### 6. input_tl
>Berisi:
data-data respon jawaban siswa untuk tes literasi
#### 7. input_tps
>Berisi:
data-data respon jawaban siswa untuk tes potensi skolastik
#### 8. main_database
>Berisi:
1 Database_TL.xlsx; yang menampung seluruh data tes literasi untuk "tes yang sama"
2 Database_TPS.xlsx; yang menampung seluruh data tes potensi skolastik untuk "tes yang sama"
#### 9. ready_data
>Menampung:
Data-data yang akan digunakan dalam analis IRT
#### 10. referensi_probabilitas
>Berisi:
File-file csv yang memuat probabilitas tiap soal untuk dijawab dengan benar

### II. Prosedur Penggunaan
1. Mengunduh folder "try_out" dan mengubah nama folder sesuai dengan periode atau jenis soal try out, e.g. "try_out_1". Folder "try_out_1" memuat database untuk try out periode 1 atau try out yang menggunakan paket soal 1
1. Isikan data-data siswa yang tidak menjawab soal tps maupun tl pada file xlsx yang tersedia pada folder "daftar_peserta_tidak_menjawab"
2. Masukkan file xlsx yang berisi respon jawaban siswa untuk tps dan tl pada masing-masing folder "input_tps" & "input_tl"
3. Sesuaikan nilai probabilitas soal-soal tiap subtes pada file-file csv yang terdapat pada folder "referensi_probabilitas"
4. (Langkah ini hanya dilakukan jika data yang dimasukkan pada folder "input_tps" & "input_tl" tidak berisikan kolom "Tanggal_Tes") Membuka script 0_penambah_tanggal_tes.R dan menjalankannya menggunakan Rstudio
5. Membuka file "a_data_preparation.R" & "b_automasi_analisis_irt.R" menggunakan Rstudio
6. Menjalankan "a_data_preparation.R" untuk mempersiapkan data yang akan digunakan dalam analis irt
7. Menjalankan "b_automasi_analisis_irt.R" untuk melakukan analisis irt dan memperoleh nilai seluruh siswa untuk setiap subtes beserta reratanya
8. Langkah 5-6 dapat dilakukan juga menggunakan all_in_one.R
