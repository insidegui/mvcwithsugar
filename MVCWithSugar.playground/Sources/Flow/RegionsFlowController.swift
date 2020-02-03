import UIKit

public final class RegionsFlowController: UIViewController {

    private typealias RegionsCollectionController = GenericCollectionViewController<RegionView, ContainerCollectionViewCell<RegionView>>

    private lazy var ownedNavigationController: UINavigationController = {
        UINavigationController(rootViewController: self.stateController)
    }()

    private lazy var stateController: StateViewController = {
        let c = StateViewController()
        c.title = "Regions"
        return c
    }()

    private lazy var regionsCollectionController: RegionsCollectionController = {
        let c = RegionsCollectionController(viewType: RegionView.self)

        c.numberOfItems = { regions.count }
        c.configureView = { $1.label.text = regions[$0.item].name }
        c.didSelectView = { [weak self] indexPath, _ in
            self?.showDetail(for: regions[indexPath.item])
        }

        return c
    }()

    private func loadRegions() {
        stateController.state = .loading(message: "Loading regions")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.stateController.state = .content(controller: self.regionsCollectionController)
        }
    }

    public override func loadView() {
        view = UIView()
        install(ownedNavigationController)
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        loadRegions()
    }

    private func showDetail(for region: Region) {
        let controller = RegionDetailViewController(region: region)
        controller.title = "Region Detail"
        ownedNavigationController.pushViewController(controller, animated: true)
    }

}
