//
//  ConditionData.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import Foundation

struct ConditionData: Decodable {
    let text: String
    let icon: String

    var iconURL: URL? {
        if icon.starts(with: "//") {
            return URL(string: "https:\(icon)")
        } else if icon.starts(with: "http://") || icon.starts(with: "https://") {
            /// если вдруг вернется полный адрес
            return URL(string: icon)
        }
        return nil
    }
}
