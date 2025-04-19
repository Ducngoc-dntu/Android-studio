/*
  expr1 ? expr2 : expr3;
  Nếu expr đúng, trả về expr2; ngược lại, trả về expr1;

  expr1 ?? expr2;
  Nếu expr1 không null, trả về giá trị của nó;
  ngược lại trả về expr2;

*/
void main(){
  var kiemtra = (100%2==0)?"100 là số chẵn": "100 là số lẻ";
  print(kiemtra);

  var x = 100;
  var y = x ?? 50;
  print(y);

  int? z;
  y = z ?? 30;
  print(y);
}