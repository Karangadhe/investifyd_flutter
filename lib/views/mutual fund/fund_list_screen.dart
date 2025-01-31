import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/api_service.dart'; // Update to your actual path

class FundListScreen extends StatefulWidget {
  const FundListScreen({super.key});

  @override
  _FundListScreenState createState() => _FundListScreenState();
}

class _FundListScreenState extends State<FundListScreen> {
  List<dynamic> allFunds = [];
  bool isLoading = false;
  bool hasMore = true;
  int pageNo = 1;

  @override
  void initState() {
    super.initState();
    fetchFunds(reset: true);
  }

  Future<void> fetchFunds({bool reset = false}) async {
    if (reset) {
      setState(() {
        isLoading = true;
        allFunds.clear();
        hasMore = true;
        pageNo = 1;
      });
    }

    final endpoint = '/ins/mffund/searchfunds?page=$pageNo';

    try {
      final response = await ApiService.fetchAPI(endpoint, 'GET');
      if (response.isNotEmpty) {
        setState(() {
          allFunds.addAll(response['funds']);
          hasMore =
              response['count'] >= 40; // Adjust the condition if necessary
          pageNo++;
        });
      } else {
        Fluttertoast.showToast(msg: "No data found.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fund List')),
      body: isLoading && allFunds.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: allFunds.length + 1,
              itemBuilder: (context, index) {
                if (index == allFunds.length) {
                  return hasMore
                      ? Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20.0), // Bottom margin
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: Colors.blue, // Button color
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () => fetchFunds(),
                              child: Text("Load More"),
                            ),
                          ),
                        )
                      : SizedBox.shrink();
                }
                final fund = allFunds[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Fund Image in a circular shape and small size
                        fund['image'] != null
                            ? ClipOval(
                                child: Image.network(
                                  fund['image'],
                                  width: 50, // Adjust the size of the image
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : SizedBox(
                                height: 50, width: 50), // Placeholder size

                        // Fund Name
                        SizedBox(height: 10),
                        Text(
                          fund['fundName'] ?? 'Unknown Fund',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Category and Subcategory
                        SizedBox(height: 5),
                        Text(
                          '${fund['broadCat'] ?? '-'} | ${fund['displayCatName'] ?? '-'}',
                          style: TextStyle(color: Colors.grey),
                        ),

                        // AUM, NAV, and Invest Button
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // AUM Section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('AUM'),
                                Text(fund['aum']?.toString() ?? 'N/A'),
                              ],
                            ),
                            // NAV Section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('NAV'),
                                Text(fund['formatted_latestNav']?.toString() ??
                                    'N/A'),
                              ],
                            ),
                            // Invest Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color(0xFF0A2542), // Custom theme color
                                padding: EdgeInsets.symmetric(vertical: 25),
                                textStyle: TextStyle(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                // Implement Invest Button Action
                              },
                              child: Text("Invest"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
