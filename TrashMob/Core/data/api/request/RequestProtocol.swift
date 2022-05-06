//
//  RequestProtocol.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/4/22.
//

import Foundation

protocol RequestProtocol {
    // endpoint usually attached to end of base url
    var path: String { get }
    // request body
    var headers: [String:String] { get }
    var params: [String: Any] { get }
    // attach query params in the URL
    var urlParams: [String:String?] { get }
    // specifies whether your quest needs an auth token
    var addAuthorizationToken: Bool { get }
    // ensure all requests specify their type using RequestType
    var requestType: RequestType { get }
}

extension RequestProtocol {
    var host: String {
        APIConstants.host
    }
    var addAuthorizationToken: Bool {
        true
    }
    var params: [String: Any] {
        [:]
    }
    var urlParams: [String: String?] {
        [:]
    }
    var headers: [String: String] {
        [:]
    }
    
    // create request with auth token which throws an error in case of failures
    func createURLRequest(authToken: String) throws -> URLRequest {
        // base components of url
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        // add urlParams
        if !urlParams.isEmpty {
            components.queryItems = urlParams.map {
                URLQueryItem(name: $0, value: $1)
            }
        }
        
        guard let url = components.url
        else { throw NetworkError.invalidURL }
        
        // create an urlRequest using url defined above
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        // adds any headers to allHHTPHeaderFields
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        // add auth token if addAuthorizationToken is true
        if addAuthorizationToken {
            urlRequest.setValue(authToken, forHTTPHeaderField: "Authorization")
        }
        // set request content type to JSON
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // add params
        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        
        return urlRequest
    }
    
    
}
