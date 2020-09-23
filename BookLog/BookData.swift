//
//  BookData.swift
//  BookLog
//
//  Created by Jay Lee on 2020/09/22.
//

import Foundation

final class BookData: ObservableObject {
    @Published var books: [Book] {
        didSet {
            _ = try? BookDataManager.shared.save(books: books)
        }
    }

    init(books: [Book] = []) {
        self.books = books
    }
}

private let foundationBook = Book(
    title: "Foundation",
    author: "Isaac Asimov",
    readingStartDate: Date(),
    readingFinishDate: nil)
