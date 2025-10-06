import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../widget/Faqcard.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {

  final List<Map<String, String>> faqList = [
    {
      'Question': 'How do I place an order?',
      'Answer': 'You can browse our products, add them to your cart, and proceed to checkout. Simply fill in your shipping and payment details to complete the purchase.',
    },
    {
      'Question': 'What are the accepted payment methods?',
      'Answer': 'We accept all major credit cards, debit cards, and secure online payment options. Your payment information is processed securely by our trusted payment gateway.',
    },
    {
      'Question': 'How can I track my order?',
      'Answer': 'Once your order is shipped, you will receive an email with a tracking number and a link to the courier\'s website. You can use this to monitor your shipment\'s progress.',
    },
    {
      'Question': 'What is your return policy?',
      'Answer': 'We have a hassle-free return policy. You can return any item within 30 days of delivery for a full refund or exchange. The item must be unused and in its original packaging.',
    },
    {
      'Question': 'Is my personal information secure?',
      'Answer': 'Yes, we take your privacy seriously. We use industry-standard security measures to protect your personal information. You can read our full Privacy Policy for more details.',
    },
  ];

  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    final filteredFaqList = faqList.where((faq)=>
    faq["Question"]!.toLowerCase().contains(searchQuery.toLowerCase())||
        faq["Answer"]!.toLowerCase()
            .contains(searchQuery.toLowerCase())).toList();
    return Scaffold(
      backgroundColor: Colors.black,
       appBar: AppBar(
         backgroundColor: Colors.black,
         automaticallyImplyLeading: false,
         leading: IconButton(
             onPressed: (){
               Navigator.pop(context);
             }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
         title:Text("Help & Support",style: TextStyle(color: Colors.white),),
         actions: [
           Icon(Iconsax.support,color: Colors.white,),
           SizedBox(
             width: 10,
           )
         ],
       ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Iconsax.search_normal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
              onChanged: (value){
                setState(() {
                  searchQuery=value;
                });
              },
            ),
            SizedBox(height: 20,),
            Text("Frequently Asked Questions",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
            color: Colors.white),
            ),
            SizedBox(height: 10,),
            ...filteredFaqList.map((faqList) => FaqCard(
              question: faqList["Question"]!,
              answer: faqList["Answer"]!,
            ),
            ),
          ],
        ),
      ),
    );
  }
}