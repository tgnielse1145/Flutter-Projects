class Validations {
  String? validateName(String value) {
    if (value.isEmpty) return 'Name is required.';
    final RegExp nameExp = new RegExp(r'^[A-za-z ]+$');
    if (!nameExp.hasMatch(value.trim()))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) return 'Email is required.';
    final RegExp nameExp = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!nameExp.hasMatch(value.trim())) return 'Invalid email address';
    return null;
  }
 // should contain at least one upper case
 // should contain at least one lower case
 // should contain at least one digit
 // should contain at least one Special character
  String? validatePassword(String value) {
    final RegExp passExp = new RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty||value.length<5){ return 'Please choose a password.';}
    else if(!passExp.hasMatch(value)){
      return 'Please enter a valid password';
    }
    return null;
  }

 
  String? validatePhone(String value) {
   // String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
   String pattern = r'^(\+0?1\s)?((\d{3})|(\(\d{3}\)))?(\s|-)\d{3}(\s|-)\d{4}$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

}
