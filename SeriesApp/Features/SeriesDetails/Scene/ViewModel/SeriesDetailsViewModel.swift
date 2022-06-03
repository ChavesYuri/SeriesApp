import Foundation

protocol SeriesDetailsViewModelProtocol {
    func fetchDetails()
    var onSetupSeasons: (() -> Void)? { get set }
    var onLoading: ((_ isLoading: Bool) -> Void)? { get set }
    var onError: ((_ message: String) -> Void)? { get set }
    var onOpenSeasonDetails: ((_ model: EpisodesCollectionCellViewModel) -> Void)? { get set }
    var seasons: [SeasonCellViewModel] { get set }
    var model: SeriesViewModel { get }
}

final class SeriesDetailsViewModel: SeriesDetailsViewModelProtocol {

    var model: SeriesViewModel
    let repository: SeriesDetailsRepositoryProtocol

    var seasons: [SeasonCellViewModel] = [] {
        didSet {
            onSetupSeasons?()
        }
    }

    var onSetupSeasons: (() -> Void)?
    var onLoading: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    var onOpenSeasonDetails: ((_ model: EpisodesCollectionCellViewModel) -> Void)?

    init(repository: SeriesDetailsRepositoryProtocol, model: SeriesViewModel) {
        self.repository = repository
        self.model = model
    }

    func fetchDetails() {
        onLoading?(true)
        repository.fetchDetails(id: model.id) { [weak self] result in
            switch result {
            case .success(let episodes):
                self?.setupSeasons(episodes: episodes)
            case .failure:
                self?.onError?("An error occurred while fetching the information")
            }
            self?.onLoading?(false)
        }
    }

    func setupSeasons(episodes: Episodes) {
        let dictionary = Dictionary(grouping: episodes) { $0.season }.sorted(by: { $0.key < $1.key })
        let seasons = dictionary.map({
            SeasonCellViewModel(
                season: $0.key,
                episodes: $0.value.map({
                    EpisodesCollectionCellViewModel(
                        id: $0.id,
                        title: $0.name,
                        image: $0.image.medium,
                        summary: $0.summary,
                        season: $0.season,
                        number: $0.number
                    ) { [weak self] episode in
                        self?.didTapOnEpisode(episode: episode)
                    }
                })
            )}
        )
        self.seasons = seasons
    }

    func didTapOnEpisode(episode: EpisodesCollectionCellViewModel) {
        onOpenSeasonDetails?(episode)
    }
}
