//
//  NetworkRouter.swift
//  SeriesApp
//
//  Created by Yuri Chaves on 31/05/22.
//

import Foundation
enum NetworkRouter{

    case seriesList
    case seriesListPagination(page: Int)
    case seriesDetails(id: Int)

    var scheme: String {
        switch self {
        case .seriesList, .seriesListPagination, .seriesDetails:
            return "https"
        }
    }

    var host: String {
        switch self {
        case .seriesList, .seriesListPagination, .seriesDetails:
            return "api.tvmaze.com"
        }
    }

    var path: String {
        switch self {
        case .seriesList:
            return "/shows"
        case .seriesListPagination(let page):
            return "/shows/\(page)"
        case .seriesDetails(id: let id):
            return "/shows/\(id)/episodes"
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .seriesList, .seriesListPagination, .seriesDetails:
            return []
        }
    }

    var method: String {
        switch self {
        case .seriesList, .seriesListPagination, .seriesDetails:
            return "GET"
        }
    }
}
