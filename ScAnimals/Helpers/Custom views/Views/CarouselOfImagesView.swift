
import UIKit
import Kingfisher
import FirebaseDatabase

class CarouselOfImagesView: UICollectionView {

    var items: [String]? {
        didSet{
            pageIndicatorView.numberOfPages = items?.count ?? 0
            self.reloadData()
        }
    }

    private lazy var pageIndicatorView: UIPageControl = {
        let view = UIPageControl()
        view.currentPageIndicatorTintColor = #colorLiteral(red: 0.2745098039, green: 0.7411764706, blue: 0.2980392157, alpha: 1)
        view.pageIndicatorTintColor = .white
        view.currentPage = 0
        return view
    }()

    // MARK: Object lifecycle

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)

        build()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UICollectionViewDelegate

extension CarouselOfImagesView : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return .zero
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let newCurrentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageIndicatorView.currentPage = newCurrentPage
    }
}

// MARK: UICollectionViewDataSource

extension CarouselOfImagesView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let items = items {
            return Int(items.count)
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselViewCell.cellIdentifier(), for: indexPath) as? CarouselViewCell

        if let items = items {
            cell?.imageView.kf.indicatorType = .activity
            cell?.imageView.kf.setImage(with: URL.init(string: items[indexPath.row]))
        }

        return cell!
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension CarouselOfImagesView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.frame.size
    }
}

// MARK: Builds

private extension CarouselOfImagesView {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildServices()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2470588235, blue: 0.2823529412, alpha: 1)
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false

    
    }

    func buildLayouts() -> Void {

        insertSubview(pageIndicatorView, aboveSubview: self)
        pageIndicatorView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-7)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
        }
    }

    func buildServices() -> Void {

        self.delegate = self
        self.dataSource = self
        self.register(CarouselViewCell.self, forCellWithReuseIdentifier: CarouselViewCell.cellIdentifier())
    }
}
