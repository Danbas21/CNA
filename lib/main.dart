import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(165, 127, 44, 1),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header section with navigation bars and news
          Container(
            color: Colors.black87, // Color para las barras de navegación
            child: const SafeArea(
              child: Column(
                children: [
                  CustomNavigationBar(),
                  SubNavigationBar(),
                ],
              ),
            ),
          ),
          // News section with different background color
          Container(
            width: 800,
            color: const Color.fromRGBO(165, 127, 44, 1),
            child: const NewsMarquee(),
          ),
          // Main content
          const Expanded(
            child: ColoredBox(
              color: Colors.white,
              child: Center(
                child: Text('Contenido Principal'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

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
  const SubNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
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
  const NewsMarquee({Key? key}) : super(key: key);

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
      title:
          "Conoce diferentes medidas de seguridad y protege tus redes | Maya",
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
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            currentPosition + 200, // Ajustado para scroll horizontal
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
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
      color: const Color.fromRGBO(165, 127, 44, 1),
      child: Row(
        children: [
          // Sección de título fija a la izquierda
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.white, width: 1),
              ),
            ),
            child: Row(
              children: const [
                Icon(Icons.arrow_forward, color: Colors.white),
                SizedBox(width: 5),
                Text(
                  'Publicaciones\nRecientes',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Sección de noticias con scroll horizontal
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: newsItems.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: 300, // Ancho fijo para cada noticia
                  child: Row(
                    children: [
                      // Botón Nuevo
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          minimumSize: const Size(0, 0),
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                        child: const Text('Nuevo'),
                      ),
                      const SizedBox(width: 8),
                      // Contenido de la noticia
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  DateFormat('yyyy-MM-dd HH:mm:ss')
                                      .format(newsItems[index].date),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              newsItems[index].title,
                              style: const TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
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
