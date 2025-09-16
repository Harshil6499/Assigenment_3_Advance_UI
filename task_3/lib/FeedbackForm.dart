import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
   final _formKey = GlobalKey<FormState>();

  // Form field controllers
   TextEditingController _nameController = TextEditingController();
   TextEditingController _feedbackController = TextEditingController();

  // Dropdown
  String? _selectedRating;

  // Checkboxes
  bool _isBugReport = false;
  bool _isFeatureRequest = false;
  bool _isOther = false;

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String feedback = _feedbackController.text;
      String rating = _selectedRating ?? "Not selected";
      List<String> categories = [];
      if (_isBugReport) categories.add("Bug Report");
      if (_isFeatureRequest) categories.add("Feature Request");
      if (_isOther) categories.add("Other");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Feedback Submitted!\n\n"
                "Name: $name\n"
                "Rating: $rating\n"
                "Categories: ${categories.join(", ")}\n"
                "Message: $feedback",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Feedback Form"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name Input
              TextFormField(
                controller: _nameController,
                decoration:  InputDecoration(
                  labelText: "Your Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? "Enter your name" : null,
              ),
               SizedBox(height: 16),

              // Dropdown for Rating
              DropdownButtonFormField<String>(
                decoration:  InputDecoration(
                  labelText: "Rate Us",
                  border: OutlineInputBorder(),
                ),
                value: _selectedRating,
                items: ["Excellent", "Good", "Average", "Poor"]
                    .map((rating) => DropdownMenuItem(
                  value: rating,
                  child: Text(rating),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRating = value;
                  });
                },
                validator: (value) =>
                value == null ? "Please select a rating" : null,
              ),
               SizedBox(height: 16),

              // Checkboxes
               Text("Feedback Type:"),
              CheckboxListTile(
                title:  Text("Bug Report"),
                value: _isBugReport,
                onChanged: (value) {
                  setState(() {
                    _isBugReport = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title:  Text("Feature Request"),
                value: _isFeatureRequest,
                onChanged: (value) {
                  setState(() {
                    _isFeatureRequest = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title:  Text("Other"),
                value: _isOther,
                onChanged: (value) {
                  setState(() {
                    _isOther = value ?? false;
                  });
                },
              ),
               SizedBox(height: 16),

              // Feedback message input
              TextFormField(
                controller: _feedbackController,
                maxLines: 4,
                decoration:  InputDecoration(
                  labelText: "Your Feedback",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Please write your feedback"
                    : null,
              ),
               SizedBox(height: 20),

              // Submit button
              ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:  EdgeInsets.symmetric(vertical: 14),
                ),
                child:  Text("Submit Feedback",
                    style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
