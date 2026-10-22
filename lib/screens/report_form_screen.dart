import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

enum FormUiState { initial, loading, success, empty, error }

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  FormUiState _uiState = FormUiState.initial;
  bool _simulateError = false;

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _uiState = FormUiState.loading;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      if (_simulateError) {
        _uiState = FormUiState.error;
      } else {
        _uiState = FormUiState.success;
      }
    });
  }

  void _resetForm() {
    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _uiState = FormUiState.initial;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Report Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    switch (_uiState) {
      case FormUiState.loading:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Submitting report, please wait...'),
            ],
          ),
        );

      case FormUiState.success:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 64),
              const SizedBox(height: 16),
              const Text(
                'Report Submitted Successfully!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'Submit Another Report',
                onPressed: _resetForm,
              ),
            ],
          ),
        );

      case FormUiState.empty:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.inbox, color: Colors.grey, size: 64),
              const SizedBox(height: 16),
              const Text('No Reports Found / List is Empty.'),
              const SizedBox(height: 24),
              AppButton(
                label: 'Back to Form',
                onPressed: () {
                  setState(() {
                    _uiState = FormUiState.initial;
                  });
                },
              ),
            ],
          ),
        );

      case FormUiState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              const Text(
                'An error occurred while submitting.',
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'Retry Action',
                onPressed: () {
                  setState(() {
                    _uiState = FormUiState.initial;
                  });
                },
              ),
            ],
          ),
        );

      case FormUiState.initial:
      default:
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  controller: _titleController,
                  label: 'Report Title',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a report title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _descriptionController,
                  label: 'Description',
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  title: const Text('Simulate Submission Error'),
                  value: _simulateError,
                  onChanged: (val) {
                    setState(() {
                      _simulateError = val ?? false;
                    });
                  },
                ),
                const SizedBox(height: 16),
                AppButton(
                  label: 'Submit Report',
                  onPressed: _submitForm,
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _uiState = FormUiState.empty;
                    });
                  },
                  child: const Text('View Empty State Example'),
                ),
              ],
            ),
          ),
        );
    }
  }
}