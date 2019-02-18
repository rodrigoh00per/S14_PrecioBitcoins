//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
  
    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencyArraySimbols = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"];
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self; //Manejado por nosotros
        currencyPicker.dataSource = self; //el origen de los datos nosotros lo manejaremos nosotros
        
      
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    //AQUI PONEMOS EL NUMERO DE COLUMNAS QUE TENDRA
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1; //
    }
    
    //PARA SABER CUANTOS ELEMENTOS TENDRA
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count;
    }
    
    //ESTE METODO SE USA PARA PONERLE LA DATA AL PICKER
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        print(currencyArray[row]);
        self.finalURL = "\(baseURL)\(currencyArray[row])";
        print(finalURL);
        self.getBitcoinData(url: finalURL, index: row);
    }

//    
//    //MARK: - Networking
//    /***************************************************************/
//    
    func getBitcoinData(url: String,index: Int) {
    
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {

                    print("Ya se esta trayendo la informacion de la moneda")
                    let BitcoinJSON : JSON = JSON(response.result.value!)
                    print(BitcoinJSON);
                   self.updateBitcoinData(json: BitcoinJSON,index: index);

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }
//
//    
//    
//    
//    
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
    func updateBitcoinData(json : JSON,index : Int) {
//        
       if let tempResult = json["changes"]["price"]["day"].double {
        bitcoinPriceLabel.text = "\(self.currencyArraySimbols[index])\(tempResult)";
//
       } else {
        bitcoinPriceLabel.text = "There are problem for recover the Price";
    }
//
//        updateUIWithWeatherData()
   }
//    




}

