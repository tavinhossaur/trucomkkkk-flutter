import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:trucomkkkk/tema.dart';

void main() => runApp(const MyHomePage(title: 'Trucomkkkk'));

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _ptsNos = 0;
  int _ptsEles = 0;
  int _ptsLimite = 12;

  bool _desabilitadoNos = false;
  bool _desabilitadoEles = false;

  void _resetCounter(String snackbarText) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _ptsNos = 0;
      _ptsEles = 0;
      _desabilitadoNos = false;
      _desabilitadoEles = false;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
            duration: const Duration(milliseconds: 2000),
            backgroundColor: Colors.indigo,
            content: Text(
              snackbarText,
              style: const TextStyle(color: Colors.white),
            )));
    });
  }

  void _increasePoints(bool player1, bool truco) {
    setState(() {
      if (player1) {
        if (truco) {
          _ptsNos += 3;
        } else {
          _ptsNos++;
        }
      } else {
        if (truco) {
          _ptsEles += 3;
        } else {
          _ptsEles++;
        }
      }
      _checarPontos();
    });
  }

  void _checarPontos() {
    if (_ptsNos == _ptsLimite) {
      _resetCounter('Nós ganhamos 😁');
    } else if (_ptsEles == _ptsLimite) {
      _resetCounter('Eles ganharam 😒');
    }

    if (_ptsNos == _ptsLimite - 1) {
      _desabilitadoNos = true;
    }

    if (_ptsEles == _ptsLimite - 1) {
      _desabilitadoEles = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            backgroundColor: Tema.tema.value == Brightness.dark
                ? const Color(0xFF303030)
                : const Color(0xFFFAFAFA),
            title: Text(
              widget.title,
              style: TextStyle(
                  color: Tema.tema.value == Brightness.dark
                      ? Colors.white
                      : Colors.indigo,
                  fontSize: 30),
            ),
            actions: [
              TextButton.icon(
                  label: _ptsLimite == 9223372036854775807
                      ? Text('Infinito',
                          style: TextStyle(
                              color: Tema.tema.value == Brightness.dark
                                  ? Colors.white
                                  : Colors.indigo,
                              fontSize: 20,
                              fontWeight: FontWeight.w400))
                      : Text('$_ptsLimite pts',
                          style: TextStyle(
                              color: Tema.tema.value == Brightness.dark
                                  ? Colors.white
                                  : Colors.indigo,
                              fontSize: 20,
                              fontWeight: FontWeight.w400)),
                  icon: Icon(Icons.layers_rounded,
                      size: 30,
                      color: Tema.tema.value == Brightness.dark
                          ? Colors.white
                          : Colors.indigo),
                  onPressed: () {
                    showMaterialModalBottomSheet(
                      context: context,
                      builder: (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 0),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 30,
                                    color: Tema.tema.value == Brightness.dark
                                        ? Colors.white
                                        : Colors.indigo,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                const Text(
                                  'Selecione o valor máximo de pontos',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.remove_rounded,
                              color: Tema.tema.value == Brightness.dark
                                  ? Colors.white
                                  : Colors.indigo,
                            ),
                            title: const Text('12 pts'),
                            onTap: () {
                              if (_ptsNos >= 12 || _ptsEles >= 12) {
                                _resetCounter(
                                    'A pontuação atual de um dos times ja execedeu este limite');
                              }

                              setState(() {
                                _ptsLimite = 12;
                                if (_desabilitadoNos || _desabilitadoEles) {
                                  _desabilitadoNos = false;
                                  _desabilitadoEles = false;
                                }
                              });

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      duration: Duration(milliseconds: 2000),
                                      backgroundColor: Colors.indigo,
                                      content: Text(
                                        'Limite de pontos definido para 12',
                                        style: TextStyle(color: Colors.white),
                                      )));

                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.add_rounded,
                              color: Tema.tema.value == Brightness.dark
                                  ? Colors.white
                                  : Colors.indigo,
                            ),
                            title: const Text('15 pts'),
                            onTap: () {
                              if (_ptsNos >= 15 || _ptsEles >= 15) {
                                _resetCounter(
                                    'A pontuação atual de um dos times ja execedeu este limite');
                              }

                              setState(() {
                                _ptsLimite = 15;
                                if (_desabilitadoNos || _desabilitadoEles) {
                                  _desabilitadoNos = false;
                                  _desabilitadoEles = false;
                                }
                              });

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      duration: Duration(milliseconds: 2000),
                                      backgroundColor: Colors.indigo,
                                      content: Text(
                                        'Limite de pontos definido para 15',
                                        style: TextStyle(color: Colors.white),
                                      )));

                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              CupertinoIcons.infinite,
                              color: Tema.tema.value == Brightness.dark
                                  ? Colors.white
                                  : Colors.indigo,
                            ),
                            title: const Text('Infinito'),
                            onTap: () {
                              if (_ptsNos >= 9223372036854775807 ||
                                  _ptsEles >= 9223372036854775807) {
                                _resetCounter(
                                    'A pontuação atual de um dos times ja execedeu este limite');
                              }

                              setState(() {
                                _ptsLimite = 9223372036854775807;
                                if (_desabilitadoNos || _desabilitadoEles) {
                                  _desabilitadoNos = false;
                                  _desabilitadoEles = false;
                                }
                              });

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      duration: Duration(milliseconds: 2000),
                                      backgroundColor: Colors.indigo,
                                      content: Text(
                                        'Limite de pontos definido para infinito',
                                        style: TextStyle(color: Colors.white),
                                      )));

                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  })
            ]),
        body: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
          child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _ptsNos > 0 ? _ptsNos-- : null;
                          _desabilitadoNos ? _desabilitadoNos = false : null;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: Tema.tema.value == Brightness.dark
                            ? const MaterialStatePropertyAll(Color(0xFF202020))
                            : const MaterialStatePropertyAll(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                        elevation: MaterialStateProperty.all(2),
                      ),
                      child: Text(
                        '-1',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Tema.tema.value == Brightness.dark
                                ? Colors.white
                                : Colors.indigo),
                      ),
                    ),
                    Text(
                      '$_ptsNos',
                      style: const TextStyle(
                          fontSize: 90, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      'Nós',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20.0),
                            child: ElevatedButton(
                                // Verifica se o botão esta desabilitado, caso sim, o botão não fara nada ao clicá-lo
                                onPressed: () => _desabilitadoNos
                                    ? null
                                    : _increasePoints(true, true),
                                style: _desabilitadoNos
                                    ? ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        fixedSize: MaterialStateProperty.all(
                                            const Size(150, 50)),
                                        elevation:
                                            MaterialStateProperty.all(15),
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                Colors.grey))
                                    : ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        fixedSize: MaterialStateProperty.all(
                                            const Size(150, 50)),
                                        elevation:
                                            MaterialStateProperty.all(15),
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                Colors.indigo)),
                                child: const Text('Truco +3',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400))),
                          ),
                          ElevatedButton(
                              onPressed: () => _increasePoints(true, false),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(150, 50)),
                                  elevation: MaterialStateProperty.all(15),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.indigo)),
                              child: const Text('Ponto +1',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400)))
                        ],
                      ),
                    )
                  ],
                ),
                const VerticalDivider(
                    indent: 220,
                    endIndent: 420,
                    thickness: 3,
                    color: Colors.grey),
                Column(
                  // Column is also a layout widget. It takes a list of children and
                  // arranges them vertically. By default, it sizes itself to fit its
                  // children horizontally, and tries to be as tall as its parent.
                  //
                  // Invoke "debug painting" (press "p" in the console, choose the
                  // "Toggle Debug Paint" action from the Flutter Inspector in Android
                  // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                  // to see the wireframe for each widget.
                  //
                  // Column has various properties to control how it sizes itself and
                  // how it positions its children. Here we use mainAxisAlignment to
                  // center the children vertically; the main axis here is the vertical
                  // axis because Columns are vertical (the cross axis would be
                  // horizontal).
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _ptsEles > 0 ? _ptsEles-- : null;
                          _desabilitadoEles ? _desabilitadoEles = false : null;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: Tema.tema.value == Brightness.dark
                            ? const MaterialStatePropertyAll(Color(0xFF202020))
                            : const MaterialStatePropertyAll(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                        elevation: MaterialStateProperty.all(2),
                      ),
                      child: Text(
                        '-1',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Tema.tema.value == Brightness.dark
                                ? Colors.white
                                : Colors.indigo),
                      ),
                    ),
                    Text(
                      '$_ptsEles',
                      style: const TextStyle(
                          fontSize: 90, fontWeight: FontWeight.w500),
                    ),
                    const Text('Eles',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w400)),
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20.0),
                            child: ElevatedButton(
                                onPressed: () => _desabilitadoEles
                                    ? null
                                    : _increasePoints(false, true),
                                style: _desabilitadoEles
                                    ? ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        fixedSize: MaterialStateProperty.all(
                                            const Size(150, 50)),
                                        elevation:
                                            MaterialStateProperty.all(15),
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                Colors.grey))
                                    : ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        fixedSize: MaterialStateProperty.all(
                                            const Size(150, 50)),
                                        elevation:
                                            MaterialStateProperty.all(15),
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                Colors.indigo)),
                                child: const Text('Truco +3',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400))),
                          ),
                          ElevatedButton(
                              onPressed: () => _increasePoints(false, false),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(150, 50)),
                                  elevation: MaterialStateProperty.all(15),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.indigo)),
                              child: const Text('Ponto +1',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400)))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 15,
          onPressed: () => _resetCounter('Partida reiniciada'),
          backgroundColor: Colors.indigo,
          icon: const Icon(Icons.loop_rounded),
          label: const Text(
            'Reiniciar',
            style: TextStyle(fontSize: 18),
          ),
        )); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
