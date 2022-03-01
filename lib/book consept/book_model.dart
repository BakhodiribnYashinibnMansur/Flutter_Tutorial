class Book {
  final String title;
  final String author;
  final String bookImage;

  Book({
    required this.title,
    required this.author,
    required this.bookImage,
  });
}

List<Book> bookList = [
  Book(
    author: 'Christopher Paolina',
    bookImage: 'assets/image/book1.jpg',
    title: 'To Sleep in a Sea of Stars',
  ),
  Book(
    author: 'Peter F. Hamilton',
    bookImage: 'assets/image/book2.jpg',
    title: 'The Saints of Salvation',
  ),
  Book(
    author: 'Arkady Martine',
    bookImage: 'assets/image/book3.jpg',
    title: 'A Desolation Called Peace',
  ),
  Book(
    author: 'Jack Four',
    bookImage: 'assets/image/book4.jpg',
    title: ' Neal Asher',
  ),
  Book(
    author: 'Adrian Tchaikovsky',
    bookImage: 'assets/image/book5.jpg',
    title: 'The Doors of Eden',
  ),
  Book(
    author: 'Neal Asher',
    bookImage: 'assets/image/book6.jpg',
    title: 'The Humans',
  ),
  Book(
    author: 'Arkady Martine',
    bookImage: 'assets/image/book7.jpg',
    title: 'Memory Called Empire',
  ),
];
