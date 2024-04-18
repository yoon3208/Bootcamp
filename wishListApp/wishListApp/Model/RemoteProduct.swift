//
//  RemoteProduct.swift
//  wishListApp
//
//  Created by SAMSUNG on 2024/04/12.
//

import Foundation

struct RemoteProduct: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: URL
    
    var priceKor: Int {
        return Int(price) * 1200
    }
}

