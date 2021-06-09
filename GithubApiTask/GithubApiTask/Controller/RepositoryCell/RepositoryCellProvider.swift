//
//  RepositoryCellProvider.swift
//  GithubApiTask
//
//  Created by Kazunori Aoki on 2021/06/08.
//

import UIKit

class RepositoryCellProvider: NSObject {
    var repositoryCellItems: [Items]?
}

extension RepositoryCellProvider: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryCellItems?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell
                = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell",
                                                for: indexPath)
                as? RepositoryTableViewCell else {

            fatalError("cell is not found")
        }

        if let items = repositoryCellItems {
            cell.fullNameLabel.text = items[indexPath.row].fullName
            cell.starCountLabel.text = String(items[indexPath.row].stargazersCount ?? 0)
        }

        return cell
    }
}
