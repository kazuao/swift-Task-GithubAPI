//
//  RepositoryEntity.swift
//  GithubApiTask
//
//  Created by Kazunori Aoki on 2021/06/08.
//

import Foundation

struct RepositoryEntity: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Items]?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct Items: Codable {
    let repositoryId: Int?
    let fullName: String?
    let htmlUrl: String?
    let stargazersCount: Int?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case repositoryId = "id"
        case fullName = "full_name"
        case htmlUrl = "html_url"
        case stargazersCount = "stargazers_count"
        case language
    }
}
