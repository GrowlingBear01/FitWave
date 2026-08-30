import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  late AnimationController _animationController;

  // ---------------- COLORS ----------------

  static const Color backgroundColor = Color(0xFFF0FAFC);

  static const Color primaryBlue = Color(0xFF2CB8D1);

  static const Color darkBlue = Color(0xFF173F5F);

  static const Color textBlue = Color(0xFF315B73);

  static const Color borderBlue = Color(0xFFBFE5EC);

  static const Color coral = Color(0xFFFF8585);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animationController.forward();

    _nameFocus.addListener(() {
      setState(() {});
    });

    _emailFocus.addListener(() {
      setState(() {});
    });

    _passwordFocus.addListener(() {
      setState(() {});
    });

    _confirmPasswordFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();

    super.dispose();
  }

  // ===============================================================
  // REGISTER
  // ===============================================================

  void _register() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // TEMPORARY
    // Firebase registration will be connected here.

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      Navigator.pushNamed(context, '/home');
    });
  }

  // ===============================================================
  // ANIMATION
  // ===============================================================

  Widget animatedItem({required Widget child, required int index}) {
    final animation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        (index * 0.06).clamp(0.0, 0.65),
        ((index * 0.06) + 0.35).clamp(0.35, 1.0),
        curve: Curves.easeOutCubic,
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - animation.value)),
            child: child,
          ),
        );
      },
    );
  }

  // ===============================================================
  // INPUT DECORATION
  // ===============================================================

  InputDecoration inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
    required bool focused,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,

      floatingLabelBehavior: FloatingLabelBehavior.auto,

      labelStyle: TextStyle(
        color: focused ? primaryBlue : textBlue.withOpacity(0.70),
        fontWeight: FontWeight.w600,
      ),

      floatingLabelStyle: const TextStyle(
        color: primaryBlue,
        fontWeight: FontWeight.w700,
      ),

      hintStyle: TextStyle(color: textBlue.withOpacity(0.35), fontSize: 14),

      prefixIcon: Icon(
        icon,
        color: focused ? primaryBlue : textBlue.withOpacity(0.55),
      ),

      suffixIcon: suffixIcon,

      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(color: borderBlue),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(color: primaryBlue, width: 1.5),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(color: coral),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(color: coral, width: 1.5),
      ),
    );
  }

  // ===============================================================
  // BUILD
  // ===============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                // =================================================
                // BACK BUTTON
                // =================================================
                Align(
                  alignment: Alignment.centerLeft,

                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(Icons.arrow_back_rounded, color: darkBlue),
                  ),
                ),

                const SizedBox(height: 2),

                // =================================================
                // WAVE
                // =================================================
                animatedItem(
                  index: 0,

                  child: SizedBox(
                    height: 90,

                    child: Stack(
                      alignment: Alignment.center,

                      children: [
                        CustomPaint(
                          size: const Size(220, 80),
                          painter: RegisterWavePainter(),
                        ),

                        const Icon(
                          Icons.favorite_rounded,
                          color: primaryBlue,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                // =================================================
                // TITLE
                // =================================================
                animatedItem(
                  index: 1,

                  child: const Column(
                    children: [
                      Text(
                        'Create Account',

                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: darkBlue,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      SizedBox(height: 7),

                      Text(
                        'Start your journey with FitWave.',

                        textAlign: TextAlign.center,

                        style: TextStyle(color: textBlue, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // =================================================
                // NAME
                // =================================================
                animatedItem(
                  index: 2,

                  child: TextFormField(
                    controller: _nameController,
                    focusNode: _nameFocus,

                    style: const TextStyle(
                      color: darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),

                    cursorColor: primaryBlue,

                    textInputAction: TextInputAction.next,

                    onFieldSubmitted: (_) {
                      _emailFocus.requestFocus();
                    },

                    decoration: inputDecoration(
                      label: 'Full Name',
                      hint: 'Enter your name',
                      icon: Icons.person_outline_rounded,
                      focused: _nameFocus.hasFocus,
                    ),

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }

                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // =================================================
                // EMAIL
                // =================================================
                animatedItem(
                  index: 3,

                  child: TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocus,

                    style: const TextStyle(
                      color: darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),

                    cursorColor: primaryBlue,

                    keyboardType: TextInputType.emailAddress,

                    textInputAction: TextInputAction.next,

                    onFieldSubmitted: (_) {
                      _passwordFocus.requestFocus();
                    },

                    decoration: inputDecoration(
                      label: 'Email Address',
                      hint: 'Enter your email',
                      icon: Icons.email_outlined,
                      focused: _emailFocus.hasFocus,
                    ),

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }

                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // =================================================
                // PASSWORD
                // =================================================
                animatedItem(
                  index: 4,

                  child: TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,

                    style: const TextStyle(
                      color: darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),

                    cursorColor: primaryBlue,

                    obscureText: _obscurePassword,

                    textInputAction: TextInputAction.next,

                    onFieldSubmitted: (_) {
                      _confirmPasswordFocus.requestFocus();
                    },

                    decoration: inputDecoration(
                      label: 'Password',
                      hint: 'Create a password',
                      icon: Icons.lock_outline_rounded,
                      focused: _passwordFocus.hasFocus,

                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },

                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,

                          color: textBlue.withOpacity(0.55),
                        ),
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please create a password';
                      }

                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // =================================================
                // CONFIRM PASSWORD
                // =================================================
                animatedItem(
                  index: 5,

                  child: TextFormField(
                    controller: _confirmPasswordController,

                    focusNode: _confirmPasswordFocus,

                    style: const TextStyle(
                      color: darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),

                    cursorColor: primaryBlue,

                    obscureText: _obscureConfirmPassword,

                    textInputAction: TextInputAction.done,

                    onFieldSubmitted: (_) {
                      _register();
                    },

                    decoration: inputDecoration(
                      label: 'Confirm Password',
                      hint: 'Re-enter your password',
                      icon: Icons.lock_reset_rounded,
                      focused: _confirmPasswordFocus.hasFocus,

                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },

                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,

                          color: textBlue.withOpacity(0.55),
                        ),
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }

                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }

                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 25),

                // =================================================
                // REGISTER BUTTON
                // =================================================
                animatedItem(
                  index: 6,

                  child: SizedBox(
                    height: 56,

                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _register,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,

                        disabledBackgroundColor: primaryBlue.withOpacity(0.55),

                        foregroundColor: Colors.white,

                        elevation: 5,

                        shadowColor: primaryBlue.withOpacity(0.25),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),

                      child: _isLoading
                          ? const SizedBox(
                              width: 23,
                              height: 23,

                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,

                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text(
                                  'Create Account',

                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),

                                SizedBox(width: 9),

                                Icon(Icons.arrow_forward_rounded, size: 20),
                              ],
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // =================================================
                // LOGIN LINK
                // =================================================
                animatedItem(
                  index: 7,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        'Already have an account?',

                        style: TextStyle(
                          color: textBlue.withOpacity(0.65),
                          fontSize: 13,
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        child: const Text(
                          'Login',

                          style: TextStyle(
                            color: coral,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),

                // =================================================
                // BRAND
                // =================================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Container(width: 28, height: 2, color: primaryBlue),

                    const SizedBox(width: 9),

                    const Text(
                      'FITWAVE',

                      style: TextStyle(
                        color: darkBlue,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 3,
                      ),
                    ),

                    const SizedBox(width: 9),

                    Container(width: 28, height: 2, color: coral),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===============================================================
// REGISTER WAVE
// ===============================================================

class RegisterWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF2CB8D1).withOpacity(0.25);

    final path = Path();

    path.moveTo(0, size.height * 0.60);

    path.cubicTo(
      size.width * 0.22,
      size.height * 0.10,
      size.width * 0.40,
      size.height * 0.90,
      size.width * 0.58,
      size.height * 0.45,
    );

    path.cubicTo(
      size.width * 0.72,
      size.height * 0.10,
      size.width * 0.88,
      size.height * 0.70,
      size.width,
      size.height * 0.35,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant RegisterWavePainter oldDelegate) {
    return false;
  }
}
