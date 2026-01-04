import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

void main() {
  runApp(const VortexApp());
}

class VortexApp extends StatelessWidget {
  const VortexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VORTEX Terminal',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF050505), // Deep Black
        primaryColor: const Color(0xFF8B5CF6), // Purple
        brightness: Brightness.dark,
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
      ),
      home: const MainWrapper(),
    );
  }
}

// --- NAVIGATION CONTROLLER ---
class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ActivityScreen(), // Transaction History
    const CardsScreen(),    // Wallet/Cards
    const SettingsScreen(), // Settings
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF050505),
          selectedItemColor: const Color(0xFF8B5CF6),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Iconsax.home5), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Iconsax.activity), label: 'Activity'),
            BottomNavigationBarItem(icon: Icon(Iconsax.card), label: 'Cards'),
            BottomNavigationBarItem(icon: Icon(Iconsax.setting_2), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}

// =======================================================
// SCREEN 1: DASHBOARD (Your existing code, simplified)
// =======================================================
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Hello, Fakhar', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text('Welcome back', style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Balance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5B21B6), Color(0xFF8B5CF6)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Balance', style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 8),
                    Text('\$32,982.38', style: GoogleFonts.jetBrainsMono(fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        ActionButton(icon: Iconsax.add, label: 'Add'),
                        ActionButton(icon: Iconsax.arrow_up_3, label: 'Send'),
                        ActionButton(icon: Iconsax.arrow_down, label: 'Request'),
                        ActionButton(icon: Iconsax.convert, label: 'Swap'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text('Your Assets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              // Asset List
              Column(
                children: const [
                  AssetTile(name: 'Bitcoin', symbol: 'BTC', price: '\$64,230', change: '+2.4%', color: Colors.orange),
                  AssetTile(name: 'Ethereum', symbol: 'ETH', price: '\$3,450', change: '-0.8%', color: Colors.blue),
                  AssetTile(name: 'Solana', symbol: 'SOL', price: '\$145', change: '+5.6%', color: Colors.purple),
                  AssetTile(name: 'Crypto', symbol: 'UKN', price: '\$897', change: '+8.2%', color: Color.fromARGB(255, 39, 176, 87)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =======================================================
// SCREEN 2: ACTIVITY (Transaction History)
// =======================================================
class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction History"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Text("Today", style: TextStyle(color: Colors.grey, fontSize: 14)),
          SizedBox(height: 10),
          TransactionTile(title: "Apple Store", date: "10:42 AM", amount: "-\$1,299.00", isExpense: true),
          TransactionTile(title: "Upwork Earnings", date: "09:15 AM", amount: "+\$450.00", isExpense: false),
          TransactionTile(title: "Starbucks", date: "08:30 AM", amount: "-\$12.50", isExpense: true),
          
          SizedBox(height: 20),
          Text("Yesterday", style: TextStyle(color: Colors.grey, fontSize: 14)),
          SizedBox(height: 10),
          TransactionTile(title: "Transfer to Savings", date: "Yesterday", amount: "-\$500.00", isExpense: true),
          TransactionTile(title: "Crypto Swap (BTC)", date: "Yesterday", amount: "+\$200.00", isExpense: false),
        ],
      ),
    );
  }
}

// =======================================================
// SCREEN 3: CARDS (Wallet)
// =======================================================
class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Cards"), backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // The Physical Card Look
            Container(
              height: 220,
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: NetworkImage("https://img.freepik.com/free-vector/gradient-black-background-with-wavy-lines_23-2149151101.jpg"), 
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.purple, BlendMode.overlay),
                ),
                boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("VORTEX Black", style: TextStyle(color: Colors.white70)),
                      Icon(Iconsax.wifi, color: Colors.white70),
                    ],
                  ),
                  Text("**** **** **** 4209", style: GoogleFonts.jetBrainsMono(fontSize: 24, letterSpacing: 4)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Card Holder", style: TextStyle(fontSize: 10, color: Colors.grey)),
                          Text("FAKHAR E ARJUMAND", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Icon(Icons.credit_card, size: 40, color: Colors.white70), // Placeholder for Mastercard/Visa logo
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Card Settings
            const SettingTile(icon: Iconsax.lock, title: "Freeze Card", subtitle: "Temporarily disable this card"),
            const SettingTile(icon: Iconsax.setting_2, title: "Card Settings", subtitle: "Limits & Pins"),
          ],
        ),
      ),
    );
  }
}

// =======================================================
// SCREEN 4: SETTINGS
// =======================================================
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), backgroundColor: Colors.transparent, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
           SettingTile(icon: Iconsax.user, title: "Profile", subtitle: "Edit personal details"),
           SettingTile(icon: Iconsax.notification, title: "Notifications", subtitle: "Alerts & Sounds"),
           SettingTile(icon: Iconsax.shield_security, title: "Security", subtitle: "2FA & Password"),
           SettingTile(icon: Iconsax.moon, title: "Theme", subtitle: "Dark Mode Enabled"),
           SizedBox(height: 20),
           SettingTile(icon: Iconsax.logout, title: "Log Out", subtitle: "Sign out of Vortex", isRed: true),
        ],
      ),
    );
  }
}

// =======================================================
// HELPER WIDGETS
// =======================================================

class ActionButton extends StatelessWidget {
  final IconData icon; final String label;
  const ActionButton({super.key, required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }
}

class AssetTile extends StatelessWidget {
  final String name, symbol, price, change; final Color color;
  const AssetTile({super.key, required this.name, required this.symbol, required this.price, required this.change, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(Iconsax.bitcoin_card, color: color, size: 18)),
          const SizedBox(width: 16),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.bold)), Text(symbol, style: TextStyle(color: Colors.grey[600], fontSize: 12))]),
          const Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(price, style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold)), Text(change, style: TextStyle(color: change.startsWith('+') ? Colors.green : Colors.red, fontSize: 12))]),
        ],
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final String title, date, amount; final bool isExpense;
  const TransactionTile({super.key, required this.title, required this.date, required this.amount, required this.isExpense});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(12)),
        child: Icon(isExpense ? Iconsax.arrow_up_1 : Iconsax.arrow_down_1, color: isExpense ? Colors.redAccent : Colors.greenAccent),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      trailing: Text(amount, style: GoogleFonts.jetBrainsMono(color: isExpense ? Colors.white : Colors.greenAccent, fontWeight: FontWeight.bold)),
    );
  }
}

class SettingTile extends StatelessWidget {
  final IconData icon; final String title, subtitle; final bool isRed;
  const SettingTile({super.key, required this.icon, required this.title, required this.subtitle, this.isRed = false});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: isRed ? Colors.red.withOpacity(0.1) : const Color(0xFF161616), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: isRed ? Colors.red : Colors.white),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isRed ? Colors.red : Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
    );
  }
}