import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../notes.dart';
import '../notificacion.dart';
import 'page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
      ThemeData(
          brightness: Brightness.dark, primarySwatch: Colors.deepPurple),
      darkTheme: ThemeData(
          brightness: Brightness.light, primarySwatch: Colors.orange),
      home: Scaffold(
          body:PageView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              _View(),
              MyAppN(),
            ],
          )
      ),
    );
  }

  Stack _View() {
    return Stack(
      children: <Widget>[
        _Logo(),
        _Bienvenido(),
      ],
    );
  }
  Widget _Logo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(image: AssetImage('assets/fercha_perfil.jpeg'),
          fit: BoxFit.cover),
    );
  }

  Widget _Bienvenido() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(child: Container()
          ),
          Icon(
              Icons.keyboard_arrow_down,
              size: 70.0,
              color: Colors.white
          )
        ],
      ),
    );
  }
}

class MyAppN extends StatefulWidget {
  @override
  _MyAppNState createState() => _MyAppNState();
}

class _MyAppNState extends State<MyAppN> {
  final _nombre = TextEditingController();
  final _correo = TextEditingController();
  final _contra = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  SharedPreferences entrada;
  bool usuario;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sesion();
  }

  void sesion() async {
    entrada = await SharedPreferences.getInstance();
    usuario = entrada.getBool('carga') ?? false;
    print(usuario);

    if (usuario == false) {
      Navigator.push(
        context, new MaterialPageRoute(
          builder: (context) => PantallaSesion()

      ),
      );
    }
  }

  @override
  void dispose() {
    _nombre.dispose();
    _correo.dispose();
    _contra.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 650.0,
                  width: 500.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/fercha.jpeg'),
                    ),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 87.0, bottom: 16.0),
                            child: CircleAvatar(
                              minRadius: 90,
                              maxRadius: 90,
                              backgroundImage: NetworkImage("https://image.freepik.com/vector-gratis/concepto-moderno-lettering-welcome_23-2147916978.jpg"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, right: 15, left: 15, bottom: 10),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            cursorRadius: Radius.circular(8.0),
                            cursorWidth: 8.0,
                            controller: _nombre,
                            decoration: InputDecoration(
                              focusColor: Colors.purpleAccent,
                              hoverColor: Colors.yellow,
                              fillColor: Colors.grey,
                              icon: Icon(Icons.perm_contact_calendar, color: Colors.lightGreenAccent),
                              border: OutlineInputBorder(),
                              labelText: 'Nombre: ',
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            cursorRadius: Radius.circular(8.0),
                            cursorWidth: 8.0,
                            controller: _correo,
                            decoration: InputDecoration(
                              icon: Icon(Icons.email, color: Colors.lightGreenAccent),
                              border: OutlineInputBorder(),
                              labelText: 'Correo: ',
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            cursorRadius: Radius.circular(8.0),
                            cursorWidth: 8.0,
                            obscureText: true,
                            controller: _contra,
                            decoration: InputDecoration(
                              icon: Icon(Icons.featured_play_list, color: Colors.lightGreenAccent),
                              border: OutlineInputBorder(),
                              labelText: 'Contraseña: ',
                            ),
                          ),
                        ),

                        RaisedButton(
                          textColor: Colors.white,
                          splashColor: Colors.indigo,
                          textTheme: ButtonTextTheme.accent,
                          color: Colors.deepOrange[500],
                          onPressed: () {
                            String nombre = _nombre.text;
                            String correo = _correo.text;
                            String contra = _contra.text;

                            if(!correo.contains("@")){
                              showInSnackBar("Inserta una dirección de correo válida.");
                            }
                            else if (nombre != '' && contra != '' && correo != '') {
                              entrada.setBool('carga', false);
                              entrada.setString('nombre', nombre);
                              entrada.setString('correo', correo);


                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => PantallaSesion()));

                            }
                            else {
                              showInSnackBar("Heey, no te olvides de llenar el formulario.");
                              print("Falta llenar el formulario.");
                            }
                          },
                          child: Text("Entrar"),
                        )
                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        backgroundColor: Colors.deepOrangeAccent,
        content: new Text(value)
    ));
  }
}