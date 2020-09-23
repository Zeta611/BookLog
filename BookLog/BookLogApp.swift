//
//  BookLogApp.swift
//  BookLog
//
//  Created by Jay Lee on 2020/09/22.
//

import SwiftUI

@main
struct BookLogApp: App {
    let bookData = BookData(books: (try? BookDataManager.shared.load()) ?? [])
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookData)
        }
    }
}
