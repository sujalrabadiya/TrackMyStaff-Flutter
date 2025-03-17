import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:track_my_staff/models/userModel.dart';
import 'package:track_my_staff/screens/splash.dart';
import 'package:track_my_staff/services/admin_service.dart';
import 'package:track_my_staff/services/chat_service.dart';
import 'package:track_my_staff/theme.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  // List<String> listRole = <String>['Role', 'Admin', 'Supervisor', 'Staff'];
  // String dropdownValueRole = 'Role';
  File? _selectedImage;
  String dropdownValueRoleEdit = 'Staff';

  Future<String?> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      return await ChatService.uploadImageToCloudinary(_selectedImage!);
    }
  }

  Future<void> addEdit(UserModel user) async {
    if(user.id == 0) {
      await AdminService.addUser(user);
    } else {
      await AdminService.editUserById(user);
    }
    setState(() {
      Navigator.of(context).pop();
    });
  }

  Widget role(role) {
    if (finalRole == 'Admin') {
      List<String> listRoleEdit = <String>['Admin', 'Supervisor', 'Staff'];
      dropdownValueRoleEdit = role;
      return Padding(
        padding: kDefaultPadding2,
        child: Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
          height: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: kWhiteColor,
          ),
          child: DropdownButton(
            value: dropdownValueRoleEdit,
            dropdownColor: kWhiteColor,
            menuMaxHeight: 150,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: kPrimaryColor,
              size: 22,
            ),
            elevation: 3,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
            underline: SizedBox(),
            items: listRoleEdit.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                dropdownValueRoleEdit = value!;
              });
            },
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget RestrictionDialog(operation){
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(4)),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 200,
            child: Padding(
              padding:
              EdgeInsets.fromLTRB(
                  10, 55, 10, 10),
              child: Column(
                children: [
                  Text(
                    "Warning !!!",
                    style: TextStyle(
                        fontWeight:
                        FontWeight
                            .bold,
                        fontSize: 20),
                    textAlign:
                    TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "You can not $operation this user!",
                    style: TextStyle(
                        fontSize: 15),
                    textAlign:
                    TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FilledButton(
                      onPressed: () {
                        Navigator.of(
                            context)
                            .pop();
                      },
                      child: Text(
                        "Okay",
                        style: TextStyle(
                            color:
                            kWhiteColor),
                      ))
                ],
              ),
            ),
          ),
          Positioned(
            child: CircleAvatar(
              backgroundColor:
              Colors.redAccent,
              radius: 40,
              child: Icon(
                Icons.assistant_photo,
                size: 30,
                color: kWhiteColor,
              ),
            ),
            top: -35,
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>?> userList() async {
    var users = AdminService.getAllUsers(finalCId);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Padding(
              //   padding: kDefaultPadding2,
              //   child: Container(
              //     padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
              //     height: 25,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(30),
              //       color: kWhiteColor,
              //     ),
              //     child: DropdownButton(
              //       value: dropdownValueRole,
              //       dropdownColor: kWhiteColor,
              //       menuMaxHeight: 150,
              //       icon: Icon(
              //         Icons.keyboard_arrow_down_rounded,
              //         color: kPrimaryColor,
              //         size: 20,
              //       ),
              //       elevation: 3,
              //       style: TextStyle(
              //           fontSize: 10,
              //           fontWeight: FontWeight.bold,
              //           color: kPrimaryColor),
              //       underline: SizedBox(),
              //       items: listRole.map<DropdownMenuItem<String>>((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text(value),
              //         );
              //       }).toList(),
              //       onChanged: (String? value) {
              //         setState(() {
              //           dropdownValueRole = value!;
              //         });
              //       },
              //     ),
              //   ),
              // ),
              Expanded(child: SizedBox()),
              Padding(
                padding: kDefaultPadding2,
                child: GestureDetector(
                  onTap: () {
                    String? imgUrl;
                    List<String> listRoleAdd = <String>[];
                    if (finalRole == 'Admin')
                      listRoleAdd = <String>['Admin', 'Supervisor', 'Staff'];
                    else
                      listRoleAdd = <String>['Staff'];
                    String dropdownValueRoleAdd = 'Staff';
                    var addName = TextEditingController();
                    var addPhone = TextEditingController();
                    var addEmail = TextEditingController();
                    var addPassword = TextEditingController();
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 450,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Add User",
                                    style: pageTitle,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => Wrap(
                                          children: [
                                            ListTile(
                                              leading: Icon(Icons.camera),
                                              title: Text("Camera"),
                                              onTap: () async {
                                                imgUrl = await _pickImage(ImageSource.camera);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.image),
                                              title: Text("Gallery"),
                                              onTap: () async {
                                                imgUrl = await _pickImage(ImageSource.gallery);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey[300],
                                      backgroundImage: _selectedImage != null
                                          ? FileImage(_selectedImage!)
                                          : null,
                                      child: _selectedImage == null
                                          ? Icon(Icons.camera_alt, color: Colors.grey[600])
                                          : Image.file(_selectedImage!, fit: BoxFit.fitHeight,),
                                    ),
                                  ),
                                  TextField(
                                    controller: addName,
                                    decoration: InputDecoration(
                                      labelText: "Name",
                                      suffix: Icon(
                                        Icons.edit_outlined,
                                        color: kPrimaryColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    controller: addPhone,
                                    decoration: InputDecoration(
                                      labelText: "Phone",
                                      suffix: Icon(
                                        Icons.phone_outlined,
                                        color: kPrimaryColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    controller: addEmail,
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      suffix: Icon(
                                        Icons.email_outlined,
                                        color: kPrimaryColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    controller: addPassword,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      suffix: Icon(
                                        Icons.password_outlined,
                                        color: kPrimaryColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: kDefaultPadding2,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 8, right: 8, top: 2, bottom: 2),
                                      height: 28,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: kWhiteColor,
                                      ),
                                      child: DropdownButton(
                                        value: dropdownValueRoleAdd,
                                        dropdownColor: kWhiteColor,
                                        menuMaxHeight: 150,
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: kPrimaryColor,
                                          size: 22,
                                        ),
                                        elevation: 3,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryColor),
                                        underline: SizedBox(),
                                        items: listRoleAdd
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            dropdownValueRoleAdd = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Cancel",
                                        style:
                                            TextStyle(color: kSecondaryColor),
                                      )),
                                  TextButton(
                                      onPressed: () async {
                                        final userData = UserModel(
                                          id: 0,
                                          phone: addPhone.text.trim(),
                                          email: addEmail.text.trim(),
                                          name: addName.text.trim(),
                                          role: dropdownValueRoleAdd,
                                          imgUrl: imgUrl,
                                          cId: finalCId,
                                          password: addPassword.text,
                                        );
                                        await addEdit(userData);
                                      },
                                      child: Text(
                                        "Add",
                                        style: TextStyle(color: kPrimaryColor),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kPrimaryColor,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: kWhiteColor,
                          size: 22,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Add New",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: kWhiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]),
        // Padding(
        //   padding: kDefaultPadding2,
        //   child: Container(
        //     decoration: ShapeDecoration(
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(30),
        //       ),
        //       color: Colors.white,
        //     ),
        //     height: 45,
        //     width: double.infinity,
        //     child: TextField(
        //       decoration: InputDecoration(
        //         hintText: "Search...",
        //         hintStyle: TextStyle(color: Colors.grey.shade600),
        //         prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
        //         border: InputBorder.none,
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 10,
        ),
        FutureBuilder(
          future: userList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    if(snapshot.data![index]["name"] == finalUName) {
                      return SizedBox();
                    } else {
                      return Card(
                      color: kWhiteColor,
                      shadowColor: Colors.amber,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading:
                            CircleAvatar(backgroundImage: NetworkImage(snapshot.data![index]["imgUrl"]),),
                        title: Text(
                          snapshot.data![index]["name"],
                          style: TextStyle(fontSize: 16),
                        ),
                        subtitle: Text(
                          snapshot.data![index]["role"],
                          style: TextStyle(fontSize: 13),
                        ),
                        trailing: PopupMenuButton(
                          onSelected: (value) async {
                            switch (value) {
                              case 'More Details':
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    // alignment: Alignment.center,
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: 300,
                                          width: double.maxFinite,
                                          padding: const EdgeInsets.only(
                                            top: 60,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8.0),
                                                  child: Text(
                                                    snapshot.data![index]
                                                        ["name"],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: kPrimaryColor),
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data![index]["role"],
                                                  style: TextStyle(
                                                      color: kSecondaryColor),
                                                ),
                                                const Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                                  child: Divider(
                                                    thickness: 0.5,
                                                    color: kDarkGreyColor,
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    snapshot.data![index]
                                                        ["phone"],
                                                    style: listTileText,
                                                  ),
                                                  leading: Icon(
                                                    Icons.phone_outlined,
                                                    size: 20,
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    snapshot.data![index]
                                                        ["email"],
                                                    style: listTileText,
                                                  ),
                                                  leading: Icon(
                                                    Icons.email_outlined,
                                                    size: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -45,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              child: Image.network(
                                                "https://th.bing.com/th/id/OIP.hGSCbXlcOjL_9mmzerqAbQHaHa?rs=1&pid=ImgDetMain",
                                                height: 90,
                                                width: 90,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                break;
                              case 'Edit':
                                if (finalRole == "Supervisor" &&
                                    (snapshot.data![index]["role"] == "Admin" ||
                                        snapshot.data![index]["role"] ==
                                            "Supervisor")) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) => RestrictionDialog("update"));
                                } else {
                                  String? imgUrl = snapshot.data![index]["imgUrl"];
                                  var editName = TextEditingController();
                                  editName.text = snapshot.data![index]["name"];
                                  var editPhone = TextEditingController();
                                  editPhone.text =
                                      snapshot.data![index]["phone"];
                                  var editEmail = TextEditingController();
                                  editEmail.text =
                                      snapshot.data![index]["email"];
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        height: 400,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  "Edit User",
                                                  style: pageTitle,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) => Wrap(
                                                        children: [
                                                          ListTile(
                                                            leading: Icon(Icons.camera),
                                                            title: Text("Camera"),
                                                            onTap: () async {
                                                              imgUrl = await _pickImage(ImageSource.camera);
                                                              Navigator.pop(context);
                                                            },
                                                          ),
                                                          ListTile(
                                                            leading: Icon(Icons.image),
                                                            title: Text("Gallery"),
                                                            onTap: () async {
                                                              imgUrl = await _pickImage(ImageSource.gallery);
                                                              Navigator.pop(context);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 40,
                                                    backgroundColor: Colors.grey[300],
                                                    backgroundImage: _selectedImage != null
                                                        ? FileImage(_selectedImage!)
                                                        : null,
                                                    child: _selectedImage == null
                                                        ? Icon(Icons.camera_alt, color: Colors.grey[600])
                                                        : Image.file(_selectedImage!, fit: BoxFit.fitHeight,),
                                                  ),
                                                ),
                                                TextField(
                                                  controller: editName,
                                                  decoration: InputDecoration(
                                                    labelText: "Name",
                                                    suffix: Icon(
                                                      Icons.edit_outlined,
                                                      color: kPrimaryColor,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                TextField(
                                                  controller: editPhone,
                                                  decoration: InputDecoration(
                                                    labelText: "Phone",
                                                    suffix: Icon(
                                                      Icons.phone_outlined,
                                                      color: kPrimaryColor,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                TextField(
                                                  controller: editEmail,
                                                  decoration: InputDecoration(
                                                    labelText: "Email",
                                                    suffix: Icon(
                                                      Icons.email_outlined,
                                                      color: kPrimaryColor,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                role(snapshot.data![index]
                                                    ["role"]),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color:
                                                              kSecondaryColor),
                                                    )),
                                                TextButton(
                                                    onPressed: () async {
                                                      if (finalRole ==
                                                          'Admin') {
                                                        UserModel userData = UserModel(
                                                            phone: editPhone
                                                                .text
                                                                .trim(),
                                                            role:
                                                                dropdownValueRoleEdit,
                                                            name: editName.text
                                                                .trim(),
                                                            id: snapshot.data![
                                                                    index]["id"]
                                                                as int,
                                                            email: editEmail
                                                                .text
                                                                .trim());
                                                        await addEdit(userData);
                                                      } else {
                                                        UserModel userData = UserModel(
                                                            phone: editPhone.text.trim(),
                                                            role: snapshot.data![index]["role"],
                                                            imgUrl: imgUrl,
                                                            name: editName.text.trim(),
                                                            id: snapshot.data![index]["id"] as int,
                                                            email: editEmail.text.trim(),
                                                            cId: finalCId
                                                        );
                                                        await addEdit(userData);
                                                      }
                                                    },
                                                    child: Text(
                                                      "Edit",
                                                      style: TextStyle(
                                                          color: kPrimaryColor),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                break;
                              case 'Delete':
                                if (finalRole == "Supervisor" &&
                                    (snapshot.data![index]["role"] == "Admin" ||
                                        snapshot.data![index]["role"] ==
                                            "Supervisor")) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) => RestrictionDialog("delete"));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            alignment: Alignment.center,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            icon: Icon(
                                              Icons.remove_circle_outline,
                                              size: 50,
                                            ),
                                            title: Text("Are you sure ?"),
                                            titleTextStyle: TextStyle(
                                                color: Colors.redAccent),
                                            content: Text(
                                              "You want to remove this user!",
                                              textAlign: TextAlign.center,
                                            ),
                                            actionsAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            iconColor: Colors.redAccent,
                                            actions: [
                                              OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                          visualDensity:
                                                              VisualDensity(
                                                                  horizontal:
                                                                      0),
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          side:
                                                              BorderSide.none),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Cancel")),
                                              OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                          visualDensity:
                                                              VisualDensity(
                                                                  horizontal:
                                                                      0),
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          side:
                                                              BorderSide.none),
                                                  onPressed: () async {
                                                    setState(() {
                                                      AdminService
                                                          .deleteUserById(
                                                              snapshot.data![
                                                                  index]["id"]);
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.redAccent),
                                                  )),
                                            ],
                                          ));
                                }
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return {'More Details', 'Edit', 'Delete'}
                                .map((String choice) {
                              return PopupMenuItem(
                                height: 30,
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    );
                    }
                  },
                ),
              );
            } else {
              return Center(
                child: Text("No Data Found!"),
              );
            }
          },
        ),
      ],
    );
  }
}
