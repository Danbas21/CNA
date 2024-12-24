import 'package:cna/contenido.dart';
import 'package:cna/footer.dart';
import 'package:cna/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromRGBO(165, 127, 44, 1),
            surface: Colors.white),
        primaryColor: const Color.fromRGBO(165, 127, 44, 1),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.black87,
            child: const SafeArea(
              child: Column(
                children: [
                  CustomNavigationBar(),
                  SubNavigationBar(),
                ],
              ),
            ),
          ),

          Row(
            children: [
              Container(
                width: 250,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: const ArrowContainer(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  width: 50,
                  color: Color.fromRGBO(98, 17, 50, 1),
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      Text(
                        'Publicaciones Recientes',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // S
              Container(
                width: 1200,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: const NewsMarquee(),
              ),
            ],
          ),
          // Main content
          Container(
            color: Colors.white,
            child: const Contain(),
          ),
          Expanded(child: SearchBarFraude()),

          Container(
            color: Colors.black87,
            child: const SafeArea(
              child: FooterSection(),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      color: const Color.fromRGBO(98, 17, 50, 1),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          // Logo
          IconButton(
            icon: SvgPicture.asset(
              'assets/logo_blanco.svg',
              fit: BoxFit.contain,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          const Spacer(),
          // Menú principal
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/tramites');
            },
            child: const Text(
              'Trámites',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/gobierno');
            },
            child: const Text(
              'Gobierno',
              style: TextStyle(color: Colors.white),
            ),
          ),
          // Botón de búsqueda
          IconButton(
            icon: Image.network(
              'https://framework-gb.cdn.gob.mx/landing/img/lupa.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              // Implementar búsqueda
            },
          ),
        ],
      ),
    );
  }
}

class SubNavigationBar extends StatelessWidget {
  const SubNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: const BoxDecoration(
        color: const Color.fromRGBO(165, 127, 44, 1),
        border: Border(
          top: BorderSide(
            color: const Color.fromRGBO(165, 127, 44, 1),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildNavButton(
                    'Prensa',
                    '/profeco/esRecomendaciones/archivo/prensa',
                    context,
                  ),
                  _buildNavButton(
                    'Acciones y programas',
                    '/profeco/esRecomendaciones/archivo/acciones_y_programas',
                    context,
                  ),
                  _buildNavButton(
                    'Contacto',
                    '/profeco/esRecomendaciones/#2240',
                    context,
                  ),
                  _buildNavButton(
                    'Protección de Datos Personales',
                    'https://www.gob.mx/profeco/acciones-y-programas/proteccion-de-datos-personales-271598',
                    context,
                  ),
                  _buildNavButton(
                    'Transparencia',
                    'https://www.profeco.gob.mx/transparencia_gob/transparencia.html',
                    context,
                  ),
                  _buildNavButton(
                    'Folio de Queja',
                    'https://www.profeco.gob.mx/transparencia_gob/transparencia.html',
                    context,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String title, String route, BuildContext context) {
    return TextButton(
      onPressed: () {
        if (route.startsWith('http')) {
          // Implementar url_launcher aquí
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}

class NewsMarquee extends StatefulWidget {
  const NewsMarquee({super.key});

  @override
  State<NewsMarquee> createState() => _NewsMarqueeState();
}

class _NewsMarqueeState extends State<NewsMarquee> {
  final ScrollController _scrollController = ScrollController();

  final List<NewsItem> newsItems = [
    NewsItem(
      date: DateTime.parse("2024-12-01 08:30:00"),
      title: "Revista del Consumidor",
      link: "/profeco/es/articulos/revista-del-consumidor",
    ),
    NewsItem(
      date: DateTime.parse("2024-11-05 08:00:00"),
      title: "Consejos y recomendaciones para comprar en línea",
      link:
          "/profeco/es/articulos/consejos-y-recomendaciones-para-comprar-en-linea",
    ),
    NewsItem(
      date: DateTime.parse("2024-08-16 00:51:00"),
      title: "Conoce diferentes medidas de seguridad y protegete",
      link:
          "/profeco/es/articulos/conoce-diferentes-medidas-de-seguridad-y-protege-tus-redes-maya-373885",
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_scrollController.hasClients) {
        final double maxScrollExtent =
            _scrollController.position.maxScrollExtent;
        final double currentPosition = _scrollController.position.pixels;

        if (currentPosition >= maxScrollExtent) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            currentPosition + 100, // Ajustado para scroll horizontal
            duration: const Duration(milliseconds: 200),
            curve: Curves.linearToEaseOut,
          );
        }
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, // Altura reducida para el marquee horizontal
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: newsItems.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: 900, // Ancho fijo para cada noticia
                  child: Row(
                    children: [
                      // Botón Nuevo
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          minimumSize: const Size(0, 0),
                          textStyle: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                        child: const Text(
                          'Nuevo',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Contenido de la noticia
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 12,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            DateFormat('yyyy-MM-dd HH:mm:ss')
                                .format(newsItems[index].date),
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            newsItems[index].title,
                            style: const TextStyle(
                                color: Colors.black,
                                letterSpacing: 4.5,
                                decoration: TextDecoration.underline,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NewsItem {
  final DateTime date;
  final String title;
  final String link;

  NewsItem({
    required this.date,
    required this.title,
    required this.link,
  });
}

class ArrowContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double width;
  final Color color;

  const ArrowContainer({
    super.key,
    required this.child,
    required this.padding,
    required this.width,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, 50), // Altura fija; ajusta según lo necesario
      painter: ArrowPainter(color: color),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  final Color color;

  ArrowPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    // Define el camino de la forma
    final path = Path()
      ..moveTo(0, 0) // Esquina superior izquierda
      ..lineTo(size.width - 50,
          0) // Hasta el lado superior menos la punta de la flecha
      ..lineTo(size.width, size.height / 2) // Punta de la flecha
      ..lineTo(size.width - 50,
          size.height) // Hasta el lado inferior menos la punta de la flecha
      ..lineTo(0, size.height) // Esquina inferior izquierda
      ..close(); // Cierra el camino

    // Dibuja el camino en el canvas
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
