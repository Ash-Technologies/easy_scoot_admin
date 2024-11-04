import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EVPage extends StatefulWidget {
  const EVPage({Key? key}) : super(key: key);

  @override
  _EVPageState createState() => _EVPageState();
}

class _EVPageState extends State<EVPage> with SingleTickerProviderStateMixin {
  bool _isLoading = false;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'EV(s)',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() => _isLoading = true);
                await Future.delayed(const Duration(seconds: 1));
                setState(() => _isLoading = false);
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  EVCard(
                    registrationNumber: 'MP09 KA 2345',
                    batteryPercentage: 75,
                    status: 'driving',
                    revenue: 2500,
                    speed: 25,
                    temperature: 32,
                    lastMaintenance: '2024-01-15',
                    totalKm: 1234,
                    location: 'Vijay Nagar, Indore',
                  ),
                  const SizedBox(height: 12),
                  EVCard(
                    registrationNumber: 'MP09 KA 2346',
                    batteryPercentage: 15,
                    status: 'halted',
                    revenue: 1800,
                    speed: 0,
                    temperature: 35,
                    lastMaintenance: '2024-01-10',
                    totalKm: 2156,
                    location: 'Palasia, Indore',
                    isCharging: true,
                  ),
                  const SizedBox(height: 12),
                  EVCard(
                    registrationNumber: 'MP09 KA 2347',
                    batteryPercentage: 45,
                    status: 'maintenance',
                    revenue: 0,
                    speed: 0,
                    temperature: 30,
                    lastMaintenance: '2024-02-01',
                    totalKm: 1876,
                    location: 'Service Center, Indore',
                    needsMaintenance: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new EV functionality
        },
        child: const Icon(Icons.add),
        tooltip: 'Add New EV',
      ),
    );
  }
}

class EVCard extends StatelessWidget {
  final String registrationNumber;
  final int batteryPercentage;
  final String status;
  final double revenue;
  final double speed;
  final double temperature;
  final String lastMaintenance;
  final int totalKm;
  final String location;
  final bool isCharging;
  final bool needsMaintenance;

  const EVCard({
    Key? key,
    required this.registrationNumber,
    required this.batteryPercentage,
    required this.status,
    required this.revenue,
    required this.speed,
    required this.temperature,
    required this.lastMaintenance,
    required this.totalKm,
    required this.location,
    this.isCharging = false,
    this.needsMaintenance = false,
  }) : super(key: key);

  Color get statusColor {
    switch (status) {
      case 'driving':
        return Colors.green;
      case 'halted':
        return Colors.orange;
      case 'maintenance':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ExpansionTile(
        title: Row(
          children: [
            Text(
              registrationNumber,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    status == 'driving'
                        ? Icons.directions_bike
                        : Icons.stop_circle,
                    size: 16,
                    color: statusColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                _buildInfoChip(
                  icon: Icons.battery_charging_full,
                  label: '$batteryPercentage%',
                  color: _getBatteryColor(batteryPercentage),
                ),
                const SizedBox(width: 8),
                if (isCharging)
                  _buildInfoChip(
                    icon: Icons.electric_bolt,
                    label: 'Charging',
                    color: Colors.green,
                  ),
                if (needsMaintenance)
                  _buildInfoChip(
                    icon: Icons.warning,
                    label: 'Service Due',
                    color: Colors.red,
                  ),
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildDetailRow(
                  'Revenue',
                  '₹${revenue.toStringAsFixed(2)}',
                  Icons.currency_rupee,
                ),
                _buildDetailRow(
                  'Speed',
                  '${speed.toStringAsFixed(1)} km/h',
                  Icons.speed,
                ),
                _buildDetailRow(
                  'Temperature',
                  '$temperature°C',
                  Icons.thermostat,
                ),
                _buildDetailRow(
                  'Total Distance',
                  '$totalKm km',
                  Icons.route,
                ),
                _buildDetailRow(
                  'Last Maintenance',
                  lastMaintenance,
                  Icons.build,
                ),
                _buildDetailRow(
                  'Location',
                  location,
                  Icons.location_on,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Open location tracking
                      },
                      icon: const Icon(Icons.location_on),
                      label: const Text('Track'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[100],
                        foregroundColor: Colors.blue[900],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Stop vehicle
                      },
                      icon: const Icon(Icons.stop_circle),
                      label: const Text('Stop'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[100],
                        foregroundColor: Colors.red[900],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getBatteryColor(int percentage) {
    if (percentage > 60) return Colors.green;
    if (percentage > 30) return Colors.orange;
    return Colors.red;
  }
}
