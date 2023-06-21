// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hawkerbro/model/fetch_stall_model.dart';
import 'package:hawkerbro/screens/hawker_screen.dart';
import 'package:hawkerbro/widgets/loading_screen.dart';

class LeaveReviewScreen extends StatefulWidget {
  final String unitNumber;
  final String postalCode;

  const LeaveReviewScreen({
    Key? key,
    required this.unitNumber,
    required this.postalCode,
  }) : super(key: key);

  @override
  State<LeaveReviewScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<LeaveReviewScreen> {
  late Future<FetchStallModel?> _stallDataFuture;
  FetchStallModel? stall;
  final TextEditingController _reviewController = TextEditingController();
  int _rating = 0;

  @override
  void initState() {
    super.initState();
    _stallDataFuture = _fetchStallData();
  }

  Future<FetchStallModel?> _fetchStallData() async {
    try {
      final DocumentSnapshot stallSnapshot = await FirebaseFirestore.instance
          .collection('hawkerCentres')
          .doc(widget.postalCode)
          .collection('stalls')
          .doc(widget.unitNumber)
          .get();

      final stallData = stallSnapshot.data() as Map<String, dynamic>;

      return FetchStallModel.fromJSON(stallData);
    } catch (e) {
      throw Exception('Error fetching stall data: $e');
    }
  }

  Future<void> _postReview() async {
    final review = _reviewController.text.trim();
    if (review.isNotEmpty) {
      try {
        final stallRef = FirebaseFirestore.instance
            .collection('hawkerCentres')
            .doc(widget.postalCode)
            .collection('stalls')
            .doc(widget.unitNumber);

        final DocumentSnapshot stallSnapshot = await stallRef.get();
        final stallData = stallSnapshot.data() as Map<String, dynamic>;

        List<String> reviews = List<String>.from(stallData['reviews'] ?? []);
        reviews.add(review);

        List<int> ratings = List<int>.from(stallData['ratings'] ?? []);
        ratings.add(_rating); // Add the selected rating

        // Update the stall data in Firestore
        await stallRef.update({
          'reviews': reviews,
          'ratings': ratings,
        });

        Navigator.pop(context, stall);

        _reviewController.clear();
        setState(() {
          _rating = 0;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to post review: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a review.'),
        ),
      );
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Thank you for your review!.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FetchStallModel?>(
      future: _stallDataFuture,
      builder: (context, stallSnapshot) {
        if (stallSnapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }

        stall = stallSnapshot.data!;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 16.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 32.0,
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HawkerStallScreen(
                            postalCode: stall!.postalCode,
                            unitNumber: stall!.unitNumber,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  stall!.name,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                RatingBar(
                  onRatingChanged: (int rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: _reviewController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Leave your review!',
                    ),
                    maxLines: 6,
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextButton(
                    onPressed: _postReview,
                    child: const Text(
                      'Post Review',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
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
}

class RatingBar extends StatefulWidget {
  final Function(int) onRatingChanged;

  const RatingBar({Key? key, required this.onRatingChanged}) : super(key: key);

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildStarIcon(1),
        buildStarIcon(2),
        buildStarIcon(3),
        buildStarIcon(4),
        buildStarIcon(5),
      ],
    );
  }

  Widget buildStarIcon(int starNumber) {
    return IconButton(
      icon: Icon(
        _rating >= starNumber ? Icons.star : Icons.star_border,
        color: _rating >= starNumber ? Colors.yellow : Colors.grey,
        size: 40.0,
      ),
      onPressed: () {
        setState(() {
          _rating = starNumber;
        });
        widget.onRatingChanged(
          _rating,
        ); // Notify parent widget of the selected rating
      },
    );
  }
}
