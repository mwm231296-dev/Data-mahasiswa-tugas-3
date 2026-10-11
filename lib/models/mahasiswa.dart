class Mahasiswa {
  final String nim;
  final String nama;
  final String? namaPanggilan;
  final String prodi;
  final String email;
  final String phone;
  final String tanggalLahir;
  final String? jenisKelamin;
  final String? agama;
  final String? passwordPortal;
  final String? tempatLahir;
  final String? semester;
  final String? kelas;
  final String? statusmahasiswa;
  final String? ipk;
  final String? penerimaBeasiswa;
  final String? bersediamagang;
  final String? minat;
  final String? alamat;
  final String? provinsi;
  final String? kotaKabupaten;
  final String? fotoProfil;
  final String? dokumenktp;
  final String? warnaprofil;

  const Mahasiswa({
    required this.nim,
    required this.nama,
    required this.namaPanggilan,
    required this.prodi,
    required this.email,
    required this.phone,
    required this.tanggalLahir,
    this.jenisKelamin,
    this.agama,
    this.passwordPortal,
    this.tempatLahir,
    this.semester,
    this.kelas,
    this.statusmahasiswa,
    this.ipk,
    this.penerimaBeasiswa,
    this.bersediamagang,
    this.minat,
    this.alamat,
    this.provinsi,
    this.kotaKabupaten,
    this.fotoProfil,
    this.dokumenktp,
    this.warnaprofil,
  });
}
