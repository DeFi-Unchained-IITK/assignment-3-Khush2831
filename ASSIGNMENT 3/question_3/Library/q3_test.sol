// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./q3.sol";

contract TestLibrary {
    Library libraryContract;

    function beforeEach() public {
        libraryContract = new Library();
    }

    function testAddBook() public {
        libraryContract.addBook("1984", "George Orwell");

        (uint id, string memory name, string memory author, bool isAvailable) = libraryContract.getBookDetails(1);
        
        Assert.equal(id, 1, "Book ID should be 1");
        Assert.equal(name, "1984", "Book name should be '1984'");
        Assert.equal(author, "George Orwell", "Book author should be 'George Orwell'");
        Assert.isTrue(isAvailable, "Book should be available");
    }

    function testBorrowBook() public {
        libraryContract.addBook("1984", "George Orwell");
        libraryContract.borrowBook(1);

        bool isAvailable = libraryContract.getBookDetails(1).isAvailable;
        bool isBorrowed = libraryContract.borrowed_books(address(this), 1);

        Assert.isFalse(isAvailable, "Book should not be available after borrowing");
        Assert.isTrue(isBorrowed, "Book should be marked as borrowed");
    }

    function testReturnBook() public {
        libraryContract.addBook("1984", "George Orwell");
        libraryContract.borrowBook(1);
        libraryContract.returnBook(1);

        bool isAvailable = libraryContract.getBookDetails(1).isAvailable;
        bool isBorrowed = libraryContract.borrowed_books(address(this), 1);

        Assert.isTrue(isAvailable, "Book should be available after returning");
        Assert.isFalse(isBorrowed, "Book should not be marked as borrowed");
    }

    function testInvalidBookId() public {
        bool r;

        (r, ) = address(libraryContract).call(abi.encodeWithSignature("borrowBook(uint256)", 999));
        Assert.isFalse(r, "Transaction should revert with invalid book ID");

        (r, ) = address(libraryContract).call(abi.encodeWithSignature("returnBook(uint256)", 999));
        Assert.isFalse(r, "Transaction should revert with invalid book ID");
    }

    function testReturnBookNotBorrowed() public {
        libraryContract.addBook("1984", "George Orwell");

        bool r;
        (r, ) = address(libraryContract).call(abi.encodeWithSignature("returnBook(uint256)", 1));
        Assert.isFalse(r, "Transaction should revert if the book was not borrowed");
    }
}
