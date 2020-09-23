//
//  ContentView.swift
//  BookLog
//
//  Created by Jay Lee on 2020/09/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var bookData: BookData
    @State private var detailBookShown = false
    @State private var currentBookUUID: UUID?

    var body: some View {
        NavigationView {
            BookList()
                .navigationTitle("Book Log")
                .navigationBarItems(trailing: Button(action: {
                    detailBookShown = true
                    let newBook = Book()
                    bookData.books.append(newBook)
                    currentBookUUID = newBook.id
                }, label: {
                    Image(systemName: "plus.circle")
                }))
        }
        .sheet(isPresented: $detailBookShown, content: {
            NavigationView {
                BookDetail(book: bookData.books.first { $0.id == currentBookUUID! }!)
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(BookData())
    }
}
