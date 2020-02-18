//
//  RequestResponseModels.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/15/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import Foundation

let baseURL = "https://itunes.apple.com/search"

enum API {
    case search(String)
    
    var endPoint: String {
        switch self {
        case .search(let queryString):
            var endPoint = baseURL
            if let term = queryString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                endPoint = baseURL + "?media=movie&term=\(term)"
            }
            return endPoint
        }
    }
}

enum RequestData {
    case searchApi(String)
    
    var payload: RequestObj {
        switch self {
        case .searchApi(let endpoint):
            return RequestObj(endPoint: endpoint, httpMethod: .GET, headerParams: ["Content-Type": "application/json"], bodyParams: nil)
        }
    }
}

struct RequestObj {
    var endPoint: String
    var httpMethod: httpMethod = .GET
    var headerParams: [String: String]?
    var bodyParams: [String: Any]?
}

enum httpMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}


protocol RequestResponseInterface {
    associatedtype ResponseType: Codable
    var requestInfo: RequestObj { get }
}

extension RequestResponseInterface {
    func parseData(data: Data) -> Any {
        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.yearFormat)
            let result = try jsonDecoder.decode(ResponseType.self, from: data)

            return result

        } catch let error {
            return error
        }
    }
}
