import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pack_bags/core/utils/validator.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  Future<void> _saveAddress() async {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not logged in')),
        );
        return;
      }

      final addressData = {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'street': _streetController.text,
        'city': _cityController.text,
        'state': _stateController.text,
        'zipCode': _zipController.text,
        'timestamp': FieldValue.serverTimestamp(),
      };

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('addresses')
            .add(addressData);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Address saved to your account!')),
        );

        _nameController.clear();
        _phoneController.clear();
        _streetController.clear();
        _cityController.clear();
        _stateController.clear();
        _zipController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving address: $e')),
        );
      }
    }
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, String field) {
    return TextFormField(
      controller: controller,
      validator: (value) => Validator.validateEmptyField(field, value),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white10,
        prefixIcon: Icon(icon, color: Colors.white54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Add Address", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(_nameController, "Full name", Iconsax.personalcard4, "name"),
                    const SizedBox(height: 10),
                    _buildTextField(_phoneController, "Phone Number", Iconsax.call, "phone"),
                    const SizedBox(height: 10),
                    _buildTextField(_streetController, "Street address", Iconsax.home, "street"),
                    const SizedBox(height: 10),
                    _buildTextField(_cityController, "City", Iconsax.bookmark, "city"),
                    const SizedBox(height: 10),
                    _buildTextField(_stateController, "State", Iconsax.map, "state"),
                    const SizedBox(height: 10),
                    _buildTextField(_zipController, "Pincode", Iconsax.bookmark_2, "pincode"),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _saveAddress,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            "SAVE ADDRESS",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.white54),
              const SizedBox(height: 10),
              const Text("Saved Addresses", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              if (user == null)
                const Text("Please log in to view saved addresses", style: TextStyle(color: Colors.white54))
              else
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .collection('addresses')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final docs = snapshot.data!.docs;

                    if (docs.isEmpty) {
                      return const Center(
                        child: Text("No addresses saved yet.", style: TextStyle(color: Colors.white54)),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index].data() as Map<String, dynamic>;
                        return Card(
                          color: Colors.grey[900],
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(data['name'], style: const TextStyle(color: Colors.white)),
                            subtitle: Text(
                              "${data['street']}, ${data['city']}, ${data['state']}, ${data['zipCode']}\nPhone: ${data['phone']}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () async {
                                await docs[index].reference.delete();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Address deleted')),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}