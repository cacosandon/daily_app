//
//  Structs.swift
//  Dailys
//
//  Created by Caco Ossandon on 01-11-21.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation

struct DolarData: Decodable {
    let cp: Double
    let variacion_porcentual: Double
}

struct BipData: Decodable {
    let balance: Double
}

struct BitcoinData: Decodable {
    let ticker: BitcoinParams
}

struct BitcoinParams: Decodable {
    let last_price: [String]
    let price_variation_24h: String
}

struct CovidData: Decodable {
    let data: [[[String]]]
}

struct CovidStats {
    var value: Double
    var variation: Double
}

