import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  // List FAQ statis sesuai desain
  final List<Map<String, String>> faqList = [
    {
      "question": "Whats is Therapalsy?",
      "answer":
          "Therapalsy is an application designed to help users detect Bell's Palsy symptoms and provide appropriate therapy recommendations. The application uses intelligent algorithms to analyze symptoms and provide recovery guidance.",
    },
    {
      "question": "How does the Therapalsy app work?",
      "answer": "",
    },
    {
      "question": "What are the features of TheraPalsy?",
      "answer": "",
    },
    {
      "question": "Is Therapalsy available for iOS and Android devices?",
      "answer": "",
    },
    {
      "question": "Is there a cost to use the TheraPalsy app?",
      "answer": "",
    },
  ];

  // Gunakan RxInt dari GetX untuk index panel yang terbuka
  final RxInt expandedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    // Pastikan controller sudah diinject lewat binding
    final ProfileController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        title: const Text(
          "F A Q",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Obx(
        () => ListView.separated(
          itemCount: faqList.length,
          separatorBuilder: (context, idx) => const Divider(
            color: Color(0xFFBDBDBD),
            height: 0,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          itemBuilder: (context, idx) {
            final isExpanded = expandedIndex.value == idx;
            final isFirst = idx == 0;
            final question = faqList[idx]['question']!;
            final answer = faqList[idx]['answer']!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    expandedIndex.value = isExpanded ? -1 : idx;
                  },
                  child: Container(
                    color: isExpanded && isFirst
                        ? const Color(0xFFFF7E7E)
                        : Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            question,
                            style: TextStyle(
                              color: isExpanded && isFirst
                                  ? Colors.white
                                  : const Color(0xFF2A3A3D),
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right,
                          color: isExpanded && isFirst
                              ? Colors.white
                              : const Color(0xFF2A3A3D),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isExpanded && answer.isNotEmpty)
                  Container(
                    color: const Color(0xFFFF7E7E),
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      answer,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
