import Foundation

struct LinkHeaderParser {
    enum LinkRelation: String {
        case prev
        case next
        case last
        case first
    }

    /// Extracts a URL from the `Link` header of an HTTP response that corresponds to a given relation.
    /// - Parameters:
    ///   - response: The HTTPURLResponse containing the headers.
    ///   - relation: The relation to look for (e.g., next, last).
    /// - Returns: A URL if a matching link is found, otherwise nil.
    /// Example link header:
    /// link: <https://api.github.com/repositories/1300192/issues?page=2>; rel="prev",
    /// <https://api.github.com/repositories/1300192/issues?page=4>; rel="next",
    /// <https://api.github.com/repositories/1300192/issues?page=515>; rel="last",
    /// <https://api.github.com/repositories/1300192/issues?page=1>; rel="first"
    static func parse(from response: HTTPURLResponse?, relation: LinkRelation) -> URL? {
        guard response != nil, let linkHeader = response?.value(forHTTPHeaderField: "Link") else {
            return nil
        }

        let links = linkHeader.split(separator: ",")
        let target = links.first { $0.contains(relation.rawValue) }

        // Select values within < >
        if let match = target?.firstMatch(of: /<([^>]+)>/) {
            let url = String(match.1)
            return URL(string: url)
        } else {
            return nil
        }
    }
}
