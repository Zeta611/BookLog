//
//  BookItem.swift
//  BookLog
//
//  Created by Jay Lee on 2020/09/22.
//

import SwiftUI

struct BookItem: View {
    @EnvironmentObject private var bookData: BookData
    let book: Book
    private var bookIndex: Int? {
        bookData.books.firstIndex { $0.id == book.id }
    }

    @State private var date: Date = Date()

    var body: some View {
        HStack {
            VStack {
                Text(book.title)
                    .font(.headline)
                Text(book.author)
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Text("from: \(DateFormatter.default.string(from: book.readingStartDate))")
                if let readingFinishDate = book.readingFinishDate {
                    Text("to: \(DateFormatter.default.string(from: readingFinishDate))")
                }
            }
        }
    }
}

struct BookItem_Previews: PreviewProvider {
    static let foundationBook = Book(
        title: "Foundation",
        author: "Isaac Asimov",
        readingStartDate: Date(),
        readingFinishDate: nil)

    static var previews: some View {
        BookItem(book: foundationBook)
            .environmentObject(BookData(books: [foundationBook]))
    }
}
