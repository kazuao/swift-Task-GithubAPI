//
//  NetworkingClient.swift
//  GithubApiTask
//
//  Created by Kazunori Aoki on 2021/06/08.
//

import Foundation
import Alamofire

class NetworkingClient {

    static func fetchRepositoryData(pageNum: Int = 1,
                                    completion: @escaping (_ result: Result<RepositoryEntity, Error>) -> Void) {

        var requestUrl: URL?

        let callSwift = "language:Swift"
        let star      = "stargazers_count"
        let order     = "desc"

        let baseUrl: URL = URL(string: URLs.baseUrl + URLs.searchUrl)!

        if var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: baseUrl.baseURL != nil) {
            components.queryItems = [URLQueryItem(name: "q", value: callSwift),
                                     URLQueryItem(name: "sort", value: star),
                                     URLQueryItem(name: "order", value: order),
                                     URLQueryItem(name: "per_page", value: "50"),
                                     URLQueryItem(name: "page", value: String(pageNum))]
            requestUrl = components.url

        } else {
            requestUrl = baseUrl
        }

        AF.request(requestUrl!,
                   method: .get,
                   headers: URLs.headers).responseJSON { (response) in

                    switch response.result {
                    case .success:
                        if let data = response.data {
                            do {
                                let result = try JSONDecoder().decode(RepositoryEntity.self, from: data)
                                return completion(.success(result))

                            } catch let error {
                                print(error)
                                fatalError()
                            }
                        }

                    case .failure(let error):
                        print(error)
                        return completion(.failure(error))
                    }
                   }
    }
}
