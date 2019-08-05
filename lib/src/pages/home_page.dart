import 'package:componentes/src/pages/alert_page.dart';
import 'package:componentes/src/providers/menu_provider.dart';
import 'package:componentes/src/utils/icono_string_util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
    //Para cargar data del future
    return FutureBuilder(
      future: menuProvider.cargarData(),
      //Informacion que va a tener por defecto mientras no se ha
      //resuelto el future (es opcional)
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _listaItems(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];
    //Recorremos todas la listas ruta de data

    data.forEach(
      (opt) {
        final widgetTemp = ListTile(
              //Seleccionamos el parametro title del item de la lista ruta
              title: Text(opt['texto']),
              leading: getIcon(opt['icon']),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.blue,
              ),
              onTap: () {
                  //Llamamos a una pagina definida en el main.dart
                  Navigator.pushNamed(context, opt['ruta']);


                // final route = MaterialPageRoute(
                //   builder: (context) => AlertPage(),
                // );
                // Navigator.push(context, route);
              },
            );
        //Añadimos el widget temporal 
        opciones..add(widgetTemp)
          ..add(Divider());
      },
    );
    return opciones;
  }
}
