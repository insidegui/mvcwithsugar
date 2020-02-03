import UIKit

public final class MessageViewController: UIViewController {

    public init(message: String = "", showSpinner: Bool) {
        super.init(nibName: nil, bundle: nil)

        label.text = message
        spinner.isHidden = !showSpinner
    }

    public required init?(coder: NSCoder) {
        fatalError()
    }

    private lazy var spinner: UIActivityIndicatorView = {
        UIActivityIndicatorView(style: .medium)
    }()

    private lazy var label: UILabel = {
        let l = UILabel()

        l.textAlignment = .center
        l.numberOfLines = 0
        l.lineBreakMode = .byTruncatingTail
        l.allowsDefaultTighteningForTruncation = true
        l.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        l.textColor = .secondaryLabel

        return l
    }()

    private lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [self.spinner, self.label])

        v.axis = .vertical
        v.spacing = 2
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .green

        return v
    }()

    public override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        stackView.axis = .vertical
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !spinner.isHidden { spinner.startAnimating() }
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if !spinner.isHidden { spinner.stopAnimating() }
    }

}
