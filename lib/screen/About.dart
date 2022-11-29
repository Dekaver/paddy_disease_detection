import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "About Paddy Leaf Disease",
      )),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'About',
                      style: TextStyle(fontSize: 16),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Paddy leaf Disease adalah aplikasi klasifikasi penyakit tumbuhan padi dengan melalui gambar daun. aplikais ini hanya bisa klasifikasi 3 kategori penyakit, diantaranya: bacterial leaf blight, brown spot, dan leaf smut. aplikasi ini dibuat dengan menggunakan artificial intelligent convolusi neural network pada tensorflow lite',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ))
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help_outline_rounded),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Version',
                      style: TextStyle(fontSize: 16),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      '1.0',
                      style: TextStyle(fontSize: 10, color: Colors.black87),
                    ))
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.error_outline_outlined),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Copyright',
                      style: TextStyle(fontSize: 16),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      '© since 2022 Paddy Leaf Disease',
                      style: TextStyle(fontSize: 10, color: Colors.black87),
                    ))
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person_outline_rounded),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Programmer',
                      style: TextStyle(fontSize: 16),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Alwiwahyudi8@gmail.com',
                      style: TextStyle(fontSize: 10, color: Colors.black87),
                    ))
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.work_outline_outlined),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Library')),
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Product By Flutter Framework',
                      style: TextStyle(fontSize: 10, color: Colors.black87),
                    ))
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
