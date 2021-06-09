//
//  ViewController.swift
//  GithubApiTask
//
//  Created by Kazunori Aoki on 2021/06/08.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var repositoryTableView: UITableView!

    // MARK: - Properties
    private let provider = RepositoryCellProvider()

    private var tableViewItems: [Items]?
    private var loadStatus: LoadStatus = .initial

    private var pageNum = 1

    private enum LoadStatus {
        case initial
        case fetching
        case full
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        fetchRepositoryData()
    }

    // MARK: - Mehotd
    private func setup() {

        repositoryTableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil),
                                     forCellReuseIdentifier: "RepositoryTableViewCell")
        repositoryTableView.delegate = self
        repositoryTableView.dataSource = provider
    }

    @objc private func pullToRefresh(sender: UIRefreshControl) {
        pageNum = 1
        fetchRepositoryData()
    }

    private func fetchRepositoryData() {

        guard loadStatus == .initial else { return }

        loadStatus = .fetching

        startIndicator()

        NetworkingClient.fetchRepositoryData(pageNum: pageNum) { result in

            self.dismissIndicator()
            self.pageNum += 1

            switch result {
            case .success(let res):
                if let items = res.items, items.count != 0 {

                    if self.tableViewItems?.count == nil {
                        self.tableViewItems = items
                    } else {
                        self.tableViewItems?.append(contentsOf: items)
                    }

                    self.provider.repositoryCellItems = self.tableViewItems
                    self.repositoryTableView.reloadData()
                    self.loadStatus = .initial

                } else {
                    self.loadStatus = .full
                }

            case .failure(let error):
                self.loadStatus = .initial
                self.present(.okAlert(title: nil, message: error.localizedDescription))
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let path = tableViewItems?[indexPath.row].htmlUrl {
            let storyBoard = UIStoryboard(name: "WebView", bundle: nil)
            if let viewC = storyBoard.instantiateViewController(withIdentifier: "WebView") as? WebViewController {

                viewC.url = URL(string: path)

                present(viewC, animated: true, completion: nil)
            }
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            self.fetchRepositoryData()
        }
    }
}
