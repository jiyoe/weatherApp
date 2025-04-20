//
//  ItemDetailView.swift
//  weatherApp
//
//  Created by jy on 4/14/25.
//

import Foundation
import UIKit
import Alamofire

class ItemDetailView: UIViewController {
    
    var film : Flims?
    
    @IBOutlet weak var regionLabelItem: UILabel!
    @IBOutlet weak var imageViewItem: UIImageView!
    @IBOutlet weak var tempLabelItem: UILabel!
    @IBOutlet weak var textLabelItem: UILabel!
    @IBOutlet weak var humidityLabelItem: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let film = film {
            regionLabelItem.text = film.region
            tempLabelItem.text = "\(film.temp_c)°C"
            textLabelItem.text = film.text
            humidityLabelItem.text = "\(film.humidity)%"
            
            var iconURL = film.image
            
            //이미지에 https 붙여주기
            if !iconURL.hasPrefix("https:") {
                iconURL = "https:" + iconURL
            }
            
            //이미지 request
            AF.request(iconURL).responseData { response in
                    switch response.result {
                    case .success(let data):
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.imageViewItem.image = image
                            }
                        }
                    case .failure(let error):
                        print("Alamofire 이미지 로딩 실패: \(error)")
                    }
                }
            }
        }
    }
