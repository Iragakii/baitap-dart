import 'dart:io';

void main() {
  print("JC Group");
  // you input a number
  stdout.write("Enter your Name : ");
  String? inputName = stdin.readLineSync();
  print("Your Name is : $inputName");
  if (inputName == "Iragaki") {
    print("Welcome back sir");
  }
  if (inputName == "Iragaki w Son Acoustic") {
    print("Welcom back Founder JC Group");
  }
  print("Today , what can i do for you sir , $inputName");
  stdout.write("Check Activity in Opensea Chart (Y/N) : ");
  String? inputCheck = stdin.readLineSync();
  if (inputCheck == "Y") {
    print("Checking Activity in Opensea Chart...");
  }
  if (inputCheck == "N") {
    print("Okay sir , have a nice day");
  }
}
