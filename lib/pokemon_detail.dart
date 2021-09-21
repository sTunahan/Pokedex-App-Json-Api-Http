///1. pokedex.dart da olusturulan pokemon class ından bır nesne olsuturduk.
///2. Detail sayfası acılırken bır parametre aldırdık Pokemon olmak zorunda dedık.
///3.Type bızım jsonda ayrı bır list olarak tutulmus ona ulasma seklımızı row un ıcınde gosterıyoruz.
///4.NextEvulotion  (gelecek sevıyesi) göstermek için  bir koşul yazcaz cunku pokemon son evredeyse bu gozukmemesı lazım.
///5.Line 63 de .toList():[Text("SonHali")]   text i Array e aldık cunku  row da bı lıst dondurduk  ancak ondan sonra gelecek wıdget lıst ıcınde degıl onu array a almamız lazım
///
///
import 'package:flutter/material.dart';
import 'package:pokedex/model/pokedex.dart';

class PokemonDetail extends StatelessWidget {
  late Pokemon pokemon; //pokedex.dart ıcındekı class

  PokemonDetail({required this.pokemon});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(pokemon.name),
      ),
      body: Stack(children: [
        Positioned(
          width: size.width * 0.8,
          height: size.height * 0.65,
          left: size.width / 11,
          top: size.height * 0.1,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Text(pokemon.name),
                Text("heigth:" + pokemon.height),
                Text("weidth:" + pokemon.weight),
                Text("Types"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  ///şimdi burada bana bır list gelcek (types) yanı bunları ben tektek widgetlarla ele almak ıstıyorum VE bu widgetlar  (Cip 'ler) o yuzden map kullancaz
                  children: pokemon.type!
                      .map((tip) => Chip(
                          backgroundColor: Colors.brown.shade200,
                          label: Text(tip)))
                      .toList(),
                ),
                Text("Pre Evolution"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  ///şimdi burada bana bır list gelcek (types) yanı bunları ben tektek widgetlarla ele almak ıstıyorum VE bu widgetlar  (Cip 'ler) o yuzden map kullancaz
                  children: pokemon.prevEvolution != null
                      ? pokemon.prevEvolution!
                          .map((preevolution) => Chip(
                              backgroundColor: Colors.brown.shade200,
                              label: Text(preevolution.name.toString())))
                          .toList()
                      : [Text("İlk Hali")],
                ),
                Text("Next Evolution"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  ///şimdi burada bana bır list gelcek (types) yanı bunları ben tektek widgetlarla ele almak ıstıyorum VE bu widgetlar  (Cip 'ler) o yuzden map kullancaz
                  children: pokemon.nextEvolution != null
                      ? pokemon.nextEvolution!
                          .map((evolution) => Chip(
                              backgroundColor: Colors.brown.shade200,
                              label: Text(evolution.name.toString())))
                          .toList()
                      : [Text("SonHali")],
                ),
                Text("weakness"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  ///şimdi burada bana bır list gelcek (types) yanı bunları ben tektek widgetlarla ele almak ıstıyorum VE bu widgetlar  (Cip 'ler) o yuzden map kullancaz
                  children: pokemon.weaknesses != null
                      ? pokemon.weaknesses!
                          .map((weakness) => Chip(
                              backgroundColor: Colors.brown.shade200,
                              label: Text(weakness.toString())))
                          .toList()
                      : [Text("Zayıflığı yok")],
                )
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img,
              child: Container(
                width: size.width * 0.4,
                height: size.height * 0.2,
                child: Image.network(pokemon.img),
              ),
            )),
      ]),
    );
  }
}
