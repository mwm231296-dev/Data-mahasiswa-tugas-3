import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/mahasiswa.dart';

class FormMahasiswaPage extends StatefulWidget {
  final Mahasiswa? mahasiswa;
  final Set<String> nimTerpakai;

  const FormMahasiswaPage({
    super.key,
    this.mahasiswa,
    required this.nimTerpakai,
  });

  @override
  State<FormMahasiswaPage> createState() => _FormMahasiswaPageState();
}

class _FormMahasiswaPageState extends State<FormMahasiswaPage> {
  static const List<String> prodiList = [
    'Teknik Informatika',
    'Sistem Informasi',
    'Manajemen Informatika',
  ];
  static const List<String> provinsiList = [
    'Aceh',
    'Sumatera Utara',
    'Sumatera Barat',
    'Riau',
    'Kepulauan Riau',
    'Jambi',
    'Sumatera Selatan',
    'Kepulauan Bangka Belitung',
    'Bengkulu',
    'Lampung',
    'DKI Jakarta',
    'Jawa Barat',
    'Jawa Tengah',
    'DI Yogyakarta',
    'Jawa Timur',
    'Banten',
    'Bali',
    'Nusa Tenggara Barat',
    'Nusa Tenggara Timur',
    'Kalimantan Barat',
    'Kalimantan Tengah',
    'Kalimantan Selatan',
    'Kalimantan Timur',
    'Kalimantan Utara',
    'Sulawesi Utara',
    'Gorontalo',
    'Sulawesi Tengah',
    'Sulawesi Barat',
    'Sulawesi Selatan',
    'Sulawesi Tenggara',
    'Maluku',
    'Maluku Utara',
    'Papua',
    'Papua Barat',
    'Papua Selatan',
    'Papua Tengah',
    'Papua Pegunungan',
    'Papua Barat Daya',
  ];
  static const List<String> kotaKabupatenList = [
    'Jakarta',
    'Jakarta Pusat',
    'Bandung',
    'Semarang',
    'Bogor',
    'Depok',
    'Tangerang',
    'Bekasi',
    'Surabaya',
    'Medan',
    'Makassar',
    'Palembang',
    'Denpasar',
    'Yogyakarta',
    'Balikpapan',
    'Pontianak',
    'Banjarmasin',
    'Manado',
    'Palu',
    'Mataram',
    'Kupang',
    'Jayapura',
    'Sorong',
    'Ambon',
    'Ternate',
    'Tidore',
    'Banda Aceh',
    'Padang',
    'Pekanbaru',
    'Jambi',
  ];

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nim;
  late final TextEditingController _namaPanggilan;
  late final TextEditingController _nama;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _tanggalLahir;
  late final TextEditingController _prodi;
  late final TextEditingController _passwordPortal;
  late final TextEditingController _tempatLahir;
  late final TextEditingController _alamatcontroller;

  String _jenisKelamin = 'Laki-laki';
  late final TextEditingController _agama;
  late final TextEditingController _semester;
  late final TextEditingController _kelas;
  String _statusMahasiswa = 'Aktif';
  double _ipkValue = 0.0;
  bool _penerimaBeasiswa = false;
  bool _setuju = false;
  bool? _bersediaMagang = false;
  String? _minat;
  String? _provinsi;
  String? _kotaKabupaten;
  Color _selectedColor = Colors.blue;
  late final TextEditingController _dokumenFile;
  late final TextEditingController _dokumenPath;
  Uint8List? _fotoProfil;

  // Helper parsing hex warna yang aman
  Color _parseColor(String? hexString) {
    if (hexString == null || hexString.isEmpty) return Colors.blue;
    try {
      String cleanHex = hexString
          .replaceAll('#', '')
          .replaceAll('0x', '')
          .replaceAll('0X', '');
      if (cleanHex.length == 6) {
        cleanHex = 'FF$cleanHex';
      }
      return Color(int.parse(cleanHex, radix: 16));
    } catch (_) {
      return Colors.blue;
    }
  }

