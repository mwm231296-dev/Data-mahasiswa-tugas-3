import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../models/mahasiswa.dart';
import 'form_mahasiswa_page.dart';

class DetailResult {
  final Mahasiswa? mahasiswa;
  const DetailResult.updated(Mahasiswa this.mahasiswa);
  const DetailResult.deleted() : mahasiswa = null;
}

class DetailMahasiswaPage extends StatefulWidget {
  final Mahasiswa mahasiswa;
  final Set<String> nimLain;

  const DetailMahasiswaPage({
    super.key,
    required this.mahasiswa,
    required this.nimLain,
  });

  @override
  State<DetailMahasiswaPage> createState() => _DetailMahasiswaPageState();
}

class _DetailMahasiswaPageState extends State<DetailMahasiswaPage> {
  Future<void> _edit() async {
    final result = await Navigator.push<Mahasiswa>(
      context,
      MaterialPageRoute(
        builder: (_) => FormMahasiswaPage(
          mahasiswa: widget.mahasiswa,
          nimTerpakai: widget.nimLain,
        ),
      ),
    );
    if (!mounted || result == null) return;
    Navigator.pop(context, DetailResult.updated(result));
  }

  Future<void> _hapus() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus mahasiswa?'),
        content: Text(
          'Data ${widget.mahasiswa.nama} (${widget.mahasiswa.nim}) akan dihapus.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (!mounted || confirmed != true) return;
    Navigator.pop(context, const DetailResult.deleted());
  }

  @override
  Widget build(BuildContext context) {
    final mahasiswa = widget.mahasiswa;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Mahasiswa')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Icon(Icons.school_outlined, size: 72),
              const SizedBox(height: 24),
              ListTile(
                title: const Text('Foto Profil'),
                subtitle: mahasiswa.fotoProfil != null
                    ? Image.memory(
                        Uint8List.fromList(mahasiswa.fotoProfil!.codeUnits),
                        width: 100,
                        height: 100,
                      )
                    : const Text('-'),
              ),
              ListTile(
                title: const Text('Nama Lengkap'),
                subtitle: Text(mahasiswa.nama),
              ),
              ListTile(
                title: const Text('Nama Panggilan'),
                subtitle: Text(mahasiswa.namaPanggilan ?? '-'),
              ),
              ListTile(
                title: const Text('Jenis Kelamin'),
                subtitle: Text(mahasiswa.jenisKelamin ?? '-'),
              ),
              ListTile(title: const Text('NIM'), subtitle: Text(mahasiswa.nim)),
              ListTile(
                title: const Text('Email'),
                subtitle: Text(mahasiswa.email.isEmpty ? '-' : mahasiswa.email),
              ),
              ListTile(
                title: const Text('Program Studi'),
                subtitle: Text(mahasiswa.prodi),
              ),
              ListTile(
                title: const Text('Semester'),
                subtitle: Text(mahasiswa.semester?.isEmpty ?? true ? '-' : mahasiswa.semester!),
              ),
              ListTile(
                title: const Text('Kelas'),
                subtitle: Text(mahasiswa.kelas?.isEmpty ?? true ? '-' : mahasiswa.kelas!),
              ),
              ListTile(
                title: const Text('Status Mahasiswa'),
                subtitle: Text(mahasiswa.statusmahasiswa?.isEmpty ?? true ? '-' : mahasiswa.statusmahasiswa!),
              ),
              ListTile(
                title: const Text('IPK'),
                subtitle: Text(mahasiswa.ipk?.isEmpty ?? true ? '-' : mahasiswa.ipk!),
              ),
              ListTile(
                title: const Text('Penerima Beasiswa'),
                subtitle: Text(mahasiswa.penerimaBeasiswa?.isEmpty ?? true ? '-' : mahasiswa.penerimaBeasiswa!),
              ),
              ListTile(
                title: const Text('Bersedia Magang'),
                subtitle: Text(mahasiswa.bersediamagang?.isEmpty ?? true ? '-' : mahasiswa.bersediamagang!),
              ),
              ListTile(
                title: const Text('Minat'),
                subtitle: Text(mahasiswa.minat?.isEmpty ?? true ? '-' : mahasiswa.minat!),
              ),
              ListTile(
                title: const Text('phone'),
                subtitle: Text(mahasiswa.phone),
              ),
              ListTile(
                title: const Text('Tanggal Lahir'),
                subtitle: Text(mahasiswa.tanggalLahir.isEmpty ? '-' : mahasiswa.tanggalLahir),
              ),
              ListTile(
                title: const Text('Tempat Lahir'),
                subtitle: Text(
                  mahasiswa.tempatLahir?.isEmpty ?? true
                      ? '-'
                      : mahasiswa.tempatLahir!,
                ),
              ),
              ListTile(
                title: const Text('Alamat'),
                subtitle: Text(mahasiswa.alamat?.isEmpty ?? true ? '-' : mahasiswa.alamat!),
              ),
              ListTile(
                title: const Text('Provinsi'),
                subtitle: Text(mahasiswa.provinsi?.isEmpty ?? true ? '-' : mahasiswa.provinsi!),
              ),
              ListTile(
                title: const Text('Kota/Kabupaten'),
                subtitle: Text(mahasiswa.kotaKabupaten?.isEmpty ?? true ? '-' : mahasiswa.kotaKabupaten!),
              ),
              ListTile(
                title: const Text('Agama'),
                subtitle: Text(mahasiswa.agama?.isEmpty ?? true ? '-' : mahasiswa.agama!),
              ),
              ListTile(
                title: const Text('Password Portal'),
                subtitle: Text(mahasiswa.passwordPortal?.isEmpty ?? true ? '-' : mahasiswa.passwordPortal!),
              ),
              ListTile(
                title: const Text('Dokumen KTP'),
  subtitle: mahasiswa.dokumenktp != null && mahasiswa.dokumenktp!.startsWith('http')
      ? Image.network(
          mahasiswa.dokumenktp!,
          width: 100,
          height: 100,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100),
        )
      : mahasiswa.dokumenktp != null
          ? Image.memory(
              Uint8List.fromList(mahasiswa.dokumenktp!.codeUnits),
              width: 100,
              height: 100,
            )
          : const Text('-'),
              ),
             CircleAvatar(
  radius: 40,
  backgroundColor: const Color(0xFFFF5733),
  child: Icon(Icons.person, size: 50, color: Colors.white),
),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _edit,
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit Data'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _hapus,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Hapus Data'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}