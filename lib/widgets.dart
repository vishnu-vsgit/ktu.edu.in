import 'package:flutter/material.dart';
import 'theme.dart';

// --- Role Selection Card (from the Landing Page) ---
class RoleCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color themeColor;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.themeColor,
    required this.onTap,
  });

  @override
  State<RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<RoleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0xFFFAFDFC) : Colors.white,
            border: const Border(
              bottom: BorderSide(color: AppColors.borderGray, width: 1),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Circle
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 54,
                height: 54,
                transform: _isHovered
                    ? Matrix4.diagonal3Values(1.05, 1.05, 1.0)
                    : Matrix4.identity(),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: widget.themeColor, width: 2),
                ),
                child: Icon(
                  widget.icon,
                  color: widget.themeColor,
                  size: 26,
                ),
              ),
              const SizedBox(width: 15),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: widget.themeColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF555555),
                        height: 1.6,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Base Panel Widget for Dashboard Cards ---
class PortalPanel extends StatelessWidget {
  final String title;
  final Color headerBgColor;
  final Color titleColor;
  final Widget child;

  const PortalPanel({
    super.key,
    required this.title,
    required this.headerBgColor,
    required this.titleColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderGray),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Panel Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: headerBgColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(3),
                topRight: Radius.circular(3),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Panel Body
          Padding(
            padding: const EdgeInsets.all(15),
            child: child,
          ),
        ],
      ),
    );
  }
}

// --- Link Text Helper ---
class ClickableText extends StatelessWidget {
  final String linkText;
  final String trailingText;
  final VoidCallback onTap;

  const ClickableText({
    super.key,
    required this.linkText,
    required this.trailingText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 13, color: AppColors.textDark),
          children: [
            TextSpan(
              text: linkText,
              style: const TextStyle(
                color: Color(0xFF337AB7),
                decoration: TextDecoration.underline,
              ),
            ),
            TextSpan(text: trailingText),
          ],
        ),
      ),
    );
  }
}

// --- Welcome Panel ---
class WelcomePanel extends StatelessWidget {
  final String userName;
  final String regNo;
  final VoidCallback onProfileTap;

  const WelcomePanel({
    super.key,
    required this.userName,
    required this.regNo,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return PortalPanel(
      title: 'Welcome',
      headerBgColor: const Color(0xFFE2F0D9), // Soft green
      titleColor: const Color(0xFF385723),    // Dark green
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              color: Color(0xFF8FBCDB), // Soft blue background for avatar
              shape: BoxShape.rectangle,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 50,
            ),
          ),
          const SizedBox(width: 15),
          // Profile Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hi ${userName == "CET Admin" || userName == "KTU Controller" ? userName : "Nandana R"}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5BC0DE), // Cyan badge
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    '${userName.toUpperCase()} ($regNo)',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ClickableText(
                  linkText: 'Click here',
                  trailingText: ' to view your profile',
                  onTap: onProfileTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Fee Details Panel ---
class FeeDetailsPanel extends StatelessWidget {
  const FeeDetailsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalPanel(
      title: 'Fee Details',
      headerBgColor: const Color(0xFFE2F0D9), // Soft green
      titleColor: const Color(0xFF385723),    // Dark green
      child: ClickableText(
        linkText: 'Click here',
        trailingText: ' to view your fee details',
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Loading Fee Details...')),
          );
        },
      ),
    );
  }
}

// --- Suraksha Panel ---
class SurakshaPanel extends StatelessWidget {
  final String academicYear;
  final String status;

