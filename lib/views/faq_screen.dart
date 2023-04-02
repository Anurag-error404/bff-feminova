import 'package:feminova/app/app_constants.dart';
import 'package:feminova/app/colors.dart';
import 'package:feminova/views/chat_screen.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  var faq = {
    "FAQs": [
      {
        "question": "What is a menstrual cycle?",
        "answer":
            "The menstrual cycle is the series of changes that occur in a woman's body to prepare for pregnancy. It involves the shedding of the uterine lining through bleeding, followed by the buildup of the lining again."
      },
      {
        "question": "How long does a menstrual cycle last?",
        "answer":
            "The length of the menstrual cycle can vary, but the average is 28 days. However, cycles can be as short as 21 days or as long as 35 days."
      },
      {
        "question": "What are the stages of the menstrual cycle?",
        "answer":
            "The menstrual cycle has four stages: the menstrual phase, the follicular phase, ovulation, and the luteal phase."
      },
      {
        "question": "What is ovulation and how does it occur?",
        "answer":
            "Ovulation is the release of an egg from the ovary. It occurs around day 14 of a 28-day menstrual cycle. The egg travels down the fallopian tube, where it can be fertilized by sperm."
      },
      {
        "question": "Can you get pregnant during your period?",
        "answer":
            "It is possible to get pregnant during your period, though it is less likely. Sperm can survive in the female reproductive tract for up to five days, so if you have sex near the end of your period and ovulate shortly after, you could still get pregnant."
      },
      {
        "question": "What are the common symptoms of PMS?",
        "answer":
            "Common symptoms of premenstrual syndrome (PMS) include bloating, cramps, mood swings, fatigue, and headaches."
      },
      {
        "question": "What are some ways to alleviate menstrual cramps?",
        "answer":
            "Some ways to alleviate menstrual cramps include taking over-the-counter pain medication, using a heating pad, practicing relaxation techniques, and getting regular exercise."
      },
      {
        "question": "How can irregular periods be treated?",
        "answer":
            "Irregular periods can be treated with hormonal birth control, lifestyle changes, and medication to regulate hormone levels."
      },
      {
        "question": "What is menorrhagia and how is it treated?",
        "answer":
            "Menorrhagia is abnormally heavy or prolonged menstrual bleeding. It can be treated with medication, such as hormonal birth control or nonsteroidal anti-inflammatory drugs (NSAIDs), or with surgical options."
      },
      {
        "question": "Is it normal to have a heavy or light flow during menstruation?",
        "answer":
            "It is normal for menstrual flow to vary from person to person. Some people may have heavy flows, while others may have light flows."
      },
      {
        "question": "How can one track their menstrual cycle?",
        "answer":
            "One can track their menstrual cycle by keeping a record of their period start and end dates, as well as any symptoms they experience throughout their cycle. There are also apps and tools available to help with tracking."
      },
      {
        "question": "How does hormonal birth control affect the menstrual cycle?",
        "answer":
            "Hormonal birth control can affect the menstrual cycle by regulating hormone levels and changing the frequency and intensity of menstrual bleeding."
      },
      {
        "question": "What are some natural remedies for menstrual discomfort?",
        "answer":
            "Some natural remedies for menstrual discomfort include herbal teas, aromatherapy, yoga, and acupuncture."
      },
      {
        "question": "When should one see a doctor for menstrual irregularities?",
        "answer":
            "One should see a doctor for menstrual irregularities if they experience heavy bleeding, periods that last longer than usual, or periods that are accompanied by severe pain or other symptoms."
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpaceSmall,
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        // height: 130,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),

                        decoration: BoxDecoration(
                          color: Color(0xffb2eee6),
                          borderRadius: BorderRadius.circular(curve15),
                        ),
                        child: Column(children: const [
                          Icon(
                            Icons.whatsapp,
                            size: 40,
                          ),
                          verticalSpaceSmall,
                          Text(
                            "Connect on Whatsapp",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    horizontalSpaceSmall,
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ChatScreen(eventName: 'Femenova Expert')));
                        },
                        child: Container(
                          // height: 130,
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          decoration: BoxDecoration(
                            // color: AppColor.accentMain.withOpacity(0.5),
                          color: Color(0xffb2eee6),

                            borderRadius: BorderRadius.circular(curve15),
                          ),
                          child: Column(children: const [
                            Icon(
                              Icons.person,
                              size: 40,
                            ),
                            verticalSpaceSmall,
                            Text(
                              "Connect with Expert",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpaceMedium,
                Text(
                  "Common FAQs",
                  style: TextStyle(
                    color: Colors.grey[404],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceSmall,
                ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 8,
                      );
                    },
                    itemCount: faq['FAQs']?.length ?? 0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      Map<String, String> x = faq['FAQs']![i];
                      return CustomExpandedList(title: x['question']!, detail: x['answer']!);
                    }),
                verticalSpaceLarge_1,
              ],
            ),
          )),
    );
  }
}

class CustomExpandedList extends StatefulWidget {
  final String title;
  final String detail;
  const CustomExpandedList({super.key, required this.title, required this.detail});

  @override
  State<CustomExpandedList> createState() => _CustomExpandedListState();
}

class _CustomExpandedListState extends State<CustomExpandedList> {
  bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: AppColor.accentMain.withOpacity(0.1), borderRadius: BorderRadius.circular(curve10)),
      child: ExpansionTile(
        title: Text(widget.title),
        // subtitle: const Text('Custom expansion arrow icon'),
        trailing: Icon(
          _customTileExpanded ? Icons.arrow_drop_up_sharp : Icons.arrow_drop_down,
        ),
        children: <Widget>[
          ListTile(title: Text(widget.detail)),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _customTileExpanded = expanded);
        },
      ),
    );
  }
}
