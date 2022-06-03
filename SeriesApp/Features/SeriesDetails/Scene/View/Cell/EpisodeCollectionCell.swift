import Foundation
import UIKit
import Kingfisher

struct EpisodesCollectionCellViewModel {
    let id: Int
    let title: String
    let image: String
    let summary: String
    let season: Int
    let number: Int
    let action: ((_ episode: EpisodesCollectionCellViewModel) -> Void)
    var seasonDescription: String {
        "Episode number \(number) of \(season) Season"
    }
}

final class EpisodeCollectionCell: UICollectionViewCell, Reusable {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let imageBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 4
        view.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.16
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTitleLabel() {
        contentView.addViewCodeSubviews(imageBackgroundView)
        imageBackgroundView.addViewCodeSubviews(imageView, titleLabel)

        imageBackgroundView
            .topAnchor(equalTo: contentView.topAnchor)
            .leadingAnchor(equalTo: contentView.leadingAnchor)
            .trailingAnchor(equalTo: contentView.trailingAnchor)
            .bottomAnchor(equalTo: contentView.bottomAnchor)

        imageView
            .topAnchor(equalTo: imageBackgroundView.topAnchor, constant: 6)
            .leadingAnchor(equalTo: imageBackgroundView.leadingAnchor, constant: 12)
            .trailingAnchor(equalTo: imageBackgroundView.trailingAnchor, constant: -12)
            .heightAnchor(equalTo: 60)
            .widthAnchor(equalTo: 24)

        titleLabel
            .topAnchor(equalTo: imageView.bottomAnchor, constant: 8)
            .leadingAnchor(equalTo: imageBackgroundView.leadingAnchor, constant: 8)
            .trailingAnchor(equalTo: imageBackgroundView.trailingAnchor, constant: -8)
            .bottomAnchor(equalTo: imageBackgroundView.bottomAnchor, constant: -12)
    }

    func configure(with viewModel: EpisodesCollectionCellViewModel) {
        titleLabel.text = viewModel.title
        guard let url = URL(string: viewModel.image) else { return }
        imageView.kf.setImage(with: url)
    }
}
