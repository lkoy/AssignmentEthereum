//
//  RinkebyRequestDispatcher.swift
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

import Foundation
import Alamofire

class RinkebyRequestDispatcher: RequestDispatcher {
    
    @discardableResult
    override func dispatch<T>(request: Request, completion handler: @escaping ((Swift.Result<T, RequestDispatcher.DispatchError>) -> Void)) -> DispatchedRequest? where T: Decodable, T: Encodable {
        var newRequest = request
        newRequest.headers["AuthKey"] = RinkebyNetworkService.Config.apiKey
        
        return super.dispatch(request: newRequest, completion: handler)
        
    }
}
