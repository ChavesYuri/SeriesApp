//
//  LoadingCell.swift
//  SeriesApp
//
//  Created by Yuri Chaves on 02/06/22.
//

import Foundation
import UIKit
final class LoadingCell: UITableViewCell {

    let progress: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView(style: .medium)
        progress.startAnimating()
        return progress
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }

    func setupView() {
        contentView.addViewCodeSubviews(progress)

        progress
            .centerXAnchor(equalTo: contentView.centerXAnchor)
            .centerYAnchor(equalTo: contentView.centerYAnchor)
            .topAnchor(equalTo: contentView.topAnchor, constant: 10)
            .bottomAnchor(equalTo: contentView.bottomAnchor, constant: -10)
            .heightAnchor(equalTo: 15)
            .widthAnchor(equalTo: 15)
    }

}
