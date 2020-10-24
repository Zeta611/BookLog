//
//  UUID+RawRepresentable.swift
//  BookLog
//
//  Created by Jay Lee on 2020/10/25.
//

import Foundation

// Needed for UUID? to work with SceneStorage.
extension Optional: RawRepresentable where Wrapped == UUID {
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return ""
        }
        return result
    }

    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(UUID?.self, from: data)
        else {
            return nil
        }
        self = result
    }
}
