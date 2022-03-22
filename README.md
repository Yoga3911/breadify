<h1>Project PBM A1 (Breadify)</h1>
<h3>Breadify adalah aplikasi marketplace yang dikhususkan untuk penjualan roti.</h3>
<h4>Rincian Pembuatan Aplikasi: </h4>
<ul>
  <li>Flutter sebagai Front end Framework</li>
  <li>Firebase sebagai Authentication, Database, dan Storage</li>
  <li>Codemagic sebagai CI/CD</li>
  <li>Bash script sebagai automate deployment ke telegram</li>
  <li>Go language sebagai service github api untuk mendapatkan last commit yang digunakan untuk deskripsi hasil deployment ke telegram</li>
  <li>Github sebagai tempat untuk kolaborasi antar pengembang</li>
  <li>Trello sebagai tempat untuk mengatur tugas yang perlu, sedang, dan sudah dikerjakan</li>
</ul>
<h4>Tim pengembang: </h4>
<ul>
  <li>Liandri Eko Prayugo (202410102008)</li>
  <li>Beatric Stevany Zebua (202410102011)</li>
  <li>Sean Anthony (202410102030)</li>
</ul>
<h4>Struktur Folder</h4>
<img src="https://firebasestorage.googleapis.com/v0/b/market-api-cda7e.appspot.com/o/breadify%2FStruktur%20folder%20PBM.png?alt=media&token=85c869f7-bd7f-4165-8ab2-59fdb04af665" width="500px" height="300px">
<ul>
  <li>Lib: Folder utama untuk menuliskan kode</li>
  <li>App: Folder dari semua kode aplikasi Breadify berada</li>
  <li>main.dart: File yang pertama dijalankan ketika aplikasi dijalankan</li>
  <li>Constant: Menyimpan variable yang sifatnya constant dan sering digunakan</li>
  <li>Models: Menyimpan kumpulan model yang didalamnya terdapat Business Login dan Data</li>
  <li>Views: Menyimpan kumpulan view yang didalamnya terdapat UI Logic</li>
  <li>View Model: Menyimpan kumpulan view model yang didalamnya terdapat Presentation Logic</li>
  <li>Routes: Menyimpan rute atau halaman aplikasi Breadify</li>
  <li>Component: Folder yang berisi kumpulan custom shape</li>
  <li>Widget: Folder yang berisi kumpulan custom widget</li>
</ul>
<h4>Pattern yang digunakan MVVM</h4>
<img src="https://firebasestorage.googleapis.com/v0/b/market-api-cda7e.appspot.com/o/breadify%2FMVVM.png?alt=media&token=aacfe24a-2b8e-4716-beb6-92711c259700" width="500px" height="200px">
