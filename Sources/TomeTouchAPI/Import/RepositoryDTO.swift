struct RepositoryDTO: Codable {
    let name: String
    let htmlURL: String
    let description: String?

    enum CodingKeys: String, CodingKey {
        case name
        case htmlURL = "html_url"
        case description
    }
}
