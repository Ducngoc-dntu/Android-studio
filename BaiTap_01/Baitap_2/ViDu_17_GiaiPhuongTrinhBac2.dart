/*
  ax^2 + bx + c = 0;
*/
import 'dart:math';
import 'dart:io';
void main(){
  double a=0, b=0,c=0;

  do{
    stdout.write("Nhập hệ số a (a khác 0): ");
    String? input = stdin.readLineSync();
    if(input!=null){
      a = double.tryParse(input) ?? 0; // có bắt lỗi
    }
  }while(a==0);

  stdout.write("Nhập hệ số b: ");
    String? inputB = stdin.readLineSync();
    if(inputB!=null){
      b = double.tryParse(inputB) ?? 0; // có bắt lỗi
    }

   stdout.write("Nhập hệ số c: ");
    String? inputC = stdin.readLineSync();
    if(inputC!=null){
      c = double.tryParse(inputC) ?? 0; // có bắt lỗi
    }  

    // Tính delta:
    double delta = b*b - 4*a*c;

    // Hiển thị phương trình 
    print('Phương trình: ${a}x^2 + ${b}x + $c = 0');

    // GPT
    if(delta<0){
      print('Phương trình vô nghiệm! ');
    }else if(delta==0){
      double x = -b/(2*a);
      print("Phương trình có nghiệm kép x1 x2 = ${x.toStringAsFixed(2)}");
    }else{
      double x1 = (-b-sqrt(delta))/(2*a);
      double x2 = (-b+sqrt(delta))/(2*a);
      print('x1 = ${x1.toStringAsFixed(2)}, x2 = ${x2.toStringAsFixed(2)}');

    }
}