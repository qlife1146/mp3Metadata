//
//  ViewController.swift
//  mp3Metadata
//
//  Created by Luca Park on 2022. 6. 4..
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers
import AVFoundation

class ViewController: UIViewController, UIDocumentPickerDelegate {

    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tfAlbumTitle: UITextField!
    @IBOutlet var tfArtist: UITextField!
    @IBOutlet var tfAlbumArtist: UITextField!
    @IBOutlet var tfComposer: UITextField!
    @IBOutlet var tfLyricist: UITextField!
    @IBOutlet var tvLyrics: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func onBtnLoad(_ sender: UIButton) {
        var documentPicker: UIDocumentPickerViewController!
        if presentedViewController == nil {
            let supportedType: [UTType] = [UTType.mp3]
            documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedType)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = false
            documentPicker.modalPresentationStyle = .formSheet
            self.present(documentPicker, animated: true)
        }
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        for url in urls {
            guard url.startAccessingSecurityScopedResource() else {
                return
            }
            do {
                let data = try Data.init(contentsOf: url)
                print("data: \(data)")
            }
            catch {
                print(error.localizedDescription)
            }
            defer {
                url.stopAccessingSecurityScopedResource()
            }
            //print("print: ", url)
            let playerItem = AVPlayerItem(url: url)
            let metadata = playerItem.asset.metadata
            let songAsset = AVURLAsset(url: url)
            let lyc = songAsset.lyrics
            for item in metadata {
                guard let key = item.commonKey?.rawValue, let value = item.value else {
                    continue
                }
                print("meta: \(metadata)")
                switch key {
                    case "title" : tfTitle.text = value as? String
                    case "albumName" : tfAlbumTitle.text = value as? String
                    case "artist" : tfArtist.text = value as? String
                    case "creator" : tfComposer.text = value as? String
                    case "author" : tfLyricist.text = value as? String
                    //case "artwork" where value is Data : imageViewAlbumCover.image = UIImage(data: value as! Data)
                    default:
                        continue
                }
                tvLyrics.text = lyc
            }
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onBtnSave(_ sender: UIButton) {
        // TODO: Save Function
        // MARK: onBtnSave
        // MARK: - dash
        // FIXME: fixme
        // !!!: warning
        // ???: question
        
    }
    
}

