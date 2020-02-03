import UIKit

public final class RegionView: UIView {

    public private(set) lazy var label: UILabel = {
        let l = UILabel()

        l.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        l.textColor = .label
        l.numberOfLines = 1
        l.lineBreakMode = .byTruncatingTail
        l.allowsDefaultTighteningForTruncation = true
        l.minimumScaleFactor = 0.7
        l.adjustsFontSizeToFitWidth = true
        l.translatesAutoresizingMaskIntoConstraints = false

        return l
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    public required init?(coder: NSCoder) {
        fatalError()
    }

    private func setup() {
        addSubview(label)

        clipsToBounds = true
        backgroundColor = .systemBackground
        layer.cornerRadius = 8
        layer.cornerCurve = .continuous
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1/UIScreen.main.scale

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}