  Future<void> _pilihFoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final bytes = await image.readAsBytes();
    if (!mounted) return;
    setState(() => _fotoProfil = bytes);
  }

  Future<void> _pilihDokumen() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null || !mounted) return;

    setState(() {
      _dokumenFile.text = file.name;
      _dokumenPath.text = file.path;
    });
  }

  @override
  void initState() {
    super.initState();
    _nim = TextEditingController(text: widget.mahasiswa?.nim);
    _namaPanggilan = TextEditingController(text: widget.mahasiswa?.namaPanggilan ?? '');
    _nama = TextEditingController(text: widget.mahasiswa?.nama);
    _email = TextEditingController(text: widget.mahasiswa?.email ?? '');
    _phone = TextEditingController(text: widget.mahasiswa?.phone ?? '');
    _tanggalLahir = TextEditingController(text: widget.mahasiswa?.tanggalLahir ?? '');
    _tempatLahir = TextEditingController(text: widget.mahasiswa?.tempatLahir ?? '');
    _alamatcontroller = TextEditingController(text: widget.mahasiswa?.alamat ?? '');
    _prodi = TextEditingController(text: widget.mahasiswa?.prodi);
    _passwordPortal = TextEditingController(text: widget.mahasiswa?.passwordPortal ?? '');
    _jenisKelamin = widget.mahasiswa?.jenisKelamin ?? 'Laki-laki';
    _agama = TextEditingController(text: widget.mahasiswa?.agama ?? '');
    _semester = TextEditingController(text: widget.mahasiswa?.semester ?? '');
    _kelas = TextEditingController(text: widget.mahasiswa?.kelas ?? '');
    _statusMahasiswa = widget.mahasiswa?.statusmahasiswa ?? 'Aktif';
    _ipkValue = double.tryParse(widget.mahasiswa?.ipk ?? '0.0') ?? 0.0;
    _penerimaBeasiswa = widget.mahasiswa?.penerimaBeasiswa == 'Ya';
    _bersediaMagang = widget.mahasiswa?.bersediamagang == 'Ya';
    _minat = widget.mahasiswa?.minat;
    _provinsi = widget.mahasiswa?.provinsi;
    _kotaKabupaten = widget.mahasiswa?.kotaKabupaten;
    _dokumenFile = TextEditingController(text: widget.mahasiswa?.dokumenktp ?? '');
    _dokumenPath = TextEditingController();
    _fotoProfil = widget.mahasiswa?.fotoProfil != null
        ? Uint8List.fromList(widget.mahasiswa!.fotoProfil!.codeUnits)
        : null;

    // Set warna secara aman
    _selectedColor = _parseColor(widget.mahasiswa?.warnaprofil);
  }

  @override
  void dispose() {
    _nim.dispose();
    _namaPanggilan.dispose();
    _nama.dispose();
    _email.dispose();
    _phone.dispose();
    _tanggalLahir.dispose();
    _prodi.dispose();
    _passwordPortal.dispose();
    _tempatLahir.dispose();
    _alamatcontroller.dispose();
    _agama.dispose();
    _semester.dispose();
    _kelas.dispose();
    _dokumenFile.dispose();
    _dokumenPath.dispose();
    super.dispose();
  }

  String? _wajib(String? value, String label) {
    return value == null || value.trim().isEmpty
        ? '$label tidak boleh kosong'
        : null;
  }

  String? _validasiEmail(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Email tidak valid';
    return null;
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;
    if (!_setuju) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harus menyetujui data sebelum disimpan')),
      );
      return;
    }

    Navigator.pop(
      context,
      Mahasiswa(
        nim: _nim.text.trim(),
        nama: _nama.text.trim(),
        namaPanggilan: _namaPanggilan.text.trim(),
        prodi: _prodi.text.trim(),
        email: _email.text.trim(),
        phone: _phone.text.trim(),
        tanggalLahir: _tanggalLahir.text.trim(),
        tempatLahir: _tempatLahir.text.trim(),
        jenisKelamin: _jenisKelamin,
        agama: _agama.text.trim(),
        passwordPortal: _passwordPortal.text,
        semester: _semester.text.trim(),
        kelas: _kelas.text.trim(),
        statusmahasiswa: _statusMahasiswa,
        ipk: _ipkValue.toStringAsFixed(2),
        penerimaBeasiswa: _penerimaBeasiswa ? 'Ya' : 'Tidak',
        bersediamagang: _bersediaMagang == true ? 'Ya' : 'Tidak',
        minat: _minat,
        alamat: _alamatcontroller.text.trim(),
        provinsi: _provinsi,
        kotaKabupaten: _kotaKabupaten,
        fotoProfil: _fotoProfil == null ? null : String.fromCharCodes(_fotoProfil!),
        dokumenktp: _dokumenFile.text.trim(),
        warnaprofil: '#${_selectedColor.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
      ),
    );
  }

  Widget _buildColorChip(Color color) {
    final isSelected = _selectedColor.value == color.value;

    return GestureDetector(
      onTap: () => setState(() => _selectedColor = color),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: color,
        child: isSelected
            ? const Icon(Icons.check, color: Colors.white, size: 20)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mahasiswa == null ? 'Tambah Mahasiswa' : 'Edit Mahasiswa',
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                TextFormField(
                  controller: _nim,
                  decoration: const InputDecoration(labelText: 'NIM'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    final error = _wajib(value, 'NIM');
                    if (error != null) return error;
                    if (widget.nimTerpakai.contains(value!.trim().toLowerCase())) {
                      return 'NIM sudah digunakan';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _namaPanggilan,
                  decoration: const InputDecoration(labelText: 'Nama Panggilan'),
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  validator: (value) => _wajib(value, 'Nama Panggilan'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nama,
                  decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  validator: (value) => _wajib(value, 'Nama Lengkap'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: _validasiEmail,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phone,
                  decoration: const InputDecoration(labelText: 'No. HP'),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) => _wajib(value, 'No. HP'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _tanggalLahir,
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Lahir',
                    hintText: 'Pilih tanggal',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _tanggalLahir.text =
                            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                      });
                    }
                  },
                  validator: (value) => value == null || value.isEmpty ? 'Tanggal Lahir tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _agama.text.isEmpty ? null : _agama.text,
                  decoration: const InputDecoration(labelText: 'Agama', hintText: 'Pilih agama'),
                  items: ['Islam', 'Kristen', 'Katolik', 'Hindu', 'Buddha', 'Konghucu', 'Lainnya'].map((agama) => DropdownMenuItem(value: agama, child: Text(agama))).toList(),
                  onChanged: (value) => setState(() => _agama.text = value ?? ''),
                  validator: (value) => _wajib(value, 'Agama'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _tempatLahir,
                  decoration: const InputDecoration(labelText: 'Tempat Lahir', hintText: 'Masukkan tempat lahir'),
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  validator: (value) => _wajib(value, 'Tempat Lahir'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Jenis Kelamin',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Laki-laki'),
                        value: 'Laki-laki',
                        groupValue: _jenisKelamin,
                        onChanged: (value) => setState(() => _jenisKelamin = value!),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Perempuan'),
                        value: 'Perempuan',
                        groupValue: _jenisKelamin,
                        onChanged: (value) => setState(() => _jenisKelamin = value!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _prodi.text.isEmpty ? null : _prodi.text,
                  decoration: const InputDecoration(labelText: 'Program Studi'),
                  items: prodiList.map((prodi) => DropdownMenuItem(value: prodi, child: Text(prodi))).toList(),
                  onChanged: (value) => setState(() => _prodi.text = value ?? ''),
                  validator: (value) => _wajib(value, 'Program Studi'),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _semester.text.isEmpty ? null : _semester.text,
                  decoration: const InputDecoration(labelText: 'Semester', hintText: 'Pilih semester'),
                  items: List.generate(8, (index) => (index + 1).toString()).map((semester) => DropdownMenuItem(value: semester, child: Text(semester))).toList(),
                  onChanged: (value) => setState(() => _semester.text = value ?? ''),
                  validator: (value) => _wajib(value, 'Semester'),
                ),
                const SizedBox(height: 16),
                InputDecorator(
                  decoration: const InputDecoration(labelText: 'Kelas'),
                  child: SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'A', label: Text('A')),
                      ButtonSegment(value: 'B', label: Text('B')),
                      ButtonSegment(value: 'C', label: Text('C')),
                    ],
                    selected: {_kelas.text.isEmpty ? 'A' : _kelas.text},
                    onSelectionChanged: (value) {
                      setState(() => _kelas.text = value.first);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Status Mahasiswa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ChoiceChip(
                      label: const Text('Aktif'),
                      selected: _statusMahasiswa == 'Aktif',
                      onSelected: (selected) {
                        if (selected) setState(() => _statusMahasiswa = 'Aktif');
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Cuti'),
                      selected: _statusMahasiswa == 'Cuti',
                      onSelected: (selected) {
                        if (selected) setState(() => _statusMahasiswa = 'Cuti');
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Lulus'),
                      selected: _statusMahasiswa == 'Lulus',
                      onSelected: (selected) {
                        if (selected) setState(() => _statusMahasiswa = 'Lulus');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('IPK', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Slider(
                        value: _ipkValue,
                        min: 0.0,
                        max: 4.0,
                        divisions: 40,
                        label: _ipkValue.toStringAsFixed(2),
                        onChanged: (value) => setState(() => _ipkValue = value),
                      ),
                    ),
                    Text(_ipkValue.toStringAsFixed(2), style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('penerimaan Beasiswa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                SwitchListTile(
                  title: const Text('ya / tidak'),
                  subtitle: const Text('Apakah mahasiswa menerima beasiswa?'),
                  value: _penerimaBeasiswa,
                  onChanged: (value) => setState(() => _penerimaBeasiswa = value),
                ),
                const SizedBox(height: 16),
                const Text('Bersedia Magang', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                CheckboxListTile(
                  title: const Text('ya / tidak'),
                  subtitle: const Text('Apakah mahasiswa bersedia magang?'),
                  value: _bersediaMagang,
                  onChanged: (value) => setState(() => _bersediaMagang = value),
                ),
                const SizedBox(height: 16),
                const Text('Minat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('Programming'),
                      selected: _minat == 'Programming',
                      onSelected: (selected) => setState(() => _minat = selected ? 'Programming' : null),
                    ),
                    FilterChip(
                      label: const Text('Desain'),
                      selected: _minat == 'Desain',
                      onSelected: (selected) => setState(() => _minat = selected ? 'Desain' : null),
                    ),
                    FilterChip(
                      label: const Text('Jaringan'),
                      selected: _minat == 'Jaringan',
                      onSelected: (selected) => setState(() => _minat = selected ? 'Jaringan' : null),
                    ),
                    FilterChip(
                      label: const Text('Multimedia'),
                      selected: _minat == 'Multimedia',
                      onSelected: (selected) => setState(() => _minat = selected ? 'Multimedia' : null),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Alamat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _alamatcontroller,
                  decoration: const InputDecoration(
                    labelText: 'Alamat',
                    hintText: 'Masukkan alamat lengkap',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  minLines: 1,
                  textInputAction: TextInputAction.done,
                  validator: (value) => _wajib(value, 'Alamat'),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Provinsi', border: OutlineInputBorder()),
                  initialValue: _provinsi,
                  items: provinsiList.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                  onChanged: (value) => setState(() => _provinsi = value),
                  validator: (value) => _wajib(value, 'Provinsi'),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Kota/Kabupaten', border: OutlineInputBorder()),
                  initialValue: _kotaKabupaten,
                  items: kotaKabupatenList.map((k) => DropdownMenuItem(value: k, child: Text(k))).toList(),
                  onChanged: (value) => setState(() => _kotaKabupaten = value),
                  validator: (value) => _wajib(value, 'Kota/Kabupaten'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordPortal,
                  decoration: const InputDecoration(labelText: 'Password Portal'),
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: (value) => _wajib(value, 'Password Portal'),
                ),
                const SizedBox(height: 16),
                const Text('Foto Profil', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.grey[200],
                        child: _fotoProfil != null
                            ? ClipOval(
                                child: Image.memory(
                                  _fotoProfil!,
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(Icons.person, size: 80, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: _pilihFoto,
                        icon: const Icon(Icons.photo_library_outlined),
                        label: const Text('Pilih Foto'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Dokumen / KTM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: _pilihDokumen,
                  icon: const Icon(Icons.attach_file),
                  label: const Text('Pilih File Dokumen / KTM'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                if (_dokumenFile.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('File terpilih: ${_dokumenFile.text}'),
                  ),
                if (_dokumenPath.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('Lokasi file: ${_dokumenPath.text}'),
                  ),
                const SizedBox(height: 16),
                const Text('Warna Profil', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildColorChip(Colors.red),
                    _buildColorChip(Colors.green),
                    _buildColorChip(Colors.blue),
                    _buildColorChip(Colors.orange),
                    _buildColorChip(Colors.purple),
                    _buildColorChip(Colors.teal),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Persetujuan Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                SwitchListTile(
                  title: const Text('Setuju'),
                  subtitle: const Text('Saya menyetujui bahwa data yang dimasukkan adalah benar'),
                  value: _setuju,
                  onChanged: (value) => setState(() => _setuju = value),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _simpan,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Simpan Data'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}