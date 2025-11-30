import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  final List<Map<String, String>> faqList = [
    {
      "question": "What is Barberz Link?",
      "answer":
          "Barberz Link is a platform that connects barbers, barbershops, product companies, schools, and service providers in one place."
    },
    {
      "question": "Is Barberz Link free to use?",
      "answer":
          "Yes, basic features are free. However, some premium features may require subscriptions."
    },
    {
      "question": "Does Barberz Link verify user information?",
      "answer":
          "No. Users must verify all licensing, job details, financial information, and product details themselves."
    },
    {
      "question": "How do I create an account?",
      "answer":
          "You can create an account using your email, phone number, or social login options available in the app."
    },
    {
      "question": "How can I contact support?",
      "answer":
          "You can reach us anytime at contact@barberzlink.com or call 904-319-3632."
    },
    {
      "question": "Is my personal data secure?",
      "answer":
          "We use reasonable security measures, but like all apps, 100% security cannot be guaranteed."
    },
    {
      "question": "Can I delete my account?",
      "answer":
          "Yes. You may request account deletion by contacting our support team via email."
    },
    {
      "question": "Who can use Barberz Link?",
      "answer":
          "Barbers, shop owners, students, product companies, and service providers can use the platform."
    },
    {
      "question": "Is Barberz Link available outside the US?",
      "answer":
          "Yes. Anyone worldwide can use the app, but licensing and regulatory information must be verified locally."
    },
    {
      "question": "Does Barberz Link sell my information?",
      "answer": "No. We do not sell or trade user information."
    },
  ];

  // Track Expanded Tiles
  List<bool> expanded = [];

  @override
  void initState() {
    super.initState();

    expanded = List.generate(faqList.length, (index) => false);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildFAQCard(int index) {
    final item = faqList[index];
    final isOpen = expanded[index];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.08),
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            expanded[index] = !expanded[index];
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question row
            Row(
              children: [
                Expanded(
                  child: Text(
                    item['question']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 250),
                  turns: isOpen ? 0.5 : 0,
                  child:
                      const Icon(Icons.keyboard_arrow_down_rounded, size: 26),
                ),
              ],
            ),

            // Expandable Answer
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 250),
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  item['answer']!,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              crossFadeState:
                  isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FAQ"), centerTitle: true, elevation: 0),
      body: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              const Text(
                "Frequently Asked Questions",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),

              // FAQ Cards
              for (int i = 0; i < faqList.length; i++) buildFAQCard(i),
            ],
          ),
        ),
      ),
    );
  }
}
