import 'package:flutter/material.dart';

class ApiImagesPage extends StatefulWidget {
  const ApiImagesPage({super.key});

  @override
  State<ApiImagesPage> createState() {
    return _ApiImagesPageState();
  }
}

class _ApiImagesPageState extends State<ApiImagesPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  
  final List<int> _code = const [100, 101, 200, 201, 204, 301, 302, 304, 404, 500];

  int _selected = 100;

  @override
  void initState() {
    super.initState();
    // Đổi length về 2 vì bạn chỉ có 2 Tab (Cat và Dog)
    _tabController = TabController(length: 2, vsync: this);
    
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          // Khi chuyển Tab (Cat <-> Dog), ta cập nhật lại UI
        });
      }
    });
  }

  String _imageUrl() {
    final idx = _tabController.index;
    if (idx == 0) return 'https://http.cat/$_selected';
    return 'https://http.dog/$_selected.jpg';
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFE9F4FF);
    const headerBlue = Color(0xFF1E88E5);
    const primary = Color(0xFF0D47A1);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Xem Anh qua Api'),
        backgroundColor: headerBlue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'http.cat'),
            Tab(text: 'http.dog'),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Thêm một Dropdown hoặc Grid để chọn mã Code vì Tab giờ là chọn loại động vật
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _code.map((c) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text('$c'),
                  selected: _selected == c,
                  onSelected: (selected) {
                    setState(() => _selected = c);
                  },
                ),
              )).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Status: $_selected',
              style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  _imageUrl(),
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.pets, size: 50, color: Colors.grey),
                      Text('No image for code $_selected'),
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