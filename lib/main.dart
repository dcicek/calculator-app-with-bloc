import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => hesapCubit()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HesapEkrani(),
      ),
    );
  }
}

class hesapCubit extends Cubit<double>
{
  hesapCubit() : super(0);
  double sonuc=0;

  topla(double sayi)
  {
    sonuc= state+sayi;
    emit(sonuc);
  }
  cikart(double sayi)
  {
    sonuc= state-sayi;
    emit(sonuc);
  }
  carp(double sayi)
  {
    sonuc= state*sayi;
    emit(sonuc);
  }
  bol(double sayi)
  {
    sonuc= state/sayi;
    emit(sonuc);
  }

  temizle()
  {
    emit(0);
  }
}

class HesapEkrani extends StatefulWidget {
  HesapEkrani({Key? key}) : super(key: key);


  @override
  State<HesapEkrani> createState() => _HesapEkraniState();
}

class _HesapEkraniState extends State<HesapEkrani> {

  TextEditingController sayiController= TextEditingController();

  temizle()
  {
    setState(() {
      sayiController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Hesap Makinesi"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: TextFormField(

                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: sayiController,
                      decoration: InputDecoration(
                        labelText: "Sayı giriniz",
                        labelStyle: TextStyle(
                          color: Colors.green
                        ),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                      ),

                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    context.read<hesapCubit>().topla(double.parse(sayiController.text));
                  },
                  child: Container(
                    color: Colors.redAccent,
                    width: MediaQuery.of(context).size.width*0.5,
                    height: 100,
                    child: Center(
                      child: Text(
                        "+",
                        style: TextStyle(
                          fontSize: 50
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    context.read<hesapCubit>().cikart(double.parse(sayiController.text));
                  },
                  child: Container(
                    color: Colors.greenAccent,
                    width: MediaQuery.of(context).size.width*0.5,
                    height: 100,
                    child: Center(
                      child: Text(
                        "-",
                        style: TextStyle(
                            fontSize: 50
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    context.read<hesapCubit>().carp(double.parse(sayiController.text));
                  },
                  child: Container(
                    color: Colors.deepPurpleAccent,
                    width: MediaQuery.of(context).size.width*0.5,
                    height: 100,
                    child: Center(
                      child: Text(
                        "x",
                        style: TextStyle(
                            fontSize: 45
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    context.read<hesapCubit>().bol(double.parse(sayiController.text));
                  },
                  child: Container(
                    color: Colors.yellowAccent,
                    width: MediaQuery.of(context).size.width*0.5,
                    height: 100,
                    child: Center(
                      child: Text(
                        "/",
                        style: TextStyle(
                            fontSize: 45
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    context.read<hesapCubit>().temizle();
                  },
                  child: Container(
                    color: Colors.cyan,
                    width: MediaQuery.of(context).size.width*0.5,
                    height: 50,
                    child: Center(
                      child: Text(
                        "TEMİZLE",
                        style: TextStyle(
                            fontSize: 30
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0,25,0,10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sonuç: ", style: TextStyle(fontSize: 20)),

                  BlocBuilder<hesapCubit,double>(
                      builder: (context,hesapSonucu)
                          {
                            return Text("$hesapSonucu", style: TextStyle(fontSize: 20));
                          }
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
