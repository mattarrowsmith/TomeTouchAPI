import Vapor

// pull xml files from git repository, save locally?
struct BSDataService {
    let network: any NetworkProtocol

    init(network: any NetworkProtocol) {
        self.network = network
    }

    /// Gets all repositories listed by the BSData Github.
    /// Each repository corresponds to a game system.
    /// - Returns: The list of repository names.
    public func getGameSystems() async throws -> [String] {
        var repositories: [RepositoryDTO] = []
        var nextURL: URL? = try createInitalURL()

        while let url = nextURL {
            let request = try createRequest(url: url)
            let result = try await network.send(request)
            let responseDTO = try JSONDecoder().decode([RepositoryDTO].self, from: result.data ?? Data())
            nextURL = LinkHeaderParser.parse(from: result.httpResponse, relation: .next)
            repositories.append(contentsOf: responseDTO)
        }

        return repositories.map { $0.name }
    }

    private func createInitalURL() throws -> URL {
        guard let baseURL = Environment.get("REPO_SOURCE") else {
            throw BSDataServiceError.missingSourceConfig
        }

        guard let url = URL(string: baseURL)?.appending(path: "repos") else {
            throw BSDataServiceError.invalidURL(invalidURLString: baseURL)
        }

        return url
    }

    private func createRequest(url: URL) throws -> NetworkRequest {
        let headers = [
            "Accept": "application/vnd.github.v3+json",
        ]

        return NetworkRequest(url: url, as: .get, headers: headers)
    }

    enum BSDataServiceError: Error {
        case invalidURL(invalidURLString: String)
        case missingSourceConfig
    }
}
