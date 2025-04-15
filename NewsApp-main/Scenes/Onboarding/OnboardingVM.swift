//
//  OnboardingVM.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 31/03/25.
//
import UIKit
import Combine

class OnboardingVM {
        
    private let slidesSubject = CurrentValueSubject<[OnboardingSlider], Never>([])
    var slidesPublisher: AnyPublisher<[OnboardingSlider], Never> {
        slidesSubject.eraseToAnyPublisher()
    }
    
    private let currentPageSubject = CurrentValueSubject<Int, Never>(0)
    var currentPagePublisher: AnyPublisher<Int, Never> {
        currentPageSubject
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    var slides: [OnboardingSlider] {
        slidesSubject.value
    }
    
    var currentPage: Int {
        currentPageSubject.value
    }
    
    weak var coordinator: RegistrationFlowCoordinatorProtocol?
    
    init(coordinator: RegistrationFlowCoordinatorProtocol) {
        self.coordinator = coordinator
        setupData()
    }
    
    private func setupData() {
        let item1 = OnboardingSlider(
            image: "onboarding1",
            title: "onboarding_title1".localized(using: "Onboarding"),
            description: "onboarding_desc1".localized(using: "Onboarding")
        )

        let item2 = OnboardingSlider(
            image: "onboarding2",
            title: "onboarding_title2".localized(using: "Onboarding"),
            description: "onboarding_desc2".localized(using: "Onboarding")
        )

        let item3 = OnboardingSlider(
            image: "onboarding3",
            title: "onboarding_title3".localized(using: "Onboarding"),
            description: "onboarding_desc3".localized(using: "Onboarding")
        )
        
        let slides = [item1, item2, item3]
        slidesSubject.send(slides)
    }
    
    func updateCurrentPage(to newPage: Int) {
        currentPageSubject.send(newPage)
    }
    
    func nextButtonTapped() {
        if currentPage < slides.count - 1 {
            currentPageSubject.send(currentPage+1)
        } else {
            showSignin()
        }
    }
    
    func showSignin() {
        coordinator?.showSignIn()
    }
}
