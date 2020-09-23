//
//  BookDataManager.swift
//  BookLog
//
//  Created by Jay Lee on 2020/09/23.
//

import Foundation

struct BookDataManager {
    static var shared = BookDataManager()

    private var fileURL: URL? {
        let fileManager = FileManager.default
        let urls = fileManager
            .urls(for: .documentDirectory, in: .userDomainMask)
        guard let url = urls.first else { return nil }
        return url
            .appendingPathComponent("book-data")
            .appendingPathExtension("json")
    }

    func load() throws -> [Book]? {
        guard let fileURL = fileURL else { return nil }
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([Book].self, from: data)
    }

    func save(books: [Book]) throws -> Bool {
        guard let fileURL = fileURL else { return false }
        let data = try JSONEncoder().encode(books)
        try data.write(to: fileURL, options: .atomicWrite)
        return true
    }

    private init() {}
}
