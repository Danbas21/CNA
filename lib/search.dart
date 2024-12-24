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

  void _realizarBusqueda() {
    String busqueda = _searchController.text.toUpperCase();

    if (busqueda.isEmpty) return;

    bool encontrado = listaFraudes.contains(busqueda);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(encontrado ? '¡Advertencia!' : 'Información'),
          content: Text(encontrado
              ? 'La empresa "$busqueda" está siendo investigada por fraude.'
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
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar empresa...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
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
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
