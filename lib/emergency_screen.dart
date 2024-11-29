import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmergencyContact {
  String name;
  String mobileNumber;

  EmergencyContact(this.name, this.mobileNumber);
}

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final List<EmergencyContact> _contacts =
      []; // List to hold emergency contacts
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  // Function to add a new contact
  void _addContact() {
    String name = _nameController.text.trim();
    String mobile = _mobileController.text.trim();

    if (name.isNotEmpty && mobile.isNotEmpty) {
      setState(() {
        _contacts.add(EmergencyContact(name, mobile));
      });
      _nameController.clear();
      _mobileController.clear();
      Get.snackbar('Success', 'Contact added successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      Get.snackbar('Error', 'Please fill in both fields',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    }
  }

  // Function to delete a contact
  void _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
    Get.snackbar('Success', 'Contact deleted successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Emergency Contacts',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ), // iOS-style back arrow icon
          onPressed: () => Get.back(), // Navigate back
        ),
        backgroundColor: Colors.black, // Customize the app bar color
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/background.jpg'), // Path to your background image
            fit: BoxFit.cover, // Cover the entire screen
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Emergency Contacts',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white), // Adjust text color
            ),
            const SizedBox(height: 20),

            // List of emergency contacts
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white.withOpacity(
                        0.8), // Semi-transparent white background for list items
                    child: ListTile(
                      title: Text(_contacts[index].name),
                      subtitle: Text(_contacts[index].mobileNumber),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteContact(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white, // White color for the FAB
        // ignore: prefer_const_constructors
        child: Icon(Icons.add, color: Colors.black), // Add icon
        onPressed: () {
          // Show dialog to add a new contact
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20)), // Rounded corners
            ),
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Add Emergency Contact',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _mobileController,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _addContact();
                        Navigator.of(context)
                            .pop(); // Close dialog after adding
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.grey, // Grey color for the button
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Add Contact',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(), // Cancel
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
