//
//  Extension+Date.swift
//  SeriesApp
//
//  Created by Yuri Chaves on 02/06/22.
//

import Foundation
extension Date {
    func convertToStrUsingFormatLocal(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = .current
        return formatter.string(from: self)
    }

    func dateFromString(_ dateString: String, format: String? = nil) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format ?? "yyyy-MM-dd'T'HH:mm:ss-SSSS"
        formatter.timeZone = TimeZone(identifier: "UTC")
        if let date = formatter.date(from: dateString) {
            return date
        }
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS-SS"
        return formatter.date(from: dateString)
    }
}
