import 'package:flutter/material.dart';
import 'homepage.dart';

class CoffeeIntroPage extends StatelessWidget {
  const CoffeeIntroPage({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFE9EEF6),

      body: Container(
        width: size.width,
        height: size.height,
        color: const Color(0xFF4A2C1F),

        child: Column(
          children: [

            /// Image
            Expanded(
              flex: 6,
              child: Image.asset(
                "assets/coffee.jpg",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            /// Text Area
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                  vertical: size.height * 0.025,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Title
                    Text(
                      "Time for a coffee break....",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.075,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Description
                    Text(
                      "Your daily dose of fresh brew delivered to your doorstep. Start your coffee journey now!",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: size.width * 0.050,
                      ),
                    ),

                    const SizedBox(height: 80),

                    /// Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _indicator(false),
                        _indicator(false),
                        _indicator(true),
                        _indicator(false),
                      ],
                    ),

                    SizedBox(height: size.height * 0.03),

                    /// Button
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.06,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFFF28C28),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Dot Indicator
  static Widget _indicator(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 18 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}