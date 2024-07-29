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
          "Politique de confidentialité",
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
                "1. Introduction",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Bienvenue sur Nuncare. En utilisant notre Application, vous acceptez les termes et conditions suivants . Veuillez les lire attentivement. Si vous n'acceptez pas ces Termes, veuillez ne pas utiliser l'Application.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "2. Services",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "L'Application offre une plateforme permettant aux utilisateurs de consulter des informations médicales, de prendre rendez-vous avec des médecins, et de recevoir des conseils médicaux. Les services fournis ne remplacent pas une consultation en personne avec un professionnel de santé qualifié.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "3. Utilisation de l'Application",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "L'Application offre une plateforme permettant aux utilisateurs de consulter des informations médicales, de prendre rendez-vous avec des médecins, et de recevoir des conseils médicaux. Les services fournis ne remplacent pas une consultation en personne avec un professionnel de santé qualifié.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "a. Inscription : Pour utiliser certains services, vous devez créer un compte en fournissant des informations exactes et à jour. Vous êtes responsable de la confidentialité de vos informations de compte.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "b. Exactitude des Informations : Vous devez fournir des informations médicales et personnelles exactes et complètes. Toute information incorrecte peut entraîner des conséquences sur les services fournis.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "c. Utilisation Autorisée : Vous acceptez d'utiliser l'Application uniquement à des fins légales et conformément aux lois et règlements applicables. Toute utilisation abusive ou non autorisée peut entraîner la suspension ou la résiliation de votre compte.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "5. Limitation de Responsabilité",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "a. Absence de Garantie : Les informations fournies sur l'Application sont à titre informatif uniquement. Nous ne garantissons pas l'exactitude, la complétude ou la pertinence des informations fournies.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "b. Conseils Médicaux : Les conseils médicaux fournis par l'intermédiaire de l'Application ne remplacent pas une consultation en personne avec un médecin. En cas d'urgence médicale, contactez immédiatement les services d'urgence.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "c. Responsabilité Limitée : Nous ne serons pas responsables des dommages directs, indirects, spéciaux, consécutifs ou punitifs résultant de l'utilisation de l'Application ou de l'incapacité à l'utiliser.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "6. Propriété Intellectuelle",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Tous les contenus, y compris les textes, graphiques, logos, et logiciels, sont la propriété de l'Application ou de ses concédants de licence et sont protégés par les lois sur la propriété intellectuelle. Vous ne pouvez pas copier, distribuer, modifier ou utiliser ces contenus sans autorisation.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "7. Modifications des Termes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Nous nous réservons le droit de modifier ces Termes à tout moment. Les modifications seront effectives dès leur publication sur l'Application. Il est de votre responsabilité de consulter régulièrement les Termes. Votre utilisation continue de l'Application constitue votre acceptation des modifications.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "8. Résiliation",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Nous nous réservons le droit de suspendre ou de résilier votre accès à l'Application à tout moment, sans préavis, pour toute violation des Termes ou pour toute autre raison à notre discrétion.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "9. Droit Applicable",
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
                height: 40,
              ),
              Text(
                "10. Contact",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Pour toute question ou préoccupation concernant ces Termes, veuillez nous contacter à l'adresse suivante : info@nuncare.pro",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "11. Acceptation des Termes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "En utilisant l'Application, vous reconnaissez avoir lu, compris et accepté ces Termes.",
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
