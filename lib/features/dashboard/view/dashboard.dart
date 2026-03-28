import 'package:flutter/material.dart';
import 'package:partner_dashboard/constants/constants.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text(
          Constants.appBarTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          SizedBox(height: 16),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Constants.dashboardTitle,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).hintColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.home),
                            Text(Constants.littleFlowers),
                          ],
                        ),
                      ),
                      Icon(Icons.notifications),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          DashBoardCard(
            label: Constants.startOfTheDay,
            icon: Icons.sunny,
            progress: 0.3,
          ),
          SizedBox(height: 16),
          DashBoardCard(
            label: Constants.endOfTheDay,
            icon: Icons.nightlight,
            progress: 0,
          ),
        ],
      ),
    );
  }
}

class DashBoardCard extends StatelessWidget {
  const DashBoardCard({
    super.key,
    required this.label,
    required this.icon,
    required this.progress,
  });

  final String label;
  final IconData icon;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade400, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.green),
              CircleAvatar(radius: 5, backgroundColor: Colors.red),
            ],
          ),
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          Text(
            Constants.taskToDO,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          LinearProgressIndicator(
            value: progress,
            color: Colors.green,
            borderRadius: BorderRadius.circular(4),
            minHeight: 4,
          ),
        ],
      ),
    );
  }
}
