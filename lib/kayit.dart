import 'package:flutter/material.dart';
import 'package:odev5/db_helper.dart';

class Kayit extends StatefulWidget {
  @override
  _KayitState createState() => _KayitState();
}

class _KayitState extends State<Kayit> {
  final TextEditingController adController = TextEditingController();
  final TextEditingController soyadController = TextEditingController();
  final TextEditingController kullaniciAdiController = TextEditingController();
  final TextEditingController parolaController = TextEditingController();
  DateTime? dogumTarihi;
  String? cinsiyet;
  List<String> hobiler = ['Yüzme', 'Koşu', 'Kitap Okuma', 'Film İzleme', 'Gezme'];
  Set<String> seciliHobiler = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kayıt Ol')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: adController, decoration: const InputDecoration(labelText: 'Ad')),
            TextField(controller: soyadController, decoration: const InputDecoration(labelText: 'Soyad')),
            TextField(controller: kullaniciAdiController, decoration: const InputDecoration(labelText: 'Kullanıcı Adı')),
            TextField(controller: parolaController, decoration: const InputDecoration(labelText: 'Parola'), obscureText: true),
            ListTile(
              title: const Text('Doğum Tarihi:'),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != dogumTarihi) {
                    setState(() {
                      dogumTarihi = picked;
                    });
                  }
                },
              ),
              subtitle: Text(dogumTarihi == null ? 'Seçiniz' : '${dogumTarihi!.toLocal()}'.split(' ')[0]),
            ),
            ListTile(
              title: const Text('Cinsiyet:'),
              trailing: DropdownButton<String>(
                value: cinsiyet,
                hint: const Text('Cinsiyet Seçin'),
                onChanged: (newValue) {
                  setState(() {
                    cinsiyet = newValue;
                  });
                },
                items: ['Erkek', 'Kadın', 'Diğer']
                    .map((value) => DropdownMenuItem<String>(value: value, child: Text(value)))
                    .toList(),
              ),
            ),
            Wrap(
              spacing: 10.0,
              children: hobiler.map((hobi) {
                return FilterChip(
                  label: Text(hobi),
                  selected: seciliHobiler.contains(hobi),
                  onSelected: (isSelected) {
                    setState(() {
                      if (isSelected) {
                        seciliHobiler.add(hobi);
                      } else {
                        seciliHobiler.remove(hobi);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () async {
                if (kullaniciAdiController.text.isNotEmpty && parolaController.text.isNotEmpty) {
                  final dbHelper = DBHelper();
                  await dbHelper.kullaniciEkle({
                    'ad': adController.text,
                    'soyad': soyadController.text,
                    'kullaniciAdi': kullaniciAdiController.text,
                    'parola': parolaController.text,
                    'dogumTarihi': dogumTarihi != null ? '${dogumTarihi!.year}-${dogumTarihi!.month}-${dogumTarihi!.day}' : '',
                    'cinsiyet': cinsiyet ?? '',
                    'hobiler': seciliHobiler.join(', '),
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kayıt Başarılı!')));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen tüm bilgileri doldurun!')));
                }
              },
              child: const Text('Kayıt'),
            ),
          ],
        ),
      ),
  floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.pop(context); // Bir önceki sayfaya dön
  },
  child: const Icon(Icons.arrow_upward),
),

    );
  }
}
