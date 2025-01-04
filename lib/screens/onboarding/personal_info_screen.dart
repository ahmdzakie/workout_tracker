import 'package:flutter/material.dart';
import '../../data/models/trainee_profile.dart';

class PersonalInfoScreen extends StatefulWidget {
  final Function(PersonalInfo) onNext;
  final PersonalInfo? initialData;

  const PersonalInfoScreen({
    super.key, 
    required this.onNext, 
    this.initialData,
  });

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emergencyNameController;
  late final TextEditingController _emergencyPhoneController;
  late final TextEditingController _emergencyRelationController;
  
  late DateTime? _dateOfBirth;
  late Gender _selectedGender;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing data if available
    _nameController = TextEditingController(text: widget.initialData?.fullName);
    _emailController = TextEditingController(text: widget.initialData?.email);
    _phoneController = TextEditingController(text: widget.initialData?.phone);
    _emergencyNameController = TextEditingController(text: widget.initialData?.emergencyContact.name);
    _emergencyPhoneController = TextEditingController(text: widget.initialData?.emergencyContact.phone);
    _emergencyRelationController = TextEditingController(text: widget.initialData?.emergencyContact.relationship);
    
    // Initialize other fields
    _dateOfBirth = widget.initialData?.dateOfBirth;
    _selectedGender = widget.initialData?.gender ?? Gender.MALE;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => 
                  value?.isEmpty ?? true ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),
              
              // Date of Birth Picker
              ListTile(
                title: const Text('Date of Birth'),
                subtitle: Text(_dateOfBirth?.toString().split(' ')[0] ?? 
                           'Select date'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _selectDate,
              ),
              
              // Gender Selection
              DropdownButtonFormField<Gender>(
                value: _selectedGender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: Gender.values.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedGender = value!);
                },
              ),
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
              ),
              
              const SizedBox(height: 24),
              const Text(
                'Emergency Contact',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _emergencyNameController,
                decoration: const InputDecoration(
                  labelText: 'Emergency Contact Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => 
                  value?.isEmpty ?? true ? 'Required' : null,
              ),
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _emergencyPhoneController,
                decoration: const InputDecoration(
                  labelText: 'Emergency Contact Phone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
              ),
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _emergencyRelationController,
                decoration: const InputDecoration(
                  labelText: 'Relationship',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => 
                  value?.isEmpty ?? true ? 'Required' : null,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Next'),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _dateOfBirth = picked);
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final personalInfo = PersonalInfo(
        fullName: _nameController.text,
        dateOfBirth: _dateOfBirth!,
        gender: _selectedGender,
        email: _emailController.text,
        phone: _phoneController.text,
        emergencyContact: EmergencyContact(
          name: _emergencyNameController.text,
          relationship: _emergencyRelationController.text,
          phone: _emergencyPhoneController.text,
        ),
      );
      widget.onNext(personalInfo);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();
    _emergencyRelationController.dispose();
    super.dispose();
  }
}
