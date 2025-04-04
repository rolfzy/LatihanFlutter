import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkingExample extends StatefulWidget{
  @override
  _NetworkingExampleState createState() => _NetworkingExampleState();
}

class _NetworkingExampleState extends State<NetworkingExample>{
  List<dynamic> users = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async{
    try{
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200){
        setState(() {
          users = json.decode(response.body);
          isLoading = false;
        });

      } else{
        setState(() {
          errorMessage = 'Gagal mengambil data: Status code ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (error){
      setState(() {
        errorMessage = 'Terjadi kesalahan: $error';
        isLoading = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Networking Example'),
      ),
      body: isLoading
        ? CircularProgressIndicator()
          : errorMessage.isNotEmpty
        ? Text(errorMessage)
    : users.isEmpty? Text('Tidak ada data pengguna')
    : ListView.builder(
        itemCount: users.length,itemBuilder: (context,index){
          final user = users[index];
          return ListTile(
            title: Text(user?['nama']),
            subtitle: Text(user['email']),
          );
      },
      ),
    );
  }
}