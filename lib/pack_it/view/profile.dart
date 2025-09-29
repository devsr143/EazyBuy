import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pack_bags/application/auth/view_model/auth_provider.dart';
import 'package:pack_bags/pack_it/view/Edit_profilr.dart';
import 'package:pack_bags/pack_it/view/address_page.dart';
import 'package:pack_bags/pack_it/view/od.dart';
import 'package:provider/provider.dart';
import '../widgets/Custom.dart';
import 'Help&Support.dart';
import 'Privacypage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "Name"; // default
  String email = "email@example.com"; // default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text("PROFILE"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25),
        actions: const [
          Icon(Iconsax.setting, color: Colors.white),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Profile Image
          const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            backgroundImage: AssetImage("assets/ad banner/SEO.jpeg"),
          ),

          const SizedBox(height: 10),

          // Display updated name and email
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            email,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),

          const SizedBox(height: 20),

          // ---------------- Options ----------------

          // Edit Profile
          GestureDetector(
            onTap: () async {
              // Navigate to EditProfilePage and wait for result
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ),
              );
              if (result != null && result is Map<String, String>) {
                setState(() {
                  name = result['name'] ?? name;
                  email = result['email'] ?? email;
                });
              }
            },
            child: const CustomContainer(
              title: "Edit Profile",
              icon: Iconsax.profile_circle,
            ),
          ),
          GestureDetector(
            onTap: () {
            },
            child: const CustomContainer(
              title: "Orders",
              icon: Iconsax.bag,
            ),
          ),

          // Address
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddAddressPage()),
              );
            },
            child: const CustomContainer(
              title: "Address",
              icon: Iconsax.home,
            ),
          ),

          // Privacy
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyPage()),
              );
            },
            child: const CustomContainer(
              title: "Privacy policy",
              icon: Iconsax.security,
            ),
          ),

          // Help
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()),
              );
            },
            child: const CustomContainer(
              title: "Help and support",
              icon: Iconsax.support,
            ),
          ),

          const SizedBox(height: 20),

          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Confirm Logout"),
                  content: const Text("Are you sure you want to log out?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Provider.of<AuthProvider>(context, listen: false).logout(context);
                      },
                      child: const Text("Logout"),
                    ),
                  ],
                ),
              );
            } ,
            child: const CustomContainer(
              title: "Logout",
              icon: Iconsax.logout,
            ),
          ),
        ],
      ),
    );
  }
}


