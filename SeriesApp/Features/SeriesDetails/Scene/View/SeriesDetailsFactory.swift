//
//  SeriesDetailsFactory.swift
//  SeriesApp
//
//  Created by Yuri Chaves on 02/06/22.
//

import Foundation
enum SeriesDetailsFactory {
    static func make(model: SeriesViewModel) -> SeriesDetailsViewController {
        let viewModel = SeriesDetailsViewModel(repository: SeriesDetailsRepository(), model: model)
        let viewController = SeriesDetailsViewController(seriesDetailsView: SeriesDetailsView(viewModel: viewModel), viewModel: viewModel)
        return viewController
    }
}
