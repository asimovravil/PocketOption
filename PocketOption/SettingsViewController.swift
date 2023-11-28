//
//  SettingsViewController.swift
//  PocketOption
//
//  Created by Ravil on 28.11.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    let settingsImage = UIImageView()
    let notiBu = UIImageView()
    let shaBu = UIButton()
    let tarBu = UIButton()
    let acypBu = UIButton()
    let switchView = UISwitch(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor(red: CGFloat(0x1D) / 255.0, green: CGFloat(0x1F) / 255.0, blue: CGFloat(0x2F) / 255.0, alpha: 1.0)
        
        settingsImage.image = UIImage(named: "settings")
        settingsImage.layer.masksToBounds = true
        settingsImage.contentMode = .scaleAspectFit
        settingsImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsImage)
        
        notiBu.image = UIImage(named: "not")
        notiBu.layer.masksToBounds = true
        notiBu.contentMode = .scaleAspectFit
        notiBu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(notiBu)
        
        switchView.setOn(true, animated: true)
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.addTarget(self, action: #selector(switchTon(_:)), for: .valueChanged)
        view.addSubview(switchView)
        
        shaBu.setImage(UIImage(named: "sha"), for: .normal)
        shaBu.addTarget(self, action: #selector(shareOptionApp), for: .touchUpInside)
        shaBu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shaBu)
        
        tarBu.setImage(UIImage(named: "tar"), for: .normal)
        tarBu.addTarget(self, action: #selector(appNameOption), for: .touchUpInside)
        tarBu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tarBu)
        
        acypBu.setImage(UIImage(named: "acyp"), for: .normal)
        acypBu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(acypBu)
        
        if UIScreen.main.bounds.size.height >= 812 {
            NSLayoutConstraint.activate([
                settingsImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            ])
        } else {
            NSLayoutConstraint.activate([
                settingsImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            ])
        }
        
        NSLayoutConstraint.activate([
            settingsImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            notiBu.topAnchor.constraint(equalTo: settingsImage.bottomAnchor, constant: 24),
            notiBu.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            switchView.topAnchor.constraint(equalTo: notiBu.topAnchor, constant: 12),
            switchView.trailingAnchor.constraint(equalTo: notiBu.trailingAnchor, constant: -16),
            
            shaBu.topAnchor.constraint(equalTo: notiBu.bottomAnchor, constant: 16),
            shaBu.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            tarBu.topAnchor.constraint(equalTo: shaBu.bottomAnchor, constant: 16),
            tarBu.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            acypBu.topAnchor.constraint(equalTo: tarBu.bottomAnchor, constant: 16),
            acypBu.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func appNameOption() {
        let appName = "PocketOption"
        
        if let url = URL(string: "https://itunes.apple.com/search?term=\(appName)&entity=software") {
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let results = json["results"] as? [[String: Any]],
                           let firstResult = results.first,
                           let appID = firstResult["trackId"] as? Int {
                            self.appIDTracker(for: appID)
                        }
                    } catch {
                        print("JSON parsing error: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
    }
    
    private func appIDTracker(for appID: Int) {
        let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id\(appID)?action=write-review")!
        
        if UIApplication.shared.canOpenURL(appStoreURL) {
            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
        } else {
            print("Unable to open App Store URL")
        }
    }
    
    @objc private func shareOptionApp() {
        let textToShare = "Check out this awesome app!"
        let appURL = URL(string: "https://www.yourappstorelink.com")!
        
        let activityViewController = UIActivityViewController(activityItems: [textToShare, appURL], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func switchTon(_ sender : UISwitch){
        if sender.isOn {
            print("On")
        } else {
            print("No")
        }
    }
}
