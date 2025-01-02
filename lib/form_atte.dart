import 'package:flutter/material.dart';
import 'dart:async';

class FormularioConsulta extends StatefulWidget {
  const FormularioConsulta({super.key});

  @override
  FormularioConsultaState createState() => FormularioConsultaState();
}

class ConsultaFormModel {
  String nombre = '';
  String folio = '';
  DateTime? fechaIngreso;

  bool isValid() {
    return nombre.isNotEmpty &&
        folio.isNotEmpty &&
        fechaIngreso != null &&
        _isFolioValid();
  }

  bool _isFolioValid() {
    // Ejemplo: validar que el folio tenga el formato correcto
    final folioRegex = RegExp(r'^[A-Z0-9]{6,}$');
    return folioRegex.hasMatch(folio);
  }
}

class FormularioConsultaState extends State<FormularioConsulta> {
  final _formKey = GlobalKey<FormState>();
  final _model = ConsultaFormModel();
  final _nombreController = TextEditingController();
  final _folioController = TextEditingController();
  bool _isLoading = false;

  Future<void> _consultarFolio() async {
    if (!_model.isValid()) return;

    setState(() => _isLoading = true);

    try {
      // Simular proceso de 15 segundos con un indicador no bloqueante
      await Future.delayed(const Duration(seconds: 15));

      if (!mounted) return;

      _mostrarConfirmacion();
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _mostrarConfirmacion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Proceso Iniciado'),
          content: const Text(
            'Tu folio ha sido registrado y se ha iniciado el proceso de investigación y recuperación de la información. En 72 horas hábiles enviaremos resolución por correo electrónico.',
            textAlign: TextAlign.justify,
          ),
          actions: [
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<void> _seleccionarFecha() async {
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: _model.fechaIngreso ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromRGBO(98, 17, 50, 1),
            ),
          ),
          child: child!,
        );
      },
    );

    if (fecha != null) {
      setState(() {
        _model.fechaIngreso = fecha;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(
                        controller: _nombreController,
                        label: 'Nombre',
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Por favor ingrese un nombre';
                          }
                          return null;
                        },
                        onChanged: (value) => _model.nombre = value,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _folioController,
                        label: 'Folio',
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Por favor ingrese un folio';
                          }
                          if (!RegExp(r'^[A-Z0-9]{6,}$').hasMatch(value!)) {
                            return 'El folio debe tener al menos 6 caracteres alfanuméricos';
                          }
                          return null;
                        },
                        onChanged: (value) => _model.folio = value,
                      ),
                      const SizedBox(height: 16),
                      _buildFechaSelector(theme),
                      const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(98, 17, 50, 1),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 15,
                            ),
                          ),
                          onPressed: _isLoading ? null : _consultarFolio,
                          child: Text(
                            'Consultar Folio',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        if (_isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    required void Function(String) onChanged,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      style: Theme.of(context).textTheme.titleLarge,
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildFechaSelector(ThemeData theme) {
    return InkWell(
      onTap: _seleccionarFecha,
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Fecha de Ingreso',
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _model.fechaIngreso == null
                  ? 'Seleccionar fecha'
                  : '${_model.fechaIngreso!.day}/${_model.fechaIngreso!.month}/${_model.fechaIngreso!.year}',
              style: theme.textTheme.titleLarge,
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _folioController.dispose();
    super.dispose();
  }
}
