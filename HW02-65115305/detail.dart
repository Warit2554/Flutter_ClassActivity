import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'product.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Details();
  }
}

class Details extends StatefulWidget{
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    
    var imgUrl = product.image;
    imgUrl ??= "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-20.jpg";

    //reverse....category
    String categoryString = categoryValues.reverse[product.category]!;

    // //Create Star icons
    // int fullStars = product.rating!.rate!.floor();
    // int halfStars = (product.rating!.rate! - fullStars >= 0.5) ? 1 : 0;
    // int emptyStars = 5 - fullStars - halfStars;

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: ListView(
        children: [
          AspectRatio(aspectRatio: 16.0/9.0,
          child: Image.network(imgUrl),),
        ListTile(
          title:Text("${product.title}", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
          subtitle: Text("\$ ${product.price}",style: TextStyle(fontSize: 20.0),),
        ),
ListTile(
            title: const Text(
              "Category",
              style: TextStyle(color: Colors.grey),
            ),
            subtitle: Text(categoryString,style: const TextStyle(fontSize: 18.0),
            ),
        ),
        ListTile(title:Text("${product.description}" ,style: const TextStyle(fontSize: 14.0),)
        ),
        ListTile(
          title: Text(
            "Rating: ${product.rating!.rate}/5 of ${product.rating!.count}"
          ),
        ),
        RatingBar.builder(itemBuilder: (context , index) => Icon(Icons.star, color: Colors.amber,), 
        onRatingUpdate: (value) => print(value),
        minRating: 0,
        itemCount: 5,
        allowHalfRating: true,
        direction: Axis.horizontal,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        initialRating: product.rating!.rate ?? 0,)
          
      
        ],
      ),
    );
  } 
}