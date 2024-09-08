import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/screens/auth/login_screen.dart';
import 'package:nuncare_mobile_firebase/screens/auth/registration_pages/location_infos_page.dart';
import 'package:nuncare_mobile_firebase/screens/auth/registration_steps.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/screens/auth/registration_pages/personnal_infos_page.dart';
import 'package:nuncare_mobile_firebase/screens/auth/registration_pages/professional_infos_page.dart';
import 'package:nuncare_mobile_firebase/screens/auth/registration_pages/security_infos_page.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = AuthService();
  late PageController _pageController;
  ResourceService _resourceService = ResourceService();
  late List<Widget> registrationsPage;
  List<String> _regionsForSelectedDistrict = [];

  var _isLoading = false;

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedGender = 'H';

  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _promotionController = TextEditingController();
  final TextEditingController _orderNumberController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  String? _selectedSpeciality;
  String? _selectedUniversity;
  String? _selectedDistrict;
  String? _selectedRegion;
  String? _selectedCity;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  bool _policyTermsCheck = false;
  bool _dataTermsCheck = false;

  void getRegionsForDistrict(String district) async {
    try {
      List<String> response =
          await _resourceService.getRegionsForSpecificDistrict(district);

      setState(() {
        _regionsForSelectedDistrict = response;
      });

      print(_regionsForSelectedDistrict);
    } catch (error) {
      print(error);
    }
  }

  void _handleChangePolicy(bool? newValue) {
    setState(() {
      _policyTermsCheck = newValue ?? false;
    });
  }

  void _handleChangeTerms(bool? newValue) {
    setState(() {
      _dataTermsCheck = newValue ?? false;
    });
  }

  void _handleSelectGender(String value) {
    setState(() {
      _selectedGender = value;
    });
  }

  void _handleSelectSpeciality(String? value) {
    _selectedSpeciality = value;
  }

  void _handleSelectUniversity(String? value) {
    _selectedUniversity = value;
  }

  void _handleSelectDistrict(String? value) {
    _selectedDistrict = value;
    getRegionsForDistrict(value!);
  }

  void _handleSelectRegion(String? value) {
    _selectedRegion = value;
  }

  void _handleSelectcity(String? value) {
    _selectedCity = value;
  }

  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    registrationsPage = [
      PersonalInfosPage(
        controller: _pageController,
        firstnameController: _firstnameController,
        lastnameController: _lastnameController,
        phoneController: _phoneController,
        selectedGender: _selectedGender,
        onChangeGender: _handleSelectGender,
      ),
      ProfessionnalPageInfos(
        controller: _pageController,
        yearsController: _yearsController,
        promotionController: _promotionController,
        orderNumberController: _orderNumberController,
        hospitalController: _hospitalController,
        selectedUniversity: _selectedUniversity,
        selectedSpeciality: _selectedSpeciality,
        onChangeSpeciality: _handleSelectSpeciality,
        onchangeUniversity: _handleSelectUniversity,
      ),
      LocationPageInfos(
        controller: _pageController,
        selectedCity: _selectedCity,
        onChangeDistrict: _handleSelectDistrict,
        onChangeRegion: _handleSelectRegion,
        onChangeCity: _handleSelectcity,
      ),
      SecurityPageInfos(
        controller: _pageController,
        emailController: _emailController,
        pwController: _pwController,
        confirmPwController: _confirmPwController,
        policyTermsCheck: _policyTermsCheck,
        dataTermsCheck: _dataTermsCheck,
        isLoading: _isLoading,
        onChangeTerms: _handleChangeTerms,
        onChangePolicy: _handleChangePolicy,
        onSubmit: _submit,
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _pwController.dispose();
    _confirmPwController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _yearsController.dispose();
    _promotionController.dispose();
    _orderNumberController.dispose();
    _hospitalController.dispose();
    super.dispose();
  }

  void _submit() async {
    try {
      setState(() {
        _isLoading = true;
      });

      Map<String, String> userData = {
        "email": _emailController.text.trim(),
        "firstName": _firstnameController.text.trim(),
        "lastName": _lastnameController.text.trim(),
        "sex": _selectedGender,
        "speciality": _selectedSpeciality ?? '',
        "years": _yearsController.text.trim(),
        "phone": _phoneController.text.replaceAll(' ', ''),
        "orderNumber": _orderNumberController.text.trim(),
        "promotion": _promotionController.text.trim(),
        // "district": _selectedDistrict!,
        "region": _selectedRegion ?? '',
        "city": _selectedCity ?? '',
        'password': _pwController.text.trim()
      };

      BasicResponse response = await _auth.signUp(userData);

      if (!context.mounted) {
        return;
      }

      if (response.success) {
        setState(() {
          _isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => const LoginScreen(),
          ),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade200,
          content: Text(response.message),
          duration: const Duration(seconds: 4),
        ),
      );

      return;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade400,
          content: Text(e.toString()),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth(BuildContext context) =>
        MediaQuery.of(context).size.width;
    double deviceHeight(BuildContext context) =>
        MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Inscription",
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
          vertical: deviceHeight(context) * 0.08,
          horizontal: deviceWidth(context) * 0.05,
        ),
        child: Column(
          children: [
            RegistrationSteps(
              pages: registrationsPage,
              activePage: _pageIndex,
            ),
            Expanded(
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: registrationsPage.length,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemBuilder: (context, index) => registrationsPage[index],
              ),
            ),
            const Text(
              "Vous avez déja une compte ? ",
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const LoginScreen(),
                  ),
                );
              },
              child: Text(
                "Connectez-vous",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
