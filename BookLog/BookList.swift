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
    @SceneStorage("currentBookUUID") private var currentBookUUID: UUID? = nil

    @State private var editMode = EditMode.inactive

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
            .navigationTitle("Book Log")
            .navigationBarItems(
                leading: Button() {
                    let newBook = Book()
                    bookData.books.append(newBook)
                    currentBookUUID = newBook.id
                } label: {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                },
                trailing: Button {
                    switch editMode {
                    case .active: editMode = .inactive
                    case .inactive: editMode = .active
                    default: break
                    }
                } label: {
                    if let isEditing = editMode.isEditing, isEditing {
                        Text("Done")
                    } else {
                        Text("Edit")
                    }
                }
            )
            .environment(
                \.editMode,
                Binding(get: { editMode }, set: { editMode = $0 })
            )
            .animation(.spring(response: 0))
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

struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        BookList()
            .environmentObject(BookData())
    }
}
