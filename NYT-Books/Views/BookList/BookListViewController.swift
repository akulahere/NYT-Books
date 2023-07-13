//
//  BookListViewController.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 13.07.2023.
//

import UIKit

class BookListViewController: UIViewController, BooksListViewModelDelegate, ErrorHandler {
    
    var viewModel: BookListViewModel
    var eventHandler: EventHandler?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 200
        tableView.register(BookListTableViewCell.self, forCellReuseIdentifier: BookListTableViewCell.id)
        return tableView
    }()
    
    
    
    
    init(viewModel: BookListViewModel) {
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
        fetchBooks()
        self.navigationItem.title = viewModel.categoryName
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
    
    private func fetchBooks() {
        DispatchQueue.main.async { [weak self] in
            self?.view.showSpinner()
        }
        Task {
            await viewModel.getBooks()
        }
    }
    
    func didUpdateBooks() {
        DispatchQueue.main.async { [weak self] in
            self?.view.hideSpinner()
            self?.tableView.reloadData()
        }
    }

    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.view.hideSpinner()
            self?.present(error: error)
        }
    }
}


extension BookListViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookListTableViewCell.id, for: indexPath) as! BookListTableViewCell
        let book = viewModel.books[indexPath.row]
        let bookVM = BookCellViewModel(book: book, networkService: viewModel.networkService)
        cell.delegate = self
        Task {
            await cell.configure(with: bookVM)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension  BookListViewController: BookListTableViewCellDelegate {
    func didTapBuyButton(url: URL) {
        eventHandler?(.displayWebPage(url))
    }
}
