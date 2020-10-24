//
//  ContentView.swift
//  BookLog
//
//  Created by Jay Lee on 2020/09/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var bookData: BookData

    @SceneStorage("currentBookUUID") private var currentBookUUID: UUID? = nil
    private var detailBookShown: Binding<Bool> {
        Binding<Bool>(
            get: { currentBookUUID != nil },
            set: { shown in
                if !shown {
                    currentBookUUID = nil
                }
            }
        )
    }

    var body: some View {
        NavigationView {
            BookList()
                .navigationTitle("Book Log")
                .navigationBarItems(trailing: Button() {
                    let newBook = Book()
                    bookData.books.append(newBook)
                    currentBookUUID = newBook.id
                } label: {
                    Image(systemName: "plus.circle")
                })
        }
        .sheet(isPresented: detailBookShown) {
            if let uuid = currentBookUUID,
               let book = bookData.books.first { $0.id == uuid } {
                NavigationView {
                    BookDetail(book: book)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(BookData())
    }
}
