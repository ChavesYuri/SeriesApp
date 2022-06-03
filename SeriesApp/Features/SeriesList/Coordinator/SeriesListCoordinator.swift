import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func start()
}

protocol CoordinatorDelegate: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func addChild(coordinator: Coordinator)
    func removeChild(coordinator: Coordinator)
}

extension CoordinatorDelegate where Self: Coordinator {
    func addChild(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChild(coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
}


final class SeriesListCoordinator: Coordinator, CoordinatorDelegate {
    var childCoordinators: [Coordinator] = []
    let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    func start() {
        
    }
}
