import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import 'login_view.dart';
import 'package:image_picker/image_picker.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final TextEditingController _avatarController = TextEditingController(); // Thêm controller cho avatar

  final UserController _userController = UserController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _passwordConfirmController.text) {
      setState(() {
        _errorMessage = 'Passwords do not match';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    final success = await _userController.register(
      _usernameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _avatarController.text.trim(), // Thêm avatar vào đây
    );

    if (success) {
      setState(() {
        _isLoading = false;
        _successMessage = 'Registration successful! Please login.';
      });
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Username or email already exists.';
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _avatarController.text = pickedFile.path; // Lưu đường dẫn ảnh
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_errorMessage != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                if (_successMessage != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text(
                      _successMessage!,
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                  validator: (val) => val == null || val.isEmpty ? 'Enter username' : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Enter email';
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}');
                    if (!emailRegex.hasMatch(val)) return 'Enter valid email';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (val) => val == null || val.isEmpty ? 'Enter password' : null,
                ),
                TextFormField(
                  controller: _passwordConfirmController,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: (val) => val == null || val.isEmpty ? 'Confirm password' : null,
                ),
                TextFormField(
                  controller: _avatarController,
                  decoration: InputDecoration(labelText: 'Avatar URL'),
                  validator: (val) => val == null || val.isEmpty ? 'Enter avatar URL' : null,
                ),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Chụp Ảnh'),
                ),
                SizedBox(height: 16),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _register,
                  child: Text('Register'),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginView()));
                    },
                    child: Text('Already have an account? Login')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ImagePicker() {}
}

class ImageSource {
  static var camera;
}
