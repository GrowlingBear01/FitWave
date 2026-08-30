import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _obscurePassword = true;
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
      duration: const Duration(milliseconds: 900),
    );

    _animationController.forward();

    _emailFocus.addListener(() {
      setState(() {});
    });

    _passwordFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    _emailFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }

  // ---------------- LOGIN ----------------

  void _login() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // TEMPORARY
    // Firebase Auth will be connected here
    // using Nishant's AuthService.

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      Navigator.pushNamed(context, '/home');
    });
  }

  // ---------------- ANIMATION ----------------

  Widget animatedItem({required Widget child, required int index}) {
    final animation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        (index * 0.08).clamp(0.0, 0.65),
        ((index * 0.08) + 0.35).clamp(0.35, 1.0),
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
            offset: Offset(0, 22 * (1 - animation.value)),
            child: child,
          ),
        );
      },
    );
  }

  // ---------------- INPUT DECORATION ----------------

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

      // IMPORTANT:
      // White field + dark text
      // so typed content is clearly visible.
      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(color: borderBlue, width: 1),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                const SizedBox(height: 12),

                // =================================================
                // WAVE ICON
                // =================================================
                animatedItem(
                  index: 0,

                  child: SizedBox(
                    height: 105,

                    child: Stack(
                      alignment: Alignment.center,

                      children: [
                        CustomPaint(
                          size: const Size(230, 90),
                          painter: WavePainter(),
                        ),

                        const Icon(
                          Icons.favorite_rounded,
                          color: primaryBlue,
                          size: 46,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // =================================================
                // WELCOME
                // =================================================
                animatedItem(
                  index: 1,

                  child: const Column(
                    children: [
                      Text(
                        'Welcome Back!',

                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: darkBlue,
                          fontSize: 29,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        'Let’s get moving towards your goals.',

                        textAlign: TextAlign.center,

                        style: TextStyle(color: textBlue, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // =================================================
                // EMAIL
                // =================================================
                animatedItem(
                  index: 2,

                  child: TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocus,

                    // IMPORTANT
                    // Typed text will now be dark blue.
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

                const SizedBox(height: 18),

                // =================================================
                // PASSWORD
                // =================================================
                animatedItem(
                  index: 3,

                  child: TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,

                    // IMPORTANT
                    style: const TextStyle(
                      color: darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),

                    cursorColor: primaryBlue,

                    obscureText: _obscurePassword,

                    textInputAction: TextInputAction.done,

                    onFieldSubmitted: (_) {
                      _login();
                    },

                    decoration: inputDecoration(
                      label: 'Password',
                      hint: 'Enter your password',
                      icon: Icons.lock_outline_rounded,
                      focused: _passwordFocus.hasFocus,

                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },

                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),

                          child: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,

                            key: ValueKey(_obscurePassword),

                            color: textBlue.withOpacity(0.55),
                          ),
                        ),
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }

                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      return null;
                    },
                  ),
                ),

                // =================================================
                // FORGOT PASSWORD
                // =================================================
                animatedItem(
                  index: 4,

                  child: Align(
                    alignment: Alignment.centerRight,

                    child: TextButton(
                      onPressed: () {},

                      child: const Text(
                        'Forgot Password?',

                        style: TextStyle(
                          color: primaryBlue,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // =================================================
                // LOGIN BUTTON
                // =================================================
                animatedItem(
                  index: 5,

                  child: SizedBox(
                    height: 56,

                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,

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
                                  'Login',

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

                const SizedBox(height: 20),

                // =================================================
                // REGISTER
                // =================================================
                animatedItem(
                  index: 6,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        "Don't have an account?",

                        style: TextStyle(
                          color: textBlue.withOpacity(0.65),
                          fontSize: 13,
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },

                        child: const Text(
                          'Register',

                          style: TextStyle(
                            color: coral,
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),

                // =================================================
                // BRAND
                // =================================================
                animatedItem(
                  index: 7,

                  child: Row(
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
// WAVE PAINTER
// ===============================================================

class WavePainter extends CustomPainter {
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
      size.width * 0.20,
      size.height * 0.10,
      size.width * 0.35,
      size.height * 0.90,
      size.width * 0.55,
      size.height * 0.45,
    );

    path.cubicTo(
      size.width * 0.72,
      size.height * 0.05,
      size.width * 0.85,
      size.height * 0.75,
      size.width,
      size.height * 0.35,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    return false;
  }
}
