//
//  BookList.swift
//  BookLog
//
//  Created by Jay Lee on 2020/09/22.
//

import SwiftUI

struct BookList: View {
    @EnvironmentObject private var bookData: BookData
    @SceneStorage("selectedBookUUID") private var selectedBookUUID: UUID? = nil

    var body: some View {
        List {
            ForEach(bookData.books) { book in
                NavigationLink(
                    destination: BookDetail(book: book),
                    tag: book.id,
                    selection: $selectedBookUUID
                ) {
                    BookItem(book: book)
                }
            }
            .onDelete { indexSet in
                indexSet.forEach {
                    bookData.books.remove(at: $0)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        BookList()
            .environmentObject(BookData())
    }
}
