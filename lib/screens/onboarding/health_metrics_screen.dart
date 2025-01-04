import 'package:flutter/material.dart';
import '../../data/models/trainee_profile.dart';

class HealthMetricsScreen extends StatefulWidget {
  final Function(HealthMetrics) onNext;
  final HealthMetrics? initialData;

  const HealthMetricsScreen({
    super.key, 
    required this.onNext,
    this.initialData,
  });

  @override
  State<HealthMetricsScreen> createState() => _HealthMetricsScreenState();
}

class _HealthMetricsScreenState extends State<HealthMetricsScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final TextEditingController _chestController;
  late final TextEditingController _waistController;
  late final TextEditingController _hipsController;
  late final TextEditingController _armsController;
  late final TextEditingController _heartRateController;
  late final TextEditingController _systolicController;
  late final TextEditingController _diastolicController;

  @override
  void initState() {
    super.initState();
    _heightController = TextEditingController(text: widget.initialData?.height.toString());
    _weightController = TextEditingController(text: widget.initialData?.weight.toString());
    _chestController = TextEditingController(text: widget.initialData?.bodyMeasurements.chest.toString());
    _waistController = TextEditingController(text: widget.initialData?.bodyMeasurements.waist.toString());
    _hipsController = TextEditingController(text: widget.initialData?.bodyMeasurements.hips.toString());
    _armsController = TextEditingController(text: widget.initialData?.bodyMeasurements.arms.toString());
    _heartRateController = TextEditingController(text: widget.initialData?.restingHeartRate.toString());
    _systolicController = TextEditingController(text: widget.initialData?.bloodPressure.systolic.toString());
    _diastolicController = TextEditingController(text: widget.initialData?.bloodPressure.diastolic.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Metrics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Basic Measurements',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              // Height and Weight Row
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _heightController,
                      decoration: const InputDecoration(
                        labelText: 'Height (cm)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: _validateNumber,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      decoration: const InputDecoration(
                        labelText: 'Weight (kg)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: _validateNumber,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              const Text(
                'Body Measurements',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              // Body measurements grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 2.5,
                children: [
                  _buildMeasurementField(_chestController, 'Chest (cm)'),
                  _buildMeasurementField(_waistController, 'Waist (cm)'),
                  _buildMeasurementField(_hipsController, 'Hips (cm)'),
                  _buildMeasurementField(_armsController, 'Arms (cm)'),
                ],
              ),
              
              const SizedBox(height: 24),
              const Text(
                'Vital Signs',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _heartRateController,
                decoration: const InputDecoration(
                  labelText: 'Resting Heart Rate (bpm)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: _validateNumber,
              ),
              
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _systolicController,
                      decoration: const InputDecoration(
                        labelText: 'Systolic',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: _validateNumber,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _diastolicController,
                      decoration: const InputDecoration(
                        labelText: 'Diastolic',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: _validateNumber,
                    ),
                  ),
                ],
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

  Widget _buildMeasurementField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: _validateNumber,
    );
  }

  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (double.tryParse(value) == null) {
      return 'Enter a valid number';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final healthMetrics = HealthMetrics(
        height: double.parse(_heightController.text),
        weight: double.parse(_weightController.text),
        bodyMeasurements: BodyMeasurements(
          chest: double.parse(_chestController.text),
          waist: double.parse(_waistController.text),
          hips: double.parse(_hipsController.text),
          arms: double.parse(_armsController.text),
        ),
        restingHeartRate: int.parse(_heartRateController.text),
        bloodPressure: BloodPressure(
          systolic: int.parse(_systolicController.text),
          diastolic: int.parse(_diastolicController.text),
        ),
      );
      widget.onNext(healthMetrics);
    }
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _chestController.dispose();
    _waistController.dispose();
    _hipsController.dispose();
    _armsController.dispose();
    _heartRateController.dispose();
    _systolicController.dispose();
    _diastolicController.dispose();
    super.dispose();
  }
}
