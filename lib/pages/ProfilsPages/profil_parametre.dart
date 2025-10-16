import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/widget/utils/text_degrade.dart';

import '../../widget/utils/imageSet.dart';

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
      ).showSnackBar(SnackBar(content: Text('Impossible de charger l\'image')));
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
    return GestureDetector(
        onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextDegrade(
            title: 'Configuration du Profil',
            choicetype: 'parametre',
          ),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
             constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  MediaQuery.of(context).padding.top,
            ),
            child: Center(
              
              child: Consumer<ProfilProvider>(
                builder: (context, profil, child) {
                  return Column(
                    spacing: 50,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: ImageSet(sizewidth: 150, 0),
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
                  
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
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
                  
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Pseudo mis à jour avec succès !',
                                          ),
                                        ),
                                      );
                                    },
                                    label: Text(
                                      'Enregistrer le pseudo',
                                      textAlign: TextAlign.center,
                                    ),
                                    icon: Icon(
                                      Icons.check_box,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Réinitialiser ?'),
                                          content: Text(
                                            'Toutes tes données seront perdues.',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: Navigator.of(context).pop,
                                              child: Text('Annuler'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Provider.of<ProfilProvider>(
                                                  context,
                                                  listen: false,
                                                ).resetAll().then((_) {
                                                  _pseudoController.text =
                                                      'Inconnu';
                                                });
                                              },
                                              child: Text('Confirmer'),
                                            ),
                                          ],
                                        ),
                                      );
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
          ),
        ),
      ),
    );
  }
}
