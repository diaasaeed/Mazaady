//
//  LanguageViewModel.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 13/04/2025.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
struct Language:Encodable ,Decodable {
    let code: String
    let name: String
    let nativeName: String
}

class LanguageViewModel {
    private let userDefaults = UserDefaults.standard
    private let languageKey = "selectedLanguage"
    
    let allLanguages = [
        Language(code: "en", name: "English".localized, nativeName: "English"),
        Language(code: "ar", name: "Arabic".localized, nativeName: "العربية")
    ]
    
    var filteredLanguages = BehaviorRelay<[Language]>(value: [])
    var selectedLanguage = BehaviorRelay<Language?>(value: nil)
    
    init() {
        filteredLanguages.accept(allLanguages)
        loadSelectedLanguage()
    }
    
    func filterLanguages(with searchText: String) {
        if searchText.isEmpty {
            filteredLanguages.accept(allLanguages)
        } else {
            let filtered = allLanguages.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.nativeName.lowercased().contains(searchText.lowercased())
            }
            filteredLanguages.accept(filtered)
        }
    }
    
    func selectLanguage(_ language: Language) {
        selectedLanguage.accept(language)
        saveSelectedLanguage(language)
    }
    
    private func saveSelectedLanguage(_ language: Language) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(language) {
            userDefaults.set(encoded, forKey: languageKey)
        }
    }
    
    private func loadSelectedLanguage() {
        if let savedData = userDefaults.data(forKey: languageKey) {
            let decoder = JSONDecoder()
            if let loadedLanguage = try? decoder.decode(Language.self, from: savedData) {
                selectedLanguage.accept(loadedLanguage)
            }
        }
    }
}
