//
//  ViewController.swift
//  Conversor
//
//  Created by Otto Colomina Pardo on 20/10/17.
//  Copyright © 2017 Universidad de Alicante. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let conversor = ConversorEUR_USD()

    @IBOutlet weak var dolares: UITextField!
    @IBOutlet weak var euros: UITextField!
    
    @IBOutlet weak var tipoCambioLabel: UILabel!
    let nc = NotificationCenter.default
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nc.addObserver(self, selector:#selector(self.cambioTipo), name:NSNotification.Name(rawValue:"cambioTipo"), object: nil)

    }
    @objc func cambioTipo(notificacion:Notification) {
        print("recibido!!")
        if let userInfo = notificacion.userInfo {
            let mensaje = userInfo["valor"] as! Float
            tipoCambioLabel.text = "1 € = "+String(mensaje)+" $"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func calcularUSDPulsado(_ sender: Any) {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        if let numEuros = nf.number(from: self.euros.text!) {
            let euros = Float(truncating:numEuros)
            let dolares = conversor.cuantosUSDson(eur: euros)
            self.dolares.text = String(dolares)
        }
    }
    
   
    @IBAction func calcularEURPulsado(_ sender: Any) {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        if let numDolares = nf.number(from: self.dolares.text!) {
            let dolares = Float(truncating:numDolares)
            let euros = conversor.cuantosEURson(usd: dolares)
            self.euros.text = String(euros)
            
            
        }
    }
}

