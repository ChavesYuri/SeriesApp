
import Foundation
import UIKit

final class SeriesDetailsViewController: UIViewController, AlertDisplayer {

    private let seriesDetailsView: SeriesDetailViewProtocol
    private var viewModel: SeriesDetailsViewModelProtocol

    init(
        seriesDetailsView: SeriesDetailViewProtocol,
        viewModel: SeriesDetailsViewModelProtocol
    ) {
        self.seriesDetailsView = seriesDetailsView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        fetchSeriesList()
    }

    func fetchSeriesList() {
        viewModel.fetchDetails()
    }

    override func loadView() {
        super.loadView()
        view = seriesDetailsView
    }

    func bind() {
        viewModel.onSetupSeasons = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.seriesDetailsView.updateSeasons()
            }
        }

        viewModel.onLoading = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.seriesDetailsView.onLoading(isLoading: isLoading)
            }
        }

        viewModel.onOpenSeasonDetails = { [weak self] episode in
            self?.openEpisodeDetails(episode: episode)
        }
    }

    func openEpisodeDetails(episode: EpisodesCollectionCellViewModel) {
        let episodeView = EpisodeDetailsView(episodeModel: episode)
        let vc = EpisodeDetailsViewController(episodeDetailsView: episodeView)
        present(vc, animated: true, completion: nil)
    }
}
