//
//  DateFormatter+default.swift
//  BookLog
//
//  Created by Jay Lee on 2020/09/22.
//

import Foundation

extension DateFormatter {
    static var `default`: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter
    }()
}
