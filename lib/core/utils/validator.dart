class Validator {
  static String? validateEmptyField(String? fieldName, String? value) {
    if(value == null || value.isEmpty){
      return' Enter $fieldName to continue';
    }
    return null;
  }
  static String? validateEmail(String? value){
    if( value == null|| value.isEmpty)
      return "Enter email";


    // requiment for email validation
    final emailRE = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRE.hasMatch(value)){
      return "Invalid email address.";
    }
    return null;
  }
  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return "Password is required";
    }
    //password lenth validation
    if(value.length <6){
      return 'Password length should be min 6';
    }
    //check password upercase
    if(!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase';
    }
    //Check numbers
    if(!value.contains(RegExp(r'[0-9]'))){
      return 'Password must contain at least one number';
    }

    //check spl charcters
    if(!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      return 'password must contain at one special charachers';
    }
    return null;
  }
  static String? validatePhoneNUmber(String? value){
    if (value == null || value.isEmpty){
      return 'phone number is required';
    }
    //expression check
    final phoneRE =RegExp(r'^\d{10}$');
    if(!phoneRE.hasMatch(value)){
      return 'Invalid phone number';
    }
    return null;
  }
}