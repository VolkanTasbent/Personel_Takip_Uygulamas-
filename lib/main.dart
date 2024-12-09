import 'package:flutter/material.dart';
import 'package:odev5/kayit.dart';
import 'package:odev5/giris_yap.dart';
import 'package:odev5/bilgilerim.dart';
import 'package:odev5/diger_kullanicilar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobil Programlama Ödev 5',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobil Programlama Ödev 5')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  Kayit()));
            },
            child: const Text('Kayıt Ol'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const GirisYap()));
            },
            child: const Text('Giriş Yap'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  Bilgilerim()));
            },
            child: const Text('Bilgilerim'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  DigerKullanicilar()));
            },
            child: const Text('Diğer Kullanıcılar'),
          ),
        ],
      ),
    );
  }
}
