import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  String helloMessage = '';
  String ageYears = '';
  String ageMonths = '';
  String ageDays = '';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dayController = TextEditingController();
    monthController = TextEditingController();
    yearController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          children: [
            // Form Input
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              padding: const EdgeInsets.all(4),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Name :  '),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: TextFormField(
                              controller: nameController,
                              textAlign: TextAlign.start,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Name is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        const Text('Tanggal Lahir'),
                        const SizedBox(
                          width: 3.0,
                        ),
                        // Form Tanggal
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              readOnly: true,
                              textAlign: TextAlign.center,
                              controller: dayController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Day is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        const Text(
                          '/',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        // Form Bulan
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              readOnly: true,
                              textAlign: TextAlign.center,
                              controller: monthController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mounth is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        const Text(
                          '/',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        // Form Tahun
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              readOnly: true,
                              textAlign: TextAlign.center,
                              controller: yearController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Year is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null &&
                                pickedDate != selectedDate) {
                              setState(() {
                                selectedDate = pickedDate;
                                dayController.text =
                                    DateFormat('dd').format(pickedDate);
                                monthController.text =
                                    DateFormat('MM').format(pickedDate);
                                yearController.text =
                                    DateFormat('yyyy').format(pickedDate);
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              calculateAge();
                              nameController.clear();
                              dayController.clear();
                              monthController.clear();
                              yearController.clear();
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Form Hasil
            Container(
              margin: const EdgeInsets.only(top: 50),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hallo $helloMessage',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Text(
                    'Usia anda saat ini adalah :',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '$ageYears Tahun',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    '$ageMonths Bulan',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    '$ageDays Hari',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text('Bintang anda adalah',
                      style: TextStyle(fontSize: 20)),
                  Text(
                    determineZodiac(selectedDate),
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void calculateAge() {
    DateTime birthDate = DateTime(
      int.parse(yearController.text),
      int.parse(monthController.text),
      int.parse(dayController.text),
    );

    DateTime currentDate = DateTime.now();

    int years = currentDate.year - birthDate.year;
    int months = currentDate.month - birthDate.month;
    int days = currentDate.day - birthDate.day;

    if (days < 0) {
      final DateTime lastMonth =
          currentDate.subtract(Duration(days: birthDate.day));
      days = currentDate.difference(lastMonth).inDays;
      months--;

      if (months < 0) {
        months += 12;
        years--;
      }
    }

    setState(() {
      ageYears = years.toString();
      ageMonths = months.toString();
      ageDays = days.toString();
      helloMessage = nameController.text;
    });

    determineZodiac(birthDate);
  }

  String determineZodiac(DateTime birthDate) {
    String zodiac = '';
    if ((birthDate.month == 3 && birthDate.day >= 21) ||
        (birthDate.month == 4 && birthDate.day <= 19)) {
      zodiac = 'Aries';
    } else if ((birthDate.month == 4 && birthDate.day >= 20) ||
        (birthDate.month == 5 && birthDate.day <= 20)) {
      zodiac = 'Taurus';
    } else if ((birthDate.month == 5 && birthDate.day >= 21) ||
        (birthDate.month == 6 && birthDate.day <= 20)) {
      zodiac = 'Gemini';
    } else if ((birthDate.month == 6 && birthDate.day >= 21) ||
        (birthDate.month == 7 && birthDate.day <= 22)) {
      zodiac = 'Cancer';
    } else if ((birthDate.month == 7 && birthDate.day >= 23) ||
        (birthDate.month == 8 && birthDate.day <= 22)) {
      zodiac = 'Leo';
    } else if ((birthDate.month == 8 && birthDate.day >= 23) ||
        (birthDate.month == 9 && birthDate.day <= 22)) {
      zodiac = 'Virgo';
    } else if ((birthDate.month == 9 && birthDate.day >= 23) ||
        (birthDate.month == 10 && birthDate.day <= 22)) {
      zodiac = 'Libra';
    } else if ((birthDate.month == 10 && birthDate.day >= 23) ||
        (birthDate.month == 11 && birthDate.day <= 21)) {
      zodiac = 'Scorpio';
    } else if ((birthDate.month == 11 && birthDate.day >= 22) ||
        (birthDate.month == 12 && birthDate.day <= 21)) {
      zodiac = 'Sagittarius';
    } else if ((birthDate.month == 12 && birthDate.day >= 22) ||
        (birthDate.month == 1 && birthDate.day <= 19)) {
      zodiac = 'Capricorn';
    } else if ((birthDate.month == 1 && birthDate.day >= 20) ||
        (birthDate.month == 2 && birthDate.day <= 18)) {
      zodiac = 'Aquarius';
    } else if ((birthDate.month == 2 && birthDate.day >= 19) ||
        (birthDate.month == 3 && birthDate.day <= 20)) {
      zodiac = 'Pisces';
    }

    return zodiac;
  }
}
