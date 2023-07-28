void main(List<String> args) async {
  Stream.periodic(Duration(seconds: 1), (time) {
    print(time);
  }).forEach((element) {
    print(element);
  });
}
