//
//  ViewController.swift
//  weatherApp
//
//  Created by jy on 4/2/25.
//

import UIKit
import Alamofire

//테이블뷰에 올릴 구조체
struct Flims{
    let region : String
    let temp_c : Double
    let humidity : Int
    let text : String
    let image : String
}

class ViewController: UIViewController {

    @IBOutlet weak var weatherTableView: UITableView!
    
    //빈 배열 선언
    var item : [Flims] = []
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var temLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        weatherTableView.register(nib, forCellReuseIdentifier: "Cell")
        
        self.weatherTableView.delegate = self
        self.weatherTableView.dataSource = self
    
        fetchfilms()
    }
}

//alamofire API
extension ViewController {
    func fetchfilms() {
        let url = API.baseURL.appendingPathComponent("v1/current.json")
        let key = API.apiKey
        
        for (city, cityname) in locations {
            let param = ["key": key, "q": cityname, "lang": "ko", "aqi": "yes"]
            
            //주소
            //http://api.weatherapi.com/v1/current.json?key=38eddeee99b84ec887640557250204&q=seoul&lang=koaqi=yes
            
            //request
            AF.request(url,
                       method: .get,
                       parameters: param)
            
            .responseDecodable(of: Weather.self) { responds in
                switch responds.result {
                case .success(let data):
                    let flim = Flims(region: city,
                                     temp_c: data.current.temp_c,
                                     humidity: data.current.humidity,
                                     text: data.current.condition.text,
                                     image: data.current.condition.icon)

                    self.item.append(flim)
                    
                case .failure(let error):
                    print("image fail: \(error)")
                }
                    
                    // 이미지 비동기로 가져오기
                DispatchQueue.main.async {
                    self.weatherTableView.reloadData()
                        }
                    }
                }
            }
        }

        
        
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.regionCellLabel.text = item[indexPath.row].region
        cell.TemCellLabel.text = "\(item[indexPath.row].temp_c)°C"
        cell.humidityCellLabel.text = "\(item[indexPath.row].humidity)%"
        
        //셀 선택시 스타일
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.containerView.layer.cornerRadius = 20
        cell.containerView.layer.masksToBounds = true
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .tintColor

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "ItemDetailView") as! ItemDetailView
        detailVC.film = item[indexPath.row]
       
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
