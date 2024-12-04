
import 'package:cloud_firestore/cloud_firestore.dart';

//Objeto para la base de datos
FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getProductos() async
{
  List proyectos=[];
  //recuperar los valores de la coleccion
  CollectionReference colProd = db.collection('productos');
  
 //Manipular los datos recuperados
  QuerySnapshot queryProjects = await colProd.get();

  //Recorrer la lista
  queryProjects.docs.forEach( 
  (documento) {
    proyectos.add(documento.data);
  }

  );
  return proyectos;

}
