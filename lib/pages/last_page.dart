import 'package:flutter/material.dart';
import 'package:freshers/books/book.dart';
import 'package:freshers/books/genreButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freshers/books/interestBookLast.dart';
import 'package:freshers/books/trendingbooksLast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LastPage extends StatefulWidget {
  @override
  _LastPageState createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
  List<Book> _generalBooks = [];
  List<Book> _devsChoiceBooks = [];
  List<Book> _allBooks = [];
  List<Book> _filteredBooks = [];
  List<Book> _favoriteBooks = [];
  TextEditingController _searchController = TextEditingController();
  PageController _pageController = PageController(viewportFraction: 1.0);
  bool _showFavorites = false;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
    _searchController.addListener(_searchBooks);
    _startAutoScroll();
  }

  void _fetchBooks() async {
    FirebaseFirestore.instance.collection('books').snapshots().listen((snapshot) {
      final allBooks = snapshot.docs.map((doc) => Book.fromFirestore(doc)).toList();
      setState(() {
        _generalBooks = allBooks;
        _allBooks.addAll(allBooks);
        _filteredBooks = List.from(_generalBooks); 
        _loadFavorites();
      });
    });

    FirebaseFirestore.instance.collection('DevsChoice').snapshots().listen((snapshot) {
      final devsChoiceBooks = snapshot.docs.map((doc) => Book.fromFirestore(doc)).toList();
      setState(() {
        _devsChoiceBooks = devsChoiceBooks;
        _allBooks.addAll(devsChoiceBooks);
        _loadFavorites();
      });
    });
  }

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteIds = prefs.getStringList('favoriteBooks');
    if (favoriteIds != null) {
      setState(() {
   
        _favoriteBooks = _allBooks.where((book) => favoriteIds.contains(book.id) && !_devsChoiceBooks.contains(book)).toList();
      });
    }
  }


  void _searchBooks() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBooks = (_showFavorites ? _favoriteBooks : _allBooks).where((book) {
        return book.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _startAutoScroll() {
    Future.delayed(Duration(seconds: 6)).then((_) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page!.round() + 1) % _devsChoiceBooks.length;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
      _startAutoScroll();
    });
  }

  void _addFavorite(Book book) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteIds = prefs.getStringList('favoriteBooks') ?? [];
    if (!favoriteIds.contains(book.id)) {
      favoriteIds.add(book.id);
      await prefs.setStringList('favoriteBooks', favoriteIds);
      setState(() {
        _favoriteBooks.add(book);
      });
    }
  }

  void _removeFavorite(Book book) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteIds = prefs.getStringList('favoriteBooks') ?? [];
    if (favoriteIds.contains(book.id)) {
      favoriteIds.remove(book.id);
      await prefs.setStringList('favoriteBooks', favoriteIds);
      setState(() {
        _favoriteBooks.remove(book);
      });
    }
  }

  void _toggleFavorites() {
    setState(() {
      _showFavorites = !_showFavorites;
      _filteredBooks = _showFavorites ? _favoriteBooks : _allBooks;
    });
    _searchBooks(); 
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    
    await Future.delayed(Duration(seconds: 2));

    final booksSnapshot = await FirebaseFirestore.instance.collection('books').get();
    final devsChoiceSnapshot = await FirebaseFirestore.instance.collection('DevsChoice').get();

    final allBooks = booksSnapshot.docs.map((doc) => Book.fromFirestore(doc)).toList();
    final devsChoiceBooks = devsChoiceSnapshot.docs.map((doc) => Book.fromFirestore(doc)).toList();

    setState(() {
      _generalBooks = allBooks;
      _devsChoiceBooks = devsChoiceBooks;
      _allBooks = [...allBooks, ...devsChoiceBooks];
      _filteredBooks = _showFavorites ? _favoriteBooks : _allBooks;
      _loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: LiquidPullToRefresh(
        backgroundColor: Theme.of(context).colorScheme.primary,
        color: Theme.of(context).colorScheme.surface,
        onRefresh: _handleRefresh,
        showChildOpacityTransition: false,
        height: 100,
        animSpeedFactor: 2,
        springAnimationDurationInMilliseconds: 700,
        child: _buildScrollableContent(),
      ),
    );
  }

  Widget _buildScrollableContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          _buildTrendingSection(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: _buildGenreButtons(),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: _buildInterestSection(),
            ),
          ),SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTrendingSection() {
    return _devsChoiceBooks.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Container(
            height: 250,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _devsChoiceBooks.length,
              itemBuilder: (context, index) {
                return TrendingBookItem(
                  book: _devsChoiceBooks[index], 
                );
              },
            ),
          );
  }

  Widget _buildGenreButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GenreButton(
          'All',
          isSelected: !_showFavorites,
          onTap: () {
            if (_showFavorites) {
              _toggleFavorites();
            }
          },
        ),
        GenreButton(
          'Favorites',
          isSelected: _showFavorites,
          onTap: () {
            if (!_showFavorites) {
              _toggleFavorites();
            }
          },
        ),
      ],
    );
  }

  Widget _buildInterestSection() {
    List<Book> nonTrendingBooks = _filteredBooks.where((book) => !_devsChoiceBooks.contains(book)).toList();

    return GridView.builder(
      key: ValueKey<bool>(_showFavorites),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.73,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
      ),
      itemCount: nonTrendingBooks.length,
      itemBuilder: (context, index) {
        Book book = nonTrendingBooks[index];
        return InterestBookItem(
          book: book,
          onFavorite: _addFavorite,
          onRemoveFavorite: _removeFavorite,
        );
      },
    );
  }
}
