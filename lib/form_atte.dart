import 'package:flutter/material.dart';
import 'dart:async';

class FormularioConsulta extends StatefulWidget {
  const FormularioConsulta({super.key});

  @override
  FormularioConsultaState createState() => FormularioConsultaState();
}

class FormularioConsultaState extends State<FormularioConsulta> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _folioController = TextEditingController();
  DateTime? _fechaIngreso;

  Future<void> _consultarFolio() async {
    // Simular proceso de 15 segundos
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 15));
    if (!mounted) return; // Verificar si el widget aún está montado
    Navigator.pop(context);
    // Cerrar el indicador de carga

    // Mostrar mensaje de confirmación
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
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _seleccionarFecha() async {
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: _fechaIngreso ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (fecha != null) {
      setState(() {
        _fechaIngreso = fecha;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta tu folio',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 50,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _folioController,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
                decoration: const InputDecoration(
                    labelText: 'Folio',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un folio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InkWell(
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
                          _fechaIngreso == null
                              ? 'Seleccionar fecha'
                              : '${_fechaIngreso!.day}/${_fechaIngreso!.month}/${_fechaIngreso!.year}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          )),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(98, 17, 50, 1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _consultarFolio();
                    }
                  },
                  child: const Text(
                    'Consultar Folio',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
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
