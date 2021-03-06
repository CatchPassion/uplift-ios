//
//  HomeViewController.swift
//  Uplift
//
//  Created by Kevin Chan on 5/19/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import Alamofire
import AppDevAnnouncements
import Crashlytics
import SkeletonView
import SnapKit
import UIKit

class HomeViewController: UIViewController {

    // MARK: - Private view vars
    private var collectionView: UICollectionView!
    private let headerView = HomeScreenHeaderView()
    private let loadingHeader = LoadingHeaderView(frame: .zero)
    private var loadingScrollView: LoadingScrollView!

    // MARK: - Public data vars
    var myGyms: [Gym] = []
    var gymClassInstances: [GymClassInstance] = []
    var gyms: [Gym] = []
    var habits: [Habit] = []
    var lookingForCategories: [Tag] = []
    var sections: [SectionType] = []

    // MARK: - Private data vars
    private var gymLocations: [Int: String] = [:]
    private var numPendingNetworkRequests = 0

    enum Constants {
        static let checkInsListCellIdentifier = "checkInsListCellIdentifier"
        static let gymEquipmentListCellIdentifier = "gymEquipmentListCellIdentifier"
        static let gymsListCellIdentifier = "gymsListCellIdentifier"
        static let lookingForListCellIdentifier = "lookingForListCellIdentifier"
        static let todaysClassesListCellIdentifier = "todaysClassesListCellIdentifier"
        static let todaysClassesEmptyCellIdentifier = "todaysClassesEmptyCellIdentifier"
    }

    // MARK: - Enums
    enum SectionType: String {
        case checkIns = "DAILY CHECK-INS"
        case myGyms = "MY GYMS"
        case todaysClasses = "TODAY'S CLASSES"
        case lookingFor = "I'M LOOKING FOR..."
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [.myGyms, .todaysClasses, .lookingFor]

        view.backgroundColor = UIColor.primaryWhite

        setupViews()
        setupConstraints()

        // Get Habits
        habits = Habit.getActiveHabits()
        // Reload Daily Check Ins section
        collectionView.reloadSections(IndexSet(integer: 0))

        // Get Gyms
        numPendingNetworkRequests += 1
        NetworkManager.shared.getGyms { gyms in
            self.gyms = gyms.sorted { $0.isOpen && !$1.isOpen }

            let gymNames = UserDefaults.standard.stringArray(forKey: Identifiers.favoriteGyms) ?? []
            self.updateFavorites(favorites: gymNames)

            // Reload All Gyms section
            self.collectionView.reloadSections(IndexSet(integer: 0))

            self.decrementNumPendingNetworkRequests()
        }

        // Get Today's Classes
        let stringDate = Date.getNowString()
        numPendingNetworkRequests += 1
        NetworkManager.shared.getGymClassesForDate(date: stringDate, completion: { (gymClassInstances) in
            self.gymClassInstances = gymClassInstances.sorted { (first, second) in
                return first.startTime < second.startTime
            }

            // Reload Today's Classes section
            self.collectionView.reloadSections(IndexSet(integer: 1))

            self.decrementNumPendingNetworkRequests()
        })

        numPendingNetworkRequests += 1
        NetworkManager.shared.getTags(completion: { tags in
            self.lookingForCategories = tags
            self.collectionView.reloadSections(IndexSet(integer: 2))

            self.decrementNumPendingNetworkRequests()
        })

        presentAnnouncement(completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = false

        let newHabits = Habit.getActiveHabits()
        if habits != newHabits {
            habits = newHabits
            collectionView.reloadSections(IndexSet(integer: 0))
        }
    }

    func decrementNumPendingNetworkRequests() {
        self.numPendingNetworkRequests -= 1
        if self.numPendingNetworkRequests == 0 {
            self.loadingHeader.isHidden = true
            self.loadingScrollView.isHidden = true
        }
    }
}

// MARK: - Layout
extension HomeViewController {

    private func setupViews() {
        headerView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        headerView.layer.shadowOpacity = 0.4
        headerView.layer.shadowRadius = 10.0
        headerView.layer.shadowColor = UIColor.buttonShadow.cgColor
        headerView.layer.masksToBounds = false

        view.addSubview(headerView)

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 6.0
        flowLayout.minimumLineSpacing = 12.0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsets(top: 11, left: 0, bottom: 0, right: 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.delaysContentTouches = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.zPosition = -1
        collectionView.register(HomeSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeSectionHeaderView.identifier)
        collectionView.register(CheckInsListCell.self, forCellWithReuseIdentifier: Constants.checkInsListCellIdentifier)
        collectionView.register(GymsListCell.self, forCellWithReuseIdentifier: Constants.gymsListCellIdentifier)
        collectionView.register(TodaysClassesListCell.self, forCellWithReuseIdentifier: Constants.todaysClassesListCellIdentifier)
        collectionView.register(TodaysClassesEmptyCell.self, forCellWithReuseIdentifier: Constants.todaysClassesEmptyCellIdentifier)
        collectionView.register(LookingForListCell.self, forCellWithReuseIdentifier: Constants.lookingForListCellIdentifier)
        view.addSubview(collectionView)

        view.addSubview(loadingHeader)

        loadingScrollView = LoadingScrollView(frame: .zero, collectionViewWidth: view.bounds.width)
        view.addSubview(loadingScrollView)
    }

    private func setupConstraints() {
        let headerViewHeight = 120

        headerView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(headerViewHeight)
        }

        collectionView.snp.makeConstraints { make in
            make.centerX.width.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }

        loadingHeader.snp.makeConstraints { make in
            make.edges.equalTo(headerView)
        }

        loadingScrollView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
    }

}
