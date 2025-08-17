import Vapor

// pull xml files from git repository, save locally?
struct BSDataService {
    let network: any NetworkProtocol

    init(network: any NetworkProtocol) {
        self.network = network
    }

    public func getGameSystems() async throws -> [String] {
        //form up url pull base from config
        guard let baseURL = Environment.get("REPO_SOURCE") else {
            throw BSDataServiceError.missingSourceConfig
        }

        guard let url = URL(string: baseURL)?.appending(path: "repos") else {
            throw BSDataServiceError.invalidURL(invalidURLString: baseURL)
        }

        let headers = [
            "Accept": "application/vnd.github.v3+json",
        ]

        let request = NetworkRequest(url: url, as: .get, headers: headers)
        let response = try await network.send(request)

        let responseDTO = try JSONDecoder().decode([RepositoryDTO].self, from: response.data ?? Data())
        return responseDTO.map { $0.name }
    }

    enum BSDataServiceError: Error {
        case invalidURL(invalidURLString: String)
        case missingSourceConfig
    }
}
