// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/profil_provider.dart';
import 'package:flutter_application_1/widget/imageSet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilParametreConfig extends StatefulWidget {
  const ProfilParametreConfig({super.key});

  @override
  State<ProfilParametreConfig> createState() => _ProfilParametreConfigState();
}

class _ProfilParametreConfigState extends State<ProfilParametreConfig> {
  final _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        await Provider.of<ProfilProvider>(
          context,
          listen: false,
        ).setProfilImagePath(pickedFile.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pseudoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final profil = Provider.of<ProfilProvider>(context, listen: false);
    _pseudoController.text = profil.pseudo;
  }

  @override
  void dispose() {
    _pseudoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuration Profil')),
      body: Center(
        child: Consumer<ProfilProvider>(
          builder: (context, profil, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: ImageSet(sizewidth: 150,0),
                    ),
                    Positioned(
                      bottom: -25,
                      right: -10,
                      child: IconButton(
                        onPressed: pickImage,
                        icon: Icon(Icons.camera_alt, size: 40),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.all(40),
                  child: Form(
                    key: _formKey,

                    child: SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: profil.pseudo,
                              prefixIcon: Icon(Icons.person),
                              labelText: 'Pseudo',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Champs du pseudo vide";
                              }
                              return null;
                            },
                            maxLength: 20,
                            controller: _pseudoController,
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Provider.of<ProfilProvider>(
                                    context,
                                    listen: false,
                                  ).setPseudo(_pseudoController.text);
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(FocusNode());
                                }
                              },
                              label: Text('Enregistrer'),
                              icon: Icon(Icons.check_box, color: Colors.green),
                            ),
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Provider.of<ProfilProvider>(
                                  context,
                                  listen: false,
                                ).resetAll();
                                 _pseudoController.text = profil.pseudo;
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                              label: Text('Réinitialiser'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
