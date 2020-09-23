//
//  BookDetail.swift
//  BookLog
//
//  Created by Jay Lee on 2020/09/22.
//

import SwiftUI

struct BookDetail: View {
    @EnvironmentObject private var bookData: BookData
    @Environment(\.presentationMode) private var presentationMode
    let book: Book
    private var bookIndex: Int? {
        bookData.books.firstIndex { $0.id == book.id }
    }

    var body: some View {
        Form {
            if let bookIndex = bookIndex {
                // Title & author section
                Section {
                    TextField("Title", text: $bookData.books[bookIndex].title)
                    TextField("Author", text: $bookData.books[bookIndex].author)
                }

                // Start & finish date section
                Section {
                    DatePicker(
                        "Start Date",
                        selection: $bookData.books[bookIndex].readingStartDate,
                        displayedComponents: .date)

                    if let readingFinishDateBinding
                        = Binding($bookData.books[bookIndex].readingFinishDate)
                    {
                        DatePicker(
                            "Finish Date",
                            selection: readingFinishDateBinding,
                            displayedComponents: .date)
                    } else {
                        Button("Add finish date!") {
                            bookData.books[bookIndex].readingFinishDate
                                = Date()
                        }
                    }
                }

                // Remove button section
                Section {
                    Button("Remove") {
                        presentationMode.wrappedValue.dismiss()
                        bookData.books.remove(at: bookIndex)
                    }
                    .accentColor(.red)
                }
            }
        }
        .navigationBarItems(trailing: Button("Done") {
            presentationMode.wrappedValue.dismiss()
        })
        .navigationTitle(
            bookIndex == nil ? "" : bookData.books[bookIndex!].title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BookDetail_Previews: PreviewProvider {
    static let foundationBook = Book(
        title: "Foundation",
        author: "Isaac Asimov",
        readingStartDate: Date(),
        readingFinishDate: nil)

    static var previews: some View {
        BookDetail(book: foundationBook)
            .environmentObject(BookData(books: [foundationBook]))
    }
}
