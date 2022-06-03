import Foundation
import UIKit
import Kingfisher

protocol EpisodeDetailsViewProtocol: UIView {
    func configure()
}

final class EpisodeDetailsView: UIView, EpisodeDetailsViewProtocol {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = false
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private let seasonDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let model: EpisodesCollectionCellViewModel

    init(episodeModel: EpisodesCollectionCellViewModel) {
        self.model = episodeModel
        super.init(frame: CGRect.zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addViewCodeSubviews(scrollView)
        scrollView.addViewCodeSubviews(contentView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(seasonDescriptionLabel)
        stackView.addArrangedSubview(summaryLabel)
        stackView.addArrangedSubview(imageView)
        contentView.addViewCodeSubviews(stackView)

        scrollView
            .topAnchor(equalTo: topAnchor)
            .leadingAnchor(equalTo: leadingAnchor)
            .trailingAnchor(equalTo: trailingAnchor)
            .bottomAnchor(equalTo: bottomAnchor)

        contentView
            .topAnchor(equalTo: scrollView.topAnchor)
            .leadingAnchor(equalTo: scrollView.leadingAnchor)
            .trailingAnchor(equalTo: scrollView.trailingAnchor)
            .bottomAnchor(equalTo: scrollView.bottomAnchor)
            .widthAnchor(equalTo: scrollView.widthAnchor)

        stackView
            .topAnchor(equalTo: contentView.topAnchor, constant: 20)
            .leadingAnchor(equalTo: contentView.leadingAnchor)
            .trailingAnchor(equalTo: contentView.trailingAnchor)
            .bottomAnchor(lessThanOrEqualTo: bottomAnchor, constant: -20)
    }

    func configure() {
        titleLabel.text = model.title
        seasonDescriptionLabel.text = model.seasonDescription
        summaryLabel.text = model.summary.htmlToString
        guard let url = URL(string: model.image) else { return }
        imageView.kf.setImage(with: url)
    }

}
