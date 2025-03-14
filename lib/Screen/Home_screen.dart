import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:zylentrix_project/Screen/Detail_screen.dart';
import 'package:zylentrix_project/webservice.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> items = [];
  bool isLoading = true;
  String? errorMessage; // Error message from API failures

  @override
  void initState() {
    super.initState();
    fetchData();
  }
// Fetches posts from the API and updates UI accordingly
  Future<void> fetchData() async {
    setState(() {
    isLoading = true;
    errorMessage = null;
    });
    try {
      final data = await ApiService.fetchPosts();
      setState(() {
      items = List<Map<String, String>>.from(
      data.map(
      (item) => {
      'title': item['title'].toString(),
      'body': item['body'].toString(),
      },),);
      });
    } catch (e) {
      setState(() {
      errorMessage = 'Failed to load data. Please try again later.';

        if (e.toString().contains("SocketException")) {
          errorMessage = "No Internet Connection. Please check your network.";
        } else if (e.toString().contains("TimeoutException")) {
          errorMessage = "Request timed out. Try again later.";
        } else if (e.toString().contains("No data available")) {
          errorMessage = "No articles available at the moment.";
        }
      setState(() {
        errorMessage = errorMessage;
        });
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
      backgroundColor: Colors.grey[300],
      surfaceTintColor: Colors.grey[300],
      title: Center(child: Text('Post Index',
      style: GoogleFonts.poppins(fontSize: screenWidth * 0.06,fontWeight: FontWeight.bold)),),),
      
      body:isLoading
     ? Center(
     child: Lottie.asset("assets/animation/loading.json",
      width: 500,
      height: 500),)
      : errorMessage != null
    ? Center(
      child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline,color: Colors.red,size: screenWidth * 0.12),

    SizedBox(height: 10),
    Text(
      errorMessage!,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(fontSize: screenWidth * 0.05,color: Colors.red),),
    SizedBox(height: 10),
    ElevatedButton(
      onPressed: fetchData,
      child: Text('Retry', style: GoogleFonts.poppins(fontSize: screenWidth * 0.05),),
                      ),
                    ],
                  ),
                ),
              )
    : Padding(
       padding: EdgeInsets.all(screenWidth * 0.04),
       child: ListView.builder(
       itemCount: items.length,
       itemBuilder: (context, index) {
  //post card with a glassmorphic effect
    return Card(
      color: Colors.white.withOpacity(0.4),
      shadowColor: Colors.black.withOpacity(0.2),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(                   
         decoration: BoxDecoration(color: Colors.white.withOpacity(0.4),
         borderRadius: BorderRadius.circular(15),),
      child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
      child: ListTile(
           contentPadding: EdgeInsets.all(16),
      title: Text(
           toBeginningOfSentenceCase(items[index]['title']!) ??'',
           style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),),
      subtitle: Text(
           toBeginningOfSentenceCase(items[index]['body'] ?? 'No Content', ) ?? 'No Content',
           maxLines: 2,
           overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
       fontSize: screenWidth * 0.04,
       color: Colors.black54,),),
      onTap: () {
        Navigator.push(context,MaterialPageRoute(builder:
                                          (context) => DetailScreen(
                                           title: toBeginningOfSentenceCase(items[index]['title']!) ?? '',
                                           body: toBeginningOfSentenceCase(items[index]['body']!) ?? '',
                                          ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}