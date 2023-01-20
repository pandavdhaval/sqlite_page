import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqllite_page/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var homepagecontroller = Get.put(HomePageController());
  TextEditingController  namecontroller = TextEditingController();
  TextEditingController gmailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  // List<int> items = List<int>.generate(100, (int index) => index);
  List<int> items=List.generate(20, (index) =>index);


  final _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLITE"),
     backgroundColor:Colors.black54,
      ),
      body:Obx(() =>  ListView.separated(
        itemCount: homepagecontroller.todoList.length,
        itemBuilder: (context,index){
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.5),
                    offset: Offset(0.5,0.5),
                    blurRadius: 16,
                    // spreadRadius: 5,
                  )
                ]

            ),
            child: Dismissible(
              background: Container(
                color: Colors.green,
              ),
              secondaryBackground: Container(
                color: Colors.red,
              ),

              key: ValueKey<int>(items[index]),
              onDismissed: (DismissDirection direction) {
                setState(() {
                  items.removeAt(index);
                });
              },
              child: ListTile(
                  trailing: Icon(Icons.edit),
                  title:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Text("${homepagecontroller.todoList[index].id}"),
                      Text("${homepagecontroller.todoList[index].name}"),
                      Text("${homepagecontroller.todoList[index].task}"),
                      Text("${homepagecontroller.todoList[index].desc}"),

                    ],
                  )
              ),
            ),
          );
        }, separatorBuilder: (context,index){
        return SizedBox(height: 10,);
      }, ),),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        onPressed: (){
          showModalBottomSheet(context: context,
              builder:( context){
            return SingleChildScrollView(
              child: Container(
                height: 500,
                // color: Colors.teal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                       key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        Column(
                          children: [
                            TextFormField(
                              controller: namecontroller,
                             validator:(v){
                               if(v!.isEmpty){
                                 return "enter user name";
                               }
                             },
                              decoration: InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Enter Username",
                                labelText: "username",
                              ),
                            ),

                            SizedBox(height: 20,),
                            TextFormField(
                              controller: gmailcontroller,
                              validator:(v){
                                if(v!.isEmpty){
                                  return "enter gmail";
                                }

                              },
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                hintText: " Enter Gmail",
                                labelText: "gmail",
                              ),
                            ),

                            SizedBox(height: 20,),
                            TextFormField(
                                controller: passcontroller,
                              validator:(v){
                                if(v!.isEmpty){
                                  return "enter user name";
                                }

                              },
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                hintText: "Enter Password",
                                labelText: "password",
                              ),
                            ),
                         SizedBox(height: 10,),

                         Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             GestureDetector(
                               onTap: (){
                                 showModalBottomSheet(context: context, builder:(context){
                                   return Container(
                                     height: 300,
                                     width: 50,
                                   );
                                 });
                               },
                                 child: Text("FORGATE PASSWORD",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                           ],
                         ),

                            SizedBox(height: 50,),

                            ElevatedButton(style: ElevatedButton.styleFrom(
                              primary: Colors.black54,
                            ),
                              onPressed: (){
                              if(_formkey.currentState!.validate()){
                                homepagecontroller.addData(name:namecontroller.text, task: gmailcontroller.text, desc: passcontroller.text);
                                Navigator.pop(context);
                                namecontroller.clear();
                                gmailcontroller.clear();
                                passcontroller.clear();
                              }
                            }, child: Text("Save",),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
              },
          );
        },
        tooltip: "floating button",
        child: Icon(Icons.add),
      ),
    );
  }
}
