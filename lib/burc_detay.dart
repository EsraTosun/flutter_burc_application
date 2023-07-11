import 'package:flutter/material.dart';
import 'package:flutter_burclar/model/burc.dart';
import 'package:palette_generator/palette_generator.dart';

class BurcDetay extends StatefulWidget {
  final Burc secilenBurc;
  const BurcDetay({required this.secilenBurc, Key? key}) : super(key: key);

  @override
  State<BurcDetay> createState() => _BurcDetayState();
}

class _BurcDetayState extends State<BurcDetay> {

  Color appbarRengi = Colors.transparent;
  late PaletteGenerator _generator;

  //Ekrana gelmeden önce çalışır.
  // Sonra istediğin kadar çalıştırma imkanın var
  @override
  void initState() {
    super.initState();
    print('init state çalıştı');
    WidgetsBinding.instance
      .addPostFrameCallback((_) => appbarRenginiBul() );
    // _generator = PaletteGenerator.fromImageProvider(AssetImage(assetName));
  }
  // WidgetsBinding.instance =>
  //Build ilk önce çalışsın ondan sonra bu çalışsın demek oluyor
  //Böylece uzun projelerde hata almamış oluruz

  @override
  Widget build(BuildContext context) {
    print('build çalıştı');
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            centerTitle: true,
            backgroundColor: appbarRengi,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.secilenBurc.burcAdi + "Burcu ve Özellikleri"),
              background: Image.asset(
                  'images/'+widget.secilenBurc.burcBuyukResim,
                  fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Text(
                    widget.secilenBurc.burcDetayi,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void appbarRenginiBul() async{
    print('build bitti baskın renk bulunacak');
    _generator = await PaletteGenerator.fromImageProvider(
      AssetImage('images/${widget.secilenBurc.burcBuyukResim}')
    );
    appbarRengi = _generator.dominantColor!.color;
    print('baskın renk bulundu build metodu tekrar çalıştırılacak');
    setState(() {  //build methodunu tekrar tetikler ve tekrar çalışır.
    });
    print(appbarRengi);
  }
}


//async ve await kullanma nedenimiz;
//Uygulama çalıştığında bu değer olmadığı için
//bir kaç saniye sonra geleceği için kullnılır
