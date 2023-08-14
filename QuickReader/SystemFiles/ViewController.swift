//
//  ViewController.swift
//  QuickReader
//
//  Created by zhangcanming on 2023/8/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard let url = Bundle.main.url(forResource: "《虚拟尽头》", withExtension: "txt") else { return }
        let content = (try? String(contentsOf: url, encoding: .utf8)) ?? ""
        DispatchQueue.global().async {
            let models = self.separateChapterWithContent(content: content)
            DispatchQueue.main.async {
                models.forEach { model in
                    print("title ======= \(model.title)")
                    print("content ====== \(model.content)")
                }
            }
        }
    }

    func separateChapterWithContent(content: String) -> [ReaderChapterModel] {
        var models: [ReaderChapterModel] = []
        let parten = "第[0-9一二三四五六七八九十千百]*[章回].*"
        guard let reg = try? NSRegularExpression(pattern: parten, options: .caseInsensitive) else {
            return []
        }
        let match = reg.matches(in: content, range: NSRange(location: 0, length: content.count))
        if (match.count == 0) {
            let model = ReaderChapterModel()
            model.content = content
            return [model]
        }
        var lastRange = NSRange(location: 0, length: 0)
        for (index, result) in match.enumerated() {
            let range = result.range
            let local = range.location
            if (index == 0) {
                let model = ReaderChapterModel()
                model.title = "Start Reading"
                model.content = NSString(string: content).substring(with: NSRange(location: 0, length: local))
                models.append(model)
            }
            if (index > 0) {
                let model = ReaderChapterModel()
                model.title = NSString(string: content).substring(with: lastRange)
                model.content = NSString(string: content).substring(with: NSRange(location: lastRange.location, length: local - lastRange.location))
                models.append(model)
            }
            if (index == match.count - 1) {
                let model = ReaderChapterModel()
                model.title = NSString(string: content).substring(with: range)
                model.content = NSString(string: content).substring(with: NSRange(location: local, length: content.count - local))
                models.append(model)
            }
            lastRange = range
        }
        return models
    }
}

