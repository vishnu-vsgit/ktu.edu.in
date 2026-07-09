import 'package:flutter/material.dart';
import 'theme.dart';
import 'widgets.dart';

void main() {
  runApp(const KtuPortalApp());
}

class KtuPortalApp extends StatelessWidget {
  const KtuPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ktu.edu.in',
      theme: buildAppTheme(),
      debugShowCheckedModeBanner: false,
      home: const PortalHomePage(),
    );
  }
}

class PortalHomePage extends StatefulWidget {
  const PortalHomePage({super.key});

  @override
  State<PortalHomePage> createState() => _PortalHomePageState();
}

class _PortalHomePageState extends State<PortalHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoggedIn = false;
  String _loggedInUser = 'NANDANA R';
  String _regNo = 'ATP23CS063';

  String? _errorMessage;
  String _activeNavId = 'Home';
  String _activeSidebarItem = 'Dashboard';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _prefillCredentials(String role) {
    setState(() {
      _usernameController.text = role;
      _passwordController.text = 'password123';
      _errorMessage = null;
    });
  }

  void _handleLogin() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both username and password.';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
      _isLoggedIn = true;
      // Capture custom name if entered, otherwise use default
      if (username.toLowerCase() == 'student') {
        _loggedInUser = 'NANDANA R';
        _regNo = 'ATP23CS063';
      } else if (username.toLowerCase() == 'institution') {
        _loggedInUser = 'CET Admin';
        _regNo = 'TVE-INST';
      } else if (username.toLowerCase() == 'university') {
        _loggedInUser = 'KTU Controller';
        _regNo = 'KTU-HQ';
      } else {
        _loggedInUser = 'Nandana R';
        _regNo = 'ATP23CS060'; // Fallback registry
      }
    });
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
      _usernameController.clear();
      _passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 800;

    if (_isLoggedIn) {
      return _buildDashboardPage(isDesktop);
    } else {
      return _buildLoginPage(isDesktop);
    }
  }

  // ==========================================
  // LOGIN SCREEN
  // ==========================================
  Widget _buildLoginPage(bool isDesktop) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: _buildLoginNavbar(isDesktop),
      ),
      drawer: !isDesktop ? _buildLoginDrawer() : null,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: isDesktop
                        ? _buildLoginDesktopLayout()
                        : _buildLoginMobileLayout(),
                  ),
                ),
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildLoginNavbar(bool isDesktop) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navbarBg,
        border: Border(bottom: BorderSide(color: Color(0xFFB2D1ED), width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Image.asset(
                    'images/ktu-logo.png',
                    height: 40,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 40,
                      height: 40,
                      color: AppColors.primaryBlue,
                      child: const Icon(
                        Icons.school,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'e-Gov Platform for APJ Abdul Kalam Technological University',
                      style: TextStyle(
                        color: AppColors.navbarText,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            if (isDesktop)
              Row(
                children: [
                  _buildLoginNavLink('Home'),
                  _buildLoginNavLink('PhD Application'),
                  _buildLoginNavLink('FAQ'),
                  _buildLoginNavLink('Contact Us'),
                ],
              )
            else
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.primaryBlue),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginNavLink(String label) {
    final bool isActive = _activeNavId == label;
    return InkWell(
      onTap: () {
        setState(() {
          _activeNavId = label;
        });
      },
      child: Container(
        color: isActive ? AppColors.navbarActive : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.primaryBlue,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginDrawer() {
    return Drawer(
      backgroundColor: AppColors.navbarBg,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primaryBlue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/ktu-logo.png', height: 50),
                const SizedBox(height: 10),
                const Text(
                  'KTU e-Governance',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildLoginDrawerLink('Home'),
          _buildLoginDrawerLink('PhD Application'),
          _buildLoginDrawerLink('FAQ'),
          _buildLoginDrawerLink('Contact Us'),
        ],
      ),
    );
  }

  Widget _buildLoginDrawerLink(String label) {
    final bool isActive = _activeNavId == label;
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          color: isActive ? AppColors.navbarActive : AppColors.navbarText,
          fontWeight: FontWeight.bold,
        ),
      ),
      selected: isActive,
      selectedTileColor: const Color(0xFFD2E4F5),
      onTap: () {
        setState(() {
          _activeNavId = label;
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildLoginDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildLoginLeftSection()),
        const SizedBox(width: 20),
        Expanded(flex: 1, child: _buildLoginRightSection()),
      ],
    );
  }

  Widget _buildLoginMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLoginLeftSection(),
        const SizedBox(height: 20),
        _buildLoginRightSection(),
      ],
    );
  }

  Widget _buildLoginLeftSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'APJ Abdul Kalam Technological University e-Governance Portal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'ktuapp5',
                  style: TextStyle(color: Color(0xFFB2D7F5), fontSize: 11),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.borderGray),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              RoleCard(
                icon: Icons.school,
                title: 'Institutions',
                description:
                    'Institutions that are affiliated/applying for affiliation with APJ Abdul Kalam Technological University can click here to login to the e-Gov application. Institution users can perform activities related to affiliation, student registration and academics, make fee payments etc. Colleges can view the student records that includes personal information, admission information, attendance details, internal evaluation details, mark lists, student history and other details after logging on. For the programs offered by the university, colleges can view the curriculum and choose the courses for each branch/stream running there.',
                themeColor: AppColors.titleBlue,
                onTap: () => _prefillCredentials('institution'),
              ),
              RoleCard(
                icon: Icons.person,
                title: 'Students',
                description:
                    'Students who are admitted in colleges affiliated to APJ Abdul Kalam Technological University can click here to login to the e-Gov application. Registered students can use the student portal to gain access to personalized information and also view their academic details, attendance and marks, earned credits etc. They can download their mark list, grade sheet etc and access educational information. The portal also allows students to securely communicate with the university.',
                themeColor: AppColors.titleGreen,
                onTap: () => _prefillCredentials('student'),
              ),
              RoleCard(
                icon: Icons.domain,
                title: 'University',
                description:
                    'University staff such as management team, auditors, external trainers and other officials can login to the e-Gov application to perform various activities. Master data such as programs, schemes, branches/streams, courses, academic calendar etc can be set up by the administrators. Clusters can be set up, cluster members configured and curriculum managed for each cluster. University academic experts can prepare the Curriculum, Course Plan and Evaluation Plan for the various programs offered and set the rules for course selection by colleges. The management team can also issue orders, view payment information and respond to communication with colleges.',
                themeColor: AppColors.titleYellow,
                onTap: () => _prefillCredentials('university'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginRightSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFC2DCF2)),
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.panelHeaderBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(3),
                topRight: Radius.circular(3),
              ),
            ),
            child: const Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_errorMessage != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2DEDE),
                        border: Border.all(color: const Color(0xFFEBCCD1)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Color(0xFFA94442),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF555555),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter username',
                    ),
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF555555),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter password',
                    ),
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.btnGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                    ),
                    onPressed: _handleLogin,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Verification Demo: Use any username to sign in.',
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Color(0xFF337AB7),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // DASHBOARD PAGE
  // ==========================================
  Widget _buildDashboardPage(bool isDesktop) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: _buildDashboardHeader(isDesktop),
      ),
      drawer: !isDesktop ? _buildDashboardDrawer() : null,
      body: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left Navigation Menu (Desktop Sidebar)
                if (isDesktop)
                  Container(
                    width: 250,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F2FC), // Light blue-grey background
                      border: Border(
                        right: BorderSide(
                          color: AppColors.borderGray,
                          width: 1,
                        ),
                      ),
                    ),
                    child: _buildSidebarMenu(),
                  ),

                // Right Main Workspace content area
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Top horizontal Tab bar
                          _buildHorizontalTabs(isDesktop),
                          const SizedBox(height: 15),

                          if (_activeNavId == 'Home') ...[
                            // Dashboard section label
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.panelHeaderBlue,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: const Text(
                                'Dashboard',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            // Panels
                            _buildPanelsWorkspace(isDesktop),
                          ] else if (_activeNavId == 'Student') ...[
                            // Profile View Page
                            ProfileViewPanel(
                              userName: _loggedInUser,
                              regNo: _regNo,
                              onNavigate: (navId, sidebarItem) {
                                setState(() {
                                  _activeNavId = navId;
                                  _activeSidebarItem = sidebarItem;
                                });
                              },
                            ),
                          ] else if (_activeNavId == 'Result') ...[
                            if (_activeSidebarItem == 'Examinations')
                              ExaminationGradesView(
                                userName: _loggedInUser,
                                regNo: _regNo,
                              )
                            else
                              Container(
                                padding: const EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: AppColors.borderGray),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    'Work in Progress: $_activeSidebarItem under Result Portal',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ),
                              ),
                          ] else ...[
                            Container(
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColors.borderGray),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  'Work in Progress: $_activeNavId Portal',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildDashboardHeader(bool isDesktop) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navbarBg,
        border: Border(bottom: BorderSide(color: Color(0xFFB2D1ED), width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Hamburger + brand logo
            Expanded(
              child: Row(
                children: [
                  if (!isDesktop)
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: AppColors.primaryBlue,
                        ),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                  Image.asset(
                    'images/ktu-logo.png',
                    height: 38,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 35,
                      height: 35,
                      color: AppColors.primaryBlue,
                      child: const Icon(
                        Icons.school,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'APJ Abdul Kalam Technological University',
                          style: TextStyle(
                            color: AppColors.navbarText,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Your contact number for support from University is: 9188922753',
                          style: TextStyle(
                            color: Colors.red[800],
                            fontSize: 9.5,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Header buttons (Right Side)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Welcome user name badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 10 : 8,
                    vertical: isDesktop ? 8 : 6,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.navbarActive,
                  ),
                  child: Text(
                    'Welcome ${isDesktop ? _loggedInUser.toUpperCase() : _loggedInUser.split(' ')[0].toUpperCase()}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isDesktop ? 11.5 : 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Change password button (Desktop view only, or smaller for mobile)
                if (isDesktop) ...[
                  const SizedBox(width: 5),
                  TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Change Password opened')),
                      );
                    },
                    icon: const Icon(
                      Icons.refresh,
                      size: 14,
                      color: Colors.black54,
                    ),
                    label: const Text(
                      'Change Password',
                      style: TextStyle(color: Colors.black87, fontSize: 11),
                    ),
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ],

                // Logout button (icon-only on mobile)
                const SizedBox(width: 5),
                isDesktop
                    ? TextButton.icon(
                        onPressed: _handleLogout,
                        icon: const Icon(
                          Icons.power_settings_new,
                          size: 14,
                          color: Colors.black54,
                        ),
                        label: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.black87, fontSize: 11),
                        ),
                        style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      )
                    : IconButton(
                        icon: const Icon(
                          Icons.power_settings_new,
                          size: 16,
                          color: Colors.black54,
                        ),
                        onPressed: _handleLogout,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Drawer for Dashboard Menu on Mobile
  Widget _buildDashboardDrawer() {
    return Drawer(
      child: Container(
        color: const Color(0xFFE8F2FC),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primaryBlue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _loggedInUser.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _regNo,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            Expanded(child: _buildSidebarMenu()),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarMenu() {
    if (_activeNavId == 'Home') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Sidebar Category Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: const Color(0xFF337AB7),
            child: const Text(
              'Administration',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          // Menu links
          _buildSidebarItem('Dashboard', Icons.dashboard),
          _buildSidebarItem('Alerts', Icons.notifications_none),
          _buildSidebarItem('Payment Request', Icons.payment),
          _buildSidebarItem('Update Contact Info', Icons.mail_outline),
          _buildSidebarItem('Reports', Icons.assessment),
        ],
      );
    } else if (_activeNavId == 'Student') {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sidebar Category Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: const Color(0xFF1E88E5), // Blue background
              child: const Text(
                'Student Management',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              ),
            ),
            // Menu links
            _buildSidebarItem('My Profile', Icons.person),
            _buildSidebarItem('Student Data Correction Request', Icons.person_outline),
            _buildSidebarItem('Course/Semester Exam Registration', Icons.assignment_outlined),
            _buildSidebarItem('Cancellation Requests', Icons.cancel_outlined),
            _buildSidebarItem('Minor Degree', Icons.school_outlined),
            _buildSidebarItem('Admission Cancellation/Course Completion', Icons.school),
            _buildSidebarItem('Bank Account Details', Icons.account_balance_wallet_outlined),
            _buildSidebarItem('Honours Degree', Icons.workspace_premium_outlined),
            _buildSidebarItem('Special FE Registration', Icons.assignment),
            _buildSidebarItem('My Certificates', Icons.card_membership),
            _buildSidebarItem('My Fees', Icons.payment),
            _buildSidebarItem('Non-KTU / Previously Done Course Registration Request', Icons.playlist_add),
            _buildSidebarItem('Program Duration Extension', Icons.hourglass_empty),
            _buildSidebarItem('PWD Eligibility / Grace Mark Request', Icons.star_border),
            _buildSidebarItem('Malpractice Decisions', Icons.gavel),
            _buildSidebarItem('My Payment Transactions', Icons.receipt_long),
          ],
        ),
      );
    } else if (_activeNavId == 'Result' || _activeNavId == 'Exam') {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sidebar Category Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: const Color(0xFF00A2E8), // Light blue/cyan background
              child: const Text(
                'Exam Management',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              ),
            ),
            _buildSidebarItem('Examinations', Icons.assignment),
            _buildSidebarItem('Eligibility', Icons.check_circle_outline),
            _buildSidebarItem('Project Work', Icons.work_outline),
            _buildSidebarItem('First Chance Certificate Request', Icons.description_outlined),
            _buildSidebarItem('Reports', Icons.bar_chart),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(15),
        child: Text('Sidebar Menu for $_activeNavId'),
      );
    }
  }

  Widget _buildSidebarItem(String label, IconData icon) {
    final bool isActive = _activeSidebarItem == label;
    return InkWell(
      onTap: () {
        setState(() {
          _activeSidebarItem = label;
          if (label == 'Dashboard') {
            _activeNavId = 'Home';
          } else if (label == 'My Profile') {
            _activeNavId = 'Student';
          }
        });
        // For mobile, close drawer after click
        if (Scaffold.of(context).isDrawerOpen) {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        color: isActive ? const Color(0xFF337AB7) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : AppColors.navbarText,
              size: 16,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : AppColors.navbarText,
                  fontSize: 12.5,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dashboard Tabs bar
  Widget _buildHorizontalTabs(bool isDesktop) {
    final tabs = [
      'Home',
      'Student',
      'Exam',
      'Result',
      'Grievance Redressal Tickets',
      'Forms',
      'Suraksha',
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((tab) {
          final isSelected = tab == _activeNavId;
          return Container(
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : const Color(0xFFF7F9FA),
              border: Border(
                top: BorderSide(
                  color: isSelected
                      ? const Color(0xFFD9534F)
                      : Colors.transparent, // Red top border
                  width: 2,
                ),
                left: const BorderSide(color: AppColors.borderGray),
                right: const BorderSide(color: AppColors.borderGray),
                bottom: BorderSide(
                  color: isSelected ? Colors.transparent : AppColors.borderGray,
                ),
              ),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  _activeNavId = tab;
                  if (tab == 'Home') {
                    _activeSidebarItem = 'Dashboard';
                  } else if (tab == 'Student') {
                    _activeSidebarItem = 'My Profile';
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    color: isSelected ? Colors.black87 : AppColors.primaryBlue,
                    fontSize: 12,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Panels workspace
  Widget _buildPanelsWorkspace(bool isDesktop) {
    if (isDesktop) {
      // Split layout for desktop
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    WelcomePanel(
                      userName: _loggedInUser,
                      regNo: _regNo,
                      onProfileTap: () {
                        setState(() {
                          _activeNavId = 'Student';
                          _activeSidebarItem = 'My Profile';
                        });
                      },
                    ),
                    const FeeDetailsPanel(),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              const Expanded(
                child: Column(
                  children: [
                    SurakshaPanel(
                      academicYear: '2023 - 2024',
                      status: 'Enrolled',
                    ),
                    AlertsPanel(),
                    FeedbackPanel(),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      // Stacked layout for mobile
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WelcomePanel(
            userName: _loggedInUser,
            regNo: _regNo,
            onProfileTap: () {
              setState(() {
                _activeNavId = 'Student';
                _activeSidebarItem = 'My Profile';
              });
            },
          ),
          const FeeDetailsPanel(),
          const SurakshaPanel(academicYear: '2023 - 2024', status: 'Enrolled'),
          const AlertsPanel(),
          const FeedbackPanel(),
        ],
      );
    }
  }

  // Footer Widget
  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: AppColors.footerBg,
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      child: const Text(
        'Copyright © APJ Abdul Kalam Technological University 2014.',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
