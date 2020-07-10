import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../delete.dart';
import '../insert.dart';
import '../notificacion.dart';
import '../update.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PantallaSesion(
      ),
    );
  }
}

class PantallaSesion extends StatefulWidget {
  @override
  PantallaSesionState createState() => PantallaSesionState();
}

class PantallaSesionState extends State<PantallaSesion> {
  SharedPreferences entrada;
  String nombre;
  String correo;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    entrada = await SharedPreferences.getInstance();
    setState(() {
      nombre = entrada.getString('nombre');
      correo = entrada.getString('correo');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Bienvenido',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage("https://66.media.tumblr.com/f46621b643cda3e8950f83d432cbae88/tumblr_pr9q2ksOHJ1uu26zq_540.png"),
                ),
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(Icons.assignment, color: Colors.limeAccent),
              title: Text('Perfil'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PantallaSesion()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add, color: Colors.limeAccent),
              title: Text('Agregar nota'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Insert()));
              },
            ),
            ListTile(
              title: Text('Corregir'),
              leading: Icon(Icons.edit, color: Colors.limeAccent),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => UpdateData()));
              },
            ),
            ListTile(
              title: Text('Elimina una nota'),
              leading: Icon(Icons.delete, color: Colors.limeAccent),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Doing()));
              },
            ),
            ListTile(
              title: Text('Notificaciones locales'),
              leading: Icon(Icons.notifications_active, color: Colors.limeAccent),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyHomePage()));
              },
            ),
          ],
        ),
      ),
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Text('Profile'),
      ),


      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child:
                Image.network("https://www.psdstamps.com/wp-content/uploads/2019/11/welcome-stamp-png.png", height: 250),
              ),
            ),

            Center(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Hola $nombre, es un gusto tenerte aqui de nuevo, tu cuenta de correo es $correo.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RaisedButton(
                onPressed: () {
                  entrada.setBool('carga', true);
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => MyAppN()));
                },
                child: Text('Cerrar Sesion'),
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}