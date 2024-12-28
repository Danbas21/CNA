import 'package:cna/components/blockText.dart';
import 'package:cna/components/type%20_text.dart';
import 'package:flutter/material.dart';

class Parrafo extends StatelessWidget {
  const Parrafo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      children: [
        RichCustomText(
          spans: [
            CustomTextSpan(
              text: title1,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
            CustomTextSpan(
              text: paragraf1,
              fontSize: 25,
            ),
          ],
        ),
        Text(
          paragraf2,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          paragraph3,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
        BlockquoteList(
          items: listaFraudes,
        ),
        Text(
          paragraph4,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          title2,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline),
        ),
        BlockquoteList(
          items: listFraudes,
        ),
        Text(
          paragraph6,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
        BlockquoteList(
          items: listFraudes2,
        ),
        Text(
          title3,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            decoration: TextDecoration.underline,
          ),
          textAlign: TextAlign.left,
        ),
        Text(
          paragraph7,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
        RichCustomText(
          spans: [
            CustomTextSpan(
                text: paragraph8,
                type: TextType.p,
                fontSize: 25,
                fontWeight: FontWeight.w300),
            CustomTextSpan(
                text: title4,
                type: TextType.p,
                fontSize: 25,
                fontWeight: FontWeight.w700),
            CustomTextSpan(
                text: paragraph9,
                type: TextType.p,
                fontSize: 25,
                fontWeight: FontWeight.w300),
            CustomTextSpan(
                text: title5,
                type: TextType.p,
                fontSize: 25,
                fontWeight: FontWeight.w700),
            CustomTextSpan(
                text: paragraph10,
                type: TextType.p,
                fontSize: 25,
                fontWeight: FontWeight.w300),
            CustomTextSpan(
                text: title6,
                type: TextType.p,
                fontSize: 25,
                fontWeight: FontWeight.w700),
          ],
        ),
        Text(
          title7,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline),
          textAlign: TextAlign.left,
        ),
        RichCustomText(
          spans: [
            CustomTextSpan(
              text: paragraph11,
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
            CustomTextSpan(
                text: title8,
                type: TextType.p,
                fontSize: 25,
                fontWeight: FontWeight.w700),
            CustomTextSpan(
              text: paragraph12,
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
        BlockquoteList(items: listFraudes3),
        Text(
          paragraph13,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

const String title1 = '''La Guardia Nacional''';

const String paragraf1 =
    ''' y las 43 Unidades de Policía Cibernética, que se articulan como parte del Sistema Nacional de Seguridad Pública en las 32 entidades federativas, impulsan desde el 1 de noviembre del 2020 y hasta el 31 de enero del 2021 la Campaña Nacional Antifraude Cibernético, con el objetivo de que sociedad y gobierno sumen esfuerzos a fin de disminuir el fraude cibernético.''';

const String paragraf2 =
    '''\nA lo largo del año, la Guardia Nacional ha emprendido iniciativas para preservar un entorno digital seguro y resiliente, al tiempo de promover una cultura de la denuncia de posibles delitos cibernéticos, en un contexto de transformación de la actividad comercial y en beneficio del consumo responsable.''';

const String paragraph3 =
    '''\nDurante la Campaña Nacional Antifraude Cibernético, la Guardia Nacional y las Unidades de Policía Cibernética han dado a conocer las diferentes modalidades utilizadas por los ciberdelincuentes, haciendo énfasis en temas como:''';

const List<String> listaFraudes = [
  'Qué es y cómo protegerse del SPAM',
  'Carding',
  'Phishing',
  'Vishing',
  'Smishing',
  'Pharming',
  'BEC (correos electrónicos corporativos comprometidos)',
  'Ransomware',
];

const String paragraph4 =
    '''\nSe promueve una cultura de la denuncia de posibles delitos cibernéticos\n''';

const String title2 = '''Recomendaciones''';

const listFraudes = [
  "Verifica las ofertas engañosas de supuestos proveedores o marcas de prestigio a través de redes.",
  "Actualiza el sistema operativo y navegadores de Internet de tus equipos de cómputo y dispositivos móviles.",
  "Instala y actualiza un software antivirus.",
  "Descarga e instala aplicaciones desde sitios oficiales",
  "Visita las páginas oficiales para llevar a cabo trámites institucionales de servicios o accesos a programas sociales.",
  "Verifica que la URL del comercio sea legítima y que el sitio web que visitas sea el oficial.",
];

const String paragraph6 =
    '''En caso de ser víctima de un fraude o delito cibernético es necesario considerar lo siguiente:''';

const List<String> listFraudes2 = [
  '''Verifica las ofertas engañosas de supuestos proveedores o marcas de prestigio a través de redes.''',
  '''Actualiza el sistema operativo y navegadores de Internet de tus equipos de cómputo y dispositivos móviles.''',
  '''Instala y actualiza un software antivirus.''',
  '''Descarga e instala aplicaciones desde sitios oficiales''',
  '''Visita las páginas oficiales para llevar a cabo trámites institucionales de servicios o accesos a programas sociales.''',
  '''Verifica que la URL del comercio sea legítima y que el sitio web que visitas sea el oficial.''',
];

const String title3 = '''Ten cuidado\n''';

const String paragraph7 =
    '''Los ciberdelincuentes ofrecen ofertas atractivas solicitando un anticipo presumiblemente como apartado; con transferencias electrónicas a cuentas personales a través de tiendas de conveniencia; persuadiendo al comprador de seguir negociaciones de adquisición fuera de la plataforma digital; invitando por mensajería instantánea a ingresar a los servicios de la banca en línea solicitando la instalación de aplicaciones o en su defecto el nombre de usuario y contraseña por medio de páginas web apócrifas.''';

const String paragraph8 =
    '''La Guardia Nacional exhorta a la ciudadanía a reportar todo abuso o delito cibernético al número ''';

const String title4 = '''888''';

const String paragraph9 =
    ''' disponible las 24 horas del día, así como a la cuenta de Twitter ''';

const String title5 = '''@CNAC_ GN''';

const String paragraph10 = ''' o al correo''';

const String title6 = ''' cert-mx@sspc.gob.mx''';

const String title7 = '''\nHazlo ahora, no mañana\n''';

const String paragraph11 = '''A través el hashtag ''';

const title8 = '''#MéxicoContraElCiberfraude''';

const String paragraph12 =
    ''' se invita a la ciudadanía a hacer uso de las siguientes recomendaciones para evitar ser víctima de algún fraude cibernético, como sigue:''';

const List<String> listFraudes3 = [
  '''Evita el acceso inmediato a la tarjeta de crédito y evita portarla como si fuera una identificación, solo si se realiza una compra o se adquiere un servicio.''',
  '''Valida, en el establecimiento oficial, la promoción sobre el servicio o producto que se ofrece en Internet, aseguráte que se trata de una tienda reconocida.''',
  '''Verifica en los sitios gob.mx los trámites, requisitos y formas de pago válidas para los diversos trámites oficiales en dependencias gubernamentales.''',
  '''Activa los sistemas de alerta de la banca electrónica para la notificación oportuna de cada movimiento.''',
  '''Activa el doble factor de autentificación de las aplicaciones de redes sociales, telefonía móvil y banca en línea.''',
  '''Revisa frecuentemente tus estados de cuenta.''',
];

const String paragraph13 =
    '''La legalidad, veracidad y la calidad de la información es estricta responsabilidad de la dependencia, entidad o empresa productiva del Estado que la proporcionó en virtud de sus atribuciones y/o facultades normativas.''';
