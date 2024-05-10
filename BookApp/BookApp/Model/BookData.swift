//
//  BookData.swift
//  BookApp
//
//  Created by SAMSUNG on 5/6/24.
//

import Foundation
import UIKit

struct BookData: Codable {
    let meta: Meta
    let documents: [Document]
}

struct Document: Codable {
//    let id: Int
    let title: String
    let contents: String
    let thumbnail: String
    let price: Int
    enum CodingKeys: String, CodingKey {
//        case id
        case title
        case contents
        case thumbnail
        case price
        
    }
}
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount =  "pageable_count"
        case totalCount = "total_count"
    }
}
