//
//  ViewController.swift
//  TCS_Coding_Test_NewsApp
//
//  Created by Charmy on 4/3/22.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private var articles = [Articles]()
    private var viewModels = [NewsCellViewModel]()
    
    var limit = 6
    var totalEntries = 0
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
         
        title = "Trending News"
        view.backgroundColor = .black
        
        view.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        
        //Add Pull to refresh
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
        
        //Check for internet connectivity
        let internetAvailability = InternetAvailableValidation()
        print(internetAvailability.isInternetAvailable())
        if internetAvailability.isInternetAvailable(){
            self.getData()
        }else{
            let alertDialogue = UIAlertController(title: "Kindly connect to the internet", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            alertDialogue.addAction(okAction)
            self.present(alertDialogue, animated: true, completion: nil)
        }
    }
    
    func getData(){
        
            NewsAPICall.shared.getTrendingNews { (result) in
                switch result{
                case .success(let articles):
                    
                    self.articles = articles
                    self.totalEntries = articles.count
                    
//                    print("Total Entries : \(self.totalEntries)")
                    
                    if self.limit < self.totalEntries{
                        var index = 0
                        while index < self.limit {
                            let newsCellViewModel = NewsCellViewModel(title: articles[index].title, subTitle: (articles[index].description ?? "Not given"), imageURL: URL(string : articles[index].urlToImage ?? ""))
                            self.viewModels.append(newsCellViewModel)
                            index += 1
                        }
                        
                    }else{
                        self.viewModels = articles.compactMap({
                            NewsCellViewModel(
                                title: $0.title,
                                subTitle: $0.description ?? "Not given",
                                imageURL: URL(string: $0.urlToImage ?? "")
                            )
                        })
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.refreshControl?.endRefreshing()
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
    
    @objc func callPullToRefresh(){
        self.getData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pos = scrollView.contentOffset.y
        if pos > tableView.contentSize.height-50 - scrollView.frame.size.height{
            if viewModels.count < totalEntries{
                // for some pending records
                var index = viewModels.count
                limit = index + limit
                while (index < limit && index < totalEntries) {
                    let newsCellViewModel = NewsCellViewModel(title: articles[index].title, subTitle: (articles[index].description ?? "Not given"), imageURL: URL(string : articles[index].urlToImage ?? ""))
                    self.viewModels.append(newsCellViewModel)
                    index += 1
                }
                self.perform(#selector(loadTable),with: nil,afterDelay: 1.0)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell
        else{
            fatalError()
        }
        
        cell.configure(with: viewModels[indexPath.row])
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ?? "") else{
            return
        }
        
        let vc = SFSafariViewController(url: url)
        self.present(vc, animated: true)
    }
    
    @objc func loadTable(){
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

