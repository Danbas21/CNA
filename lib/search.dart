import 'package:flutter/material.dart';

class SearchBarFraude extends StatefulWidget {
  const SearchBarFraude({super.key});

  @override
  SearchBarFraudeState createState() => SearchBarFraudeState();
}

class SearchBarFraudeState extends State<SearchBarFraude> {
  final TextEditingController _searchController = TextEditingController();

  // Lista de empresas fraudulentas
  final List<String> listaFraudes = [
    'APOYO A VÍCTIMAS FINANCIERAS',
    'CENTRO NACIONAL ANTIFRAUDE',
    'CONSIGNACIÓN GUBERNAMENTAL',
    'COORDINACIÓN DE ENLACE GUBERNAMENTAL',
    'ENLACE GUBERNAMENTAL',
    'ENLACE NACIONAL ANTIFRAUDE',
    'INSTITUTO NACIONAL DE APOYO A VÍCTIMAS DE FRAUDE',
    'INVESTIGACIÓN Y PREVENCIÓN DE FRAUDE',
    'ORGANIZACIÓN NACIONAL DE APOYO A VÍCTIMAS DE FRAUDE',
    'ORGANIZACIÓN NACIONAL PARA VÍCTIMAS DE FRAUDE',
    'RED DE APOYO ANTIFRAUDE',
    'SECRETARÍA DE ADMINISTRACIÓN Y FINANZAS',
    'SINDICATO DE TRABAJADORES CONTRA FRAUDES',
    'SISTEMA DE APOYO GUBERNAMENTAL',
    'SISTEMA DE ENLACE GUBERNAMENTAL',
    'SISTEMA NACIONAL ANTIFRAUDE',
    'UNIDAD DE INVESTIGACIÓN Y PREVENCIÓN ANTIFRAUDE',
    'UNIDAD DE INVESTIGACIÓN Y PREVENCIÓN DE FRAUDES',
    'UNIDAD ESPECIALIZADA EN DELITOS FISCALES Y FINANCIEROS',
    'UNIDAD MEXICANA DE INVESTIGACIÓN CONTRA FRAUDE',
    'CONSIGNACIÓN GUBERNAMENTAL'
  ];

  int _calcularDistanciaLevenshtein(String s1, String s2) {
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    List<List<int>> matriz = List.generate(
      s1.length + 1,
      (i) => List.generate(s2.length + 1, (j) => 0),
    );

    for (int i = 0; i <= s1.length; i++) {
      matriz[i][0] = i;
    }
    for (int j = 0; j <= s2.length; j++) {
      matriz[0][j] = j;
    }

    for (int i = 1; i <= s1.length; i++) {
      for (int j = 1; j <= s2.length; j++) {
        int costo = (s1[i - 1] == s2[j - 1]) ? 0 : 1;
        matriz[i][j] = [
          matriz[i - 1][j] + 1,
          matriz[i][j - 1] + 1,
          matriz[i - 1][j - 1] + costo,
        ].reduce((curr, next) => curr < next ? curr : next);
      }
    }

    return matriz[s1.length][s2.length];
  }

// Función auxiliar para calcular el porcentaje de similitud
  double _calcularSimilitud(String s1, String s2) {
    int maxLength = s1.length > s2.length ? s1.length : s2.length;
    int distancia = _calcularDistanciaLevenshtein(s1, s2);
    return ((maxLength - distancia) / maxLength) * 100;
  }

// Función auxiliar para verificar si una cadena contiene todas las palabras de búsqueda
  bool _contieneTodasLasPalabras(String texto, String busqueda) {
    List<String> palabrasBusqueda = busqueda.split(' ');
    return palabrasBusqueda.every((palabra) => texto.split(' ').any(
        (palabraTexto) => _calcularSimilitud(palabra, palabraTexto) >= 80));
  }

  void _realizarBusqueda() {
    String busqueda = _searchController.text.toUpperCase();

    if (busqueda.isEmpty) return;

    // Buscar la mejor coincidencia
    double mejorSimilitud = 0;
    String? mejorCoincidencia;
    bool coincidenciaParcial = false;

    for (String fraude in listaFraudes) {
      // Verificar coincidencia exacta con umbral de similitud
      double similitud = _calcularSimilitud(busqueda, fraude);

      // Verificar si contiene todas las palabras de la búsqueda
      bool contienePalabras = _contieneTodasLasPalabras(fraude, busqueda);

      if (similitud > mejorSimilitud || contienePalabras) {
        mejorSimilitud = similitud;
        mejorCoincidencia = fraude;
        coincidenciaParcial = contienePalabras;
      }
    }

    // Considerar como coincidencia si la similitud es mayor al 80% o si contiene todas las palabras
    bool encontrado = mejorSimilitud >= 80 || coincidenciaParcial;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(encontrado ? '¡Advertencia!' : 'Información'),
          content: Text(encontrado
              ? 'La empresa "$mejorCoincidencia" está siendo investigada por fraude.${coincidenciaParcial ? '\n(Coincidencia parcial encontrada)' : '\n(Similitud: ${mejorSimilitud.toStringAsFixed(1)}%)'}'
              : 'No se encontraron coincidencias para la búsqueda.'),
          actions: [
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );

    // Limpiar el campo de búsqueda
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Column(
          children: [
            const SizedBox(
              width: 700,
              child: Text(
                'Consulta de Empresas en Investigación por fraude:',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      iconColor: Colors.amberAccent,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: 'Buscar empresa...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                    ),
                    textCapitalization: TextCapitalization.characters,
                    onSubmitted: (_) => _realizarBusqueda(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _realizarBusqueda,
                ),
              ],
            ),
            const SizedBox(height: 200),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
