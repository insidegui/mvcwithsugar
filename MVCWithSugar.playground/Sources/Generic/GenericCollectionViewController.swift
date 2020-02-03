import UIKit

fileprivate func makeDefaultLayout() -> UICollectionViewFlowLayout {
    let l = UICollectionViewFlowLayout()
    let margin = CGFloat(16)

    l.scrollDirection = .vertical
    l.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
    l.minimumLineSpacing = 4
    l.sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: 0, right: 0)

    return l
}

public final class GenericCollectionViewController<V: UIView, C: ContainerCollectionViewCell<V>>: UICollectionViewController {

    public init(viewType: V.Type) {
        super.init(collectionViewLayout: makeDefaultLayout())
    }

    public required init?(coder: NSCoder) {
        fatalError()
    }

    public var numberOfItems: () -> Int = { 0 } {
        didSet {
            collectionView?.reloadData()
        }
    }

    public var configureView: (IndexPath, V) -> () = { _, _ in } {
        didSet {
            collectionView?.reloadData()
        }
    }

    public var didSelectView: (IndexPath, V) -> () = { _, _ in }

    public override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = .systemBackground
        collectionView?.register(C.self, forCellWithReuseIdentifier: "cell")
    }

    public override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfItems()
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? C else {
            fatalError("Unexpected cell type dequeued from collection view")
        }

        configureView(indexPath, cell.view)

        return cell
    }

    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? C else { return }

        didSelectView(indexPath, cell.view)
    }

}
