import 'dart:io';

class namespace {
  String? name;

  namespace() {
    stdout.write("Enter your Name : ");
    String? inputName = stdin.readLineSync();
    print("Your Name is : $inputName");
    this.name = inputName;
  }
}
