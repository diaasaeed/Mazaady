//
//  LanguageVC.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 13/04/2025.
//

import UIKit
import RxSwift
import RxCocoa
import MOLH

class LanguageVC: UIViewController {
    @IBOutlet weak var langugageTableView: UITableView!
    @IBOutlet weak var viewLang: UIView!
    
    private let viewModel = LanguageViewModel()
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLang.layer.cornerRadius = 10
        bindViewModel()
        
        
        langugageTableView.register(UITableViewCell.self, forCellReuseIdentifier: "LanguageCell")
        langugageTableView.translatesAutoresizingMaskIntoConstraints = false
        langugageTableView.keyboardDismissMode = .onDrag
        langugageTableView.register(UINib(nibName: LanguageCell.identifier, bundle: nil), forCellReuseIdentifier: LanguageCell.identifier)

    }
    
    @IBAction func cancelBu(_ sender: Any) {
        self.dismiss(animated: false)
    }

    private func bindViewModel() {
        // Bind filtered languages to table view
        viewModel.filteredLanguages
            .bind(to: langugageTableView.rx.items(cellIdentifier: "LanguageCell")) { index, language, cell in
                cell.textLabel?.text = language.name
                cell.detailTextLabel?.text = language.nativeName
                cell.accessoryType = self.viewModel.selectedLanguage.value?.code == language.code ? .checkmark : .none
            }
            .disposed(by: disposeBag)
        
        viewModel.filteredLanguages
            .bind(to: langugageTableView.rx.items(cellIdentifier: LanguageCell.identifier, cellType: LanguageCell.self)) { [weak self] index, language, cell in
                let isSelected = self?.viewModel.selectedLanguage.value?.code == language.code
                cell.configure(with: language, isSelected: isSelected)
            }
            .disposed(by: disposeBag)
        
        
        // Handle language selection
        langugageTableView.rx.modelSelected(Language.self)
            .subscribe(onNext: { [weak self] language in
                self?.viewModel.selectLanguage(language)
                self?.langugageTableView.reloadData()
                MOLH.setLanguageTo(language.code)
 
                let splashVC = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: "ProfileViewController")

                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let sceneDelegate = windowScene.delegate as? SceneDelegate else {
                    return
                }

                sceneDelegate.window?.rootViewController = splashVC
                sceneDelegate.window?.makeKeyAndVisible()
                AppDelegate.lang = language.code
                
                // Optional animation
                UIView.transition(with: sceneDelegate.window!,
                                  duration: 0.3,
                                  options: [.transitionCrossDissolve],
                                  animations: nil,
                                  completion: nil)
                

            })
            .disposed(by: disposeBag)
    }
    
}
