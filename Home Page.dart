import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //////////////////////////////////////////////////////////////////////
  /////////////////////////////USING LISTS//////////////////////////////
  //////////////////////////////////////////////////////////////////////
  List Products = [];
  late int count;

  Future getProducts() async {
    var url = Uri.https('api.instantwebtools.net', '/v1/airlines');
    print(url); // https://example.org/a%252F

    var response = await http.get(url);

    //print(response.body);

    var jsonResponse = convert.jsonDecode(response.body);

    //var responsebody = convert.jsonDecode(response.body);

    setState(() {
      Products.addAll(jsonResponse);
    });
  }

////////////////////////////////////////////////////////////////////////
/////////////////////////USING FUTURE BUILDER///////////////////////////
////////////////////////////////////////////////////////////////////////

  Future getUsingFutureBuilder() async {
    var url = Uri.https('api.instantwebtools.net', '/v1/airlines');

    var response = await http.get(url);

    // ignore: non_constant_identifier_names
    var JsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    return JsonResponse.values;
  }

  //////////////////////////////////////////////////////////////////////////////
  /////////////////////////////HTTP POST////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  postUser() async {
    var url = Uri.https('api.instantwebtools.net', '/v1/airlines');

    var response = await http.post(url, body: {
      "id": 12,
      "name": "Sri Lankan Airways",
      "country": "Sri Lanka",
      "logo":
          "https://upload.wikimedia.org/wikipedia/en/thumb/9/9b/Qatar_Airways_Logo.svg/sri_lanka.png",
      "slogan": "From Sri Lanka",
      "head_quaters": "Katunayake, Sri Lanka",
      "website": "www.srilankaairways.com",
      "established": "1990"
    });

    var responsebody =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    print(responsebody.values);
  }

  @override
  void initState() {
    getProducts();

    super.initState();
  }

  late UserCredential userCredential;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Home Page"),
        leading: const Icon(Icons.note),
        actions: [
          IconButton(
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  animType: AnimType.rightSlide,
                  title: 'Logout',
                  desc: 'Are you sure you want to Logout?',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    ///LOGOUT ANONYMOUS ACCOUNT//
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacementNamed("Login");
                  },
                ).show();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("AddNote");
        },
        child: const Icon(Icons.add),
      ),
      //////////////////////////////////////////////////////////////////////////
      ///////////////////////// BY USING LISTS /////////////////////////////////
      //////////////////////////////////////////////////////////////////////////
      body: Products == null || Products.isEmpty
          ? Container(
              color: Colors.black,
              child: const Center(
                  child: CircularProgressIndicator(
                color: Colors.amber,
              )))
          : Container(
              color: Colors.black,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: Products.length,
                itemBuilder: (context, i) {
                  return Center(
                    child: ListTile(
                        subtitle: Text(
                          "${Products[i]['slogan']}",
                          style: const TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                        leading: const Icon(
                          Icons.travel_explore_rounded,
                          color: Colors.green,
                        ),
                        title: Text(
                          "${Products[i]['name']}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                  );
                },
                separatorBuilder: (context, i) {
                  return const Divider(
                    thickness: 2,
                  );
                },
              )
              /////////////////////////////////////////////////////////////////////////////////////
              /*GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, i) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.blue, width: 3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: ListView.builder(itemBuilder: (context, i) {
                      return i < Products[0].length
                          ? Center(
                              child: Container(
                                child: Text(
                                  "${Products[0][i]['firstName']}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            )
                          : const Divider();
                    }),
                  );
                },
                itemCount: Products[0].length,
              ),*/

              /*body: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder(
            future: getUsingFutureBuilder(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(
                          "${snapshot.data}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      );
                    },
                    separatorBuilder: (context, i) {
                      return const Divider(
                        thickness: 3,
                        height: 30,
                      );
                    },
                    itemCount: snapshot.data.length);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),*/
              ),
    );
  }
}
