//
//  EpisodeDetailsViewController.swift
//  SeriesApp
//
//  Created by Yuri Chaves on 02/06/22.
//

import Foundation
import UIKit
final class EpisodeDetailsViewController: UIViewController {

    let episodeDetailsView: EpisodeDetailsViewProtocol

    init(episodeDetailsView: EpisodeDetailsViewProtocol) {
        self.episodeDetailsView = episodeDetailsView
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        super.loadView()
        view = episodeDetailsView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeDetailsView.configure()
    }
}
