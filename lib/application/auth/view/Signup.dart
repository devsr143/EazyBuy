// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:pack_bags/application/auth/view/Login.dart';
// import 'package:pack_bags/application/auth/view_model/auth_provider.dart';
// import 'package:pack_bags/validator.dart';
// import 'package:provider/provider.dart';
//
// class CreateAccountScreen extends StatefulWidget {
//   const CreateAccountScreen({super.key});
//
//   @override
//   State<CreateAccountScreen> createState() => _CreateAccountScreenState();
// }
//
// class _CreateAccountScreenState extends State<CreateAccountScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool isloading = false;
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();
//
//   bool _isPasswordVisible = true;
//   bool _isConfirmPasswordVisible = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.center,
//             colors: [
//               Color(0xFF0f261e), // dark greenish tone
//               Color(0xFF000000), // black
//             ],
//           ),
//         ),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   spacing: 25,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withValues(alpha: 0.1),
//                           ),
//                           child: IconButton(
//                             onPressed: () => Navigator.pop(context),
//                             icon: const Icon(Iconsax.arrow_left, color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Text(
//                            "SIGN UP",
//                            style: TextStyle(
//                              color: Colors.white,
//                              fontSize: 28,
//                              fontWeight: FontWeight.bold,
//                            ),
//                          ),
//                          Text(
//                            "Create your account to enter.",
//                            style: TextStyle(color: Colors.white54, fontSize: 15),
//                          ),
//                        ],
//                      ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child:
//                           TextFormField(
//                             validator: (value)=>Validator.validateEmptyField("name", value),
//                             style: const TextStyle(color: Colors.white),
//                             decoration: InputDecoration(
//                               hintText: "First name",
//                               hintStyle: const TextStyle(color: Colors.white54),
//                               filled: true,
//                               fillColor: Colors.white.withValues(alpha: 0.1),
//                               prefixIcon: const Icon(Iconsax.personalcard4, color: Colors.white54),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: TextFormField(
//                             validator: (value)=>Validator.validateEmptyField("name", value),
//                             style: const TextStyle(color: Colors.white),
//                             decoration: InputDecoration(
//                               hintText: "Last name",
//                               hintStyle: const TextStyle(color: Colors.white54),
//                               filled: true,
//                               fillColor: Colors.white.withValues(alpha: 0.1),
//                               prefixIcon: const Icon(Iconsax.personalcard4, color: Colors.white54),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     TextFormField(
//                       controller: emailController,
//                       validator: (value)=>Validator.validateEmail(value),
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         hintText: "Enter your email",
//                         hintStyle: const TextStyle(color: Colors.white54),
//                         filled: true,
//                         fillColor: Colors.white.withValues(alpha: 0.1),
//                         prefixIcon: const Icon(Iconsax.sms, color: Colors.white54),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: passwordController,
//                       validator: (value)=>Validator.validatePassword(value),
//                       obscureText: _isPasswordVisible,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         hintText: "Enter your Password",
//                         hintStyle: const TextStyle(color: Colors.white54),
//                         filled: true,
//                         fillColor: Colors.white.withValues(alpha: 0.1),
//                         prefixIcon: const Icon(Iconsax.lock, color: Colors.white54),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _isPasswordVisible ? Iconsax.eye_slash : Iconsax.eye,
//                             color: Colors.white54,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _isPasswordVisible = !_isPasswordVisible;
//                             });
//                           },
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: confirmPasswordController,
//                       validator: (value)=>Validator.validatePassword(value),
//                       obscureText: true,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         hintText: "Confirm your Password",
//                         hintStyle: const TextStyle(color: Colors.white54),
//                         filled: true,
//                         fillColor: Colors.white.withValues(alpha: 0.1),
//                         prefixIcon: const Icon(Iconsax.lock, color: Colors.white54),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _isConfirmPasswordVisible ? Iconsax.eye_slash : Iconsax.eye,
//                             color: Colors.white54,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//                             });
//                           },
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                     Consumer<AuthProvider>(
//                       builder: (context, auth, _) {
//                         return auth.isLoading
//                             ? const Center(child: CircularProgressIndicator(color: Colors.greenAccent))
//                             : SizedBox(
//                           width: double.infinity,
//                           height: 50,
//                           child: DecoratedBox(
//                             decoration: BoxDecoration(
//                               gradient: const LinearGradient(
//                                 colors: [Color(0xFF56f78d), Color(0xFF00c853)],
//                               ),
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 if (_formKey.currentState!.validate()) {
//                                   if (passwordController.text != confirmPasswordController.text) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(content: Text("Passwords do not match")),
//                                     );
//                                     return;
//                                   }
//
//                                   Provider.of<AuthProvider>(context, listen: false).signUp(
//                                     emailController.text.trim(),
//                                     passwordController.text.trim(),
//                                     context,
//                                   );
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.transparent,
//                                 shadowColor: Colors.transparent,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                               ),
//                               child: const Text("CREATE ACCOUNT", style: TextStyle(fontSize: 16, color: Colors.black)),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     Row(
//                       children: [
//                         const Expanded(child: Divider(color: Colors.white24)),
//                         const Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Text("Or", style: TextStyle(color: Colors.white54)),
//                         ),
//                         const Expanded(child: Divider(color: Colors.white24)),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "Already have an account ",
//                           style: TextStyle(color: Colors.white54,fontSize: 15),
//                         ),
//                         Spacer(),
//                         TextButton(onPressed: (){
//                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
//                         },
//                             child: Text("LOGIN",style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),))
//                       ],
//                     ),
//                     const SizedBox(height: 2),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton.icon(
//                             style: OutlinedButton.styleFrom(
//                               side: const BorderSide(color: Colors.white24),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                             ),
//                             onPressed: () {},
//                             icon: const Icon(Icons.g_mobiledata_rounded, color: Colors.white, size: 28),
//                             label: const Text("Google", style: TextStyle(color: Colors.white)),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: OutlinedButton.icon(
//                             style: OutlinedButton.styleFrom(
//                               side: const BorderSide(color: Colors.white24),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                             ),
//                             onPressed: () {},
//                             icon: const Icon(Icons.apple, color: Colors.white, size: 28),
//                             label: const Text("Apple", style: TextStyle(color: Colors.white)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pack_bags/application/auth/view/Login.dart';
import 'package:pack_bags/application/auth/view_model/auth_provider.dart';
import 'package:pack_bags/validator.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [
              Color(0xFF0f261e), // dark greenish tone
              Color(0xFF000000), // black
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  spacing: 25,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Iconsax.arrow_left, color: Colors.white),
                          ),
                        ),
                      ],
                    ),

                    // Title
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "SIGN UP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Create your account to enter.",
                          style: TextStyle(color: Colors.white54, fontSize: 15),
                        ),
                      ],
                    ),

                    // First & Last name
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: firstnameController,
                            validator: (value) =>
                                Validator.validateEmptyField("First name", value),
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "First name",
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.white.withValues(alpha: 0.1),
                              prefixIcon: const Icon(Iconsax.personalcard4, color: Colors.white54),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: lastnameController,
                            validator: (value) =>
                                Validator.validateEmptyField("Last name", value),
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Last name",
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.white.withValues(alpha: 0.1),
                              prefixIcon: const Icon(Iconsax.personalcard4, color: Colors.white54),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Email
                    TextFormField(
                      controller: emailController,
                      validator: (value) => Validator.validateEmail(value),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.1),
                        prefixIcon: const Icon(Iconsax.sms, color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    // Password
                    TextFormField(
                      controller: passwordController,
                      validator: (value) => Validator.validatePassword(value),
                      obscureText: _isPasswordVisible,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter your Password",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.1),
                        prefixIcon: const Icon(Iconsax.lock, color: Colors.white54),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Iconsax.eye_slash : Iconsax.eye,
                            color: Colors.white54,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    // Confirm Password
                    TextFormField(
                      controller: confirmPasswordController,
                      validator: (value) => Validator.validatePassword(value),
                      obscureText: _isConfirmPasswordVisible,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Confirm your Password",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.1),
                        prefixIcon: const Icon(Iconsax.lock, color: Colors.white54),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible ? Iconsax.eye_slash : Iconsax.eye,
                            color: Colors.white54,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    // Sign Up Button
                    Consumer<AuthProvider>(
                      builder: (context, auth, _) {
                        return auth.isLoading
                            ? const Center(
                            child: CircularProgressIndicator(color: Colors.greenAccent))
                            : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF56f78d), Color(0xFF00c853)],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (passwordController.text !=
                                      confirmPasswordController.text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Passwords do not match")),
                                    );
                                    return;
                                  }

                                  Provider.of<AuthProvider>(context, listen: false)
                                      .signUp(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                    firstnameController.text.trim(),
                                    lastnameController.text.trim(),
                                    context,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text("CREATE ACCOUNT",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                            ),
                          ),
                        );
                      },
                    ),

                    // Divider with OR
                    Row(
                      children: const [
                        Expanded(child: Divider(color: Colors.white24)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child:
                          Text("Or", style: TextStyle(color: Colors.white54)),
                        ),
                        Expanded(child: Divider(color: Colors.white24)),
                      ],
                    ),

                    // Login Redirect
                    Row(
                      children: [
                        const Text(
                          "Already have an account ",
                          style: TextStyle(color: Colors.white54, fontSize: 15),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text("LOGIN",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),

                    // Social Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white24),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.g_mobiledata_rounded,
                                color: Colors.white, size: 28),
                            label: const Text("Google",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white24),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.apple,
                                color: Colors.white, size: 28),
                            label: const Text("Apple",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
