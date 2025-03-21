import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailProject extends StatefulWidget {
  const DetailProject({super.key});

  @override
  State<DetailProject> createState() => _DetailProjectState();
}

class _DetailProjectState extends State<DetailProject> {
  Map<String, dynamic> projectData = {
    'customerId': 'CUST789',
    'customerName': 'Jane Smith',
    'projectId': 'PROJ789',
    'projectStatus': 'Pending',
    'assignDate': '2023-11-01',
    'deadlineDate': '2023-12-15',
    'requirements':
        'Detailed requirements from JSON this is influncer setter appp',
  };

  String _projectStatus = 'Ongoing';
  String _uploadedFilePath = '';
  String _uploadedFileName = '';
  double _uploadProgress = 0.0;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple[500],
      ),
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    _buildDetailRow('Customer ID', projectData['customerId']),
                    _buildDetailRow(
                        'Customer Name', projectData['customerName']),
                    _buildDetailRow('Project ID', projectData['projectId']),
                    _buildDetailRow('Project Status', projectData['projectStatusw']),
                    // ... inside your build method ...
                    
                    _buildDetailRow('Assign Date', projectData['assignDate']),
                    _buildDetailRow(
                        'Deadline Date', projectData['deadlineDate']),
                    SizedBox(height: 10),
                    Text('Requirements',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(projectData['requirements']),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Upload File',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _simulateFileUpload,
                      child: Text('Choose Video File',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.purple,
                        backgroundColor: Colors.purple,
                      ),
                    ),
                    if (_isUploading)
                      Column(
                        children: [
                          SizedBox(height: 10),
                          LinearProgressIndicator(value: _uploadProgress),
                          SizedBox(height: 5),
                          Text('Uploading: $_uploadedFileName'),
                        ],
                      ),
                    if (_uploadedFilePath.isNotEmpty && !_isUploading)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Uploaded: $_uploadedFileName'),
                      ),
                    SizedBox(height: 20),
                    Text('Change Status',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    _buildStatusDropdown(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Implement submit logic here
                      },
                      child:
                          Text('Submit', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButton<String>(
      value: _projectStatus,
      onChanged: (String? newValue) {
        setState(() {
          _projectStatus = newValue!;
        });
      },
      items: <String>['Ongoing', 'Pending', 'Review']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _simulateFileUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _isUploading = true;
          _uploadProgress = 0.0;
          _uploadedFilePath = result.files.first.path!;
          _uploadedFileName = result.files.first.name;
        });

        for (double i = 0; i <= 100; i++) {
          await Future.delayed(Duration(milliseconds: 50));
          setState(() {
            _uploadProgress = i / 100.0;
          });
        }

        setState(() {
          _isUploading = false;
        });
        print('File path: $_uploadedFilePath');
        print('File name: $_uploadedFileName');
      } else {
        print('User canceled file picker');
      }
    } catch (e) {
      print('Error picking file: $e');
      setState(() {
        _isUploading = false;
      });
    }
  }
}
//    Map<String, dynamic> projectData = {
//     'customerId': 'CUST789',
//     'customerName': 'Jane Smith',
//     'projectId': 'PROJ789',
//     'assignDate': '2023-11-01',
//     'deadlineDate': '2023-12-15',
//     'requirements': 'Detailed requirements from JSON...',
//   };

//   final _customerIdController = TextEditingController();
//   final _customerNameController = TextEditingController();
//   final _projectIdController = TextEditingController();
//   final _assignDateController = TextEditingController();
//   final _deadlineDateController = TextEditingController();
//   final _requirementController = TextEditingController();
//   String _projectStatus = 'Ongoing';
//   String _uploadedFilePath = '';
//   String _uploadedFileName = '';
//   double _uploadProgress = 0.0;
//   bool _isUploading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }

