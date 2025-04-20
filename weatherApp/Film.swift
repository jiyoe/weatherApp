//
//  Flims.swift
//  weatherApp
//
//  Created by jy on 4/4/25.
//

import Foundation

    struct Weather : Decodable {
        let location: location
        let current: Current
    }

    struct location : Decodable {
        let name: String
        let localtime: String
    }

    struct Current : Decodable {
        let temp_c: Double
        let humidity : Int
        let condition : Condition
    }

    struct Condition : Decodable {
        let text: String
        let icon: String
    }


