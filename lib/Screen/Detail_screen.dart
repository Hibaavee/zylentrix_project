import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final String body;

  const DetailScreen({super.key, required this.title, required this.body});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        surfaceTintColor: Colors.grey[300],
        elevation: 0,
        centerTitle: true,
        leading: IconButton( onPressed: () {
        Navigator.pop(context);
  },
       icon: Icon(Icons.arrow_back_ios),
),

        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Post Title
              Text(
                widget.title.isNotEmpty ? widget.title : "No Title Available",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 50),

              /// Glassmorphic Card for Body
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.2),
                elevation: 8,
                shadowColor: Colors.black26,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(screenHeight * 0.03),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        widget.body.isNotEmpty
                            ? widget.body
                            : "No Content Available",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.038,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
