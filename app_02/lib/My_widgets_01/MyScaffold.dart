import "package:flutter/material.dart";

class MyScaffold extends StatelessWidget{
  const MyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    // Tra ve Scaffold - widget cung cap bo cuc Material Design co ban
    // Man Hinh
    return Scaffold(
      //tieu de cua ung dung
      appBar: AppBar(
        title:Text("App 02")

      ) ,
      backgroundColor: Colors.yellow,

      body: Center(child: Text("Noi Dung chinh"),),

      floatingActionButton: FloatingActionButton(
          onPressed: (){print("pressed");},

          child: const Icon(Icons.add_ic_call),
      ),

      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chu"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Tim Kiem"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Ca Nhan"),
      ]),

    );
  }
}