///1. ilk basta pokedex.dart da Json larımızı oluşturduk.
///2. Pokedex nesnesi olusturduk
///3.  future donduren bır fonksıyon olusturduk  Pokedex turunde
///4. http.get  ile alıp bır degıskene atadık (response)
///5. json.decode ile gelen json ı okuduk. map 'e donusturduk
///6. Pokedex nesnemize  isimli constructor verdık  böylelıkle ıcınde pokemon lıstesı bir nesne olusturduk.
///7. FutureBuılder da bir kontrol yaptırdık if - else if - else  olarak
///8. gelenPodedex.data!.pokemon!.map((poke) yaparak herbır listedeki pokemonu poke ile gezdedik ve bu poke ilede resim veya baska ozellıklerını cagırdık
///9.Ontap yaparak kullanıcıyı Detail sayfasına göndereceğiz.
///
///    *******************              ÖNEMLİ                *******************************************
///10. Şimdi her detay sayfasına gidip geldigimde build ediliyor hızlılık için initstate kullanırız. İnitstate ilk açtıgımızda tetiklenir
///    ondan sonra calısmaz. Ondan dolayı   "Future<pokedex> veri " adında bir degısken olustururum.İnitstate dede  bu degıskene
///    pokemonlarıGetir Fonksiyonunu  veririm.Bunu yaparak herzaman buıld edılmıycek dolayısıyla her seferınde ınternetten cekmıycez verıyı.
///11. Telefon yan cevrılınce ekranı ona göre ayarlamak ıcın  bir kosul olusturcaz Body i ilk once bır widget'la(OrientationBuilder) sarmalıycaz.
///12. sarmaladıktan sonra  else yede yatay oldugunda ekranın seklını ayarlama işlemi yaptık." GridView.extend "
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/model/pokedex.dart';
import 'package:pokedex/pokemon_detail.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"; //verilerimi buradan cekıyorum

  late Pokedex pokedex;
  late Future<Pokedex> veri;

  Future<Pokedex> pokemonlariGetir() async {
    var response = await http.get(Uri.parse(url));
    var decodedJson = json.decode(response.body);
    pokedex = Pokedex.fromJson(
        decodedJson); //içinde pokemon listesi olan bir nesneyi oluşturmus olduk

    return pokedex;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veri =
        pokemonlariGetir(); // nolacak burada veri bir kere doldurulacak buıld tekrar tekrar calıssa bıle pokemonlar state edılmıycek
    // dolayısı ile hızlandırmıs olduk uygulamayı.
  }

  @override
  Widget build(BuildContext context) {
    String gif = "assets/loading.gif";
    return Scaffold(
      appBar: AppBar(
        title: Text("PokeDex"),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return FutureBuilder(
              future: veri,
              builder: (context, AsyncSnapshot<Pokedex> gelenPodedex) {
                if (gelenPodedex.connectionState ==
                    ConnectionState
                        .waiting) // yenı daha verı gelmemısse , getırılıyorsa bunu yap
                {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (gelenPodedex.connectionState ==
                    ConnectionState.done) // done = yani artık işlem bittiyse
                {
                  // childrenda   yaptıgımız    bir bir eleman için şunu olustur dedık
                  return GridView.count(
                    crossAxisCount: 2,
                    children: gelenPodedex.data!.pokemon!.map((poke) {
                      //poke pokemon array ını tek tek dolasarak herbır pokemunu gezıyor
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PokemonDetail(pokemon: poke)));
                        },
                        //Hero yaptık cunku tıkladıgımda resım karsı tarafa anımasyonla gıtmesını ıstıyorum.
                        child: Hero(
                            //tag:poke.img,
                            tag: poke.img,
                            child: Card(
                              elevation: 6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //FadeInImage Widget   :  Resım yuklenırken gif oynasın demek ıstedıgımızde  kullanırz.
                                children: [
                                  Container(
                                    width: 250,
                                    height: 150,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/loading.gif',
                                      image: poke.img,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text(poke.name),
                                ],
                              ),
                            )),
                      );
                      ;
                    }).toList(),
                  );
                } else {
                  return Container(); // HATA CIKMASI DURUMU
                }
              },
            );
          } else {
            return FutureBuilder(
              future: veri,
              builder: (context, AsyncSnapshot<Pokedex> gelenPodedex) {
                if (gelenPodedex.connectionState ==
                    ConnectionState
                        .waiting) // yenı daha verı gelmemısse , getırılıyorsa bunu yap
                {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (gelenPodedex.connectionState ==
                    ConnectionState.done) // done = yani artık işlem bittiyse
                {
                  // childrenda   yaptıgımız    bir bir eleman için şunu olustur dedık
                  return GridView.extent(
                    maxCrossAxisExtent: 250,
                    children: gelenPodedex.data!.pokemon!.map((poke) {
                      //poke pokemon array ını tek tek dolasarak herbır pokemunu gezıyor
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PokemonDetail(pokemon: poke)));
                        },
                        //Hero yaptık cunku tıkladıgımda resım karsı tarafa anımasyonla gıtmesını ıstıyorum.
                        child: Hero(
                            //tag:poke.img,
                            tag: poke.img,
                            child: Card(
                              elevation: 6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //FadeInImage Widget   :  Resım yuklenırken gif oynasın demek ıstedıgımızde  kullanırz.
                                children: [
                                  Container(
                                    width: 250,
                                    height: 150,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/loading.gif',
                                      image: poke.img,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text(poke.name),
                                ],
                              ),
                            )),
                      );
                      ;
                    }).toList(),
                  );
                } else {
                  return Container(); // HATA CIKMASI DURUMU
                }
              },
            );
          }
        },
      ),
    );
  }
}
