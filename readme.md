# Dokumentasi Automasi Analisis IRT
## Updated: 29 Jan 2024

### Post-Download Hasil Tryout
Gunakan 00_scanning_files.R untuk menghapus file duplikasi sebelum dipindahkan ke folder input_tl & input_tps. Hal ini dilakukan karena ada kasus dimana 1 orang dapat melakukan submit jawaban lebih dari satu kali.

Tampilan Console yang menunjukkan bahwa tidak ada file duplikasi
>Warning messages:
>1: In file.remove(paste0(dir_folder, "/", nama_file)) :
>  cannot remove file '/Users/windusara/Downloads/tryout_january_2024/tps/NA', reason 'No such file or directory'
>2: In file.remove(paste0(dir_folder, "/", nama_file)) :
>  cannot remove file '/Users/windusara/Downloads/tryout_january_2024/tps/', reason 'Directory not empty'

### I. Struktur Folder Try Out
#### 1. 0_penambah_tanggal_tes.R
>Script ini berfungsi untuk menambahkan kolom tanggal_tes pada data yang belum berisi tanggal_tes. Tanggal yang digunakan dapat disesuaikan dengan kebutuhan.
#### 2. a_data_preparation.R
>Script ini berfungsi untuk menambahkankan data-data baru ke database utama dan membagi respon siswa berdasarkan 7 buah sub tes yang diujikan.
#### 3. b_automasi_analisis_irt.R
>Script ini berfungsi untuk melakukan analisis irt dan uji anova. Skrip ini menghasilkan nilai seluruh siswa dalam database per sub tes, nilai uji anova, dan nilai seluruh siswa untuk tiap subtes beserta reratanya.
#### 4. all_in_one.R
>Script ini berfungsi untuk menjalankan script 0_penambah_tanggal_tes.R, a_data_preparation.R, dan b_automasi_analisis_irt.R secara berurutan.
#### 5. daftar_peserta_tidak_menjawab
>Berisi:
1_list_siswa_yang_tidak_menjawab_TPS.xlsx; berisi daftar siswa yang tidak menjawab tes potensi skolastik
2_list_siswa_yang_tidak_menjawab_TL.xlsx; berisi daftar siswa yang tidak menjawab tes literasi
#### 6. hasil_analisis_irt
>Berisi:
1 nilai_akhir_lengkap.xlsx; nilai seluruh siswa untuk semua sub tes beserta reratanya
2 file-file yang mengandung nilai seluruh siswa tiap uji irt tiap sub tes & uji anova
#### 7. input_tl
>Berisi:
data-data respon jawaban siswa untuk tes literasi (termasuk dummy data; jangan dihapus)
#### 8. input_tps
>Berisi:
data-data respon jawaban siswa untuk tes potensi skolastik (termasuk dummy data; jangan dihapus)
#### 9. main_database
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
1. Mengunduh folder "try_out_i" dan mengubah nama folder sesuai dengan periode atau jenis soal try out, e.g. "try_out_1". Folder "try_out_1" memuat database untuk try out periode 1 atau try out yang menggunakan paket soal 1
1. Isikan data-data siswa yang tidak menjawab soal tps maupun tl pada file-file xlsx yang tersedia pada folder "daftar_peserta_tidak_menjawab"
2. Masukkan file xlsx yang berisi respon jawaban siswa untuk tps dan tl pada masing-masing folder "input_tps" & "input_tl" dengan menggunakan format penamaan baru, seperti TPS1, TPS2, TPS3, ..., TPSn & TL1, TL2, TL3, ..., TLn
3. Sesuaikan nilai probabilitas soal-soal tiap subtes pada file-file csv yang terdapat pada folder "referensi_probabilitas"
4. Membuka script 0_penambah_tanggal_tes.R dan menjalankannya menggunakan Rstudio
5. Membuka file "a_data_preparation.R" & "b_automasi_analisis_irt.R" menggunakan Rstudio
6. Menjalankan "a_data_preparation.R" untuk mempersiapkan data yang akan digunakan dalam analis irt
7. Menjalankan "b_automasi_analisis_irt.R" untuk melakukan analisis irt dan memperoleh nilai seluruh siswa untuk setiap subtes beserta reratanya
8. Langkah 5-7 dapat dilakukan juga menggunakan all_in_one.R
