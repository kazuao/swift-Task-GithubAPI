//
//  URLs.swift
//  GithubApiTask
//
//  Created by Kazunori Aoki on 2021/06/08.
//

import Foundation
import Alamofire

class URLs {
    static var headers: HTTPHeaders {
        return [
            "Accept": "application/vnd.github.v3+json"
        ]
    }
    static let baseUrl = "https://api.github.com"
    static let searchUrl = "/search/repositories"
}
