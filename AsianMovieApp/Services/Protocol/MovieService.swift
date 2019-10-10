//
//  MovieService.swift
//  AsianMovieApp
//
//  Created by SourabhMehta on 09/10/19.
//  Copyright © 2019 SourabhMehta. All rights reserved.
//

import Foundation

public enum MovieHttpResponse<Value> {
    case success(Value)
    case failure(MovieError)
}

public enum MovieError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}
