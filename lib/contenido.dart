import 'package:flutter/material.dart';

class Contain extends StatelessWidget {
  const Contain({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isDesktop = constraints.maxWidth > 600;
      return Column(
        children: [
          Text(
            'Campaña Nacional Antifraude\nCibernético',
            style: TextStyle(
              fontSize: isDesktop ? 60 : 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Se busca empoderar a los consumidores\npara prevenir los fraudes cibernéticos.\nConoce este esfuerzo en pro de la economía familiar.',
            style: TextStyle(
              fontSize: isDesktop ? 30 : 20,
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
              Text(
                'Campaña Nacional Antifraude Cibernético',
                style: TextStyle(
                  fontSize: isDesktop ? 30 : 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
