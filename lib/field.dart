import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

final _formKey = GlobalKey<FormState>();

final _nameController = TextEditingController();
final _phoneController = TextEditingController();
final _emailController = TextEditingController();
final _passController = TextEditingController();
final _confirmPassController = TextEditingController();

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextFormField(
            validator: (value) => _validateName(value!),
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Full Name *',
              hintText: 'What do people call you',
              prefixIcon: Icon(Icons.person),
              suffixIcon: Icon(Icons.delete),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number *',
              hintText: 'Where can we reach you?',
              helperText: 'Phone format: (XXX)XXX-XXXX',
              prefixIcon: Icon(Icons.call),
              suffixIcon: Icon(Icons.delete),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            keyboardType: TextInputType.phone,
            // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            inputFormatters: [
              FilteringTextInputFormatter(
                RegExp(r'^[()\d+-]{1,15}$'),
                allow: true,
              ),
            ],
            validator: (value) => _validatePhoneNumber(value)
                ? null
                : 'Phone number must be +7 XXX XXX XXXX',
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email *',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
          ),
          SizedBox(height: 10),
          TextFormField(decoration: InputDecoration(labelText: 'Countru *')),
          SizedBox(height: 10),
          TextFormField(decoration: InputDecoration(labelText: 'City *')),
          SizedBox(height: 10),
          TextFormField(
            validator: _validatePassword,
            controller: _passController,
            decoration: InputDecoration(
              labelText: 'Password *',
              suffixIcon: IconButton(
                icon: Icon(
                  _hidePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            obscureText: _hidePassword,
            maxLength: 8,
          ),
          SizedBox(height: 10),
          TextFormField(
            validator: _validatePassword,
            controller: _confirmPassController,
            decoration: InputDecoration(
              labelText: 'Confirm Password *',
              suffixIcon: IconButton(
                icon: Icon(
                  _hidePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            obscureText: _hidePassword,
            maxLength: 8,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.green),
            ),
            onPressed: _submitForm,
            child: Text('Submit Form', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('form is valid');
      print('Name: ${_nameController.text}');
      print('Phone number: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passController.text}');
    } else {
      print('Form is not valid');
    }
  }
}

String? _validateName(String value) {
  final _nameExp = RegExp(r'^[A-Z a-z]+$');
  if (value.isEmpty) {
    return 'name is required';
  } else if (!_nameExp.hasMatch(value)) {
    return 'Please write alphabetica characters';
  } else {
    return null;
  }
}

bool _validatePhoneNumber(String? input) {
  final _phoneExp = RegExp(r'^\+7\d\d\d\-\d\d\d\-\d\d\d\d$');
  return _phoneExp.hasMatch(input!);
}

String? _validateEmail(String? value) {
  if (value!.isEmpty) {
    return 'email cannot be empty';
  } else if (!_emailController.text.contains('@')) {
    return 'invalid email adress';
  } else {
    return null;
  }
}

String? _validatePassword(String? value) {
  if (value!.length != 8) {
    return '8 characters required for password';
  } else if (_confirmPassController.text != _passController.text) {
    return "Password doesn't match";
  } else {
    return null;
  }
}
