// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:pack_bags/pack_it/view/root_page.dart';
// import 'package:pack_bags/validator.dart';
// import 'Signup.dart';
// import 'forgotpasswordscreen.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool isloading = false;
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Container(
//         decoration: BoxDecoration(
//           gradient:  LinearGradient(
//             begin: Alignment.topLeft,
//             end:  Alignment.center,
//             colors: [
//               Color(0xFF0f261e), // dark green
//               Color(0xFF000000), // Almost black
//           ],
//           )
//         ),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 spacing: 10,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withValues(alpha: 0.1),
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         child: const Row(
//                           children: [
//                             Icon(Icons.language, color: Colors.white, size: 18),
//                             SizedBox(width: 6),
//                             Text("English", style: TextStyle(color: Colors.white)),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 40),
//                   const Text(
//                     "Welcome Back",
//                     style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
//                   ),
//                   const Text(
//                     "Login to view daily mortgage updates.",
//                     style: TextStyle(color: Colors.white54, fontSize: 14),
//                   ),
//                   const SizedBox(height: 30),
//                   TextFormField(
//                     validator: (value)=>Validator.validateEmail(value),
//                     style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       hintText: "Enter your email",
//                       hintStyle: const TextStyle(color: Colors.white54),
//                       filled: true,
//                       fillColor: Colors.white.withValues(alpha: 0.1),
//                       prefixIcon: const Icon(Iconsax.sms, color: Colors.white54),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     validator: (value)=>Validator.validatePassword(value),
//                     obscureText: true,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       hintText: "Enter your Password",
//                       hintStyle: const TextStyle(color: Colors.white54),
//                       filled: true,
//                       fillColor: Colors.white.withValues(alpha: 0.1),
//                       prefixIcon: const Icon(Iconsax.lock, color: Colors.white54),
//                       suffixIcon: const Icon(Iconsax.eye_slash, color: Colors.white54),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
//                         },
//                         child: const Text("Forgot Password?", style: TextStyle(color: Colors.white)),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: DecoratedBox(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF56f78d), Color(0xFF00c853)],
//                         ),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if(_formKey.currentState!.validate()){
//                             setState(() => isloading =true);
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>RootPage()));
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.transparent,
//                           shadowColor: Colors.transparent,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         child: const Text("Log In", style: TextStyle(fontSize: 16)),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: const [
//                       Expanded(child: Divider(color: Colors.white24)),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text("Or", style: TextStyle(color: Colors.white54)),
//                       ),
//                       Expanded(child: Divider(color: Colors.white24)),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton.icon(
//                           style: OutlinedButton.styleFrom(
//                             side: const BorderSide(color: Colors.white24),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                           ),
//                           onPressed: () {},
//                           icon: const Icon(Icons.g_mobiledata, color: Colors.white, size: 28),
//                           label: const Text("Google", style: TextStyle(color: Colors.white)),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: OutlinedButton.icon(
//                           style: OutlinedButton.styleFrom(
//                             side: const BorderSide(color: Colors.white24),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                           ),
//                           onPressed: () {},
//                           icon: const Icon(Icons.apple, color: Colors.white, size: 28),
//                           label: const Text("Apple", style: TextStyle(color: Colors.white)),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   Center(
//                     child:
//                       Row(
//                         children: [
//                           Text(
//                             "Don't have an account?",style: TextStyle(color: Colors.white54),
//                           ),
//                           SizedBox(
//                             width: 50,
//                           ),
//                           TextButton(onPressed: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccountScreen()));
//                           },
//                               child: Text("Create an account",style: TextStyle(color: Colors.greenAccent,fontSize: 17),))
//                         ],
//                       ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
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
import 'package:pack_bags/application/auth/view_model/auth_provider.dart';
import 'package:pack_bags/validator.dart';
import 'package:provider/provider.dart';
import 'Signup.dart';
import 'forgotpasswordscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
            gradient:  LinearGradient(
              begin: Alignment.topLeft,
              end:  Alignment.center,
              colors: [
                Color(0xFF0f261e), // dark green
                Color(0xFF000000), // Almost black
              ],
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.language, color: Colors.white, size: 18),
                              SizedBox(width: 6),
                              Text("English", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      "Welcome Back",
                      style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Login to view daily mortgage updates.",
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: emailController,
                      validator: (value)=>Validator.validateEmail(value),
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
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) => Validator.validatePassword(value),
                      obscureText: !_isPasswordVisible,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter your Password",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        prefixIcon: const Icon(Iconsax.lock, color: Colors.white54),
                        suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
                            color: Colors.white54,
                        ),
                        onPressed: () {
                        setState(() {
                         _isPasswordVisible = !_isPasswordVisible;
                         }
                    );
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
                          },
                          child: const Text("Forgot Password?", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Consumer<AuthProvider>(
                      builder: (context, auth, _) {
                        return auth.isLoading
                            ? const Center(child: CircularProgressIndicator(color: Colors.greenAccent))
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
                                  Provider.of<AuthProvider>(context, listen: false).login(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
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
                              child: const Text("Log In", style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        );
                      },
                    ),
                    Row(
                      children: const [
                        Expanded(child: Divider(color: Colors.white24)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Or", style: TextStyle(color: Colors.white54)),
                        ),
                        Expanded(child: Divider(color: Colors.white24)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white24),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.g_mobiledata, color: Colors.white, size: 28),
                            label: const Text("Google", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white24),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.apple, color: Colors.white, size: 28),
                            label: const Text("Apple", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    
                    Center(
                      child:
                      Row(
                        spacing: 110,
                        children: [
                          Text(
                            "Don't have an account?",style: TextStyle(color: Colors.white54),
                          ),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccountScreen()));
                          },
                              child: Text("Create an account",style: TextStyle(color: Colors.greenAccent,fontSize: 17),))
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
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
