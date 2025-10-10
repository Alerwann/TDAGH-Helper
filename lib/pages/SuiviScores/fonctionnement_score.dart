import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FonctionnementScore extends StatelessWidget {
  const FonctionnementScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: SizedBox(
          width: 350,
          child: SingleChildScrollView(
            child: Column(
                 
              spacing: 15,
              children: [
                Text("Règles de l'XP",style: TextStyle(fontSize: 35, color: Colors.amber, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                Text("Tous les jours à 4h du 🌞 matin, l'Xp quotidienne se remet à 0.",style: TextStyle(fontSize: 25),textAlign: TextAlign.center,),      
                Text("Remplis le bingo des taches. \n 4 tâches remplis = 5 points d'Xp 🏆",style: TextStyle(fontSize: 25),textAlign: TextAlign.center,),
                Text("Pioche des tâches au hasard et réalise les pour gagner 5 points 🏆.",style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                Text("En plus tu peux choisir ton nombre de tâche dans les paramètre suivant ta forme. 😜",style: TextStyle(fontSize: 25),textAlign: TextAlign.center,),
                Text("Pour finir fait les tâches bonus (Lavage de Dents et les record) 🦷",style: TextStyle(fontSize: 25),textAlign: TextAlign.center,),
                Text("Tu auras 5 points par réalisation de tâches bonus 🏆 ",style: TextStyle(fontSize: 25),textAlign: TextAlign.center,),
                Text("Tous les 140 d'Xp tu prends un niveau et débloque des grades spectaculaires !!!",style: TextStyle(fontSize: 25),textAlign: TextAlign.center,),
            
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
