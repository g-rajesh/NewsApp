//
//  OnboardingVC.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 25/03/25.
//

import UIKit
import Combine
import Localize_Swift

final class OnboardingVC: UIViewController {
    
    private let onboardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let colllectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colllectionView.backgroundColor = .systemGray6
        colllectionView.isPagingEnabled = true
        colllectionView.showsHorizontalScrollIndicator = false
        colllectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return colllectionView
    }()

    private let onboardingPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .primary
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("next_button_title".localized(using: "Onboarding"), for: .normal)
        button.backgroundColor = .primary
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var subscriptions = Set<AnyCancellable>()
    // TODO: Move constants to separate file
    private let localizationTable = "Onboarding"
    private let viewModel: OnboardingVM
    
    init(viewModel: OnboardingVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureUI()
        binding()
    }

}

// MARK: OnboardingVC Functions
extension OnboardingVC {
    private func setupUI() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(onboardingCollectionView)
        view.addSubview(onboardingPageControl)
        view.addSubview(nextButton)
        
        onboardingCollectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
        
        onboardingPageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            // collectionView
            onboardingCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            onboardingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            
            // pageControl
            onboardingPageControl.topAnchor.constraint(equalTo: onboardingCollectionView.bottomAnchor, constant: 20),
            onboardingPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // nextButton
            nextButton.topAnchor.constraint(equalTo: onboardingPageControl.bottomAnchor, constant: 20),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        
    }
    
    private func binding() {
        viewModel.slidesPublisher
            .sink { [weak self] slides in
                guard let self else { return }
                
                self.onboardingCollectionView.reloadData()
                self.onboardingPageControl.numberOfPages = slides.count
            }
            .store(in: &subscriptions)
        
        viewModel.currentPagePublisher
            .sink { [weak self] page in
                guard let self else { return }
                
                self.onboardingPageControl.currentPage = page
                self.updateNextButtonTitle(for: page)
                
                guard let currentPage = getCurrentPage(of: self.onboardingCollectionView) else { return }
                if currentPage != page {
                    scrollToPage(page)
                }
                
            }
            .store(in: &subscriptions)
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        viewModel.updateCurrentPage(to: sender.currentPage)
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        viewModel.nextButtonTapped()
    }
    
    private func scrollToPage(_ page: Int) {
        let indexpath = IndexPath(item: page, section: 0)
        onboardingCollectionView.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
    }
    
    private func updateNextButtonTitle(for page: Int) {
        let title = (page == viewModel.slides.count - 1) ? "get_started_button_title" : "next_button_title"
        nextButton.setTitle(title.localized(using: localizationTable), for: .normal)
    }
    
    private func getCurrentPage(of scrollView: UIScrollView) -> Int? {
        let offset = scrollView.contentOffset.x
        let width = scrollView.frame.width
        
        guard width > 0 else { return nil }
        
        return Int(offset / width)
    }
}

// MARK: Collection View Delegate and Data Source Methods
extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: viewModel.slides[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let newPage = getCurrentPage(of: scrollView) else { return }
        viewModel.updateCurrentPage(to: newPage)
    }
}
