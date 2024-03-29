//
//  APIClient.swift
//  MyContactApp
//
//  Created by SourabhMehta on 09/10/19.
//  Copyright © 2019 Sourabh. All rights reserved.
//

import Foundation

/**
 ### API client
 
 An API client for performing API requests
 */
public struct APIClient {
    
    /**
     Perform POST requests using the specified URL
     
     - parameter url:                The URL endpoint
     - parameter messageBody:        The dictionary with all data
     - parameter methodtype:         The type of method used like PUT, POST, GET
     - parameter completion:         Completion closure expression
     */
    static func request(from url: String,with messageBody : NSDictionary,methodType : String,
                     withCompletion completion: @escaping (MovieHttpResponse<Data>) -> Void) -> URLSessionDataTask? {
        guard let request = clientURLRequest(url,urlType: methodType,options: messageBody) else { return nil }
        return dataTask(for: request, withCompletion: completion)
    }

    
    /**
     Create the request using the specified URL
     
     - parameter url:                The URL endpoint
     - parameter options:            The dictionary with all data
     - parameter urlType:            The type of method used like PUT, POST, GET
     */
    
    fileprivate static func clientURLRequest(_ url: String,urlType : String,options : NSDictionary) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.Strings.applicationJson, forHTTPHeaderField: Constants.Strings.contentType)
        request.httpMethod = urlType
        /* Data */
        if let dataInput = options.object(forKey: Constants.Strings.DATA)
        {
            request.httpBody = try! JSONSerialization.data(withJSONObject:dataInput, options: [])
        }
        return request
    }
    
    /**
     Create the request using the specified URL
     
     - parameter request:            The URL request
     - parameter completion:         Completion closure expression
     */
    
    fileprivate static func dataTask(for request: URLRequest,
                                     withCompletion completion: @escaping (MovieHttpResponse<Data>) -> Void) -> URLSessionDataTask {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                completion(.failure(MovieError.apiError))
                return
            }
            
            guard let data = data else {
                completion(.failure(MovieError.noData))
                return
            }
                DispatchQueue.main.async(execute: {
                if let response = response as? HTTPURLResponse,
                200...299 ~= response.statusCode {
                completion(.success(data))
                }
                })
        }
        dataTask.resume()
        session.finishTasksAndInvalidate()
        return dataTask
    }
}
