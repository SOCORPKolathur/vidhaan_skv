import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Previous extends StatefulWidget {
  const Previous({Key? key}) : super(key: key);

  @override
  State<Previous> createState() => _PreviousState();
}

class _PreviousState extends State<Previous> with SingleTickerProviderStateMixin {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(child: Padding(
                padding: const EdgeInsets.only(left: 38.0,top: 30),
                child: Text(" View Previous Circulars",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: width/75.888888889,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
                //color: Colors.white,
                width: width/1.050,
                height: height/8.212,
                decoration: BoxDecoration(
                    color: Color(0xff00A0E3),
                    borderRadius: BorderRadius.circular(12)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: Container(
                  height:height/9.3,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: TabBar(
                    isScrollable:false,
                    controller: tabController,
                    labelColor: Color(0xff00A0E3),
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Color(0xff00A0E3),
                    indicatorPadding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 0),
                    labelPadding: const EdgeInsets.all(0),
                    splashBorderRadius: BorderRadius.zero,
                    splashFactory: NoSplash.splashFactory,
                    labelStyle: GoogleFonts.openSans(
                      fontSize: width/75.888888889,
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelStyle: GoogleFonts.openSans(
                      fontSize: width/85.375,
                      fontWeight: FontWeight.w400,
                    ),
                    onTap: (index){
                      setState(() {
                        // selectTabIndex = index;
                        // isLoading = true;
                      });
                    },
                    tabs: [
                      Tab(
                        child: const Text("All"),
                      ),
                      Tab(
                        child: const Text("Students"),
                      ),
                      Tab(
                        child: const Text("Staff"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("Circulars")
                          .orderBy("timestamp",descending: true)
                          .snapshots(),
                      builder: (context,snapshot){
                        if(!snapshot.hasData)
                        {
                          return   Center(
                            child:  CircularProgressIndicator(),
                          );}
                        if(snapshot.hasData==null)
                        {
                          return   Center(
                            child:  CircularProgressIndicator(),
                          );}
                        return

                          // Container(color: Colors.yellow, height: 400, width: 500,);
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,index){
                              var value = snapshot.data!.docs[index];
                              return
                                value['type'].toString().toLowerCase() == 'all'.toString().toLowerCase()  ?
                                Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: ListTile(
                                    leading: IconButton(
                                      onPressed: (){
                                        setState(() {
                                          titleController.text = value["Descr"];
                                          descriptionController.text = value["reason"];
                                        });
                                        editNoticePopUp(value.id);
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    title: Text(
                                        "${value["Descr"]}",
                                        style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold)
                                    ),
                                    subtitle: Text(
                                        "${value["reason"]}",
                                        style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.normal)
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "${value["Date"]}",
                                          style: GoogleFonts.poppins(
                                            fontSize: width/105.076923077,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff00A0E3),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          "${value["Time"]}",
                                          style: GoogleFonts.poppins(
                                            fontSize: width/105.076923077,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff00A0E3),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // child: Container(
                                //
                                //   width: width/1.241,
                                //   decoration: BoxDecoration(
                                //       color:Colors.white,
                                //       borderRadius: BorderRadius.circular(12),
                                //     border: Border.all(
                                //       color: Colors.black
                                //     )
                                //   ),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Column(
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: [
                                //         Text("Title :${value["reason"]}",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                                //         Container(
                                //           width: width/1.841,
                                //           child: Divider(
                                //             thickness: 2,
                                //           ),
                                //         ),
                                //         Text("Des: ${value["Descr"]}",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.w600,),textAlign: TextAlign.left,),
                                //
                                //         Row(
                                //           crossAxisAlignment: CrossAxisAlignment.end,
                                //           mainAxisAlignment: MainAxisAlignment.end,
                                //           children: [
                                //             Text("Date: ${value["Date"]}",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.w600,color: Color(0xff00A0E3)),textAlign: TextAlign.left,),
                                //
                                //             SizedBox(width: width/34.15,),
                                //
                                //             Text("Time: ${value["Time"]}",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.w600,color: Color(0xff00A0E3)),textAlign: TextAlign.left,),
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                //
                                //
                                //
                                // ),
                              ) : SizedBox();
                            });

                      }),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("Circulars").orderBy("timestamp",descending: true).snapshots(),

                      builder: (context,snapshot){
                        if(!snapshot.hasData)
                        {
                          return   Center(
                            child:  CircularProgressIndicator(),
                          );}
                        if(snapshot.hasData==null)
                        {
                          return   Center(
                            child:  CircularProgressIndicator(),
                          );}
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,index){
                              var value = snapshot.data!.docs[index];
                              return value['type'].toString().toLowerCase() == 'student'.toString().toLowerCase()  ?
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: ListTile(
                                    leading: IconButton(
                                      onPressed: (){
                                        setState(() {
                                          titleController.text = value["Descr"];
                                          descriptionController.text = value["reason"];
                                        });
                                        editNoticePopUp(value.id);
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    title: Text(
                                        "${value["Descr"]}",
                                        style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold)
                                    ),
                                    subtitle: Text(
                                        "${value["reason"]}",
                                        style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.normal)
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "${value["Date"]}",
                                          style: GoogleFonts.poppins(
                                            fontSize: width/105.076923077,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff00A0E3),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          "${value["Time"]}",
                                          style: GoogleFonts.poppins(
                                            fontSize: width/105.076923077,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff00A0E3),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // child: Container(
                                //
                                //   width: width/1.241,
                                //   decoration: BoxDecoration(
                                //       color:Colors.white,
                                //       borderRadius: BorderRadius.circular(12),
                                //     border: Border.all(
                                //       color: Colors.black
                                //     )
                                //   ),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Column(
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: [
                                //         Text("Title :${value["reason"]}",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                                //         Container(
                                //           width: width/1.841,
                                //           child: Divider(
                                //             thickness: 2,
                                //           ),
                                //         ),
                                //         Text("Des: ${value["Descr"]}",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.w600,),textAlign: TextAlign.left,),
                                //
                                //         Row(
                                //           crossAxisAlignment: CrossAxisAlignment.end,
                                //           mainAxisAlignment: MainAxisAlignment.end,
                                //           children: [
                                //             Text("Date: ${value["Date"]}",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.w600,color: Color(0xff00A0E3)),textAlign: TextAlign.left,),
                                //
                                //             SizedBox(width: width/34.15,),
                                //
                                //             Text("Time: ${value["Time"]}",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.w600,color: Color(0xff00A0E3)),textAlign: TextAlign.left,),
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                //
                                //
                                //
                                // ),
                              ) : SizedBox();
                            });

                      }),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("Circulars").orderBy("timestamp",descending: true).snapshots(),
                      builder: (context,snapshot){
                        if(!snapshot.hasData)
                        {
                          return   Center(
                            child:  CircularProgressIndicator(),
                          );}
                        if(snapshot.hasData==null)
                        {
                          return   Center(
                            child:  CircularProgressIndicator(),
                          );}
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,index){
                              var value = snapshot.data!.docs[index];
                              // return value['type'].toString().toLowerCase() == 'staff'.toString().toLowerCase()  ?
                              return value['type'].toString().toLowerCase() == 'All Staff'.toString().toLowerCase()  ?
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: ListTile(
                                    leading: IconButton(
                                      onPressed: (){
                                        setState(() {
                                          titleController.text = value["Descr"];
                                          descriptionController.text = value["reason"];
                                        });
                                        editNoticePopUp(value.id);
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    title: Text(
                                        "${value["Descr"]}",
                                        style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold)
                                    ),
                                    subtitle: Text(
                                        "${value["reason"]}",
                                        style: GoogleFonts.poppins(fontSize: width/85.375,fontWeight: FontWeight.normal)
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "${value["Date"]}",
                                          style: GoogleFonts.poppins(
                                            fontSize: width/105.076923077,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff00A0E3),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          "${value["Time"]}",
                                          style: GoogleFonts.poppins(
                                            fontSize: width/105.076923077,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff00A0E3),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // child: Container(
                                //
                                //   width: width/1.241,
                                //   decoration: BoxDecoration(
                                //       color:Colors.white,
                                //       borderRadius: BorderRadius.circular(12),
                                //     border: Border.all(
                                //       color: Colors.black
                                //     )
                                //   ),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Column(
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: [
                                //         Text("Title :${value["reason"]}",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                                //         Container(
                                //           width: width/1.841,
                                //           child: Divider(
                                //             thickness: 2,
                                //           ),
                                //         ),
                                //         Text("Des: ${value["Descr"]}",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.w600,),textAlign: TextAlign.left,),
                                //
                                //         Row(
                                //           crossAxisAlignment: CrossAxisAlignment.end,
                                //           mainAxisAlignment: MainAxisAlignment.end,
                                //           children: [
                                //             Text("Date: ${value["Date"]}",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.w600,color: Color(0xff00A0E3)),textAlign: TextAlign.left,),
                                //
                                //             SizedBox(width: width/34.15,),
                                //
                                //             Text("Time: ${value["Time"]}",style: GoogleFonts.poppins(fontSize: width/75.888888889,fontWeight: FontWeight.w600,color: Color(0xff00A0E3)),textAlign: TextAlign.left,),
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                //
                                //
                                //
                                // ),
                              ) : SizedBox();
                            });

                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  editNoticePopUp(String id){
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            height: size.height * 0.55,
            width: size.width * 0.4,
            margin:   EdgeInsets.symmetric(
                vertical: height/32.55,
                horizontal: width/68.3
            ),
            decoration: BoxDecoration(
              color: Color(0xff00A0E3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1, 2),
                  blurRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width/68.3, vertical: height/81.375),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Edit Circular",
                          style: GoogleFonts.openSans(
                            fontSize: width/68.3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                FirebaseFirestore.instance.collection("Circulars").doc(id).update(
                                  {
                                    "Descr" : titleController.text,
                                    "reason" : descriptionController.text
                                  }
                                );

                                Navigator.pop(context);
                              },
                              child: Container(
                                height:height/16.275,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(1, 2),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal:width/227.66),
                                  child: Center(
                                    child: Text(
                                      "Update",
                                      style: GoogleFonts.openSans(
                                        fontSize:width/85.375,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width:width/136.6),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  titleController.text = "";
                                  descriptionController.text = "";
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                height:height/16.275,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(1, 2),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal:width/227.66),
                                  child: Center(
                                    child: Text(
                                      "CANCEL",
                                      style: GoogleFonts.openSans(
                                        fontSize:width/85.375,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffF7FAFC),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding:   EdgeInsets.symmetric(
                        vertical: height/32.55,
                        horizontal: width/68.3
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Title",
                          style: GoogleFonts.openSans(
                            fontSize:width/97.571,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: height/108.5),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          elevation: 10,
                          child: SizedBox(
                            height:height/13.02,
                            width: width/3.902857142857143,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height/81.375,
                                  horizontal: width/170.75
                              ),
                              child: TextFormField(
                                controller: titleController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                                  border: InputBorder.none,
                                  hintStyle: GoogleFonts.openSans(
                                    fontSize:width/97.571,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height:height/65.1),
                        Text(
                          "Description",
                          style: GoogleFonts.openSans(
                            fontSize:width/97.571,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: height/108.5),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          elevation: 10,
                          child: SizedBox(
                            height:height/5.007692307692308,
                            width: width/3.902857142857143,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height/81.375,
                                  horizontal: width/170.75
                              ),
                              child: TextFormField(
                                maxLines: null,
                                controller: descriptionController,
                                decoration: InputDecoration(

                                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                                  border: InputBorder.none,
                                  hintStyle: GoogleFonts.openSans(
                                    fontSize:width/97.571,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}
