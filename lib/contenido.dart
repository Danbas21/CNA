import 'package:flutter/material.dart';

class Contain extends StatelessWidget {
  const Contain({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Campaña Nacional Antifraude\nCibernético',
          style: TextStyle(
            fontSize: 70,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'Se busca empoderar a los consumidores\npara prevenir los fraudes cibernéticos.\nConoce este esfuerzo en pro de la economía familiar.',
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
        Column(
          children: [
            Image.asset(
              'assets/image1.jpg',
              width: 900,
              height: 500,
              fit: BoxFit.cover,
            ),
            const Text(
              'Campaña Nacional Antifraude Cibernético',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
