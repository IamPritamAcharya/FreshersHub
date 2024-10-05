import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  final List<TravelItem> travelItems = [
    TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=15gtkSILsm_gTyPjnUCbpJ5gbS8Mgud-e',
      name: 'AKASH BHAWAN',
      tag: 'Hostel',
      fullDescription:
          '4 student accommodation, decent rooms, decent food, A-block is better, has Volleyball court, for 1st year boys',
    ),
    TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=17n-Aj3eOlegI0urIniYsI5ge7rMS_TIf',
      name: 'ARYABHATTA BHAWAN',
      tag: 'Hostel',
      fullDescription:
          '4 student accommodation, personally not a fan of the rooms here, good food, East block is better, has badminton court and basketball court, for 2nd year boys',
    ),

    TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=1JqSRaQo8WE1e64ZWYfBImYX6D2j-gLXC',
      name: 'BHASKAR BHAWAN',
      tag: 'Hostel',
      fullDescription:
          '3 student accommodation, decent rooms, great structure, good food, has badminton court, for 2nd year and 3rd year boys',
    ),
    TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=1WOLMZRogCYQYJs_OkTfHDwVJ1qvY2yis',
      name: 'BRAHMOS BHAWAN',
      tag: 'Hostel',
      fullDescription:
          '2 student accommodation, great rooms, great structure, good food, has badminton court, it consists of 3 blocks, for 3rd year, 4th year and mca boys, need good grades for allotment',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=1Pl9G0iJKGZMScYFLe22X4-lWkwdY64E_',
      name: 'SURYA BHAWAN',
      tag: 'Hostel',
      fullDescription:
          '1 student accommodation, for 4th year boys, has Basketball Court and Badminton Court, need top grades for allotment',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=18agu5ezTIpv73vyzgPm3BpfdH4UoHut7',
      name: 'ROHINI BHAWAN',
      tag: 'Hostel',
      fullDescription:
          '6 student accomodation, for 1st, 2nd year, diploma, mca girls',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=1w6e7hc-oSpqbDfSw5lJcOAYaSDb8VarE',
      name: 'PRITHVI BHAWAN',
      tag: 'Hostel',
      fullDescription:
          'for 3rd and 4th year girls',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=1coRc961NsLAmgYrBglFR54_oAEVGLTwz',
      name: 'AGNI BHAWAN',
      tag: 'Hostel',
      fullDescription:
          '4 student accommodation, has outdoor space, for Diploma boys',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=1dymgJNiU1iDyj2fIJNZ7T-B-_bTaOnBq',
      name: 'Cafeteria',
      tag: 'Canteen',
      fullDescription:
          'College Cafeteria',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=11nCLeMzr881JnnYMtpicYjsGYU3-oH0r',
      name: 'Old Canteen (OC)',
      tag: 'Canteen',
      fullDescription:
          'Old College Canteen, located at old building',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=1OpNC9Jv937gDRpVqm0XEAla5AIn7dJbM',
      name: 'BME Lab',
      tag: 'Lab',
      fullDescription:
          'Basic Mechanical Engineering lab for 1st year, Great learning experience, great teachers. Location: Go straight from the park, turn left then right and left and straight ahead. If you enter from the gate towards the new building then you will enter directly near the entrance of the lab',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=112NsY10KKHD68_xz_GAp5tH0iw2qZJg2',
      name: 'Workshop',
      tag: 'Lab',
      fullDescription:
          'Workshop for 1st year, waste of time mostly, we just stood there pretty much most of the time doing nothing, Location: Directly opposite to BME Lab; You will be writing 4 records here all the best :)',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=1U_Z8oGPpW5mjNh9plzULa7YHLIJHlgSN',
      name: 'BE Lab',
      tag: 'Lab',
      fullDescription:
          'Basic Electronic Engineering lab for 1st year, Do good in viva here, you will enjoy this one, Location: Near the main gate or dome or central library',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=11IsRQegCGts4NUawgYA1YOdkoFk7D_dd',
      name: 'BEE Lab',
      tag: 'Lab',
      fullDescription:
          'Basic Electrical Engineering lab for 1st year, Make sure your presence is known to the teachers, Location: Straight from park and turn right',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=1cadV1d-62Xt2fBAwXrnazXdVWWLDhcAd',
      name: 'Civil Lab',
      tag: 'Lab',
      fullDescription:
          'Basic Civil Engineering lab for 1st year, Location: Move inwards from BEE lab towards the hall and turn at 2nd left',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=1R2qthp6hLp4B5Y9NuDSYrSXT_qihXY4u',
      name: 'Chemistry Lab',
      tag: 'Lab',
      fullDescription:
          'Chemistry lab for 1st year, great learning experience, you will divided into groups based on roll number (1 group has 4 members generally), Location: If you are at room 206, go towards the toilet in first floor and when you reach stairs take a liitle diversion and move straight ahead(basically keep moving straight)',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=1tVNlS85IZ3aCN-emLkSLQe0jx6aV2_Lq',
      name: 'Physics Lab',
      tag: 'Lab',
      fullDescription:
          'Physics lab for 1st year ( Make sure you have hard cover notebook for record, keep your rough records safe, doesnt matter if you do experiments; let someone else from your group do them, they wont care, the lab marks are going to entirely depend on your viva and semester exams, Consider me shocked if you understand anything here, Location: Infront of Chemistry Lab',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=1FwrQfohuEjUE-pav6yRwhE3FjcE0Hu3d',
      name: 'English Lab',
      tag: 'Lab',
      fullDescription:
          'Only lab that has AC besides PLC lab. However you will attend at max 3 classes here. They dont check records',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=1V0zPANCcQ5NEZU-kXfJDAOfr1u6DSMLA',
      name: 'Library',
      tag: 'Library',
      fullDescription:
          'Best place to sit and study. Has AC. Quiet and best environment to study. Location: Near the dome/main gate',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=1grFwlozBgZVPvP8osYHGFMnp_YHOWXSb',
      name: 'Badminton court',
      tag: 'Other',
      fullDescription:
          'At Old building',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=19Ye3jiuFy07olYaSPStEirGy5QAx9zMJ',
      name: 'Room 206',
      tag: 'Other',
      fullDescription:
          'This is where we had our classes. Location: At old building',
    ), TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=16CZwKnp5ISbioLg_D7ZQ_5v6zwZFHSJV',
      name: 'Academic building',
      tag: 'Other',
      fullDescription:
          'This is where you can query about admission or academic related matter. Staff here are very straight forward',
    ),TravelItem(
      imageUrl:
          'https://drive.google.com/uc?export=view&id=1rd8EBanwKtbIhoDjs94XrQfBwR8D-KGR',
      name: 'Park',
      tag: 'Other',
      fullDescription:
          'One of the few places I like',
    ),

    // Add more items as needed
  ];

  String searchQuery = '';
  String selectedTag = '';
  int currentPage = 1;
  final int itemsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    final filteredItems = travelItems
        .where((item) =>
            item.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    final tagItems = travelItems
        .where((item) =>
            item.tag.toLowerCase().contains(selectedTag.toLowerCase()))
        .toList();
    final displayedItems = selectedTag.isEmpty ? filteredItems : tagItems;

    final totalPages = (displayedItems.length / itemsPerPage).ceil();
    final paginatedItems = displayedItems
        .skip((currentPage - 1) * itemsPerPage)
        .take(itemsPerPage)
        .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: '\t\t\tSearch',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  currentPage = 1;
                });
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: travelItems.map((item) => item.tag).toSet().length,
              itemBuilder: (context, index) {
                final tag =
                    travelItems.map((item) => item.tag).toSet().toList()[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedTag == tag) {
                        selectedTag = '';
                      } else {
                        selectedTag = tag;
                      }
                      currentPage = 1;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: selectedTag == tag
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSecondary,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: selectedTag == tag
                              ? Theme.of(context).colorScheme.onSecondary
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PT Sans',
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: paginatedItems.length,
              itemBuilder: (context, index) {
                final item = paginatedItems[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DetailPage(travelItem: item),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ));
                  },
                  child: TravelCard(travelItem: item),
                );
              },
            ),
          ),
          if (totalPages > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(totalPages, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentPage = index + 1;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: currentPage == index + 1
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          color: currentPage == index + 1
                              ? Theme.of(context).colorScheme.onSecondary
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PT Sans',
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}

class TravelItem {
  final String imageUrl;
  final String name;
  final String tag;
  final String fullDescription;

  TravelItem({
    required this.imageUrl,
    required this.name,
    required this.tag,
    required this.fullDescription,
  });
}

class TravelCard extends StatelessWidget {
  final TravelItem travelItem;

  TravelCard({required this.travelItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Stack(
        children: [
          Hero(
            tag: travelItem.name,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                travelItem.imageUrl,
                fit: BoxFit.cover,
                height: 200.0,
                width: double.infinity,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Icon(Icons.error));
                },
              ),
            ),
          ),
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            top: 15.0,
            left: 15.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                travelItem.tag,
                style: GoogleFonts.lato(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15.0,
            left: 15.0,
            child: Text(
              travelItem.name,
              style: GoogleFonts.lato(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final TravelItem travelItem;

  DetailPage({required this.travelItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Hero(
              tag: travelItem.name,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  travelItem.imageUrl,
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: double.infinity,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.error));
                  },
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              travelItem.name,
              style: GoogleFonts.lato(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              travelItem.fullDescription,
              style: GoogleFonts.lato(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
