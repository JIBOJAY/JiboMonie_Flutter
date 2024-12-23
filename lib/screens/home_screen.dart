import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../variables.dart'; // Import variables.dart to access uProfilePic
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Track the current selected index
  bool _isBalVisible = false; // Boolean to control card number visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            title: const Text(
              "Welcome, User",
              style: TextStyle(
                fontFamily: 'Poppins', // Apply Poppins font here
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                debugPrint("Profile Picture Clicked");
              },
              child: CircleAvatar(
                backgroundColor: Colors.lightGreen,
                backgroundImage:
                    NetworkImage(uProfilePic), // Accessing the getter
                radius: 100,
              ),
            ),
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  debugPrint('Notification Button Pressed');
                },
                icon: const FaIcon(
                  FontAwesomeIcons.bell,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
          gap: 8, // Gap between icons
          activeColor: Colors.green, // Active icon color
          iconSize: 18, // Icon size
          padding: const EdgeInsets.all(16), // Padding around icons
          duration: const Duration(milliseconds: 400), // Animation duration
          tabBackgroundColor: Colors.grey
              .withOpacity(0.2), // Background color of the active tab
          color: Colors.black, // Inactive icon color
          tabs: const [
            GButton(
              icon: FontAwesomeIcons.house,
              text: 'Home',
            ),
            GButton(
              icon: FontAwesomeIcons.wallet,
              text: 'Wallet',
            ),
            GButton(
              icon: FontAwesomeIcons.clockRotateLeft,
              text: 'History',
            ),
            GButton(
              icon: FontAwesomeIcons.user,
              text: 'Profile',
            ),
          ],
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index; // Update the selected index
            });
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Balance',
                            style: TextStyle(
                              fontFamily: 'Poppins', // Apply Poppins font here
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _isBalVisible ? uBalance : '****',
                            style: const TextStyle(
                              fontFamily: 'Poppins', // Apply Poppins font here
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 16,
                      top: 16,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isBalVisible = !_isBalVisible;
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _isBalVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildMenuItem(Icons.send, "Send Money", "Acc to acc"),
                    _buildMenuItem(Icons.wifi, "Buy Data", "Get data bundles"),
                    _buildMenuItem(Icons.phone_android, "Mobile Prepaid",
                        "Recharge Airtime"),
                    _buildMenuItem(Icons.account_balance, "Transfer to Bank",
                        "Send to other Banks"),
                  ],
                ),
              ),
            ],
          ),
        );
      case 1:
        return const Center(
          child: Text('Wallet Screen Content'),
        );
      case 2:
        return const Center(
          child: Text('History Screen Content'),
        );
      case 3:
        return const Center(
          child: Text('Profile Screen Content'),
        );
      default:
        return const Center(
          child: Text('Unknown Screen'),
        );
    }
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle) {
    return Material(
      color: Colors.white, // Ensures the background matches the card
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          debugPrint('Card $title tapped');
          // Add your navigation logic here
        },
        borderRadius: BorderRadius.circular(16), // Ensures smooth ripple edges
        splashColor: Colors.green.withOpacity(0.4), // Visible splash color
        highlightColor: Colors.green.withOpacity(0.2), // Highlight during press
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.greenAccent),
              const SizedBox(height: 12),
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
