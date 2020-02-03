import UIKit

public final class RegionDetailViewController: UIViewController {

    public let region: Region

    public init(region: Region) {
        self.region = region

        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        fatalError()
    }

    private lazy var regionView: RegionView = {
        let v = RegionView()

        v.label.text = self.region.name
        v.translatesAutoresizingMaskIntoConstraints = false

        return v
    }()

    public override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(regionView)
        NSLayoutConstraint.activate([
            regionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            regionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            regionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
    }

}
