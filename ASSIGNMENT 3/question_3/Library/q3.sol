// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Library {
    struct Book {
        uint ID;
        string name;
        string author;
        bool isAvailable;
    }

    mapping(uint => Book) public books;
    mapping(address => mapping(uint => bool)) public borrowed_books;
    uint public bookCount;

    modifier validBookId(uint _bookId) {
        require(_bookId > 0 && _bookId <= bookCount, "Invalid book ID");
        _;
    }

    function addBook(string memory _name, string memory _author) public {
        bookCount++;
        books[bookCount] = Book(bookCount, _name, _author, true);
    }

    function borrowBook(uint _bookId) public validBookId(_bookId) {
        require(books[_bookId].isAvailable, "Book is not available");
        books[_bookId].isAvailable = false;
        borrowed_books[msg.sender][_bookId] = true;
    }

    function getBookDetails(uint _bookId) public view validBookId(_bookId) returns (Book memory) {
        return books[_bookId];
    }

    function returnBook(uint _bookId) public validBookId(_bookId) {
        require(borrowed_books[msg.sender][_bookId], "You did not borrow this book");
        books[_bookId].isAvailable = true;
        borrowed_books[msg.sender][_bookId] = false;
    }
}
