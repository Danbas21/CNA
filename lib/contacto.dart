import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormularioContacto extends StatefulWidget {
  const FormularioContacto({super.key});

  @override
  State<FormularioContacto> createState() => _FormularioContactoState();
}

class _FormularioContactoState extends State<FormularioContacto> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    _comentarioController.dispose();
    super.dispose();
  }

  Future<void> _enviarFormulario() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Configuración de EmailJS
      const serviceId = 'service_lovg3wf';
      const templateId = 'template_9twkcwe';
      const userId = 'INDjLGEDEd78xmetg';
      const accessToken = 'wtrNQdhxh3uyo6qLlpMf5';
      const url = 'https://api.emailjs.com/api/v1.0/email/send';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'accessToken': accessToken,
          'template_params': {
            'to_email': 'kioskodigitalcna@gmail.com',
            'from_name': _nombreController.text,
            'from_email': _emailController.text,
            'phone': _telefonoController.text,
            'message': _comentarioController.text,
          }
        }),
      );

      if (response.statusCode == 200) {
        _mostrarMensaje('¡Mensaje enviado con éxito!', true);
        _formKey.currentState!.reset();
        _limpiarFormulario();
      } else {
        throw Exception('Error al enviar el mensaje');
      }
    } catch (e) {
      _mostrarMensaje('Error al enviar el mensaje: $e', false);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _limpiarFormulario() {
    _nombreController.clear();
    _telefonoController.clear();
    _emailController.clear();
    _comentarioController.clear();
  }

  void _mostrarMensaje(String mensaje, bool esExito) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: esExito ? Colors.green : Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 600;

        return Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(isDesktop ? 24.0 : 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Formulario de Contacto',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildTextFormField(
                  controller: _nombreController,
                  label: 'Nombre',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  controller: _telefonoController,
                  label: 'Teléfono',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su teléfono';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Ingrese un número válido de 10 dígitos';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  controller: _emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Ingrese un email válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  controller: _comentarioController,
                  label: 'Comentario',
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su comentario';
                    }
                    if (value.length < 10) {
                      return 'El comentario debe tener al menos 10 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _enviarFormulario,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(98, 17, 50, 1),
                      foregroundColor: Colors.white,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Enviar Comentarios',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    int? maxLines,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      validator: validator,
    );
  }
}
