import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ManagerRoleTab extends StatefulWidget {
  ManagerRoleTab({super.key, required this.currentRole});

  String currentRole;

  @override
  State<ManagerRoleTab> createState() => _ManagerRoleTabState();
}

class _ManagerRoleTabState extends State<ManagerRoleTab> {
  TextEditingController roleNameController = TextEditingController();
  TextEditingController rolePasswordController = TextEditingController();

  List<String> rolesList = [];
  List<String> rolesList1 = [];
  List<String> dashboardItemsList = [];
  List<String> dashboardItemsList1 = [];
  bool isFetched = false;
  bool isAddedFirst = true;
/*
  setRoles(ManageRoleModel roles) {
    if (isAddedFirst) {
      rolesList.clear();
      dashboardItemsList.clear();
    }
    rolesList1.clear();
    dashboardItemsList1.clear();
    if (roles.role != null) {
      if (roles.permissions!.isNotEmpty) {
        for (int j = 0; j < roles.permissions!.length; j++) {
          rolesList1.add(roles.permissions![j]);
        }
      } else {
        rolesList1 = [];
      }
      if (roles.dashboardItems!.isNotEmpty) {
        for (int j = 0; j < roles.dashboardItems!.length; j++) {
          dashboardItemsList1.add(roles.dashboardItems![j]);
        }
      } else {
        dashboardItemsList1 = [];
      }
    } else {
      rolesList1 = [];
      dashboardItemsList1 = [];
    }
    if (isAddedFirst) {
      rolesList1.forEach((element) {
        rolesList.add(element);
      });
      dashboardItemsList1.forEach((element) {
        dashboardItemsList.add(element);
      });
      isAddedFirst = false;
    }
    isFetched = true;
  }

  updateRole(String content, bool isAlreadyIn) async {
    setState(() {
      if (isAlreadyIn) {
        rolesList.removeWhere((element) => element == content);
        rolesList1.removeWhere((element) => element == content);
      } else {
        rolesList.add(content);
        rolesList1.add(content);
      }
    });
  }

  updateDashboardItem(String content, bool isAlreadyIn) async {
    setState(() {
      if (isAlreadyIn) {
        dashboardItemsList.removeWhere((element) => element == content);
        dashboardItemsList1.removeWhere((element) => element == content);
      } else {
        dashboardItemsList.add(content);
        dashboardItemsList1.add(content);
      }
    });
  }

  updateToCloud(String id, String roleString) async {
    List<String> permissions = rolesList.toSet().toList();
    List<String> dashboardPermissions = dashboardItemsList.toSet().toList();
    ManageRoleModel role = ManageRoleModel();
    role.role = roleString;
    role.id = id;
    role.dashboardItems = dashboardPermissions;
    role.permissions = permissions;
    Response res = await RolePermissionFireCrud.updatedRole(role);
    setState(() {
      isAddedFirst = true;
    });
    if (res.code == 200) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          "Roles Permissions Updated successfully!",
          width: MediaQuery.of(context).size.width * 0.4,
          backgroundColor: Constants().primaryAppColor.withOpacity(0.8));
    } else {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          "Failed update roles!",
          width: MediaQuery.of(context).size.width * 0.4,
          backgroundColor: Constants().primaryAppColor.withOpacity(0.8));
    }
  }*/

