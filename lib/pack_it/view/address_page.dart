import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pack_bags/validator.dart';
import '../model/address_model.dart';

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

  late Box<AddressModel> _addressBox;

  @override
  void initState() {
    super.initState();
    _addressBox = Hive.box<AddressModel>('addresses');
  }

  Future<void> _saveAddress() async {
    if (_formKey.currentState!.validate()) {
      final address = AddressModel(
        name: _nameController.text,
        phone: _phoneController.text,
        street: _streetController.text,
        city: _cityController.text,
        state: _stateController.text,
        zipCode: _zipController.text,
      );

      await _addressBox.add(address);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Address Saved!')),
      );

      _nameController.clear();
      _phoneController.clear();
      _streetController.clear();
      _cityController.clear();
      _stateController.clear();
      _zipController.clear();

      setState(() {}); // Refresh the list below
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
               SizedBox(height: 20),
               Divider(color: Colors.white54),
               SizedBox(height: 10),
               Text("Saved Addresses", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
               SizedBox(height: 10),
              ValueListenableBuilder(
                valueListenable: _addressBox.listenable(),
                builder: (context, Box<AddressModel> box, _) {
                  if (box.values.isEmpty) {
                    return const Center(
                      child: Text(
                        "No addresses saved yet.",
                        style: TextStyle(color: Colors.white54),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      final address = box.getAt(index);
                      return Card(
                        color: Colors.grey[900],
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(address!.name, style: const TextStyle(color: Colors.white)),
                          subtitle: Text(
                            "${address.street}, ${address.city}, ${address.state}, ${address.zipCode}\nPhone: ${address.phone}",
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () {
                              // Delete the selected address
                              address.delete();
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
