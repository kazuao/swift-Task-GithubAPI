//
//  RepositoryTableViewCell.swift
//  GithubApiTask
//
//  Created by Kazunori Aoki on 2021/06/08.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var starCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        starImageView.tintColor = .black
    }

}