  const SurakshaPanel({
    super.key,
    required this.academicYear,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return PortalPanel(
      title: 'Suraksha',
      headerBgColor: const Color(0xFFD9E1F2), // Soft blue
      titleColor: const Color(0xFF1F4E79),    // Dark blue
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Suraksha Logo Placeholder (Heart inside Hands)
          Container(
            padding: const EdgeInsets.all(5),
            child: const Icon(
              Icons.volunteer_activism, // Heart in hands icon
              color: Colors.black,
              size: 32,
            ),
          ),
          const SizedBox(width: 15),
          // Info list
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClickableText(
                  linkText: 'Click here',
                  trailingText: ' to view Suraksha Profile',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Loading Suraksha Profile...')),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  'Academic Year: $academicYear',
                  style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
                Text(
                  'Status: $status',
                  style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Alerts Panel ---
class AlertsPanel extends StatelessWidget {
  const AlertsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalPanel(
      title: 'Alerts',
      headerBgColor: AppColors.panelHeaderBlue,
      titleColor: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.mail_outline,
            color: Colors.black54,
            size: 32,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF2CC), // Soft yellow warning background
                border: Border.all(color: const Color(0xFFFFE699)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'You have no alerts',
                style: TextStyle(
                  color: Color(0xFF7F6000),
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Feedback Panel ---
class FeedbackPanel extends StatelessWidget {
  const FeedbackPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalPanel(
      title: 'Feedback Form',
      headerBgColor: const Color(0xFFD9E1F2), // Soft blue
      titleColor: const Color(0xFF1F4E79),    // Dark blue
      child: ClickableText(
        linkText: 'Click here',
        trailingText: ' to view the Anti-Ragging Feedback Form.',
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Loading Feedback Form...')),
          );
        },
      ),
    );
  }
}

// --- Profile View Panel ---
class ProfileViewPanel extends StatefulWidget {
  final String userName;
  final String regNo;
  final Function(String navId, String sidebarItem) onNavigate;

  const ProfileViewPanel({
    super.key,
    required this.userName,
    required this.regNo,
    required this.onNavigate,
  });

  @override
  State<ProfileViewPanel> createState() => _ProfileViewPanelState();
}

class _ProfileViewPanelState extends State<ProfileViewPanel> {
  bool _showFullProfile = false;
  
  // Collapsible panels state variables
  bool _admissionExpanded = true;
  bool _contactExpanded = false;
  bool _bankExpanded = true;
  bool _qualificationExpanded = false;
  bool _additionalExpanded = false;
  bool _guardianExpanded = false;

  // Active sub-tab (0: Personal, 1: Curriculum, 2: Semesters, 3: Exam/Result, 4: Certificates)
  int _activeSubTab = 0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 800;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderGray),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: AppColors.panelHeaderBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _showFullProfile
                        ? '${widget.userName.toUpperCase()}(${widget.regNo}) (AHALIA SCHOOL OF ENGINEERING AND TECHNOLOGY)'
                        : 'Profile View (AHALIA SCHOOL OF ENGINEERING AND TECHNOLOGY)',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _showFullProfile = !_showFullProfile;
                    });
                  },
                  icon: Icon(
                    _showFullProfile ? Icons.arrow_back : Icons.visibility,
                    color: Colors.white,
                    size: 14,
                  ),
                  label: Text(
                    _showFullProfile ? 'Back to Basic' : 'View Full Profile',
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black26,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Body content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Avatar and Signature Photo Row
                isDesktop
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildAvatarBox(widget.userName, widget.regNo),
                          _buildSignatureBox(),
                        ],
                      )
                    : Column(
                        children: [
                          _buildAvatarBox(widget.userName, widget.regNo),
                          const SizedBox(height: 20),
                          _buildSignatureBox(),
                        ],
                      ),
                const SizedBox(height: 20),

                // If in Full Profile mode, show the horizontal sub-tabs
                if (_showFullProfile) ...[
                  _buildSubTabs(),
                  const SizedBox(height: 20),
                ],

                if (!_showFullProfile || _activeSubTab == 0) ...[
                  // Basic Details Section Divider (Always shown)
                  Row(
                    children: [
                      const Icon(Icons.keyboard_arrow_down, color: Colors.black87, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        'Basic details',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 2,
                    color: AppColors.titleBlue,
                  ),
                  const SizedBox(height: 15),

                  // Basic Details Grid tables
                  isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildLeftDetails(context)),
                            const SizedBox(width: 20),
                            Expanded(child: _buildRightDetails(context)),
                          ],
                        )
                      : Column(
                          children: [
                            _buildLeftDetails(context),
                            const SizedBox(height: 10),
                            _buildRightDetails(context),
                          ],
                        ),
                  const SizedBox(height: 20),

                  // Collapsible sections (Only visible in Full Profile View mode)
                  if (_showFullProfile) ...[
                    // 1. Admission Details
                    _buildCollapsiblePanel(
                      icon: Icons.folder_open,
                      title: 'Admission Details',
                      isExpanded: _admissionExpanded,
                      onToggle: () => setState(() => _admissionExpanded = !_admissionExpanded),
                      child: isDesktop
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _buildLeftAdmissionDetails(context)),
                                const SizedBox(width: 20),
                                Expanded(child: _buildRightAdmissionDetails(context)),
                              ],
                            )
                          : Column(
                              children: [
                                _buildLeftAdmissionDetails(context),
                                const SizedBox(height: 10),
                                _buildRightAdmissionDetails(context),
                              ],
                            ),
                    ),

                    // 2. Contact Details
                    _buildCollapsiblePanel(
                      icon: Icons.contact_mail_outlined,
                      title: 'Contact Details',
                      isExpanded: _contactExpanded,
                      onToggle: () => setState(() => _contactExpanded = !_contactExpanded),
                      child: Column(
                        children: [
                          _buildDetailRow(context, 'Mobile Number', '9188922753', isFirst: true),
                          _buildDetailRow(context, 'Email ID', 'nandana.r2005@gmail.com'),
                          _buildDetailRow(context, 'Communication Address', 'Nandana House, Olavakkot, Palakkad, Kerala'),
                          _buildDetailRow(context, 'Permanent Address', 'Nandana House, Olavakkot, Palakkad, Kerala'),
                        ],
                      ),
                    ),

                    // 3. Bank Account Details
                    _buildCollapsiblePanel(
                      icon: Icons.account_balance_outlined,
                      title: 'Bank Account Details',
                      isExpanded: _bankExpanded,
                      onToggle: () => setState(() => _bankExpanded = !_bankExpanded),
                      child: Column(
                        children: [
                          _buildDetailRow(context, 'Bank Name', 'STATE BANK OF INDIA', isFirst: true),
                          _buildDetailRow(context, 'Branch Name', 'OLAVAKKOT'),
                          _buildDetailRow(context, 'Account Number', '42580492791'),
                          _buildDetailRow(context, 'Account Holder', 'NANDANA R'),
                          _buildDetailRow(context, 'IFSC Code', 'SBIN0002245'),
                        ],
                      ),
                    ),

                    // 4. Qualification Details
                    _buildCollapsiblePanel(
                      icon: Icons.school_outlined,
                      title: 'Qualification Details',
                      isExpanded: _qualificationExpanded,
                      onToggle: () => setState(() => _qualificationExpanded = !_qualificationExpanded),
                      child: Column(
                        children: [
                          _buildDetailRow(context, '10th Standard / SSLC', 'Passed - 2021', isFirst: true),
                          _buildDetailRow(context, 'Plus Two / HSE', 'Passed - 2023'),
                        ],
                      ),
                    ),

                    // 5. Additional Document
                    _buildCollapsiblePanel(
                      icon: Icons.description_outlined,
                      title: 'Additional Document',
                      isExpanded: _additionalExpanded,
                      onToggle: () => setState(() => _additionalExpanded = !_additionalExpanded),
                      child: Column(
                        children: [
                          _buildDetailRow(context, 'No additional documents uploaded', '-', isFirst: true),
                        ],
                      ),
                    ),

                    // 6. Guardian Details
                    _buildCollapsiblePanel(
                      icon: Icons.family_restroom_outlined,
                      title: 'Guardian Details',
                      isExpanded: _guardianExpanded,
                      onToggle: () => setState(() => _guardianExpanded = !_guardianExpanded),
                      child: Column(
                        children: [
                          _buildDetailRow(context, 'Guardian Name', 'Sujatha R', isFirst: true),
                          _buildDetailRow(context, 'Relationship', 'Mother'),
                          _buildDetailRow(context, 'Contact Number', 'XXXXXX9181'),
                        ],
                      ),
                    ),
                  ],
                ] else if (_activeSubTab == 3) ...[
                  _buildExamResultView(context),
                ] else ...[
                  _buildTabPlaceholder(context, _activeSubTab),
                ],

                // Bottom actions button
                if (!_showFullProfile)
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _showFullProfile = true;
                        });
                      },
                      icon: const Icon(Icons.visibility, size: 14),
                      label: const Text('View Full Profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.btnGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Horizontal tabs bar inside the full profile view
  Widget _buildSubTabs() {
    final tabs = [
      {'label': 'Personal', 'icon': Icons.person},
      {'label': 'Curriculum', 'icon': Icons.school_outlined},
      {'label': 'Semesters', 'icon': Icons.grid_view_outlined},
      {'label': 'Exam / Result', 'icon': Icons.assignment_outlined},
      {'label': 'Certificates', 'icon': Icons.badge_outlined},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = _activeSubTab == index;
          return InkWell(
            onTap: () {
              setState(() {
                _activeSubTab = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF337AB7) : Colors.white,
                border: Border.all(color: AppColors.borderGray),
                borderRadius: BorderRadius.circular(2),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    tabs[index]['icon'] as IconData,
                    color: isSelected ? Colors.white : Colors.grey[700],
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    tabs[index]['label'] as String,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[800],
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // Collapsible category header and wrapper panel
  Widget _buildCollapsiblePanel({
    required IconData icon,
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGray),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Tab Clickable Bar
          InkWell(
            onTap: onToggle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              color: const Color(0xFF63B2F5), // Light blue header
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 14),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          // Expanded list body
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(12),
              child: child,
            ),
        ],
      ),
    );
  }

  // User Avatar Box with Suraksha Cover Badge
  Widget _buildAvatarBox(String name, String reg) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[300]!, width: 2),
            color: const Color(0xFFE8F2FC),
          ),
          child: ClipOval(
            child: Image.asset(
              'images/user_photo.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.person,
                size: 70,
                color: Colors.black38,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            '${name.toUpperCase()}($reg)',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
        // Suraksha Covered green badge (visible in full profile view)
        if (_showFullProfile) ...[
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF5CB85C), // Green
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check, color: Colors.white, size: 10),
                const SizedBox(width: 4),
                const Text(
                  'Suraksha Covered',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 9.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  // Signature Box
  Widget _buildSignatureBox() {
    return Column(
      children: [
        Container(
          width: 200,
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            color: Colors.white,
          ),
          child: Image.asset(
            'images/user_signature.jpeg',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Text(
                'Nandana R',
                style: TextStyle(
                  fontFamily: 'Caveat',
                  fontStyle: FontStyle.italic,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F4E79), // Ink blue
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(3),
          ),
          child: const Text(
            'Signature',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }

  // Left side details table
  Widget _buildLeftDetails(BuildContext context) {
    return Column(
      children: [
        _buildDetailRow(context, 'Gender', 'Female', isFirst: true),
        _buildDetailRow(context, 'Date of Birth', '30/03/2005'),
        _buildDetailRow(context, 'Aadhar Number', 'XXXX XXXX 9181'),
        _buildDetailRow(context, 'Mother Tongue', 'Malayalam'),
        _buildDetailRow(context, 'Category', 'Ezhava'),
      ],
    );
  }

  // Right side details table
  Widget _buildRightDetails(BuildContext context) {
    return Column(
      children: [
        _buildDetailRow(context, 'Religion', 'Hindu', isFirst: true),
        _buildDetailRow(context, 'Cast', 'OBC'),
        _buildDetailRow(context, 'Nationality', 'Indian'),
        _buildDetailRow(context, 'Additional Information', '-'),
        _buildDetailRow(context, 'Blood Group', 'O+ve'),
        if (_showFullProfile) ...[
          _buildDetailRow(context, 'Category Certificate', _buildPdfButton('noicertificate.pdf')),
          _buildDetailRow(context, 'Name/Age Proof ( Birth Certificate/SSLC Book )', _buildPdfButton('10th.pdf')),
        ],
      ],
    );
  }

  // Collapsible Left Admission Details Grid
  Widget _buildLeftAdmissionDetails(BuildContext context) {
    return Column(
      children: [
        _buildDetailRow(context, 'Date of Admission', '11/09/2023', isFirst: true),
        _buildDetailRow(context, 'Admission Quota', 'Merit'),
        _buildDetailRow(context, 'College Admission Number', '23RECS035'),
        _buildDetailRow(context, 'Admitted Program', 'B.Tech'),
        _buildDetailRow(context, 'Staff Advisor (KTU F41010)', 'AMRITHA DEVADASAN'),
        _buildDetailRow(context, 'Admitted Branch', 'COMPUTER SCIENCE & ENGINEERING'),
      ],
    );
  }

  // Collapsible Right Admission Details Grid
  Widget _buildRightAdmissionDetails(BuildContext context) {
    return Column(
      children: [
        _buildDetailRow(context, 'Division', '2', isFirst: true),
        _buildDetailRow(context, 'Admitted Category', 'General'),
        _buildDetailRow(context, 'Eligible For Fee Concession', 'No'),
        _buildDetailRow(context, 'Admitted Scheme', 'B.Tech Full Time 2019 Scheme'),
        _buildDetailRow(context, 'Admission Type', 'Regular'),
        _buildDetailRow(context, 'Program to be completed by', '15/08/2029'),
        _buildDetailRow(context, 'Institution Name', 'AHALIA SCHOOL OF ENGINEERING AND TECHNOLOGY'),
      ],
    );
  }

  // PDF Action Button Widget
  Widget _buildPdfButton(String filename) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Viewing $filename...')),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF337AB7),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.picture_as_pdf, color: Colors.white, size: 11),
            const SizedBox(width: 4),
            Text(
              filename,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.visibility, color: Colors.white, size: 11),
          ],
        ),
      ),
    );
  }

  // Grid Cell Row Generator
  Widget _buildDetailRow(BuildContext context, String label, dynamic value, {bool isFirst = false}) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 800;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: const BorderSide(color: AppColors.borderGray),
          left: const BorderSide(color: AppColors.borderGray),
          right: const BorderSide(color: AppColors.borderGray),
          top: isFirst ? const BorderSide(color: AppColors.borderGray) : BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          // Label cell
          Container(
            width: isDesktop ? 150 : 120,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFFF7F9FA),
              border: Border(
                right: BorderSide(color: AppColors.borderGray, width: 1),
              ),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF5BC0DE), // Light blue label
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Value cell (plain text or custom Widget support)
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              color: Colors.white,
              child: value is Widget
                  ? Align(alignment: Alignment.centerLeft, child: value)
                  : Text(
                      value.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.5,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Exam / Result View helper methods ---

  Widget _buildExamResultView(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Exam Result header row
        isDesktop
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.keyboard_arrow_down, color: Colors.black87, size: 18),
                      const SizedBox(width: 5),
                      RichText(
                        text: const TextSpan(
                          text: 'Exam / Result ',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: '( Total registered exams - 7 )',
                              style: TextStyle(
                                color: Color(0xFFD9534F),
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Exam Center - AHALIA SCHOOL OF ENGINEERING AND TECHNOLOGY',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.keyboard_arrow_down, color: Colors.black87, size: 18),
                      const SizedBox(width: 5),
                      RichText(
                        text: const TextSpan(
                          text: 'Exam / Result ',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: '( Total registered exams - 7 )',
                              style: TextStyle(
                                color: Color(0xFFD9534F),
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Padding(
                    padding: EdgeInsets.only(left: 23),
                    child: Text(
                      'Exam Center - AHALIA SCHOOL OF ENGINEERING AND TECHNOLOGY',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
        const SizedBox(height: 8),
        Container(
          height: 1,
          color: AppColors.borderGray,
        ),
        const SizedBox(height: 15),

        // Exam cards list
        ...mockExamRecords.map((record) => _buildExamCard(context, record)),
      ],
    );
  }

  Widget _buildExamCard(BuildContext context, ExamRecord record) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 800;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFC),
        border: Border.all(color: const Color(0xFFE5E9EC)),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top row: badge + scheme year
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF337AB7),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        record.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      record.type,
                      style: const TextStyle(
                        color: Color(0xFFD9534F),
                        fontWeight: FontWeight.bold,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF337AB7),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        record.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      record.type,
                      style: const TextStyle(
                        color: Color(0xFFD9534F),
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 12),

          // Action buttons
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  if (record.title.contains('S6 (R, S)')) {
                    widget.onNavigate('Result', 'Examinations');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF337AB7),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Examination Grades',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (record.hasRevaluation) ...[
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF0AD4E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Revaluation Status',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  void _showGradesDialog(BuildContext context, ExamRecord record) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          titlePadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.all(15),
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            color: const Color(0xFF337AB7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    record.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.close, color: Colors.white, size: 18),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          content: SizedBox(
            width: 600,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  color: const Color(0xFFF7F9FA),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Student: ${widget.userName.toUpperCase()} (${widget.regNo})',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 11.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Exam Center: AHALIA SCHOOL OF ENGINEERING AND TECHNOLOGY',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 570,
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1.2),
                        1: FlexColumnWidth(3.8),
                        2: FlexColumnWidth(1.0),
                        3: FlexColumnWidth(1.0),
                      },
                      border: TableBorder.all(color: Colors.grey[300]!),
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(color: Color(0xFFECF0F1)),
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'Course Code',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'Course Name',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'Grade',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'Status',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ...record.grades.map(
                          (item) => TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    item.code,
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    item.grade,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    item.status,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: item.status == 'Pass' ? Colors.green : Colors.red,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabPlaceholder(BuildContext context, int index) {
    final titles = ['Personal', 'Curriculum', 'Semesters', 'Exam / Result', 'Certificates'];
    final title = index < titles.length ? titles[index] : 'Details';
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderGray),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.info_outline, size: 36, color: Colors.grey[400]),
            const SizedBox(height: 10),
            Text(
              'No information available under $title section.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// --- Examination Grades View Page ---

class ExaminationGradesView extends StatefulWidget {
  final String userName;
  final String regNo;

  const ExaminationGradesView({
    super.key,
    required this.userName,
    required this.regNo,
  });

  @override
  State<ExaminationGradesView> createState() => _ExaminationGradesViewState();
}

class _ExaminationGradesViewState extends State<ExaminationGradesView> {
  String _selectedSemester = 'S6';

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 800;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderGray),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Green Alert Header Banner
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFDFF0D8), // Light green success bg
              border: Border.all(color: const Color(0xFFD6E9C6)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Text(
                'Examination Grades',
                style: TextStyle(
                  color: Color(0xFF3C763D), // Dark green success text
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 2. Semester Select Blue Panel
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F2FC), // Light blue tint
              border: Border.all(color: const Color(0xFFB2D1ED)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: isDesktop
                ? Row(
                    children: [
                      const Text(
                        'Semester',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F4E79),
                          fontSize: 12.5,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(child: _buildSemesterDropdown()),
                      const SizedBox(width: 20),
                      _buildSearchButton(),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Semester',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F4E79),
                          fontSize: 12.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildSemesterDropdown(),
                      const SizedBox(height: 12),
                      _buildSearchButton(),
                    ],
                  ),
          ),
          const SizedBox(height: 25),

          // 3. Side-by-Side Details Cards
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildLeftDetailsCard()),
                    const SizedBox(width: 20),
                    Expanded(child: _buildRightDetailsCard()),
                  ],
                )
              : Column(
                  children: [
                    _buildLeftDetailsCard(),
                    const SizedBox(height: 15),
                    _buildRightDetailsCard(),
                  ],
                ),
          const SizedBox(height: 20),

          // 4. Blue Note Banner
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFD9EDF7), // Light blue alert bg
              border: Border.all(color: const Color(0xFFBCE8F1)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Note : 1) Click on the button \'View Mark\' to view the mark. Only failed courses can view marks.',
                  style: TextStyle(
                    color: Color(0xFF31708F), // Dark blue alert text
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '2) Only result published courses are listed here and pending courses can be viewed in the pending results menu. Click here',
                  style: TextStyle(
                    color: Color(0xFF31708F),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 5. Grades Table
          _buildGradesTable(context),
        ],
      ),
    );
  }

  Widget _buildSemesterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFCCCCCC)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedSemester,
          isExpanded: true,
          style: const TextStyle(color: Colors.black, fontSize: 12.5),
          items: ['S1', 'S2', 'S3', 'S4', 'S5', 'S6'].map((sem) {
            return DropdownMenuItem<String>(
              value: sem,
              child: Text(sem),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              setState(() {
                _selectedSemester = val;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.search, size: 14, color: Colors.white),
      label: const Text(
        'Search',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF337AB7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildLeftDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGray),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          _buildInfoRow(widget.userName.toUpperCase(), 'Name', isFirst: true),
          _buildInfoRow('AHALIA SCHOOL OF ENGINEERING AND TECHNOLOGY', 'Name Of College'),
          _buildInfoRow(_selectedSemester, 'Semester'),
          _buildInfoRow('B. Tech S6 (R, S) Exam April 2026 (2019 Scheme)', 'Exam Name'),
        ],
      ),
    );
  }

  Widget _buildRightDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGray),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          _buildInfoRow(widget.regNo, 'Register Number', isFirst: true),
          _buildInfoRow('COMPUTER SCIENCE & ENGINEERING', 'Branch'),
          _buildInfoRow('April 2026', 'Month & Year Of Examination'),
          _buildInfoRow('End Semester', 'Exam Type'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String text, String badgeLabel, {bool isFirst = false}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: const BorderSide(color: AppColors.borderGray),
          top: isFirst ? const BorderSide(color: AppColors.borderGray) : BorderSide.none,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              border: Border.all(color: const Color(0xFFDDDDDD)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              badgeLabel,
              style: const TextStyle(
                color: Color(0xFF777777),
                fontSize: 9.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradesTable(BuildContext context) {
    // 8 mock S6 subjects with updated grades and credits as requested
    final courses = [
      {'name': 'INDUSTRIAL ECONOMICS AND FOREIGN TRADE', 'code': 'HUT300', 'grade': 'P', 'credits': '3.0'},
      {'name': 'COMPILER DESIGN', 'code': 'CST302', 'grade': 'P', 'credits': '4.0'},
      {'name': 'COMPUTER GRAPHICS AND IMAGE PROCESSING', 'code': 'CST304', 'grade': 'P', 'credits': '4.0'},
      {'name': 'ALGORITHM ANALYSIS AND DESIGN', 'code': 'CST306', 'grade': 'C', 'credits': '4.0'},
      {'name': 'COMPREHENSIVE COURSE WORK', 'code': 'CST308', 'grade': 'A', 'credits': '1.0'},
      {'name': 'NETWORKING LAB', 'code': 'CSL332', 'grade': 'S', 'credits': '2.0'},
      {'name': 'MINIPROJECT', 'code': 'CSD334', 'grade': 'S', 'credits': '2.0'},
      {'name': 'PROGRAMMING IN PYTHON', 'code': 'CST362', 'grade': 'P', 'credits': '3.0'},
    ];

    return Table(
      columnWidths: const {
        0: FlexColumnWidth(4.5),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(1.5),
        3: FlexColumnWidth(1.2),
      },
      border: TableBorder.all(color: Colors.grey[200]!),
      children: [
        // Table Header
        const TableRow(
          decoration: BoxDecoration(color: Color(0xFFF9FAFC)),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  'Course Name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.5, color: Colors.black87),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  'Code',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.5, color: Colors.black87),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  'Grade',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.5, color: Colors.black87),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  'Credits',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.5, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
        // Table Body
        ...courses.map((course) {
          final String grade = course['grade']!;
          return TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    course['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.5,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    course['code']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.5,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    grade,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.5,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    course['credits']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.5,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}

// --- Helper Data Classes & Mock Records for Exam/Result subtab ---

class ExamRecord {
  final String title;
  final String type;
  final bool hasRevaluation;
  final List<GradeItem> grades;

  const ExamRecord({
    required this.title,
    required this.type,
    this.hasRevaluation = false,
    required this.grades,
  });
}

class GradeItem {
  final String code;
  final String name;
  final String grade;
  final String status;

  const GradeItem({
    required this.code,
    required this.name,
    required this.grade,
    required this.status,
  });
}

const List<ExamRecord> mockExamRecords = [
  ExamRecord(
    title: 'B.Tech S6 (R, S) Exam April 2026 (2019 Scheme)',
    type: 'End Semester 2025-2026',
    hasRevaluation: true,
    grades: [
      GradeItem(code: 'CST302', name: 'Compiler Design', grade: 'A+', status: 'Pass'),
      GradeItem(code: 'CST304', name: 'Computer Graphics and Image Processing', grade: 'A', status: 'Pass'),
      GradeItem(code: 'CST306', name: 'Algorithm Analysis and Design', grade: 'A+', status: 'Pass'),
      GradeItem(code: 'CST308', name: 'Comprehensive Course Work', grade: 'A', status: 'Pass'),
      GradeItem(code: 'CST312', name: 'Elective 1: Soft Computing', grade: 'A+', status: 'Pass'),
      GradeItem(code: 'CSL332', name: 'Networking and Compiler Lab', grade: 'O', status: 'Pass'),
      GradeItem(code: 'CSL334', name: 'Miniproject', grade: 'O', status: 'Pass'),
    ],
  ),
  ExamRecord(
    title: 'B.Tech S4 (S, FE) Exam Jan 2026 (2019 Scheme)',
    type: 'Supplementary 2025-2026',
    hasRevaluation: false,
    grades: [
      GradeItem(code: 'MAT206', name: 'Graph Theory', grade: 'B+', status: 'Pass'),
      GradeItem(code: 'CST206', name: 'Operating Systems', grade: 'B+', status: 'Pass'),
    ],
  ),
  ExamRecord(
    title: 'B.Tech S5 (R, S) Exam Nov 2025 (2019 Scheme)',
    type: 'End Semester 2025-2026',
    hasRevaluation: false,
    grades: [
      GradeItem(code: 'CST301', name: 'Formal Languages and Automata Theory', grade: 'A', status: 'Pass'),
      GradeItem(code: 'CST303', name: 'Computer Networks', grade: 'A+', status: 'Pass'),
      GradeItem(code: 'CST305', name: 'Laptop & System Administration', grade: 'A', status: 'Pass'),
      GradeItem(code: 'CST307', name: 'Microprocessors and Microcontrollers', grade: 'B+', status: 'Pass'),
      GradeItem(code: 'CST309', name: 'Management of Software Systems', grade: 'A', status: 'Pass'),
      GradeItem(code: 'MCN301', name: 'Disaster Management', grade: 'Pass', status: 'Pass'),
      GradeItem(code: 'CSL331', name: 'System Software and Microprocessors Lab', grade: 'O', status: 'Pass'),
      GradeItem(code: 'CSL333', name: 'Database Lab', grade: 'O', status: 'Pass'),
    ],
  ),
  ExamRecord(
    title: 'B.Tech S4 (R, S) Exam April 2025 (2019 Scheme)',
    type: 'End Semester 2024-2025',
    hasRevaluation: false,
    grades: [
      GradeItem(code: 'MAT206', name: 'Graph Theory', grade: 'B+', status: 'Pass'),
      GradeItem(code: 'CST202', name: 'Computer Organization and Architecture', grade: 'A', status: 'Pass'),
      GradeItem(code: 'CST204', name: 'Database Management Systems', grade: 'A', status: 'Pass'),
      GradeItem(code: 'CST206', name: 'Operating Systems', grade: 'B+', status: 'Pass'),
      GradeItem(code: 'EST200', name: 'Design & Engineering', grade: 'A+', status: 'Pass'),
      GradeItem(code: 'CSL202', name: 'Digital Lab', grade: 'A+', status: 'Pass'),
      GradeItem(code: 'CSL204', name: 'Operating Systems Lab', grade: 'O', status: 'Pass'),
    ],
  ),
  ExamRecord(
    title: 'B.Tech S3 (R, S) Exam Nov 2024 (2019 Scheme)',
    type: 'End Semester 2024-2025',
    hasRevaluation: false,
    grades: [
      GradeItem(code: 'MAT203', name: 'Discrete Mathematical Structures', grade: 'A', status: 'Pass'),
      GradeItem(code: 'CST201', name: 'Data Structures', grade: 'A+', status: 'Pass'),
      GradeItem(code: 'CST203', name: 'System Software', grade: 'B+', status: 'Pass'),
      GradeItem(code: 'CST205', name: 'Object Oriented Programming using Java', grade: 'A', status: 'Pass'),
      GradeItem(code: 'MCN201', name: 'Sustainable Engineering', grade: 'Pass', status: 'Pass'),
      GradeItem(code: 'CSL201', name: 'Data Structures Lab', grade: 'O', status: 'Pass'),
      GradeItem(code: 'CSL203', name: 'System Software Lab', grade: 'A+', status: 'Pass'),
    ],
  ),
  ExamRecord(
    title: 'B.Tech S2 (R, S) Exam April 2024 (2019 Scheme)',
    type: 'End Semester 2023-2024',
    hasRevaluation: false,
    grades: [
      GradeItem(code: 'MA102', name: 'Vector Calculus, Differential Equations and Transforms', grade: 'B+', status: 'Pass'),
      GradeItem(code: 'CY100', name: 'Engineering Chemistry', grade: 'A', status: 'Pass'),
      GradeItem(code: 'EE100', name: 'Basics of Electrical Engineering', grade: 'B+', status: 'Pass'),
      GradeItem(code: 'EC100', name: 'Basics of Electronics Engineering', grade: 'A', status: 'Pass'),
      GradeItem(code: 'CY110', name: 'Chemistry Lab', grade: 'O', status: 'Pass'),
      GradeItem(code: 'EE110', name: 'Electrical Engineering Workshop', grade: 'A+', status: 'Pass'),
    ],
  ),
  ExamRecord(
    title: 'B.Tech S1 (R, S) Exam Dec 2023 (2019 Scheme)',
    type: 'End Semester 2023-2024',
    hasRevaluation: false,
    grades: [
      GradeItem(code: 'MA101', name: 'Linear Algebra & Calculus', grade: 'A', status: 'Pass'),
      GradeItem(code: 'PH100', name: 'Engineering Physics', grade: 'B+', status: 'Pass'),
      GradeItem(code: 'BE100', name: 'Engineering Mechanics', grade: 'B', status: 'Pass'),
      GradeItem(code: 'BE101-05', name: 'Introduction to Computing and Problem Solving', grade: 'A+', status: 'Pass'),
      GradeItem(code: 'BE103', name: 'Introduction to Sustainable Engineering', grade: 'O', status: 'Pass'),
      GradeItem(code: 'ME110', name: 'Mechanical Engineering Workshop', grade: 'O', status: 'Pass'),
      GradeItem(code: 'CS110', name: 'Computer Science Workshop', grade: 'O', status: 'Pass'),
    ],
  ),
];

