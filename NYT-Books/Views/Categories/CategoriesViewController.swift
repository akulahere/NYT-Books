//
//  CategoriesViewController.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 10.07.2023.
//

import UIKit

enum CategoriesViewControllerEvent {
    case displayBookList(String)
}

class CategoriesViewController: UIViewController, ErrorHandler  {
    private let viewModel: CategoriesViewModel
    var eventHandler: EventHandler<CategoriesViewControllerEvent>?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 96
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.id)
        return tableView
    }()
    
    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setUpViews()
        fetchCategories()
    }
    
    func setUpViews() {
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func fetchCategories() {
        Task {
            await MainActor.run {
                view.showSpinner()
            }
            await viewModel.getCategories()
        }
    }
}



extension CategoriesViewController: CategoriesViewModelDelegate {
    
    @MainActor
    func didUpdateCategories() {
        
        view.hideSpinner()
        tableView.reloadData()
    }
    
    @MainActor
    func didFailWithError(error: Error) {
        view.hideSpinner()
        present(error: error)
    }
}

extension CategoriesViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.id, for: indexPath) as! CategoryTableViewCell
        cell.configure(categoryName: viewModel.categories[indexPath.row].displayName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let encodedName = viewModel.categories[indexPath.row].listNameEncoded
        eventHandler?(.displayBookList(encodedName))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


