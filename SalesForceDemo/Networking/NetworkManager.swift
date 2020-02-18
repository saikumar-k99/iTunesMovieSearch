//
//  NetworkManager.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/15/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import Foundation

protocol SharedNetworkingInterface {
    typealias successCallback = (_ responseJson: Data) -> Void
    typealias failureCallback = (_ error: Error) -> Void
    //List of all the network API calls go here
    func getMovieSearchResults(request: RequestObj,
                                successCallBack: @escaping successCallback,
                                errorCallback: @escaping failureCallback)
}

enum Dispatcher {
    // we can add more sessions types here
    case urlSession
    
    func makeAPICall(request: RequestObj, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void) {
        switch self {
        case .urlSession:
            
            guard let url = URL(string: request.endPoint) else {
                return
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.httpMethod.rawValue
            
            do {
                if let params = request.bodyParams {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
                }
            } catch let error {
                onError(error)
                return
            }
            
            if let headers = request.headerParams {
                urlRequest.allHTTPHeaderFields = headers
            }
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    onError(error)
                    return
                }
                
                guard let _data = data else {
                    return
                }
                
                onSuccess(_data)
                }.resume()
           return
        }
    }
}

final class NetworkManager {
    private static var sharedInstanceInterface: SharedNetworkingInterface?
    private static var isMockMode = false
    
    private init() { }
    
    static func setMockMode(isEnabled: Bool) {
        isMockMode = isEnabled
    }
    
    static func shared() -> SharedNetworkingInterface {
        let realServiceHandler = RealServiceHandler(dispatcher: .urlSession)
        let mockServiceHandler = MockServiceHandler.init()
        
        return isMockMode ? mockServiceHandler : realServiceHandler
    }
}

struct RealServiceHandler: SharedNetworkingInterface {
    
    var dispatcher: Dispatcher?
    
    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
    }
    
    func getMovieSearchResults(request: RequestObj,
                                successCallBack: @escaping SharedNetworkingInterface.successCallback,
                                errorCallback: @escaping SharedNetworkingInterface.failureCallback) {
        
        dispatcher?.makeAPICall(request: request, onSuccess: successCallBack, onError: errorCallback)
    }
}

struct MockServiceHandler: SharedNetworkingInterface {
    func getMovieSearchResults(request: RequestObj, successCallBack: (Data) -> Void, errorCallback: (Error) -> Void) {
        // mock implementation here
    }
}
