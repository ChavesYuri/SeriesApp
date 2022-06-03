import Foundation
import UIKit

struct SeasonCellViewModel {
    let season: Int
    let episodes: [EpisodesCollectionCellViewModel]
}

protocol ReusableCell: AnyObject {
    func setup<ViewModel>(_ viewModel: ViewModel)
}

final class SeasonTableViewCell: UITableViewCell {

    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerReusableCell(EpisodeCollectionCell.self)
        return collectionView
    }()

    private var viewModel: SeasonCellViewModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollection()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollection() {
        contentView.addViewCodeSubviews(collectionView)

        collectionView
            .topAnchor(equalTo: contentView.topAnchor)
            .leadingAnchor(equalTo: contentView.leadingAnchor)
            .trailingAnchor(equalTo: contentView.trailingAnchor)
            .bottomAnchor(equalTo: contentView.bottomAnchor)

        selectionStyle = .none
    }
}

extension SeasonTableViewCell: ReusableCell {
    func setup<ViewModel>(_ viewModel: ViewModel) {
        guard let viewModel = viewModel as? SeasonCellViewModel else { return }
        self.viewModel = viewModel
        collectionView.reloadData()
    }
}

extension SeasonTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.episodes.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let episodes = viewModel?.episodes[indexPath.row] else {
            return UICollectionViewCell()
        }

        let cell: EpisodeCollectionCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.configure(with: episodes)
        return cell
    }
}

extension SeasonTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedEpisode = viewModel?.episodes[indexPath.item] else { return }
        selectedEpisode.action(selectedEpisode)
    }
}

extension SeasonTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 120, height: 140)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }
}
