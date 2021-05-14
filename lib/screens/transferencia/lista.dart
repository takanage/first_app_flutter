import 'package:bytebank/config.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'formulario.dart';

const _tituloAppBar = 'Transferências';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

// O Stateful precisa traballhar com um state
class ListaTransferenciasState extends State<ListaTransferencias> {

  ThemeChanger themeChanger;
  bool systemIsDark;

  @override
  Widget build(BuildContext context) {
    //
    themeChanger = Provider.of<ThemeChanger>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      //SEMPRE UTILIZAR O setState para atualizar!
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          })).then(
            (trasnferenciaRecebida) => _atualiza(trasnferenciaRecebida),
          );
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Dark Theme'),
              trailing: Switch(
                value: themeChanger.isDark(),
                onChanged: (status) {
                  themeChanger.setDarkStatus(status);
                },
              ),
            )
          ],
        ),
      )
    );
  }

  void _atualiza(Transferencia trasnferenciaRecebida) {
    if (trasnferenciaRecebida != null) {
      setState(() {
        widget._transferencias.add(trasnferenciaRecebida);
      });
    }
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}
