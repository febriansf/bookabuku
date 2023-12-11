// ignore: file_names
import 'package:books_finder/books_finder.dart';

class BookSearcher {
  Future<List<BookInfo>> searchBooks(String query) async {
    final books = await queryBooks(
      query,
      maxResults: 10,
      printType: PrintType.books,
      orderBy: OrderBy.relevance,
      reschemeImageLinks: true,
    );

    final bookInfoList = books.map((book) => book.info).toList();
    return bookInfoList;
  }

  Future getDetailInfo(String isbn) async {
    final List<Book> books = await queryBooks(
      isbn,
      queryType: QueryType.isbn,
      maxResults: 1,
      printType: PrintType.books,
      orderBy: OrderBy.relevance,
      reschemeImageLinks: true,
    );

    final bookInfo = books.last.info;
    return bookInfo;
  }
}

// void main() async {
//   BookSearcher searcher = BookSearcher();

//   final List<BookInfo> result = await searcher.searchBooks('new');

//   for (final book in result) {
//     print('$book\n');
//   }
// }
