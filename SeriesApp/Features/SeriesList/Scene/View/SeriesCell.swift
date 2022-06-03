//
//  SeriesCell.swift
//  SeriesApp
//
//  Created by Yuri Chaves on 02/06/22.
//

import Foundation
import UIKit
import Kingfisher

final class SeriesCell: UITableViewCell {

    let roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 4
        view.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.16
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()

    let summaryLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .justified
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()

    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addViewCodeSubviews(roundedView)
        roundedView.addViewCodeSubviews(titleLabel, summaryLabel, image)

        roundedView
            .topAnchor(equalTo: topAnchor, constant: 4)
            .leadingAnchor(equalTo: leadingAnchor, constant: 12)
            .trailingAnchor(equalTo: trailingAnchor, constant: -12)
            .bottomAnchor(equalTo: bottomAnchor, constant: -4)

        titleLabel
            .topAnchor(equalTo: roundedView.topAnchor, constant: 8)
            .leadingAnchor(equalTo: image.trailingAnchor, constant: 12)
            .trailingAnchor(equalTo: roundedView.trailingAnchor, constant: -12)

        summaryLabel
            .topAnchor(equalTo: titleLabel.bottomAnchor, constant: 4)
            .leadingAnchor(equalTo: titleLabel.leadingAnchor)
            .trailingAnchor(equalTo: titleLabel.trailingAnchor)
            .bottomAnchor(equalTo: image.bottomAnchor)

        image
            .topAnchor(equalTo: titleLabel.topAnchor, constant: 12)
            .leadingAnchor(equalTo: roundedView.leadingAnchor, constant: 12)
            .widthAnchor(equalTo: 50)
            .heightAnchor(equalTo: 80)
            .bottomAnchor(equalTo: roundedView.bottomAnchor, constant: -12)

        selectionStyle = .none
        backgroundColor = .systemBackground
    }

    func configure(viewModel: SeriesViewModel) {
        titleLabel.text = viewModel.name
        summaryLabel.text = viewModel.summary.htmlToString
        guard let url = URL(string: viewModel.image) else { return }
        image.kf.setImage(with: url)
    }
}
