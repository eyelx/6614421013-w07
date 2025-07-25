import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ตัวอย่างฟอร์ม Flutter', // Title of the application
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyFormPage(),
    );
  }
}

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  // GlobalKey สำหรับ Form เพื่อใช้ในการตรวจสอบความถูกต้องของฟอร์ม
  final _formKey = GlobalKey<FormState>();

  // TextEditingController สำหรับแต่ละช่องกรอกข้อมูล
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    // ต้อง dispose Controller เมื่อ Widget ถูกทำลายเพื่อป้องกันการรั่วไหลของหน่วยความจำ
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แบบฟอร์มตัวอย่าง'), // App bar title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // กำหนด GlobalKey ให้กับ Form
          child: ListView(
            children: <Widget>[
              // ช่องกรอกชื่อ-นามสกุล
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'ชื่อ-นามสกุล', // Label for the input field
                  hintText: 'กรุณากรอกชื่อ-นามสกุล', // Hint text
                  border: OutlineInputBorder(), // Border style
                ),
                validator: (value) {
                  // Validator function for name
                  if (value == null || value.isEmpty) {
                    return 'โปรดระบุชื่อ-นามสกุล'; // Error message if empty
                  }
                  return null; // No error
                },
              ),
              const SizedBox(height: 20),
              // ช่องกรอกอีเมล
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'อีเมล',
                  hintText: 'กรุณากรอกอีเมล',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    TextInputType.emailAddress, // Keyboard type for email
                validator: (value) {
                  // Validator function for email
                  if (value == null || value.isEmpty) {
                    return 'โปรดระบุอีเมล';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'รูปแบบอีเมลไม่ถูกต้อง'; // Error message for invalid email format
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // ช่องกรอกเบอร์โทรศัพท์
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'เบอร์โทรศัพท์',
                  hintText: 'กรุณากรอกเบอร์โทรศัพท์',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    TextInputType.phone, // Keyboard type for phone number
                validator: (value) {
                  // Validator function for phone number
                  if (value == null || value.isEmpty) {
                    return 'โปรดระบุเบอร์โทรศัพท์';
                  }
                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'เบอร์โทรศัพท์ต้องมี 10 ตัวเลข'; // Error message for invalid phone number format
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // ช่องกรอกที่อยู่
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'ที่อยู่',
                  hintText: 'กรุณากรอกที่อยู่',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3, // Allow multiple lines for address
                validator: (value) {
                  // Validator function for address
                  if (value == null || value.isEmpty) {
                    return 'โปรดระบุที่อยู่';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // ช่องกรอกจังหวัด
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'จังหวัด',
                  hintText: 'กรุณากรอกจังหวัด',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // Validator function for city
                  if (value == null || value.isEmpty) {
                    return 'โปรดระบุจังหวัด';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              // ปุ่มสำหรับส่งข้อมูล
              ElevatedButton(
                onPressed: () {
                  // ตรวจสอบความถูกต้องของฟอร์มทั้งหมด
                  if (_formKey.currentState!.validate()) {
                    // ถ้าข้อมูลถูกต้องทั้งหมด
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'ข้อมูลที่กรอก: \n'
                          'ชื่อ: ${_nameController.text}\n'
                          'อีเมล: ${_emailController.text}\n'
                          'เบอร์โทร: ${_phoneController.text}\n'
                          'ที่อยู่: ${_addressController.text}\n'
                          'จังหวัด: ${_cityController.text}',
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'ส่งข้อมูล', // Button text
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
