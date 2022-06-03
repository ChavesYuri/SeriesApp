//
//  SeriesDetailsHeader.swift
//  SeriesApp
//
//  Created by Yuri Chaves on 02/06/22.
//

import Foundation
import UIKit
import Kingfisher

final class SeriesDetailsHeader: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addViewCodeSubviews(imageView, titleLabel, descriptionLabel)

        titleLabel
            .topAnchor(equalTo: topAnchor, constant: 12)
            .leadingAnchor(equalTo: leadingAnchor, constant: 8)
            .trailingAnchor(equalTo: trailingAnchor, constant: -8)

        imageView
            .topAnchor(equalTo: titleLabel.bottomAnchor)
            .leadingAnchor(equalTo: leadingAnchor, constant: 22)
            .trailingAnchor(equalTo: trailingAnchor, constant: -22)
            .heightAnchor(equalTo: 100)

        descriptionLabel
            .topAnchor(equalTo: imageView.bottomAnchor, constant: 12)
            .leadingAnchor(equalTo: leadingAnchor, constant: 8)
            .trailingAnchor(equalTo: trailingAnchor, constant: -8)
    }

    func configure(with viewModel: SeriesViewModel) {
        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.descriptionTime
        guard let url = URL(string: viewModel.image) else { return }
        imageView.kf.setImage(with: url)
    }
}
