//
//  Network.swift
//  TomeTouchAPI
//
//  Created by Arrowsmith, Matthew on 17/08/2025.
//

import Foundation

struct NetworkResponse {
    let data: Data?
    let response: URLResponse?

    var httpResponse: HTTPURLResponse? {
        response as? HTTPURLResponse
    }
}
