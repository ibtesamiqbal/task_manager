
import 'package:flutter/material.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _taskName = '';
  String _taskDate = '';
  String _startTime = '';
  String _endTime = '';
  String _description = '';
  String _category = 'Design'; // Default category

  void _submitTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context, {
        'name': _taskName,
        'date': _taskDate,
        'startTime': _startTime,
        'endTime': _endTime,
        'description': _description,
        'category': _category,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Task Name
                const Text('Name', style: TextStyle(fontSize: 16)),
                TextFormField(
                  onSaved: (value) => _taskName = value!,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a task name' : null,
                ),
                const SizedBox(height: 16),

                // Task Date
                const Text('Date', style: TextStyle(fontSize: 16)),
                TextFormField(
                  onSaved: (value) => _taskDate = value!,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a date' : null,
                ),
                const SizedBox(height: 16),

                // Start and End Time
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Start Time'),
                        onSaved: (value) => _startTime = value!,
                        validator: (value) =>
                            value!.isEmpty ? 'Enter start time' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'End Time'),
                        onSaved: (value) => _endTime = value!,
                        validator: (value) =>
                            value!.isEmpty ? 'Enter end time' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Description
                const Text('Description', style: TextStyle(fontSize: 16)),
                TextFormField(
                  maxLines: 3,
                  onSaved: (value) => _description = value!,
                ),
                const SizedBox(height: 16),

                // Category
                const Text('Category', style: TextStyle(fontSize: 16)),
                Wrap(
                  spacing: 8,
                  children: [
                    _buildCategoryButton('Design'),
                    _buildCategoryButton('Meeting'),
                    _buildCategoryButton('Coding'),
                    _buildCategoryButton('BDE'),
                    _buildCategoryButton('Testing'),
                  ],
                ),
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _submitTask,
                    child: const Text('Create Task'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for Category Button
  Widget _buildCategoryButton(String category) {
    final isSelected = _category == category;
    return ChoiceChip(
      label: Text(category),
      selected: isSelected,
      onSelected: (_) => setState(() => _category = category),
      selectedColor: Colors.purple,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
    );
  }
}

