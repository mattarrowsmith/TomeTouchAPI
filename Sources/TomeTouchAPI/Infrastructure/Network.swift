import Foundation

protocol NetworkProtocol {
    func send(_ request: NetworkRequest) async throws -> NetworkResponse
}
struct Network: NetworkProtocol {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    public func send(_ request: NetworkRequest) async throws -> NetworkResponse {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.httpMethod.description

        let (data, response) = try await session.data(for: urlRequest)
        return NetworkResponse(data: data, response: response)
    }
}
