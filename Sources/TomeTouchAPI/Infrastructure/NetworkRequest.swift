//
//  NetworkRequest.swift
//  TomeTouchAPI
//
//  Created by Arrowsmith, Matthew on 17/08/2025.
//

import Foundation

struct NetworkRequest {
    let url: URL
    let method: HTTPMethod

    init(url: URL, method: HTTPMethod) {
        self.url = url
        self.method = method
    }
}

enum HTTPMethod {
    case get
    case post
    case put
    case delete
    case patch
}
