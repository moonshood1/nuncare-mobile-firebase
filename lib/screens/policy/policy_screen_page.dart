import 'package:flutter/material.dart';

class PolicyScreenPage extends StatelessWidget {
  const PolicyScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth(BuildContext context) =>
        MediaQuery.of(context).size.width;
    double deviceHeight(BuildContext context) =>
        MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Termes et conditions",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: deviceHeight(context) * 0.04,
          horizontal: deviceWidth(context) * 0.05,
        ),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "CONDITIONS D'UTILISATION DE NUNCARE",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Bienvenue sur NUNCARE ! Avant d'utiliser notre application, veuillez lire attentivement les conditions d'utilisation suivantes :",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Acceptation des Conditions ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "En utilisant l'application NUNCARE, vous acceptez automatiquement les présentes conditions d'utilisation. Si vous n'acceptez pas ces conditions, veuillez ne pas utiliser l'application.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Objectif de l'Application ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "NUNCARE est une application médicale qui vise à faciliter la mise en relation entre les professionnels de santé et les patients pour la prise de rendez-vous médicaux et la recherche d'informations médicales générales. L'application ne doit pas être utilisée comme substitut à une consultation médicale professionnelle",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Utilisation Personnelle",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Vous vous engagez à utiliser l'application NUNCARE uniquement à des fins personnelles et non commerciales. Toute utilisation de l'application à des fins commerciales est strictement interdite sans l'autorisation préalable de NUNCARE.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Protection des Données Personnelles ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "NUNCARE s'engage à protéger la confidentialité et la sécurité de vos données personnelles conformément aux lois et réglementations en vigueur sur la protection des données en Côte d’Ivoire. En utilisant l'application, vous consentez à la collecte, au traitement et à l'utilisation de vos données personnelles par NUNCARE dans le but de fournir les services demandés.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Responsabilité de l'Utilisateur s",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Vous êtes seul responsable de l'exactitude et de la légalité des informations que vous fournissez via l'application. NUNCARE décline toute responsabilité en cas de dommages ou de préjudices résultant de l'utilisation de l'application ou de la confiance accordée aux informations fournies par celle-ci.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Propriété Intellectuelle",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Tous les droits de propriété intellectuelle relatifs à l'application NUNCARE, y compris les droits d'auteur, les marques de commerce et les brevets, sont la propriété exclusive de NUNCARE. Vous vous engagez à ne pas copier, modifier, distribuer ou reproduire l'application sans l'autorisation écrite préalable de NUNCARE.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Modifications des Conditions ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Ces Termes sont régis et interprétés conformément aux lois du pays dans lequel l'Application est opérée. Tout litige découlant de ces Termes sera soumis à la juridiction exclusive des tribunaux compétents de ce pays.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "En utilisant l'application NUNCARE, vous reconnaissez avoir lu, compris et accepté les présentes conditions d'utilisation. Si vous avez des questions ou des préoccupations concernant ces conditions, veuillez nous contacter à l'adresse suivante : [infonuncare@gmail.com ; www.nuncare.pro].",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Merci de votre confiance et bonne utilisation de NUNCARE !",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "L'Équipe NUNCARE!",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
