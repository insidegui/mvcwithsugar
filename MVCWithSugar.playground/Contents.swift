import UIKit
import PlaygroundSupport

// CONTAINER

func loadContent(with completion: @escaping (Result<[String], Error>) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        completion(.success([]))
    }
}

final class ContentViewController: UIViewController {
    init(content: [String]) {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

let stateController = StateViewController()
stateController.title = "Container"

loadContent { result in
    switch result {
    case .success(let content):
        if content.isEmpty {
            stateController.state = .empty(message: "There is no content here, this is an empty message.")
        } else {
            stateController.state = .content(controller: ContentViewController(content: content))
        }
    case .failure(let error):
        stateController.state = .error(message: error.localizedDescription)
    }
}

// GENERIC CONTROLLER

let genericController = GenericCollectionViewController(viewType: RegionView.self)

genericController.numberOfItems = { regions.count }
genericController.configureView = { $1.label.text = regions[$0.item].name }
genericController.didSelectView = { i, _ in print(regions[i.item]) }
genericController.title = "Generic"

// FLOW CONTROLLER

let flowController = RegionsFlowController()
flowController.title = "Flow"

let tabController = UITabBarController()

tabController.setViewControllers([stateController, genericController, flowController], animated: false)

PlaygroundPage.current.liveView = tabController
