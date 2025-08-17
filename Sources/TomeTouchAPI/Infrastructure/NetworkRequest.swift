//
//  NetworkRequest.swift
//  TomeTouchAPI
//
//  Created by Arrowsmith, Matthew on 17/08/2025.
//

import Foundation

struct NetworkRequest {
    let url: URL
    let httpMethod: HTTPMethod

    init(url: URL, as method: HTTPMethod) {
        self.url = url
        self.httpMethod = method
    }
}

enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
    case patch

    var description: String {
        rawValue.uppercased()
    }
}
