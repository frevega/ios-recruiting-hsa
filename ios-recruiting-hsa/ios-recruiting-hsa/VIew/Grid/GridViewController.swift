//
//  GridViewController.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import UIKit

class GridViewController: BaseViewController {
    @IBOutlet
    weak var collectionView: UICollectionView!
    @IBOutlet
    weak var collectionViewBottom: NSLayoutConstraint!
    private let presenter: GridPresenter
    private let delegate: GridViewDelegate
    private let datasource: GridViewDataSource
    private let prefetchDataSource: GridViewPrefetchDataSource
    private let searchResultsDelegate: GridSearchResultsDelegate
    var movies: [MovieView] {
        return presenter.getMovies()
    }
    var localSearchedMovies: [MovieView] {
        return presenter.getLocalSearchedMovies()
    }
    var totalMovieCount: Int {
        return presenter.getTotalMovieCount()
    }
    var isSearchActive: Bool = false
    let searchController = UISearchController(searchResultsController: nil)
    
    init(presenter: GridPresenter,
         delegate: GridViewDelegate,
         datasource: GridViewDataSource,
         prefetchDataSource: GridViewPrefetchDataSource,
         searchControllerDelegate: GridSearchResultsDelegate
    ) {
        self.presenter = presenter
        self.delegate = delegate
        self.datasource = datasource
        self.prefetchDataSource = prefetchDataSource
        self.searchResultsDelegate = searchControllerDelegate
        super.init(nibName: String(describing: GridViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate.attach(view: self)
        datasource.attach(view: self)
        prefetchDataSource.attach(view: self)
        searchResultsDelegate.attach(view: self)
        presenter.attach(view: self)
        fetchPopularMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyBoardNotifications()
    }
    
    @objc
    func fetchPopularMovies() {
        presenter.popularMovies()
    }
    
    override func prepare() {
        super.prepare()
        prepareNavigationItem()
        prepareCollectionView()
        prepareCollectionViewCells()
        prepareRefreshControl()
        prepareSearchController()
        prepareKeyBoardToolbar()
    }
    
    private func prepareNavigationItem() {
        title = Constants.Labels.gridTitle
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func prepareCollectionView() {
        collectionView.delegate = delegate
        collectionView.dataSource = datasource
        collectionView.prefetchDataSource = prefetchDataSource
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func prepareCollectionViewCells() {
        let cellName = String(describing: MovieCollectionViewCell.self)
        collectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        let headerName = String(describing: UICollectionViewCell.self)
        collectionView.register(UINib(nibName: headerName, bundle: nil), forCellWithReuseIdentifier: headerName)
    }
    
    private func prepareRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(fetchPopularMovies), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    private func prepareSearchController() {
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = Constants.Colors.dark
        searchController.searchBar.barTintColor = Constants.Colors.brand
        searchController.searchResultsUpdater = searchResultsDelegate
        searchController.searchBar.delegate = searchResultsDelegate
    }
    
    private func prepareKeyBoardToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let hideButton = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(hideKeyboard))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, hideButton], animated: false)
        
        searchController.searchBar.inputAccessoryView = toolbar
    }
    
    @objc
    func hideKeyboard() {
        searchController.searchBar.endEditing(true)
    }
    
    func pushViewController(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func localSearchPopularMovies(text: String) {
        presenter.localSearchPopularMovies(text: text)
    }
}

extension GridViewController: GridView {
    func show(rows indexes: [IndexPath]?, shouldReload: Bool) {
        if (collectionView.refreshControl?.isRefreshing ?? false) {
            collectionView.refreshControl?.endRefreshing()
        }
        
        if shouldReload || isSearchActive || indexes == nil {
            collectionView.reloadData()
        } else if let indexes = indexes {
            let indexPathsToReload = visibleIndexPathsToReload(intersecting: indexes)
            collectionView.reloadItems(at: indexPathsToReload)
        }
    }
}

extension GridViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= movies.count
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = collectionView.indexPathsForVisibleItems
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

extension GridViewController {
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterKeyBoardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(notification: Notification) {
        let infoKey = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
        guard
            let keyboardHeight = (infoKey as? NSValue)?.cgRectValue.size.height,
            let tabBarHeight = self.tabBarController?.tabBar.frame.height else {
                return
        }
        
        animate(constant: keyboardHeight - tabBarHeight)
    }
    
    @objc
    func keyboardWillHide(notification: Notification) {
        animate(constant: 0)
    }
    
    private func animate(constant: CGFloat) {
        UIView.animate(withDuration: GridConstants.animationDuration, animations: {
            self.collectionViewBottom.constant = constant
            self.view.layoutIfNeeded()
        })
    }
}
