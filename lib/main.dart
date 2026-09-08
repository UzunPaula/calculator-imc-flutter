import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // transmite cheia widgetului către clasa părinte.

  @override
  Widget build(BuildContext context) { //construiește interfața grafică a widgetului.
    return const MaterialApp(
      debugShowCheckedModeBanner: false, //elimină eticheta DEBUG din colțul aplicației.
      home: CalculatorIMC(), //stabilește pagina care apare prima.
    );
  }
}

class CalculatorIMC extends StatefulWidget {
  const CalculatorIMC({super.key}); //constructorul clasei

  @override
  State<CalculatorIMC> createState() => _CalculatorIMCState();
}

//Aceste obiecte(greutate, inaltime) permit aplicației să citească textul introdus în TextField
class _CalculatorIMCState extends State<CalculatorIMC> {
  final greutate = TextEditingController();
  final inaltime = TextEditingController();

  double imc = 0;
  String categorie = '';

  void calculeaza() {
    double? kg = double.tryParse(greutate.text);
    double? cm = double.tryParse(inaltime.text);

    if (kg == null || cm == null || kg <= 0 || cm <= 0) {
      setState(() {
        imc = 0;
        categorie = 'Introdu valori corecte';
      });
      return;
    }

    double metri = cm / 100;
    double rezultat = kg / (metri * metri);

    //După apăsarea butonului, valorile se schimbă. Aplicația trebuie apoi să actualizeze interfața.
    setState(() {
      imc = rezultat;

      if (imc < 18.5) {
        categorie = 'Subponderal';
      } else if (imc < 25) {
        categorie = 'Greutate normală';
      } else if (imc < 30) {
        categorie = 'Supraponderal';
      } else {
        categorie = 'Obezitate';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F5),

      appBar: AppBar(
        backgroundColor: const Color(0xFF183153),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Calculator IMC'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [
            const SizedBox(height: 20),

            const Icon(
              Icons.monitor_weight_outlined,
              size: 70,
              color: Color(0xFF2A9D8F),
            ),

            const SizedBox(height: 10),

            const Text(
              'Verifică indicele tău de masă corporală',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF183153),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: greutate,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Greutate (kg)',
                prefixIcon: const Icon(Icons.fitness_center), //afișează iconița în partea stângă.
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: inaltime,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Înălțime (cm)',
                prefixIcon: const Icon(Icons.height),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: calculeaza,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE76F51),
                  foregroundColor: Colors.white,
                ),

                child: const Text(
                  'CALCULEAZĂ',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 25),

            //Containerul cu rezultatul apare doar dacă categorie nu este goală.
            if (categorie.isNotEmpty)
              Container( //afișam rezultatul într-o zonă separată.
                width: double.infinity,
                padding: const EdgeInsets.all(20), //creează spațiu interior de 20 pixeli.

                decoration: BoxDecoration(
                  color: const Color(0xFFD8F3DC),
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Column(
                  children: [ //lista de widgeturi pe care Column le conține.
                    if (imc > 0)
                      Text(
                        'IMC: ${imc.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF183153),
                        ),
                      ),

                    const SizedBox(height: 5),

                    Text(
                      categorie,
                      style: const TextStyle(
                        fontSize: 19,
                        color: Color(0xFF2A9D8F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}