  bool isAddRole = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(width: width/1.050,
                height: height/8.212,
                decoration: BoxDecoration(
                    color: Color(0xff00A0E3),
                    borderRadius: BorderRadius.circular(12)
                ),child: Padding(
                padding: const EdgeInsets.only(left: 38.0,top: 30),
                child: Text(" User Permissions",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: width/75.888888889,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              ),
            ),
           /* StreamBuilder(
              stream: RolePermissionFireCrud.fetchPermissions(),
              builder: (ctx, snapshot) {
                if (snapshot.hasError) {
                  return Container();
                } else if (snapshot.hasData) {
                  List<ManageRoleModel> roles = snapshot.data!;
                  ManageRoleModel managerRole = ManageRoleModel();
                  roles.forEach((element) {
                    if (element.role!.toUpperCase() == widget.currentRole.toUpperCase()) {
                      managerRole = element;
                    } else if (widget.currentRole.toLowerCase() == 'admin@gmail.com') {
                      managerRole = element;
                    }
                  });
                  setRoles(managerRole);
                  return !isFetched
                      ? Container()
                      : Container(
                    height: size.height * 1.98,
                    width: width / 1.241818182,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Constants().primaryAppColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(1, 2),
                          blurRadius: 3,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                   "Manage Role Permission",
                                  style: GoogleFonts.openSans(
                                    fontSize: width / 68.3,
                                    fontWeight: FontWeight.bold,
                                    color: Constants().subHeadingColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                const manager_rol_tab_page()));
                                      },
                                      child: Container(
                                        height: height / 18.6,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(1, 2),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Center(
                                            child: Text(
                                              "Manage role",
                                              style: GoogleFonts.openSans(
                                                fontSize:
                                                width / 105.076923077,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: width / 136.6),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isAddRole = !isAddRole;
                                        });
                                      },
                                      child: Container(
                                        height: height / 18.6,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(1, 2),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Center(
                                            child: Text(
                                              isAddRole
                                                  ? "Cancel"
                                                  : "Add Role",
                                              style: GoogleFonts.openSans(
                                                fontSize:
                                                width / 105.076923077,
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
                        isAddRole
                            ? Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: height / 12.55),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Role Name : ",
                                        style: GoogleFonts.openSans(
                                          fontSize:
                                          width / 97.571428571,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: height / 108.5),
                                      Material(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        color: Colors.white,
                                        elevation: 10,
                                        child: SizedBox(
                                          height: height / 16.275,
                                          width: width / 5.464,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top:8.0,left:8,right: 4),
                                            child: TextFormField(

                                              controller:
                                              roleNameController,
                                              decoration:
                                              InputDecoration(
                                                isDense: true,
                                                border:
                                                InputBorder.none,
                                                hintStyle: GoogleFonts
                                                    .openSans(
                                                  fontSize: width /
                                                      97.571428571,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height / 32.55),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Role Password : ",
                                        style: GoogleFonts.openSans(
                                          fontSize:
                                          width / 97.571428571,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: height / 108.5),
                                      Material(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        color: Colors.white,
                                        elevation: 10,
                                        child: SizedBox(
                                          height: height / 16.275,
                                          width: width / 5.464,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top:8.0,left:8,right: 4),
                                            child: TextFormField(
                                              controller:
                                              rolePasswordController,
                                              decoration:
                                              InputDecoration(
                                                isDense: true,
                                                border:
                                                InputBorder.none,
                                                hintStyle: GoogleFonts
                                                    .openSans(
                                                  fontSize: width /
                                                      97.571428571,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height / 32.55),
                                  InkWell(
                                    onTap: () {
                                      if (roleNameController.text !=
                                          "" &&
                                          rolePasswordController.text !=
                                              "") {
                                        addRole();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                    child: Container(
                                      height: height / 16.275,
                                      width: width / 5.464,
                                      decoration: BoxDecoration(
                                        color:
                                        Constants().primaryAppColor,
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Add Role",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                            : Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height/32.55),
                                Center(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Text("Select Role"),
                                      SizedBox(
                                          height: height / 13.02,
                                          width:
                                          width / 4.553333333,
                                          child: StreamBuilder(
                                            stream: ChurchDetailsFireCrud.fetchChurchDetails(),
                                            builder: (ctx, snaps) {
                                              if (snaps.hasData) {
                                                ChurchDetailsModel church = snaps.data!.first;
                                                return DropdownButton(
                                                  isExpanded: true,
                                                  value: widget
                                                      .currentRole,
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_down),
                                                  items: church
                                                      .roles!
                                                      .map((items) {
                                                    return DropdownMenuItem(
                                                      value: items
                                                          .roleName!,
                                                      child: Text(items
                                                          .roleName!),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (newValue) {
                                                    if (newValue !=
                                                        "") {
                                                      setState(() {
                                                        widget.currentRole =
                                                        newValue!;
                                                        isAddedFirst =
                                                        true;
                                                      });
                                                    }
                                                  },
                                                );
                                              }
                                              return Container();
                                            },
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height / 21.7),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Modules",
                                        style: GoogleFonts.openSans(
                                          fontSize: width / 68.3,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 50),
                                  child: Container(

                                    child: Divider(),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: width / 90.464,),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.currentRole.toUpperCase() == "ADMIN@GMAIL.COM" ? true
                                                : rolesList.contains("Dashboard"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Dashboard",
                                                  rolesList.contains(
                                                      "Dashboard"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Dashboard",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),


                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Gallery"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Gallery",
                                                  rolesList.contains(
                                                      "Gallery"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Gallery",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Reports"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Reports",
                                                  rolesList.contains(
                                                      "Reports"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Reports",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),

                                SizedBox(height: height / 61.7),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Church Database",
                                        style: GoogleFonts.openSans(
                                          fontSize: width / 68.3,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 50),
                                  child: Container(

                                    child: Divider(),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: width / 90.464,),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.currentRole.toUpperCase() == "ADMIN@GMAIL.COM" ? true
                                                : rolesList.contains("Users"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Users",
                                                  rolesList.contains(
                                                      "Users"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Users",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Members"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Members",
                                                  rolesList.contains(
                                                      "Members"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Members",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Families"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Families",
                                                  rolesList.contains(
                                                      "Families"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Families",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Flocks"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Flocks",
                                                  rolesList.contains(
                                                      "Flocks"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Flocks",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.currentRole.toUpperCase() == "ADMIN@GMAIL.COM" ? true
                                                : rolesList.contains("Teen"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Teen",
                                                  rolesList.contains(
                                                      "Teen"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Teen",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Teams"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Teams",
                                                  rolesList.contains(
                                                      "Teams"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Teams",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Pastors"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Pastors",
                                                  rolesList.contains(
                                                      "Pastors"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Pastors",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),


                                  ],
                                ),
                                SizedBox(height: height / 61.7),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: width / 90.464,),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.currentRole.toUpperCase() == "ADMIN@GMAIL.COM" ? true
                                                : rolesList.contains("ChurchStaff"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "ChurchStaff",
                                                  rolesList.contains(
                                                      "ChurchStaff"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "ChurchStaff",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Department"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Department",
                                                  rolesList.contains(
                                                      "Department"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Department",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),



                                  ],
                                ),

                                SizedBox(height: height / 61.7),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Membership",
                                        style: GoogleFonts.openSans(
                                          fontSize: width / 68.3,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 50),
                                  child: Container(

                                    child: Divider(),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: width / 90.464,),
                                    SizedBox(
                                      width: width / 6.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.currentRole.toUpperCase() == "ADMIN@GMAIL.COM" ? true
                                                : rolesList.contains("Membership Reports"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Membership Reports",
                                                  rolesList.contains(
                                                      "Membership Reports"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Membership Reports",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 6.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Membership Register"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Membership Register",
                                                  rolesList.contains(
                                                      "Membership Register"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Membership Register",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),



                                  ],
                                ),


                                SizedBox(height: height / 61.7),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Finance",
                                        style: GoogleFonts.openSans(
                                          fontSize: width / 68.3,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 50),
                                  child: Container(

                                    child: Divider(),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: width / 90.464,),
                                    SizedBox(
                                      width: width / 6.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.currentRole.toUpperCase() == "ADMIN@GMAIL.COM" ? true
                                                : rolesList.contains("Fund Management"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Fund Management",
                                                  rolesList.contains(
                                                      "Fund Management"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Fund Management",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 6.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Donations"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Donations",
                                                  rolesList.contains(
                                                      "Donations"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Donations",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 6.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Asset Management"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Asset Management",
                                                  rolesList.contains(
                                                      "Asset Management"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Asset Management",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),



                                  ],
                                ),

                                SizedBox(height: height / 61.7),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Engagement",
                                        style: GoogleFonts.openSans(
                                          fontSize: width / 68.3,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 50),
                                  child: Container(

                                    child: Divider(),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: width / 90.464,),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.currentRole.toUpperCase() == "ADMIN@GMAIL.COM" ? true
                                                : rolesList.contains("Wishes"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Wishes",
                                                  rolesList.contains(
                                                      "Wishes"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Wishes",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "SMS COM"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "SMS COM",
                                                  rolesList.contains(
                                                      "SMS COM"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "SMS COM",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Email COM"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Email COM",
                                                  rolesList.contains(
                                                      "Email COM"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Email COM",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Notifications"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Notifications",
                                                  rolesList.contains(
                                                      "Notifications"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Notifications",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.currentRole.toUpperCase() == "ADMIN@GMAIL.COM" ? true
                                                : rolesList.contains("Blood"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Blood",
                                                  rolesList.contains(
                                                      "Blood"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Blood",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Blog"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Blog",
                                                  rolesList.contains(
                                                      "Blog"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Blog",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Social Media"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Social Media",
                                                  rolesList.contains(
                                                      "Social Media"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Social Media",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),


                                  ],
                                ),

                                SizedBox(height: height / 61.7),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Church Tools",
                                        style: GoogleFonts.openSans(
                                          fontSize: width / 68.3,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 50),
                                  child: Container(

                                    child: Divider(),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: width / 90.464,),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.currentRole.toUpperCase() == "ADMIN@GMAIL.COM" ? true
                                                : rolesList.contains("Speech"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Speech",
                                                  rolesList.contains(
                                                      "Speech"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Speech",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Testimony"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Testimony",
                                                  rolesList.contains(
                                                      "Testimony"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Testimony",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 9.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Prayer requests"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Prayer requests",
                                                  rolesList.contains(
                                                      "Prayer requests"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Prayer requests",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Meetings"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Meetings",
                                                  rolesList.contains(
                                                      "Meetings"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Meetings",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.currentRole.toUpperCase() == "ADMIN@GMAIL.COM" ? true
                                                : rolesList.contains("Event"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Event",
                                                  rolesList.contains(
                                                      "Event"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Event",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 7.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Remembrance Day"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Remembrance Day",
                                                  rolesList.contains(
                                                      "Remembrance Day"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Remembrance Day",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 8.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Announcements"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Announcements",
                                                  rolesList.contains(
                                                      "Announcements"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Announcements",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),


                                  ],
                                ),
                                SizedBox(height: height / 61.7),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: width / 90.464,),
                                    SizedBox(
                                      width: width / 10.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.currentRole.toUpperCase() == "ADMIN@GMAIL.COM" ? true
                                                : rolesList.contains("Functionhall"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Functionhall",
                                                  rolesList.contains(
                                                      "Functionhall"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Function Hall",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 8.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Audio Podcast"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Audio Podcast",
                                                  rolesList.contains(
                                                      "Audio Podcast"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Audio Podcast",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 5.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Certificate Generation"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Certificate Generation",
                                                  rolesList.contains(
                                                      "Certificate Generation"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Certificate Generation",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),



                                  ],
                                ),

                                SizedBox(height: height / 61.7),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Attendance",
                                        style: GoogleFonts.openSans(
                                          fontSize: width / 68.3,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 50),
                                  child: Container(

                                    child: Divider(),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: width / 90.464,),
                                    SizedBox(
                                      width: width / 6.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.currentRole.toUpperCase() == "ADMIN@GMAIL.COM" ? true
                                                : rolesList.contains("Member Attendance"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Member Attendance",
                                                  rolesList.contains(
                                                      "Member Attendance"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Member Attendance",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 6.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Student Attendance"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Student Attendance",
                                                  rolesList.contains(
                                                      "Student Attendance"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Sunday School Attendance",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: height / 61.7),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Security",
                                        style: GoogleFonts.openSans(
                                          fontSize: width / 68.3,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 50),
                                  child: Container(

                                    child: Divider(),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: width / 90.464,),
                                    SizedBox(
                                      width: width / 6.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.currentRole.toUpperCase() == "ADMIN@GMAIL.COM" ? true
                                                : rolesList.contains("Manage Role"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Manage Role",
                                                  rolesList.contains(
                                                      "Manage Role"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Manage Role",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 6.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Login Reports"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Login Reports",
                                                  rolesList.contains(
                                                      "Login Reports"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Login Reports",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),


                                SizedBox(height: height / 61.7),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Zone Activities",
                                        style: GoogleFonts.openSans(
                                          fontSize: width / 68.3,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 50),
                                  child: Container(

                                    child: Divider(),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: width / 90.464,),
                                    SizedBox(
                                      width: width / 6.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.currentRole.toUpperCase() == "ADMIN@GMAIL.COM" ? true
                                                : rolesList.contains("Zone Areas"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Zone Areas",
                                                  rolesList.contains(
                                                      "Zone Areas"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Zone Areas",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 6.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Zone List"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Zone List",
                                                  rolesList.contains(
                                                      "Zone List"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Zone List",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 6.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Zone Reports"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Zone Reports",
                                                  rolesList.contains(
                                                      "Zone Reports"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Zone Reports",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: height / 61.7),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Ecommerce",
                                        style: GoogleFonts.openSans(
                                          fontSize: width / 68.3,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 50),
                                  child: Container(

                                    child: Divider(),
                                  ),
                                ),


                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: width / 90.464,),
                                    SizedBox(
                                      width: width / 6.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget.currentRole.toUpperCase() == "ADMIN@GMAIL.COM" ? true
                                                : rolesList.contains("Products"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Products",
                                                  rolesList.contains(
                                                      "Products"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Products",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 6.464,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: widget
                                                .currentRole
                                                .toUpperCase() ==
                                                "ADMIN@GMAIL.COM"
                                                ? true
                                                : rolesList
                                                .contains(
                                                "Orders"),
                                            onChanged: (val) {
                                              updateRole(
                                                  "Orders",
                                                  rolesList.contains(
                                                      "Orders"));
                                            },
                                          ),
                                          SizedBox(
                                              width: width / 136.6),
                                          const Text(
                                            "Orders",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),



                                *//*Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList
                                                                .contains(
                                                                    "Prayers"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Prayers",
                                                              rolesList.contains(
                                                                  "Prayers"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Prayers",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList
                                                                .contains(
                                                                    "Notices"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Notices",
                                                              rolesList.contains(
                                                                  "Notices"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Notices",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList
                                                                .contains(
                                                                    "Speech"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Speech",
                                                              rolesList.contains(
                                                                  "Speech"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Speech",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList
                                                                .contains(
                                                                    "Families"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Families",
                                                              rolesList.contains(
                                                                  "Families"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Families",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList.contains(
                                                                "Department"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Department",
                                                              rolesList.contains(
                                                                  "Department"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Department",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList.contains(
                                                                "Committee"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Committee",
                                                              rolesList.contains(
                                                                  "Committee"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Committee",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList
                                                                .contains(
                                                                    "Members"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Members",
                                                              rolesList.contains(
                                                                  "Members"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Members",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList
                                                                .contains(
                                                                    "Pastors"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Pastors",
                                                              rolesList.contains(
                                                                  "Pastors"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Pastors",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList
                                                                .contains(
                                                                    "Clans"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Clans",
                                                              rolesList
                                                                  .contains(
                                                                      "Clans"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Clans",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList
                                                                .contains(
                                                                    "Chorus"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Chorus",
                                                              rolesList.contains(
                                                                  "Chorus"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Chorus",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList.contains(
                                                                "Church Staff"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Church Staff",
                                                              rolesList.contains(
                                                                  "Church Staff"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Church Staff",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList
                                                                .contains(
                                                                    "Student"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Student",
                                                              rolesList.contains(
                                                                  "Student"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Student",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList
                                                                .contains(
                                                                    "User"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "User",
                                                              rolesList
                                                                  .contains(
                                                                      "User"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "User",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList.contains(
                                                                "Attendance Record"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Attendance Record",
                                                              rolesList.contains(
                                                                  "Attendance Record"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                       
                                                            "Attendance Record",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList.contains(
                                                                "Communication"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Communication",
                                                              rolesList.contains(
                                                                  "Communication"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Communication",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList
                                                                .contains(
                                                                    "Blog"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Blog",
                                                              rolesList
                                                                  .contains(
                                                                      "Blog"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Blog",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList
                                                                .contains(
                                                                    "Product"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Product",
                                                              rolesList.contains(
                                                                  "Product"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Product",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList
                                                                .contains(
                                                                    "Orders"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Orders",
                                                              rolesList.contains(
                                                                  "Orders"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Orders",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList.contains(
                                                                "Greetings"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Greetings",
                                                              rolesList.contains(
                                                                  "Greetings"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Greetings",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList.contains(
                                                                "Blood Requirement"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Blood Requirement",
                                                              rolesList.contains(
                                                                  "Blood Requirement"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                       
                                                            "Blood Requirement",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : rolesList.contains(
                                                                "Social Media"),
                                                        onChanged: (val) {
                                                          updateRole(
                                                              "Social Media",
                                                              rolesList.contains(
                                                                  "Social Media"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                       
                                                            "Website & Social Media",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                 SizedBox(width: width/5.464),
                                                 SizedBox(width: width/5.464),
                                                 SizedBox(width: width/5.464),
                                              ],
                                            ),*//*
                                *//*    const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  bottom: 30,
                                                  top: 30),
                                              child: Text(
                                                "Dashboard Items",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : dashboardItemsList
                                                                .contains(
                                                                    "Users"),
                                                        onChanged: (val) {
                                                          updateDashboardItem(
                                                              "Users",
                                                              dashboardItemsList
                                                                  .contains(
                                                                      "Users"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Users",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : dashboardItemsList
                                                                .contains(
                                                                    "Committee"),
                                                        onChanged: (val) {
                                                          updateDashboardItem(
                                                              "Committee",
                                                              dashboardItemsList
                                                                  .contains(
                                                                      "Committee"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Committee",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : dashboardItemsList
                                                                .contains(
                                                                    "Pastors"),
                                                        onChanged: (val) {
                                                          updateDashboardItem(
                                                              "Pastors",
                                                              dashboardItemsList
                                                                  .contains(
                                                                      "Pastors"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Pastors",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : dashboardItemsList
                                                                .contains(
                                                                    "Clans"),
                                                        onChanged: (val) {
                                                          updateDashboardItem(
                                                              "Clans",
                                                              dashboardItemsList
                                                                  .contains(
                                                                      "Clans"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Clans",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : dashboardItemsList
                                                                .contains(
                                                                    "Chorus"),
                                                        onChanged: (val) {
                                                          updateDashboardItem(
                                                              "Chorus",
                                                              dashboardItemsList
                                                                  .contains(
                                                                      "Chorus"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Chorus",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : dashboardItemsList
                                                                .contains(
                                                                    "Staff"),
                                                        onChanged: (val) {
                                                          updateDashboardItem(
                                                              "Staff",
                                                              dashboardItemsList
                                                                  .contains(
                                                                      "Staff"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Staff",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : dashboardItemsList
                                                                .contains(
                                                                    "Student"),
                                                        onChanged: (val) {
                                                          updateDashboardItem(
                                                              "Student",
                                                              dashboardItemsList
                                                                  .contains(
                                                                      "Student"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Student",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : dashboardItemsList
                                                                .contains(
                                                                    "Member"),
                                                        onChanged: (val) {
                                                          updateDashboardItem(
                                                              "Member",
                                                              dashboardItemsList
                                                                  .contains(
                                                                      "Member"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Member",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : dashboardItemsList
                                                                .contains(
                                                                    "Families"),
                                                        onChanged: (val) {
                                                          updateDashboardItem(
                                                              "Families",
                                                              dashboardItemsList
                                                                  .contains(
                                                                      "Families"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Families",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : dashboardItemsList
                                                                .contains(
                                                                    "Birthday"),
                                                        onChanged: (val) {
                                                          updateDashboardItem(
                                                              "Birthday",
                                                              dashboardItemsList
                                                                  .contains(
                                                                      "Birthday"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Birthday Count",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : dashboardItemsList
                                                                .contains(
                                                                    "Anniversary"),
                                                        onChanged: (val) {
                                                          updateDashboardItem(
                                                              "Anniversary",
                                                              dashboardItemsList
                                                                  .contains(
                                                                      "Anniversary"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                       
                                                            "Anniversary Count",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : dashboardItemsList
                                                                .contains(
                                                                    "MemberPresent"),
                                                        onChanged: (val) {
                                                          updateDashboardItem(
                                                              "MemberPresent",
                                                              dashboardItemsList
                                                                  .contains(
                                                                      "MemberPresent"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                       
                                                            "Member Present Count",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: width / 5.464,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: widget
                                                                    .currentRole
                                                                    .toUpperCase() ==
                                                                "ADMIN@GMAIL.COM"
                                                            ? true
                                                            : dashboardItemsList
                                                                .contains(
                                                                    "Event Count"),
                                                        onChanged: (val) {
                                                          updateDashboardItem(
                                                              "Event Count",
                                                              dashboardItemsList
                                                                  .contains(
                                                                      "Event Count"));
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: width / 136.6),
                                                      const Text(
                                                        "Event Count",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                 SizedBox(width: width/5.464),
                                                 SizedBox(width: width/5.464),
                                                 SizedBox(width: width/5.464),
                                              ],
                                            ),*//*
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        updateToCloud(
                                            managerRole.id!,
                                            widget.currentRole);
                                      },
                                      child: Container(
                                        height: size.height / 16.6,
                                        decoration: BoxDecoration(
                                          color: Constants()
                                              .primaryAppColor,
                                          borderRadius:
                                          BorderRadius.circular(
                                              8),
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
                                          EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Center(
                                            child: Text(
                                              "Update",
                                              style: GoogleFonts
                                                  .openSans(
                                                  fontSize:
                                                  size.width /
                                                      105.07,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: width/68.3)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),*/

            SizedBox(height: size.height * 0.01),
          ],
        ),
      ),
    );
  }

  /*addRole() async {
    bool isadded = await _register();
    if (isadded) {
      RoleUserModel role = RoleUserModel(
        roleName: roleNameController.text,
        rolePassword: rolePasswordController.text,
      );
      var json = role.toJson();
      List roles = [];
      var documentmain = await FirebaseFirestore.instance.collection('ChurchDetails').get();
      var document = await FirebaseFirestore.instance.collection('ChurchDetails').doc(documentmain.docs.first.id).get();
      Map<String, dynamic>? values = document.data();
      roles = values!["roles"];
      roles.add(json);
      FirebaseFirestore.instance.collection('ChurchDetails').doc(documentmain.docs.first.id).update({"roles": roles});
      String docId = generateRandomString(16);
      ManageRoleModel roleModel = ManageRoleModel(
        id: docId,
        dashboardItems: [],
        permissions: [],
        role: roleNameController.text,
      );
      var roleJson = roleModel.toJson();
      FirebaseFirestore.instance.collection('RolePermissions').doc(docId).set(roleJson);
      setState(() {
        isAddRole = false;
      });
      CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          "Roles added successfully!",
          width: MediaQuery.of(context).size.width * 0.4,
          backgroundColor: Constants().primaryAppColor.withOpacity(0.8),
          onConfirmBtnTap: () async {
          }
      );
    }
  }*/

  static String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }


 /* final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Constants().primaryAppColor, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: Offset(2, 4),
            )
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Constants().primaryAppColor),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('Please fill required fields !!',
                  style: TextStyle(color: Colors.black)),
            ),
            const Spacer(),

          ],
        )),


  );*/
}
