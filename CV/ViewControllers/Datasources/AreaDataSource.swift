//
//  AreaDataSource.swift
//  CV
//
//  Created by Paolo Carollo on 07/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import Foundation
import UIKit

class AreaDatasource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private(set) var area: Area
    private(set) var dataService: DataService

    init(with area: Area) {
        self.area = area
        self.dataService = DataService(baseURL: Bundle.main.bundleURL)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return area.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return area.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return area.sections[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let row = area.sections[indexPath.section].rows[indexPath.row]
        
        switch row.type {
        case .description:
            return dequeRowTableViewCell(for: tableView, with: row, at: indexPath)
        case .image:
            return dequeImageTableViewCell(for: tableView, with: row, at: indexPath)
        case .email, .phone, .link:
            return dequeLinkTableViewCell(for: tableView, with: row, at: indexPath)
        case .variable:
            return dequeRowTableViewCellWithSubstitution(for: tableView, with: row, at: indexPath)
        }
        
    }
    
    //  MARK: -
    
    func registerCells(for tableView: UITableView) {
        
        tableView.register(UINib(nibName: "RowTableViewCell", bundle: Bundle(for: RowTableViewCell.classForCoder())), forCellReuseIdentifier: RowTableViewCell.ReuseIdentifier)
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: Bundle(for: ImageTableViewCell.classForCoder())), forCellReuseIdentifier: ImageTableViewCell.ReuseIdentifier)
        tableView.register(UINib(nibName: "LinkTableViewCell", bundle: Bundle(for: LinkTableViewCell.classForCoder())), forCellReuseIdentifier: LinkTableViewCell.ReuseIdentifier)
    }
    
    //  MARK: - Helpers
    
    private func dequeRowTableViewCell(for tableView: UITableView, with row: Row, at indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RowTableViewCell.ReuseIdentifier) as? RowTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.titleLabel.text = row.title.capitalized
        cell.detailLabel.text = row.details
        
        return cell
        
    }
    
    private func dequeImageTableViewCell(for tableView: UITableView, with row: Row, at indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.ReuseIdentifier) as? ImageTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.titleLabel.text = row.title.capitalized
        self.dataService.image(with: row.details) { (image) in
            guard let image = image else {
                return
            }
            
            DispatchQueue.main.async {
                
                cell.customImageView.image = image
                
            }
            
        }
        
        return cell
        
    }
    
    private func dequeLinkTableViewCell(for tableView: UITableView, with row: Row, at indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LinkTableViewCell.ReuseIdentifier) as? LinkTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = row.title
        cell.detailLabel.text = row.details
        cell.iconImageView.contentMode = .scaleAspectFit
        cell.iconImageView.image = UIImage(named: row.type.rawValue)
        return cell
    }
    
    private func dequeRowTableViewCellWithSubstitution(for tableView: UITableView, with row: Row, at indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RowTableViewCell.ReuseIdentifier) as? RowTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.titleLabel.text = row.title.capitalized
        cell.detailLabel.text = Bundle.main.infoDictionary?[row.details] as? String ?? ""
        
        return cell
        
    }
}
