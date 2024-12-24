import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(98, 17, 50, 1),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo Section
              Expanded(
                child: SvgPicture.asset(
                  'assets/logo_blanco.svg',
                  fit: BoxFit.contain,
                  width: 200,
                ),
              ),
              // Links Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enlaces',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...[
                      {'text': 'Datos', 'url': 'https://datos.gob.mx/'},
                      {
                        'text': 'Publicaciones',
                        'url': 'https://www.gob.mx/publicaciones'
                      },
                      {
                        'text': 'Portal de Obligaciones de Transparencia',
                        'url':
                            'https://www.profeco.gob.mx/transparencia_gob/transparencia.html'
                      },
                      {
                        'text': 'PNT',
                        'url':
                            'https://www.infomex.org.mx/gobiernofederal/home.action'
                      },
                      {'text': 'INAI', 'url': 'http://www.inai.org.mx/'},
                      {
                        'text': 'Alerta',
                        'url': 'http://alertadores.funcionpublica.gob.mx/'
                      },
                      {
                        'text': 'Denuncia',
                        'url': 'http://sidec.funcionpublica.gob.mx/'
                      },
                    ].map((link) {
                      return InkWell(
                        onTap: () {
                          // Acción para abrir URL
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            link['text']!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              // What is Gob.mx Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '¿Qué es gob.mx?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Es el portal único de trámites, información y participación ciudadana.',
                    ),
                    InkWell(
                      onTap: () {
                        // Acción para abrir URL
                      },
                      child: const Text(
                        'Leer más',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...[
                      {
                        'text': 'Declaración de Accesibilidad',
                        'url': '/accesibilidad'
                      },
                      {
                        'text': 'Aviso de privacidad',
                        'url': '/privacidadintegral'
                      },
                      {
                        'text': 'Aviso de privacidad simplificado',
                        'url': '/privacidadsimplificado'
                      },
                      {'text': 'Términos y Condiciones', 'url': '/terminos'},
                      {
                        'text': 'Política de seguridad',
                        'url': '/terminos#medidas-seguridad-informacion'
                      },
                      {
                        'text': 'Marco jurídico',
                        'url': 'http://www.ordenjuridico.gob.mx'
                      },
                      {'text': 'Mapa de sitio', 'url': '/sitemap'},
                    ].map((link) {
                      return InkWell(
                        onTap: () {
                          // Acción para abrir URL
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            link['text']!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              // Contact Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contacto',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Acción para abrir URL
                      },
                      child: const Text(
                        'Dudas e información a dudasportal@profeco.gob.mx',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Síguenos en',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        _buildSocialIcon(
                          FontAwesomeIcons.facebook,
                          'https://www.facebook.com/profile.php?id=61571028842345',
                        ),
                        _buildSocialIcon(
                          FontAwesomeIcons.twitter,
                          'https://twitter.com/ccxxx',
                        ),
                        _buildSocialIcon(
                          FontAwesomeIcons.instagram,
                          'https://www.instagram',
                        ),
                        _buildSocialIcon(
                          FontAwesomeIcons.youtube,
                          'https://www.youtube.com',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData name, String url) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
          onTap: () {
            url;
          },
          child: Icon(name, size: 30, color: Colors.white)),
    );
  }
}
