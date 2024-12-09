import 'package:flutter/material.dart';
import 'package:odev5/diger_kullanicilar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Bilgilerim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bilgilerim')),
      body: FutureBuilder<Map<String, String>>(
        future: oturumAcikKullaniciBilgileri(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('Kullanıcı bilgileri yüklenemedi.'));
          }

          final bilgiler = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ad: ${bilgiler['ad']}'),
                Text('Soyad: ${bilgiler['soyad']}'),
                Text('Kullanıcı Adı: ${bilgiler['kullaniciAdi']}'),
                Text('Doğum Tarihi: ${bilgiler['dogumTarihi']}'),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DigerKullanicilar()));
                  },
                  child: const Text('Diğer Kullanıcılar'),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.pop(context); // Bir önceki sayfaya dön
  },
  child: const Icon(Icons.arrow_upward),
),

    );
  }

  Future<Map<String, String>> oturumAcikKullaniciBilgileri() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'ad': prefs.getString('ad') ?? 'Bilinmiyor',
      'soyad': prefs.getString('soyad') ?? 'Bilinmiyor',
      'kullaniciAdi': prefs.getString('kullaniciAdi') ?? 'Bilinmiyor',
      'dogumTarihi': prefs.getString('dogumTarihi') ?? 'Bilinmiyor',
    };
  }
}