//   void _loadData() {
//     _customerIdController.text = projectData['customerId'];
//     _customerNameController.text = projectData['customerName'];
//     _projectIdController.text = projectData['projectId'];
//     _assignDateController.text = projectData['assignDate'];
//     _deadlineDateController.text = projectData['deadlineDate'];
//     _requirementController.text = projectData['requirements'];
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Project Details'),
//         backgroundColor: Colors.pink[100],
//       ),
//       backgroundColor: Colors.pink[50],
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Project Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
//                     SizedBox(height: 10),
//                     _buildTextField('Customer ID', _customerIdController),
//                     _buildTextField('Customer Name', _customerNameController),
//                     _buildTextField('Project ID', _projectIdController),
//                     Row(
//                       children: [
//                         Text(
//                           'Project Status:',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 10),
//                         Expanded(child: _buildStatusDropdown()),
//                       ],
//                     ),
//                     _buildTextField('Assign Date', _assignDateController, isDate: true),
//                     _buildTextField('Deadline Date', _deadlineDateController, isDate: true),
//                     SizedBox(height: 10),
//                     Text('Requirements', style: TextStyle(fontWeight: FontWeight.bold)),
//                     SizedBox(height: 5),
//                     TextFormField(
//                       controller: _requirementController,
//                       maxLength: 500,
//                       maxLines: 5,
//                       style: TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: "Enter requirements (minimum 150 words)",
//                       ),
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Requirement is required';
//                         }
//                         if (value.trim().split(' ').length < 150) {
//                           return "Minimum 150 words required";
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Text('Upload Project Work', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: _simulateFileUpload,
//                       child: Text('Choose Video File', style: TextStyle(color: Colors.white)),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,
//                       ),
//                     ),
//                     if (_isUploading)
//                       Column(
//                         children: [
//                           SizedBox(height: 10),
//                           LinearProgressIndicator(value: _uploadProgress),
//                           SizedBox(height: 5),
//                           Text('Uploading: $_uploadedFileName'),
//                         ],
//                       ),
//                     if (_uploadedFilePath.isNotEmpty && !_isUploading)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8.0),
//                         child: Text('Uploaded: $_uploadedFileName'),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Text('Change Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                     SizedBox(height: 10),
//                     _buildStatusDropdown(),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                         // Implement submit logic here
//                       },
//                       child: Text('Submit', style: TextStyle(color: Colors.white)),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white, backgroundColor: Colors.blue,
//                         padding: EdgeInsets.symmetric(vertical: 16),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller, {bool isDate = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         readOnly: isDate,
//         onTap: isDate
//             ? () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2101),
//                 );

//                 if (pickedDate != null) {
//                   String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
//                   setState(() {
//                     controller.text = formattedDate;
//                   });
//                 }
//               }
//             : null,
//       ),
//     );
//   }

//   Widget _buildStatusDropdown() {
//     return DropdownButton<String>(
//       value: _projectStatus,
//       onChanged: (String? newValue) {
//         setState(() {
//           _projectStatus = newValue!;
//         });
//       },
//       items: <String>['Ongoing', 'Pending', 'Review']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text('Project Details', style: TextStyle(color: Colors.white)),
//   //       backgroundColor: Colors.purple[400],
//   //     ),
//   //     backgroundColor: Colors.pink[50],
//   //     body: SingleChildScrollView(
//   //       padding: EdgeInsets.all(16.0),
//   //       child: Column(
//   //         crossAxisAlignment: CrossAxisAlignment.stretch,
//   //         children: [
//   //           Card(
//   //             elevation: 5,
//   //             shape: RoundedRectangleBorder(
//   //               borderRadius: BorderRadius.circular(12),
//   //             ),
//   //             child: Padding(
//   //               padding: const EdgeInsets.all(16.0),
//   //               child: Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [
//   //                   _buildTextField('Customer ID', _customerIdController),
//   //                   _buildTextField('Customer Name', _customerNameController),
//   //                   _buildTextField('Project ID', _projectIdController),
//   //                   Row(
//   //                     children: [
//   //                       Text(
//   //                         'Project Status:', // Your label text
//   //                         style: TextStyle(fontWeight: FontWeight.bold),
//   //                       ),
//   //                       SizedBox(
//   //                           width:
//   //                               10), // Add some spacing between the text and dropdown
//   //                       Expanded(
//   //                         // Use Expanded to allow the dropdown to take available space
//   //                         child: _buildStatusDropdown(),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                   _buildTextField('Assign Date', _assignDateController,
//   //                       isDate: true),
//   //                   _buildTextField('Deadline Date', _deadlineDateController,
//   //                       isDate: true),
//   //                   SizedBox(height: 10),
//   //                   Text('Requirements',
//   //                       style: TextStyle(fontWeight: FontWeight.bold)),
//   //                   SizedBox(height: 5),
//   //                   TextFormField(
//   //                     controller: _requirementController,
//   //                     maxLength: 500,
//   //                     maxLines: 5,
//   //                     style: TextStyle(color: Colors.black87),
//   //                     decoration: InputDecoration(
//   //                       border: OutlineInputBorder(
//   //                         borderRadius: BorderRadius.circular(8),
//   //                         borderSide: BorderSide(color: Colors.grey),
//   //                       ),
//   //                       filled: true,
//   //                       fillColor: Colors.white,
//   //                       hintText: "Enter requirements (minimum 150 words)",
//   //                     ),
//   //                     validator: (value) {
//   //                       if (value == null || value.trim().isEmpty) {
//   //                         return 'Requirement is required';
//   //                       }
//   //                       if (value.trim().split(' ').length < 150) {
//   //                         return "Minimum 150 words required";
//   //                       }
//   //                       return null;
//   //                     },
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //           SizedBox(height: 20),
//   //           Card(
//   //             elevation: 5,
//   //             shape: RoundedRectangleBorder(
//   //               borderRadius: BorderRadius.circular(12),
//   //             ),
//   //             child: Padding(
//   //               padding: const EdgeInsets.all(16.0),
//   //               child: Column(
//   //                 children: [
//   //                   Text('Upload Project work',
//   //                       style: TextStyle(fontWeight: FontWeight.bold)),
//   //                   SizedBox(height: 10),
//   //                   ElevatedButton(
//   //                     onPressed: _simulateFileUpload,
//   //                     child: Text('Choose File', style: TextStyle(color: Colors.white),),
//   //                     style: ElevatedButton.styleFrom(
//   //                       foregroundColor: Colors.purple,
//   //                       backgroundColor: Colors.purple,
//   //                     ),
//   //                   ),
//   //                   if (_isUploading)
//   //                     Column(
//   //                       children: [
//   //                         SizedBox(height: 10),
//   //                         LinearProgressIndicator(value: _uploadProgress),
//   //                         SizedBox(height: 5),
//   //                         Text('Uploading: $_uploadedFileName'),
//   //                       ],
//   //                     ),
//   //                   if (_uploadedFilePath.isNotEmpty && !_isUploading)
//   //                     Padding(
//   //                       padding: const EdgeInsets.only(top: 8.0),
//   //                       child: Text('Uploaded: $_uploadedFileName'),
//   //                     ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //           SizedBox(height: 20),
//   //           Card(
//   //             elevation: 5,
//   //             shape: RoundedRectangleBorder(
//   //               borderRadius: BorderRadius.circular(12),
//   //             ),
//   //             child: Padding(
//   //               padding: const EdgeInsets.all(16.0),
//   //               child: Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [
//   //                   Text('Change Status',
//   //                       style: TextStyle(fontWeight: FontWeight.bold)),
//   //                   SizedBox(height: 10),
//   //                   _buildStatusDropdown(),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //           SizedBox(height: 20),
//   //           ElevatedButton(
//   //             onPressed: () {
//   //               // Implement submit logic here
//   //             },
//   //             child: Text('Submit', style: TextStyle(color: Colors.white),),
//   //             style: ElevatedButton.styleFrom(
//   //               foregroundColor: Colors.purple,
//   //               backgroundColor: Colors.purple,
//   //               padding: EdgeInsets.symmetric(vertical: 16),
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Widget _buildTextField(String label, TextEditingController controller,
//   //     {bool isDate = false}) {
//   //   return Padding(
//   //     padding: const EdgeInsets.symmetric(vertical: 4.0),
//   //     child: TextFormField(
//   //       controller: controller,
//   //       decoration: InputDecoration(
//   //         labelText: label,
//   //         border: OutlineInputBorder(
//   //           borderRadius: BorderRadius.circular(8),
//   //         ),
//   //       ),
//   //       readOnly: isDate, // Make the field read-only for date pickers
//   //       onTap: isDate
//   //           ? () async {
//   //               DateTime? pickedDate = await showDatePicker(
//   //                 context: context,
//   //                 initialDate: DateTime.now(),
//   //                 firstDate: DateTime(2000),
//   //                 lastDate: DateTime(2101),
//   //               );

//   //               if (pickedDate != null) {
//   //                 String formattedDate = DateFormat('dd-MM-yyyy')
//   //                     .format(pickedDate); // Format the date
//   //                 setState(() {
//   //                   controller.text = formattedDate; // Update the text field
//   //                 });
//   //               }
//   //             }
//   //           : null,
//   //     ),
//   //   );
//   // }

//   // // Widget _buildTextField(String label, TextEditingController controller) {
//   // //   return Padding(
//   // //     padding: const EdgeInsets.symmetric(vertical: 4.0),
//   // //     child: TextFormField(
//   // //       controller: controller,
//   // //       decoration: InputDecoration(
//   // //         labelText: label,
//   // //         border: OutlineInputBorder(
//   // //           borderRadius: BorderRadius.circular(8),
//   // //         ),
//   // //       ),
//   // //     ),
//   // //   );
//   // // }

//   // Widget _buildStatusDropdown() {
//   //   return DropdownButton<String>(
//   //     value: _projectStatus,
//   //     onChanged: (String? newValue) {
//   //       setState(() {
//   //         _projectStatus = newValue!;
//   //       });
//   //     },
//   //     items: <String>['Ongoing', 'Pending', 'Review']
//   //         .map<DropdownMenuItem<String>>((String value) {
//   //       return DropdownMenuItem<String>(
//   //         value: value,
//   //         child: Text(value),
//   //       );
//   //     }).toList(),
//   //   );
//   // }

//   void _simulateFileUpload() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles();

//       if (result != null && result.files.isNotEmpty) {
//         setState(() {
//           _isUploading = true;
//           _uploadProgress = 0.0;
//           _uploadedFilePath = result.files.first.path!; // Get the file path
//           _uploadedFileName = result.files.first.name; // Get the file name
//         });

//         // Simulate upload progress (replace with actual upload logic)
//         for (double i = 0; i <= 100; i++) {
//           await Future.delayed(Duration(milliseconds: 50));
//           setState(() {
//             _uploadProgress = i / 100.0;
//           });
//         }

//         setState(() {
//           _isUploading = false;
//         });

//         //Here you would upload the file to your backend.
//         print('File path: $_uploadedFilePath');
//         print('File name: $_uploadedFileName');
//       } else {
//         // User canceled the picker
//         print('User canceled file picker');
//       }
//     } catch (e) {
//       print('Error picking file: $e');
//       setState(() {
//         _isUploading = false;
//       });
//     }
//   }
// }
