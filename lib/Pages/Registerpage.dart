import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _phoneAuthController = TextEditingController();
  static Country _selectedFilteredDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode("91");
  String _countryCode = _selectedFilteredDialogCountry.phoneCode;
  String _phoneNumber = "";
  @override
  void dispose() {
    _phoneAuthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _bodyWidget(),
      ),
    );
  }

  Widget _bodyWidget() {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 5,
            ),
            Text(
              "Register",
              style: TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 20,
            ),
            Text(
              "CarsFin will send a OTP to verify ",
              style: TextStyle(color: Color(0xFF818181), fontSize: 18),
            ),
            Text(
              "your Phone number",
              style: TextStyle(color: Color(0xFF818181), fontSize: 18),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 8,
            ),
            ListTile(
              onTap: _openFilteredCountryPickerDialog,
              title: _buildDialogItem(_selectedFilteredDialogCountry),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 25,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                  width: 80,
                  height: 42,
                  alignment: Alignment.center,
                  child: Text("${_selectedFilteredDialogCountry.phoneCode}",
                      style: TextStyle(color: Color(0xFF818181))),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneAuthController,
                      decoration: InputDecoration(
                          hintText: "Phone Number",
                          hintStyle: TextStyle(color: Color(0xFF818181))),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                color: Colors.indigo,
                onPressed: () {},
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  void _openFilteredCountryPickerDialog() {
    showDialog(
        context: context,
        child: CountryPickerDialog(
          titlePadding: EdgeInsets.all(1),
          title: Text("Select your country"),
          searchInputDecoration: InputDecoration(hintText: "Seach"),
          isSearchable: true,
          onValuePicked: (Country country) {
            setState(() {
              _selectedFilteredDialogCountry = country;
              _countryCode = country.phoneCode;
            });
          },
          itemBuilder: _buildDialogItem,
        ));
  }

  Widget _buildDialogItem(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            height: 8,
          ),
          Text(
            " + ${country.phoneCode}",
            style: TextStyle(color: Color(0xFF818181)),
          ),
          SizedBox(
            height: 8,
          ),
          Text(" ${country.name}", style: TextStyle(color: Color(0xFF818181))),
          Spacer(),
          Icon(Icons.keyboard_arrow_down)
        ],
      ),
    );
  }
}
