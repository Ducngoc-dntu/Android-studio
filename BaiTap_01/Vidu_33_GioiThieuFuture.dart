import "dart:async";

/*
Future là gì?

Hãy tưởng tưởng bạn gọi món ăn tại nhà hàng:
+ Bạn đặt món (gọi một hàm)
+ Nhân viên phục vụ nói "vâng, tôi sẽ mang món ăn đến sau" (nhận về một Future)
+ Bạn có thể làm việc khác trong lúc chờ đợi (tiếp tục chạy code)
Khi món ăn được phục vụ (Future hoàn thành), bạn có thể thưởng thức nó (sử dụng kết)

Future trong Dart cũng hoạt động tưởng tự.
Đó là một cách để làm việc với các tác vụ
mất thời gian mà không phải chờ đợi (ví dụ: tải dữ liệu từ internet, đọc tệp).

Hiểu rõ về "async/await"
async và await là hai từ khóa đặc biệt trong Dart giúp làm việc với Future dễ dàng hơn

Từ khóa async:
- Khi thêm từ khóa async vào một hàm,
bạn đang nói với Dart: "Hàm này sẽ chứa code bất đồng bộ"

- Một hàm được đánh dấu async sẽ luôn luôn trả
về một Future (ngay cả khi bạn không khai báo)
*/

Future<String> layTen() async {
  return "ha Duc Ngoc";
}

/*
Từ khóa await
- await chỉ có thể được sử dụng bên trong một hàm async
Khi bạn đặt await trược một Future, Dart sẽ:
- Tạm dừng thực thi hàm tại dòng đó
- Đợi Future hoàn thành
- Trả về giá trị từ Future (Không còn đóng gói trong Future nữa)
- Tiếp tục thực thi những dòng code còn lại

await biến đổi Future<T> thành giá trị T, giúp code dễ đọc hơn

*/

//Ham trả vceef Future
Future<String> taiDuLieu(){
  return Future.delayed(Duration(seconds: 2),()=> "Dữ liệu dẫ tải xong"
  );
}

//Gọi hàm cách 1:
void hamChinh(){
  print("Bat dau tai");
  Future<String> f = taiDuLieu();
  f.then((Ketqua){
    print("Kết quả: $Ketqua");
  });
  print("Tiếp tục công việc khác.");
}


void hamChinh2() async{
  print("Bat dau tai");
 String Ketqua = await taiDuLieu();
    print("Kết quả: $Ketqua");
  print("Tiếp tục công việc khác.");
}

void main() {
  hamChinh2();
}
