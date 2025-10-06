import 'package:flutter/material.dart';
class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
        backgroundColor: Colors.black,
        title: Text("PRIVACY POLICY"),
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 25),
      ),
      body: SingleChildScrollView(

        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Privacy policy for Safe Basket",style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white
            ),),
            SizedBox(height: 8,),
            Text("Last Updated:September 9,2025",style: TextStyle(color: Colors.white),),
            SizedBox(height: 20,),
            Text(
              "This Privacy Policy describes how Safe Basket (\"we,\" \"our,\" or \"us\") "
                  "collects, uses, and protects your personal information when you use our mobile "
                  "application or website (the \"Service\") to purchase products.\n\n"
                  "By using the Service, you agree to the collection and use of information in "
                  "accordance with this policy.",
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),

            SizedBox(height: 20),
            Text("1. Information We Collect", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white)),
            SizedBox(height: 8),
            Text(
              "• Personal Identification Information: Your name, email, phone number, shipping address.\n"
                  "• Payment Information: Securely processed by a third-party gateway (we don’t store full card details).\n"
                  "• Transaction Information: Products purchased, transaction date/time, amount charged.\n"
                  "• Account Information: Login credentials, order history, wishlists, preferences.\n"
                  "• Technical Data: Device details, IP address, browser type, OS, unique device IDs.\n"
                  "• Usage Data: Pages viewed, searches, time spent in the Service.",
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),

            SizedBox(height: 20),
            Text("2. How We Use Your Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white)),
            SizedBox(height: 8),
            Text(
              "• To Provide and Maintain the Service\n"
                  "• To Improve and Personalize your experience\n"
                  "• To Communicate with you (orders, updates, promotions)\n"
                  "• To Ensure Security (fraud prevention, unauthorized access)\n"
                  "• For Legal Compliance",
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),

            SizedBox(height: 20),
            Text("3. Data Sharing and Disclosure", style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(
              "We do not sell your personal information. We may share it with:\n"
                  "• Service Providers (payments, shipping, analytics, IT support)\n"
                  "• Legal Authorities (when required by law)\n"
                  "• Business Transfers (in case of mergers or acquisitions)",
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),

            SizedBox(height: 20),
            Text("4. Data Security", style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(
              "We use encryption, firewalls, and secure access controls to protect your data. "
                  "However, no method of storage or transmission is 100% secure.",
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),

            SizedBox(height: 20),
            Text("5. Your Rights and Choices", style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(
              "• Access and Correction of your data\n"
                  "• Request Deletion (subject to legal obligations)\n"
                  "• Opt-Out of marketing emails anytime",
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),

            SizedBox(height: 20),
            Text("6. Children's Privacy", style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(
              "We do not knowingly collect personal information from children under 13. "
                  "If discovered, we will delete it.",
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),

            SizedBox(height: 20),
            Text("7. Changes to This Policy", style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(
              "We may update this Privacy Policy. Updates will be posted here with a revised "
                  "\"Last Updated\" date.",
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),

            SizedBox(height: 20),
            Text("8. Contact Us", style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(
              "Email: support@safebasket.com\n"
                  "Address: Safe Basket, Vadakara, Kozhikode, India",
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}