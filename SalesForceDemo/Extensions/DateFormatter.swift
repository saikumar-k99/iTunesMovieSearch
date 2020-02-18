//
//  DateFormatter.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/16/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let yearFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
