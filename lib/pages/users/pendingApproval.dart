import 'package:flutter/material.dart';

class PendingApprovalPage extends StatefulWidget {
  const PendingApprovalPage({Key? key}) : super(key: key);

  @override
  _PendingApprovalPageState createState() => _PendingApprovalPageState();
}

class _PendingApprovalPageState extends State<PendingApprovalPage>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;

  @override
  Future<void> _refreshList() async {
    setState(() => _isLoading = true);
    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  void _showUserApprovalDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserApprovalDetailsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Approvals'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshList,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Pending approval cards
                  for (int i = 0; i < 3; i++)
                    Card(
                      color: Colors.yellow[50],
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Raju Rastogi',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('F'),
                                  Text('24 yrs'),
                                  Text('requested: now, day ago...'),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  _showUserApprovalDetails(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                              ),
                              child: const Text('view'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text('no more requests'),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _refreshList,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                      ),
                      child: Text(_isLoading ? 'Refreshing...' : 'refresh'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserApprovalDetailsPage extends StatelessWidget {
  const UserApprovalDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Approval'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                color: Colors.yellow[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Raju Rastogi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text('F'),
                      const Text('24 yrs'),
                      const Text('+91 2344324434'),
                      const Text('raju@gmail.com'),
                      const SizedBox(height: 16),
                      const Text('requested: now, day ago...'),
                      const SizedBox(height: 16),
                      const Text('Live Selfie:'),
                      Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.person, size: 50),
                      ),
                      const SizedBox(height: 16),
                      const Text('Aadhar:'),
                      Container(
                        height: 100,
                        width: 160,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.credit_card, size: 50),
                      ),
                      const SizedBox(height: 8),
                      const Text('raju male'),
                      const Text('13/5/20002'),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[100],
                              foregroundColor: Colors.red,
                            ),
                            child: const Text('reject'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[100],
                              foregroundColor: Colors.green,
                            ),
                            child: const Text('approve'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
