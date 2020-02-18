//
//  SearchResultsWorker.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/15/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import Foundation

// Start request response binding from here
struct SearchAPIRequestResponse: RequestResponseInterface {
    typealias ResponseType = SearchResultModel
    let queryString: String
    
    var requestInfo: RequestObj {
        let endPointString = API.search(queryString).endPoint
        let requestData = RequestData.searchApi(endPointString)
        return requestData.payload
    }
}

struct MoviesWorker {
    func getMovieSearchResults(queryString: String, callBack: @escaping (_ response: SearchResultModel?, _ error: Error?) -> Void ) {
        let requestResponseModel = SearchAPIRequestResponse(queryString: queryString)
        
        NetworkManager.shared().getMovieSearchResults(request: requestResponseModel.requestInfo, successCallBack: { (responseData) in
            let responseModel = requestResponseModel.parseData(data: responseData )
           
                if let successModel = responseModel as? SearchResultModel {
                    callBack(successModel, nil)
                } else if let error = responseModel as? Error {
                    callBack(nil, error)
                }
        }, errorCallback: { (error) in
                callBack(nil, error)
        })
    }
}
