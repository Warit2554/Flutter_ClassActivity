import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product.dart';
import 'detail.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      
      home: MyPage(),
      debugShowCheckedModeBanner: false, 
      );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  late List<Product> products;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var url = Uri.https("fakestoreapi.com","products");
    var response = await http.get(url);
    // print(response.body);
    setState(() {
      products = productFromJson(response.body).cast<Product>();
    });
    return;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("IT@WU Shop????"),
          backgroundColor: Colors.cyan, 
        ),
        
        body: ListView.builder(
          
          itemCount: products.length,
          itemBuilder: (context, index) 
            {
              Product product = products[index];
              var imgUrl = product.image;
              imgUrl ??= "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-20.jpg";
              return ListTile(
                title: Text("${product.title}"),
                subtitle: Text("\$${product.price}"),
                leading: AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.network(imgUrl),

                ),
                onTap:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Details(),
                    settings: RouteSettings(arguments: product))
                    );
                    //Cal detail Screen ?????? wait
                },
              );
            },
          ),
    );
  }
}