import "package:flutter/material.dart";

class MyAppbar extends StatelessWidget{
  const MyAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    // Tra ve Scaffold - widget cung cap bo cuc Material Design co ban
    // Man Hinh
    return Scaffold(
      //tieu de cua ung dung
      appBar: AppBar(
        //Tiêu Đề
        title:Text("App 02"),
        //Màu nền
        backgroundColor: Colors.yellow,
        // do nang/ do bong cua Appbar
        elevation: 4,
        actions: [
          IconButton(onPressed: (){
            print("b1");
          },
            icon: Icon(Icons.search),
          ),
          IconButton(onPressed: (){
            print("b2");
          },
            icon: Icon(Icons.abc),
          ),
          IconButton(onPressed: (){
            print("b3");
          },
            icon: Icon(Icons.more_vert),
          ),

        ],
      ) ,
      backgroundColor: Colors.white,

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