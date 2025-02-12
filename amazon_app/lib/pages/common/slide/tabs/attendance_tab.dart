import 'package:amazon_app/pages/src/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceTab extends ConsumerStatefulWidget {
  const AttendanceTab({super.key});

  @override
  ConsumerState createState() => AttendanceTabState();
}

class AttendanceTabState extends ConsumerState<AttendanceTab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        await Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
            builder: (context) => const HomePage(),
          ),
          (_) => false,
        );
      },
      child: Container(
        width: 180,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: Row(
          children: [
            Container(
              width: 33,
              height: 33,
              decoration: BoxDecoration(
                color: const Color.fromARGB(210, 194, 136, 223),
                borderRadius: BorderRadius.circular(33),
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                ),
              ),
            ),
            const Text(
              '出席簿',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF7B61FF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





// child: IntrinsicHeight(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 width: 33,
//                 height: 33,
//                 decoration: BoxDecoration(
//                   color: const Color.fromRGBO(255, 255, 255, 0.20),
//                   borderRadius: BorderRadius.circular(33),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'all',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       color: Color.fromRGBO(255, 255, 255, 0.80),
//                     ),
//                   ),
//                 ),
//               ),
//               const Text(
//                 '出席簿',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                 ),
//               ),
//               const Icon(
//                 Icons.expand_more,
//                 size: 30,
//                 color: Colors.white,
//               ),
//             ],
//           ),
//         ),