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
                "Responsabilité de l'Utilisateur",
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
              SizedBox(
                height: 50,
              ),
              Text(
                "POLITIQUE D'UTILISATION DE NUNCARE",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Cette Politique de Confidentialité régit la manière dont NUNCARE collecte, utilise, conserve et divulgue les informations collectées auprès des utilisateurs de notre application, conformément à la loi ivoirienne sur la protection des données à caractère personnel.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Collecte des Informations",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "NUNCARE peut collecter des informations personnelles identifiables auprès des utilisateurs, telles que leur nom, leur adresse e-mail, leur numéro de téléphone, leur adresse postale, etc., uniquement dans le cadre de la fourniture de nos services. Nous ne collectons ces informations que si elles sont fournies volontairement par les utilisateurs.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Utilisation des Informations ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Les informations personnelles collectées par NUNCARE sont utilisées dans le but de fournir les services demandés par les utilisateurs, tels que la prise de rendez-vous médicaux, la communication avec les professionnels de santé, etc. Ces informations ne seront pas utilisées à d'autres fins sans le consentement préalable de l'utilisateur.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Conservation des Informations ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "NUNCARE s'engage à conserver les informations personnelles des utilisateurs de manière sécurisée et confidentielle, et à ne les conserver que pendant la durée nécessaire à la réalisation des finalités pour lesquelles elles ont été collectées.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Divulgation des Informations",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "NUNCARE ne divulguera pas les informations personnelles des utilisateurs à des tiers sans leur consentement préalable, sauf dans les cas prévus par la loi ou lorsque cela est nécessaire pour protéger nos droits légaux.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Sécurité des Informations",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "NUNCARE met en œuvre des mesures de sécurité appropriées pour protéger les informations personnelles des utilisateurs contre tout accès non autorisé, toute divulgation ou toute altération. Cependant, aucune méthode de transmission sur Internet ou de stockage électronique n'est totalement sécurisée, et NUNCARE ne peut garantir la sécurité absolue des informations transmises ou stockées.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Droits des Utilisateurs",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Les utilisateurs ont le droit d'accéder à leurs informations personnelles, de les corriger, de les mettre à jour ou de les supprimer. Ils ont également le droit de retirer leur consentement à tout moment pour le traitement de leurs informations personnelles.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Modifications de la Politique de Confidentialité ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "NUNCARE se réserve le droit de modifier cette Politique de Confidentialité à tout moment et sans préavis. Les utilisateurs seront informés de toute modification importante de cette Politique de Confidentialité via notre application ou par d'autres moyens appropriés.",
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
