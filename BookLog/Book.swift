//
//  Book.swift
//  BookLog
//
//  Created by Jay Lee on 2020/09/22.
//

import SwiftUI

// TODO: Create a ViewModel that corresponds to this Model
struct Book: Identifiable, Codable {
    var id = UUID()
    var title = ""
    var author = ""
    // TODO: Use an image name with a shared image store to remove dependency of SwiftUI
//    var image = Image(systemName: "books.closed.fill")
    var readingStartDate = Date()
    var readingFinishDate: Date?
}
