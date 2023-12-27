import 'package:automata_project/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/userAuth_controller.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  late TextEditingController searchTextEditingController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: const Text('Smart Talk'),
              actions: [
                IconButton(
                    onPressed: () => null, icon: const Icon(Icons.logout)),
              ]),
        ));
  }

  Widget buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.person_search,
            color: AppColors.secondaryColor,
            size: 24,
          ),
          const SizedBox(
            width: 5,
          ),
          // Expanded(
          //   child: TextFormField(
          //     textInputAction: TextInputAction.search,
          //     controller: searchTextEditingController,
          //     onChanged: (value) {
          //       if (value.isNotEmpty) {
          //         buttonClearController.add(true);
          //         setState(() {
          //           _textSearch = value;
          //         });
          //       } else {
          //         buttonClearController.add(false);
          //         setState(() {
          //           _textSearch = "";
          //         });
          //       }
          //     },
          //     decoration: const InputDecoration.collapsed(
          //       hintText: 'Search here...',
          //       hintStyle: TextStyle(color: AppColors.white),
          //     ),
          //   ),
          // ),
          // StreamBuilder(
          //     stream: buttonClearController.stream,
          //     builder: (context, snapshot) {
          //       return snapshot.data == true
          //           ? GestureDetector(
          //               onTap: () {
          //                 searchTextEditingController.clear();
          //                 buttonClearController.add(false);
          //                 setState(() {
          //                   _textSearch = '';
          //                 });
          //               },
          //               child: const Icon(
          //                 Icons.clear_rounded,
          //                 color: AppColors.greyColor,
          //                 size: 20,
          //               ),
          //             )
          //           : const SizedBox.shrink();
          //     })
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.secondaryColor,
      ),
    );
  }
}
