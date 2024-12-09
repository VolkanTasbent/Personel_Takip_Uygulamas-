import 'package:flutter/material.dart';
import 'package:odev5/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GirisYap extends StatelessWidget {
  const GirisYap({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController kullaniciAdiController = TextEditingController();
    final TextEditingController parolaController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: kullaniciAdiController, decoration: const InputDecoration(labelText: 'Kullanıcı Adı')),
            TextField(controller: parolaController, decoration: const InputDecoration(labelText: 'Parola'), obscureText: true),
            ElevatedButton(
              onPressed: () async {
                final dbHelper = DBHelper();
                final tumKullanicilar = await dbHelper.tumKullanicilariGetir();
                final kullanici = tumKullanicilar.firstWhere(
                  (kullanici) =>
                      kullanici['kullaniciAdi'] == kullaniciAdiController.text &&
                      kullanici['parola'] == parolaController.text,
                  orElse: () => {},
                );

                if (kullanici.isNotEmpty) {
                  // Kullanıcı bilgilerini sakla
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('ad', kullanici['ad']);
                  await prefs.setString('soyad', kullanici['soyad']);
                  await prefs.setString('kullaniciAdi', kullanici['kullaniciAdi']);
                  await prefs.setString('dogumTarihi', kullanici['dogumTarihi']);

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Giriş Başarılı!')));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Hatalı Kullanıcı Adı veya Parola!')));
                }
              },
              child: const Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
