import 'package:flutter/material.dart';
import 'package:odev5/db_helper.dart';

class DigerKullanicilar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diğer Kullanıcılar')),
      body: FutureBuilder(
        future: DBHelper().tumKullanicilariGetir(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(child: Text('Kayıtlı Kullanıcı Bulunamadı'));
          }

          final kullanicilar = snapshot.data as List<Map<String, dynamic>>;

          return ListView.builder(
            itemCount: kullanicilar.length,
            itemBuilder: (context, index) {
              final kullanici = kullanicilar[index];
              return Column(
                children: [
                  ListTile(
                    title: Text('${kullanici['ad']} ${kullanici['soyad']}'),
                    subtitle: Text('Kullanıcı Adı: ${kullanici['kullaniciAdi']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.expand_more),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('${kullanici['ad']} ${kullanici['soyad']} Detayları'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Ad: ${kullanici['ad']}'),
                                  Text('Soyad: ${kullanici['soyad']}'),
                                  Text('Kullanıcı Adı: ${kullanici['kullaniciAdi']}'),
                                  Text('Doğum Tarihi: ${kullanici['dogumTarihi']}'),
                                  Text('Cinsiyet: ${kullanici['cinsiyet']}'),
                                  Text('Hobiler: ${kullanici['hobiler']}'),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Tamam'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
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
}
