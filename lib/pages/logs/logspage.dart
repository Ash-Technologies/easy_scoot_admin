import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({Key? key}) : super(key: key);

  @override
  _LogsPageState createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage>
    with SingleTickerProviderStateMixin {
  String _selectedFilter = 'all';
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  // Sample logs data
  final List<LogEntry> _logs = [
    LogEntry(
      timestamp: '2024-11-04 10:15:32',
      type: 'user',
      message: 'User registered: user123',
      level: 'info',
    ),
    LogEntry(
      timestamp: '2024-11-04 10:18:45',
      type: 'user',
      message: 'User logged in: user123',
      level: 'info',
    ),
    LogEntry(
      timestamp: '2024-11-04 10:20:10',
      type: 'user',
      message: 'User basic info uploaded: user123',
      level: 'info',
    ),
    LogEntry(
      timestamp: '2024-11-04 10:22:30',
      type: 'user',
      message: 'User user123 uploaded image: profile_pic.jpg',
      level: 'info',
    ),
    LogEntry(
      timestamp: '2024-11-04 10:25:00',
      type: 'user',
      message: 'User user123 KYC approved',
      level: 'success',
    ),
    LogEntry(
      timestamp: '2024-11-04 10:30:15',
      type: 'user',
      message: 'User user123 booked an EV: Tesla Model 3',
      level: 'info',
    ),
    LogEntry(
      timestamp: '2024-11-04 10:32:00',
      type: 'ev',
      message: 'EV: started: Tesla Model 3, user: user123',
      level: 'info',
    ),
    LogEntry(
      timestamp: '2024-11-04 10:45:22',
      type: 'ev',
      message: 'EV: stopped: Tesla Model 3, user: user123',
      level: 'info',
    ),
    LogEntry(
      timestamp: '2024-11-04 10:50:10',
      type: 'ev',
      message: 'EV: battery level: 75% - Tesla Model 3, user: user123',
      level: 'warning',
    ),
    LogEntry(
      timestamp: '2024-11-04 10:55:45',
      type: 'ev',
      message: 'EV: collision detected: Tesla Model 3, user: user123',
      level: 'error',
    ),
    LogEntry(
      timestamp: '2024-11-04 11:05:00',
      type: 'user',
      message: 'User user123 logged out',
      level: 'info',
    ),
    LogEntry(
      timestamp: '2024-11-04 11:10:15',
      type: 'user',
      message: 'User user456 registered',
      level: 'info',
    ),
  ];

  @override
  List<LogEntry> get filteredLogs {
    return _logs.where((log) {
      final matchesFilter =
          _selectedFilter == 'all' || log.type == _selectedFilter;
      final matchesSearch = log.message
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  Future<void> _refreshLogs() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Logs',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 1,
      ),
      body: Column(
        children: [
          // //Search Bar
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: TextField(
          //     controller: _searchController,
          //     decoration: InputDecoration(
          //       hintText: 'Search logs...',
          //       prefixIcon: const Icon(Icons.search),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          //     ),
          //     onChanged: (value) => setState(() {}),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterChip('all', 'All'),
                _buildFilterChip('user', 'User'),
                _buildFilterChip('ev', 'EV'),
                _buildFilterChip('system', 'System'),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshLogs,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredLogs.length,
                itemBuilder: (context, index) {
                  final log = filteredLogs[index];
                  return LogEntryCard(
                    log: log,
                    onCopy: () {
                      Clipboard.setData(ClipboardData(
                        text: '${log.timestamp} | ${log.message}',
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Log entry copied to clipboard'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _isLoading ? null : _refreshLogs,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
              ),
              child: Text(_isLoading ? 'Refreshing...' : 'refresh'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String filter, String label) {
    return FilterChip(
      selected: _selectedFilter == filter,
      label: Text(label),
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? filter : 'all';
        });
      },
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.blue[100],
      checkmarkColor: Colors.blue[900],
    );
  }
}

class LogEntry {
  final String timestamp;
  final String type;
  final String message;
  final String level;

  LogEntry({
    required this.timestamp,
    required this.type,
    required this.message,
    required this.level,
  });
}

class LogEntryCard extends StatelessWidget {
  final LogEntry log;
  final VoidCallback onCopy;

  const LogEntryCard({
    Key? key,
    required this.log,
    required this.onCopy,
  }) : super(key: key);

  Color get levelColor {
    switch (log.level) {
      case 'error':
        return Colors.red;
      case 'warning':
        return Colors.orange;
      case 'success':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onCopy,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: levelColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      log.timestamp,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      log.message,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 16),
                onPressed: onCopy,
                tooltip: 'Copy log entry',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
