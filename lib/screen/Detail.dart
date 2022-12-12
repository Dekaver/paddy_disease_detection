import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paddy_disease_detection/model/entity/prediction.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';
  final Prediction prediction;
  const DetailPage({Key? key, required this.prediction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(5),
        children: [
          Container(
            width: 300,
            child: Image.memory(
              const Base64Decoder().convert(prediction.image),
              fit: BoxFit.cover,
            ),
          ),
          const Text(
            "Prediction",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Container(
            child: Row(
              children: [
                const SizedBox(
                    width: 100,
                    child: Text(
                      "That Image is: ",
                      style: TextStyle(fontSize: 18),
                    )),
                SizedBox(
                    width: 100,
                    child: Text(
                      prediction.category,
                      style: const TextStyle(fontSize: 18),
                    )),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                const SizedBox(
                    width: 100,
                    child: Text(
                      "Score: ",
                      style: TextStyle(fontSize: 18),
                    )),
                SizedBox(
                    width: 100,
                    child: Text(
                      prediction.score.toString(),
                      style: const TextStyle(fontSize: 18),
                    )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                const SizedBox(
                    width: 100,
                    child: Text(
                      "Time: ",
                      style: TextStyle(fontSize: 18),
                    )),
                SizedBox(
                    width: 100,
                    child: Text(
                      prediction.time.toString(),
                      style: const TextStyle(fontSize: 18),
                    )),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(
                  style: const TextStyle(
                    fontSize: 27,
                  ),
                  children: [
                    TextSpan(
                      text: "Apa itu: " + prediction.category,
                      style:
                          const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ])),
              RichText(
                  textAlign: TextAlign.justify,
                  text: prediction.category == "Brown spot"
                      ? const TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            
                          ),
                          text:
                              "Bintik-bintik coklat (Brown Spot) pada padi dapat dimulai bahkan pada daun semai dan biasanya kecil, lingkaran bulat hingga lonjong, berwarna kecoklatan. Ini adalah masalah jamur yang disebabkan oleh Bipolaris oryzae (sebelumnya dikenal sebagai Helminthosporium oryzae). Saat tanaman tumbuh, bercak daun dapat berubah warna dan bervariasi dalam bentuk dan ukuran, tetapi biasanya berbentuk bulat. Bintik-bintik sering berwarna merah kecoklatan seiring berjalannya waktu tetapi biasanya dimulai hanya sebagai bercak coklat. Bintik-bintik juga muncul di lambung dan pelepah daun. Bintik-bintik yang lebih tua mungkin dikelilingi oleh halo kuning cerah. Jangan bingung dengan lesi penyakit blas, yang berbentuk berlian, tidak bulat, dan membutuhkan perawatan yang berbeda. Akhirnya, biji padi terinfeksi, menghasilkan hasil yang minimal. Kualitas juga terpengaruh. Ketika glume dan cabang malai terinfeksi, mereka sering menunjukkan perubahan warna menjadi hitam. Ini adalah saat biji menjadi paling tipis atau berkapur, tidak terisi dengan benar dan hasil panen sangat berkurang.")
                      : (prediction.category == "Leaf smut"
                          ? const TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              text:
                                  "Penyebab penyakit luka bakar (Leaf smut) daun padi adalah jamur yang disebut Entyloma oryzae. Untungnya untuk taman Anda, jika Anda melihat tanda-tandanya, infeksi ini biasanya ringan. Ini tersebar luas di tempat padi ditanam, tetapi gosong daun tidak sering menyebabkan kerusakan serius. Namun penyakit gosong daun dapat membuat padi Anda rentan terhadap penyakit lain, dan pada akhirnya dapat menyebabkan penurunan hasil.")
                          : const TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              text:
                                  "Penyakit hawar daun bakteri (Bacterial Leaf Blight) pada padi merupakan penyakit bakteri perusak yang pertama kali diamati pada tahun 1884-1885 di Jepang. Penyakit ini disebabkan oleh bakteri Xanthomonas oryzae pv. oryzae. Ini hadir di daerah penanaman padi di Asia, Afrika, Australia, Amerika Latin dan Karibia dan sangat jarang di Amerika Serikat (Texas)"))),
              Text.rich(TextSpan(
                  style: const TextStyle(
                    fontSize: 27,
                  ),
                  children: [
                    TextSpan(
                      text: "Penanganan: " + prediction.category,
                      style:
                          const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ])),
              RichText(
                  textAlign: TextAlign.justify,
                  text: prediction.category == "Brown spot"
                      ? const TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            
                          ),
                          text:
                              "Penyakit ini berkembang terutama di daerah dengan kelembaban tinggi dan pada tanaman yang ditanam di tanah yang kekurangan unsur hara. Infeksi ini terjadi ketika daun tetap basah selama 8 hingga 24 jam. Ini paling sering terjadi ketika tanaman ditanam dari benih yang terinfeksi atau pada tanaman sukarela, dan ketika ada gulma atau puing-puing dari tanaman sebelumnya. Praktikkan sanitasi yang baik di lahan Anda untuk membantu menghindari bercak daun coklat pada padi dan menanam varietas yang tahan penyakit. Anda juga dapat menyuburkan tanaman, meskipun ini membutuhkan beberapa musim tanam untuk bekerja sepenuhnya. Anda bisa merendam benih sebelum menanam untuk membatasi penyakit jamur. Rendam dalam air panas 10 hingga 12 menit atau dalam air dingin selama delapan jam semalam. Perlakukan benih dengan fungisida jika Anda mengalami masalah dengan padi dengan bercak daun coklat.")
                      : (prediction.category == "Leaf smut"
                          ? const TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              text:
                                  "Penanganan dan Pencegahan Penyakit Goresan Daun Padi Pada sebagian besar situasi, tidak ada kerugian besar yang disebabkan oleh penyakit gosong daun padi, sehingga pengobatan biasanya tidak diberikan. Namun, sebaiknya gunakan praktik manajemen umum yang baik untuk mencegah infeksi atau mengendalikannya, dan menjaga tanaman tetap sehat secara keseluruhan. Seperti banyak infeksi jamur lainnya, yang satu ini disebarkan oleh bahan tanaman yang terinfeksi di dalam tanah. Ketika daun yang sehat bersentuhan dengan air atau tanah dengan daun tua yang sakit, mereka dapat terinfeksi. Membersihkan puing-puing pada akhir setiap musim tanam dapat mencegah penyebaran gosong daun. Menjaga keseimbangan nutrisi yang baik juga penting, karena kadar nitrogen yang tinggi meningkatkan timbulnya penyakit. Terakhir, jika gosong daun menjadi masalah di area tanam Anda, pertimbangkan untuk menggunakan varietas padi yang memiliki ketahanan tertentu.")
                          : const TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              text:
                                  "Bakteri tumbuh subur di lingkungan yang hangat dan lembab dan dipupuk oleh curah hujan yang tinggi dikombinasikan dengan angin, dimana ia memasuki daun melalui jaringan yang terluka. Selanjutnya, ia bergerak melalui air yang tergenang dari tanaman padi ke akar dan daun tanaman tetangga. Tanaman yang banyak dipupuk dengan nitrogen adalah yang paling rentan. Metode pengendalian yang paling murah dan paling efektif adalah menanam kultivar tahan. Jika tidak, batasi dan seimbangkan jumlah pupuk nitrogen, pastikan drainase yang baik di lahan, praktikkan sanitasi yang baik dengan menghilangkan gulma dan membajak di bawah tunggul dan detritus padi lainnya, dan biarkan lahan mengering di antara penanaman."))),
              RichText(
                  textAlign: TextAlign.justify,
                  text: prediction.category == "Brown spot"
                      ?  TextSpan(
                        children:[
                          TextSpan(text: "Baca lebih lanjut di Berkebun Ketahui Caranya: Apa Itu Bintik Daun Coklat – Mengobati Bintik Coklat Pada Tanaman Padi"),
                          TextSpan(
                               style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                               //make link blue and underline
                               text: "disini",
                               recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                      //on tap code here, you can navigate to other page or URL
                                      var urllaunchable = await canLaunchUrl(Uri(
                                          scheme: 'https',
                                          host: 'www.gardeningknowhow.com',
                                          path:
                                              'edible/grains/rice/treating-rice-brown-leaf-spot.htm')); //canLaunch is from url_launcher package
                                      // if(urllaunchable){
                                          await launchUrl(Uri(
                                            scheme: 'https',
                                            host: 'www.gardeningknowhow.com',
                                            path:
                                                'edible/grains/rice/treating-rice-brown-leaf-spot.htm')); //launch is from url_launcher package to launch URL
                                      // }else{
                                      //   print("URL can't be launched.");
                                      // }
                                  }
                            ),
                        ],
                        
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            
                          ),
                          text:
                              " https://www.gardeningknowhow.com/edible/grains/rice/treating-rice-brown-leaf-spot.htm")
                      : (prediction.category == "Leaf smut"
                          ? const TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              text:
                                  "Baca lebih lanjut di Berkebun Ketahui Caranya: Info Jerokan Daun Padi – Cara Mengobati Jerohan Daun Tanaman Padi https://www.gardeningknowhow.com/edible/grains/rice/how-to-treat-leaf-smut-of-rice. htm")
                          : const TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              text:
                                  "Baca lebih lanjut di Berkebun Ketahui Caranya: Pengendalian Hawar Daun Bakteri Padi: Mengobati Padi Dengan Penyakit Hawar Daun Bakteri https://www.gardeningknowhow.com/edible/grains/rice/rice-with-bacterial-leaf-blight-disease.htm"))),
            ],
            
          ),
          
        ],
      ),
    );
  }
}

class DetailScreenArguments {
  final Prediction prediction;

  DetailScreenArguments({required this.prediction});
}
