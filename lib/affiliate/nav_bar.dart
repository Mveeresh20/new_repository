import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/WelcomeScreen.dart'; // Import WelcomeScreen to navigate after logout
import 'package:tngtong/affiliate/ProfileScreen.dart'; // Import ProfileUpdateScreen
import 'package:tngtong/affiliate//walletScreen.dart'; // Import ProfileUpdateScreen
/*import 'package:tngtong/celebrities/myProjectScreen.dart';*/
import 'package:tngtong/affiliate/SelectPackageScreen.dart';
import 'package:tngtong/affiliate/ReferralProgramScreen.dart';
import 'package:tngtong/affiliate/WithdrawalsScreen.dart';
import 'package:tngtong/affiliate/affilate_dashboard.dart';

class NavBar extends StatelessWidget {
  final VoidCallback onClose;

  const NavBar({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Fixed width of the NavBar
      decoration: const BoxDecoration(
        color: Color(0xff281537),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Close Button at the Top-Left Corner
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: onClose,
            ),
          ),
          const SizedBox(height: 0),

          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Text(
                    'm', // Replace with user's initial
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    'manoj kumar',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: CircleAvatar(
                    child: Icon(Icons.logout),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()),
                      (Route<dynamic> route) =>
                          false, // Removes all previous routes
                    ); // Handle logout
                  },
                ),
                // Language selection
              ],
            ),
          ),

          // Menu Items
          _buildMenuItem(Icons.home, "Home", context,
              nextScreen: AffiliateDashboardScreen()),
          _buildMenuItem(Icons.wallet_giftcard_sharp, "Wallet", context,
              nextScreen: WalletScreen()),
              _buildMenuItem(Icons.attach_money, "Withdrawals", context,
              nextScreen: WithdrawalsScreen()),
          _buildMenuItem(Icons.person_add, "My Referrals", context,
              nextScreen: ReferralProgramScreen()),
              _buildMenuItem(Icons.payment, "Packages", context,
              nextScreen: SelectPackageScreen()),

          _buildMenuItem(Icons.person, "My Account", context,
              nextScreen: ProfileUpdateScreen()),
          /* _buildMenuItem(Icons.settings, "My Projects", context,/*nextScreen: MyProjectsScreen()*/),*/
      
          
          /*_buildMenuItem(Icons.settings, "Referral Program", context,nextScreen:ReferralProgramScreen()),*/

          _buildMenuItem(Icons.logout, "Logout", context, isLogout: true),

          SizedBox(
            height: 56,
          ),
          Container(
            width: double.infinity,
            child: Card(
              color: Color(0xFFFFDAB9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  // Main content is now a Row
                  children: [
                    Container(
                      width: 60, // Adjust size as needed
                      height: 60, // Adjust size as needed
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow, // Optional background color
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/coin.png',
                          // Replace with your image path
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      // To make the Column take remaining space
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Refer & Earn',
                            style: TextStyle(
                              color: Colors.purple.shade500,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Earn 20k to 25k monthly by referral this app with your friends and family !!',
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 8.0),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              minimumSize: Size(80, 30),
                              backgroundColor: Colors.purple[500],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReferralProgramScreen()));
                              // Handle Refer Now button tap
                            },
                            child: Text(
                              'REFER NOW',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build menu items
  Widget _buildMenuItem(IconData icon, String label, BuildContext context,
      {bool isLogout = false, Widget? nextScreen}) {
    return InkWell(
      onTap: () async {
        if (isLogout) {
          // Clear shared preferences
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.clear(); // Removes all keys

          // Navigate to the WelcomeScreen after logging out
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            (Route<dynamic> route) => false, // Removes all previous routes
          );
        } else if (nextScreen != null) {
          // Navigate to the ProfileUpdateScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextScreen),
          );
        } else {
          print("Clicked on $label");
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
