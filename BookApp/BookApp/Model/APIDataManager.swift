//
//  APIDataManager.swift
//  BookApp
//
//  Created by SAMSUNG on 5/6/24.
//

import Foundation
import UIKit

private var apiKey: String {
    get {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("Couldn't find file 'Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "APIKey") as? String else {
            fatalError("Couldn't find key 'APIKey' in 'Info.plist'.")
        }
        return value
    }
}

class APIDataManager {
    
    static let shared = APIDataManager()
    private init() { }
    
    var Book: [Document] = []
//    var currentResult: BookData?
    
    let session = URLSession.shared

    func readAPI(keyword: String, completion: @escaping ([Document]?, Error?) -> Void) {
        if let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=\(keyword)") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = [
                "Authorization": "KakaoAK 077147e850a3f741950aa0476d39fe59"
            ]
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    completion(nil, error)
                    return
                } else if let data = data {
                    print(String(data: data, encoding: .utf8))
                }
                do {
                    let decoder = JSONDecoder()
                    let decodedResults = try decoder.decode(BookData.self, from: data!)
                    self.Book = decodedResults.documents
                    completion(decodedResults.documents, nil)
//                    self.currentResult = bookData
                } catch {
                    print("디코딩 에러: \(error)")
                    completion(nil, error)
                }
//                print("책 검색 결과", self.currentResult)
            }
            task.resume()
        }
    }
    
    func readImage(_ image: String, completion: @escaping (Data) -> Void) {
        if let url = URL(string: "http://search3.kakaocdn.net/argon?query=\(image)") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("\(error)")
                } else if let data = data {
                    completion(data)
                }
            }
            task.resume()
        }
    }
}

