//
//  AreaViewController.swift
//  CV
//
//  Created by Paolo Carollo on 07/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import UIKit
import MessageUI

class AreaViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var areaDatasource: AreaDatasource
    
    init(areaDatasource: AreaDatasource) {
        self.areaDatasource = areaDatasource
        super.init(nibName: "AreaViewController", bundle: Bundle(for: AreaViewController.classForCoder()))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //  Register cells
        areaDatasource.registerCells(for: tableView)
        tableView.dataSource = areaDatasource
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AreaViewController: UITableViewDelegate, MFMailComposeViewControllerDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = tableView.dataSource as? AreaDatasource else {
            return 0
        }
        
        let row = datasource.area.sections[indexPath.section].rows[indexPath.row]
        switch row.type {
        case .image:
            return 100.0
        default:
            return 65.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let datasource = tableView.dataSource as? AreaDatasource else {
            return
        }
        
        let row = datasource.area.sections[indexPath.section].rows[indexPath.row]
        switch row.type {
        case .email:
            handleMailTo(with: row.details)
        case .phone:
            handlePhone(with: row.details)
        case .link:
            handleLink(with: row.details)
        default:
            break
        }
        
    }
    
    //  MARK: - LINK
    
    private func handleLink(with string: String) {
        
        let urlString = normalizeHttpsURLString(string: string)
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
    
    private func normalizeHttpsURLString(string: String) -> String {
        
        if string.hasPrefix("https") {
            return string
        }
        
        return "https://\(string)"
        
    }
    
    //  MARK: - TEL
    
    private func handlePhone(with string: String) {
        
        let urlString = "tel://\(string)".replacingOccurrences(of: " ", with: "")
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
    
    //  MARK: - EMAIL
    
    private func handleMailTo(with string: String) {
        
        guard MFMailComposeViewController.canSendMail() else {
            print("Mail services are not available")
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients([string])
        composeVC.setSubject("Moew from the other side")
        composeVC.setMessageBody(NSLocalizedString("AreaViewController.mail.message.text", comment: ""), isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)

        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
