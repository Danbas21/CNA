import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatefulWidget {
  const FooterSection({super.key});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 800;

        if (isDesktop) {
          return Container(
            color: const Color.fromRGBO(98, 17, 50, 1),
            padding: const EdgeInsets.all(16.0),
            child: _buildDesktopLayout(),
          );
        }

        return GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              // Deslizamiento hacia arriba
              if (!_isExpanded) _toggleExpanded();
            } else if (details.primaryVelocity! > 0) {
              // Deslizamiento hacia abajo
              if (_isExpanded) _toggleExpanded();
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Indicador de deslizamiento
              Container(
                color: const Color.fromRGBO(98, 17, 50, 1),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        'assets/logo_blanco.svg',
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white,
                      size: 24,
                    ),
                    const Text(
                      'Desliza para ver más',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Contenido expandible
              SizeTransition(
                sizeFactor: _animation,
                child: Container(
                  color: const Color.fromRGBO(98, 17, 50, 1),
                  padding: const EdgeInsets.all(12.0),
                  child: _buildMobileLayout(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SvgPicture.asset(
                'assets/logo_blanco.svg',
                fit: BoxFit.contain,
                width: 200,
              ),
            ),
            Expanded(child: _buildLinksSection()),
            Expanded(child: _buildGobSection()),
            Expanded(child: _buildContactSection()),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionTile(
          title: const Text(
            'Enlaces',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          children: [_buildLinksSection()],
        ),
        ExpansionTile(
          title: const Text(
            '¿Qué es gob.mx?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          children: [_buildGobSection()],
        ),
        ExpansionTile(
          title: const Text(
            'Contacto',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          children: [_buildContactSection()],
        ),
      ],
    );
  }

  Widget _buildLinksSection() {
    final links = [
      {'text': 'Datos', 'url': 'https://datos.gob.mx/'},
      {'text': 'Publicaciones', 'url': 'https://www.gob.mx/publicaciones'},
      {
        'text': 'Portal de Obligaciones de Transparencia',
        'url': 'https://www.profeco.gob.mx/transparencia_gob/transparencia.html'
      },
      {
        'text': 'PNT',
        'url': 'https://www.infomex.org.mx/gobiernofederal/home.action'
      },
      {'text': 'INAI', 'url': 'http://www.inai.org.mx/'},
      {'text': 'Alerta', 'url': 'http://alertadores.funcionpublica.gob.mx/'},
      {'text': 'Denuncia', 'url': 'http://sidec.funcionpublica.gob.mx/'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...links.map((link) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: InkWell(
                onTap: () => _launchURL(link['url']!),
                child: Text(
                  link['text']!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildGobSection() {
    final links = [
      {'text': 'Declaración de Accesibilidad', 'url': '/accesibilidad'},
      {'text': 'Aviso de privacidad', 'url': '/privacidadintegral'},
      {
        'text': 'Aviso de privacidad simplificado',
        'url': '/privacidadsimplificado'
      },
      {'text': 'Términos y Condiciones', 'url': '/terminos'},
      {
        'text': 'Política de seguridad',
        'url': '/terminos#medidas-seguridad-informacion'
      },
      {'text': 'Marco jurídico', 'url': 'http://www.ordenjuridico.gob.mx'},
      {'text': 'Mapa de sitio', 'url': '/sitemap'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Es el portal único de trámites, información y participación ciudadana.',
          style: TextStyle(color: Colors.white),
        ),
        InkWell(
          onTap: () => _launchURL('https://www.gob.mx/que-es-gobmx'),
          child: const Text(
            'Leer más',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: InkWell(
                onTap: () => _launchURL(link['url']!),
                child: Text(
                  link['text']!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => _launchURL('mailto:kioskodigitalcna@gmail.com'),
          child: const Text(
            'Dudas e información a kioskodigitalcna@gmail.com',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Síguenos en\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
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
              'https://www.instagram.com/cnaofficial1/',
            ),
            _buildSocialIcon(
              FontAwesomeIcons.youtube,
              'https://www.youtube.com',
            ),
            _buildSocialIcon(
                FontAwesomeIcons.whatsapp, 'https://wa.me/525532432264'),
          ],
        ),
      ],
    );
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'No se pudo abrir $urlString';
      }
    } catch (e) {
      debugPrint('Error al abrir URL: $e');
    }
  }

  Widget _buildSocialIcon(IconData name, String urlString) {
    return InkWell(
      onTap: () => _launchURL(urlString),
      child: Icon(name, size: 30, color: Colors.white),
    );
  }
}
