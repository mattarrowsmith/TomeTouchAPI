import Vapor

// pull xml files from git repository, save locally?
struct BSDataService {
    func getGameSystems() throws -> [String] {
        //form up url pull base from config
        guard let baseURL = Environment.get("REPO_SOURCE") else {
            throw BSDataServiceError.missingSourceConfig
        }

        guard let url = URL(string: "https://example.com/gamesystems.xml") else {
            throw BSDataServiceError.invalidURL
        }

        let NetworkRequest = NetworkRequest(url: url, as: .get)

        return []
    }


    enum BSDataServiceError: Error {
        case invalidURL
        case missingSourceConfig
    }
}
