//
//  ViewController.swift
//  ejercicio1
//
//  Created by Pol Monleón Vives on 07/10/2018.
//  Copyright © 2018 Pol Monleón Vives. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var segundos:Int = 0
    var time = Timer()
    
    var array_enters_aleatoris = [Int]()
    
    var cuenta_atras:UILabel = UILabel()
    
    var puntos:UILabel = UILabel()
    
    var record:UILabel = UILabel()
    
    var sampleTextField = UITextField()
    
    var nuevo_record:UILabel = UILabel()
    
    var puntuacion:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iniciarJuego()
    }
    
    //esta es la funcion que carga todos los datos necesarios iniciando la pantalla y colocando los botones
    func iniciarJuego(){
        
        cuenta_atras = UILabel(frame: CGRect(x: tamañoPorcentaje(porcentage: 5, total: Double(self.view.frame.width)), y: tamañoPorcentaje(porcentage: 5, total: Double(self.view.frame.height)), width: tamañoPorcentaje(porcentage: 70, total: Double(self.view.frame.width)), height: tamañoPorcentaje(porcentage: 8, total: Double(self.view.frame.height))))
        self.view.addSubview(cuenta_atras)
        cuenta_atras.text = "30"
        cuenta_atras.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        cuenta_atras.font = cuenta_atras.font.withSize(25)
        
        puntos = UILabel(frame: CGRect(x: tamañoPorcentaje(porcentage: 20, total: Double(self.view.frame.width)), y: tamañoPorcentaje(porcentage: 75, total: Double(self.view.frame.height)), width: tamañoPorcentaje(porcentage: 80, total: Double(self.view.frame.width)), height: tamañoPorcentaje(porcentage: 20, total: Double(self.view.frame.height))))
        self.view.addSubview(puntos)
        puntos.text = "Puntuación: \(puntuacion)"
        puntos.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        puntos.font = puntos.font.withSize(35)
        
        record = UILabel(frame: CGRect(x: tamañoPorcentaje(porcentage: 8, total: Double(self.view.frame.width)), y: tamañoPorcentaje(porcentage: 85, total: Double(self.view.frame.height)), width: tamañoPorcentaje(porcentage: 80, total: Double(self.view.frame.width)), height: tamañoPorcentaje(porcentage: 20, total: Double(self.view.frame.height))))
        self.view.addSubview(record)
        record.text = "Record: \(UserDefaults.standard.string(forKey: "max_puntos") ?? "0") de \(UserDefaults.standard.string(forKey: "name") ?? " NULL")"
        record.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        record.font = puntos.font.withSize(30)
        
        if (puntuacion<100){
            let x:Double = (tamañoPorcentaje(porcentage: 40, total: Double(self.view.frame.width)))
            var y:Double = tamañoPorcentaje(porcentage: 15, total: Double(self.view.frame.height))
            
            for _ in 1...6{
                let random:Int = Int.random(in: -100 ... 100)
                let boton:UIButton = crearBoton(x: x, y: y, width: tamañoPorcentaje(porcentage: 20, total: Double(self.view.frame.width)), height: tamañoPorcentaje(porcentage: 6, total: Double(self.view.frame.height)),texto: String(random), color:UIColor.green)
                boton.addTarget(self, action: #selector(clic(_:)), for: .touchUpInside)
                self.view.addSubview(boton)
                array_enters_aleatoris.append(random)
                y += tamañoPorcentaje(porcentage: 12, total: Double(self.view.frame.height))
            }
        }else{
            var x:Double = (tamañoPorcentaje(porcentage: 20, total: Double(self.view.frame.width)))
            var y:Double = tamañoPorcentaje(porcentage: 15, total: Double(self.view.frame.height))
            
            for _ in 1...6{
                let random:Int = Int.random(in: -100 ... 100)
                let boton:UIButton = crearBoton(x: x, y: y, width: tamañoPorcentaje(porcentage: 20, total: Double(self.view.frame.width)), height: tamañoPorcentaje(porcentage: 6, total: Double(self.view.frame.height)),texto: String(random),color:UIColor.yellow)
                boton.addTarget(self, action: #selector(clic(_:)), for: .touchUpInside)
                self.view.addSubview(boton)
                array_enters_aleatoris.append(random)
                y += tamañoPorcentaje(porcentage: 12, total: Double(self.view.frame.height))
            }
            
            x = (tamañoPorcentaje(porcentage: 60, total: Double(self.view.frame.width)))
            y = tamañoPorcentaje(porcentage: 15, total: Double(self.view.frame.height))
            
            for _ in 1...6{
                let random:Int = Int.random(in: -100 ... 100)
                let boton:UIButton = crearBoton(x: x, y: y, width: tamañoPorcentaje(porcentage: 20, total: Double(self.view.frame.width)), height: tamañoPorcentaje(porcentage: 6, total: Double(self.view.frame.height)),texto: String(random),color:UIColor.yellow)
                boton.addTarget(self, action: #selector(clic(_:)), for: .touchUpInside)
                self.view.addSubview(boton)
                array_enters_aleatoris.append(random)
                y += tamañoPorcentaje(porcentage: 12, total: Double(self.view.frame.height))
            }
        }
        
        array_enters_aleatoris.sort()
        
        cuentAtras()
    }
    
    //esta funcion inicializa la cuenta atras
    func cuentAtras(){
        segundos = 30
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.actualizarTiempo)), userInfo: nil, repeats: true)
    }
    
    //esta funcion se encarga de actualizar el tiempo
    @objc func actualizarTiempo(){
        if segundos < 1 {
            time.invalidate()
            cuenta_atras.textColor = UIColor(red: 100, green: 0, blue: 0, alpha: 1.0)
            cuenta_atras.text = "Has agotado el tiempo..."
            
            array_enters_aleatoris.removeAll()
            
            for view in self.view.subviews as [UIView] {
                if let btn = view as? UIButton {
                    btn.isHidden = true
                }
            }
            
            var x:Double = 0
            var y:Double = 0
            var width:Double = 0
            var height:Double = 0
            
            if(Int(UserDefaults.standard.string(forKey: "max_puntos") ?? "0")!<puntuacion){
                
                nuevo_record = UILabel(frame: CGRect(x: tamañoPorcentaje(porcentage: 15, total: Double(self.view.frame.width)), y: tamañoPorcentaje(porcentage: 20, total: Double(self.view.frame.height)), width: tamañoPorcentaje(porcentage: 70, total: Double(self.view.frame.width)), height: tamañoPorcentaje(porcentage: 20, total: Double(self.view.frame.height))))
                self.view.addSubview(nuevo_record)
                nuevo_record.text = "Nuevo Record!!"
                nuevo_record.textColor = UIColor.yellow
                nuevo_record.font = nuevo_record.font.withSize(35)
                
                sampleTextField =  UITextField(frame: CGRect(x: tamañoPorcentaje(porcentage: 15, total: Double(self.view.frame.width)), y: tamañoPorcentaje(porcentage: 45, total: Double(self.view.frame.height)), width: tamañoPorcentaje(porcentage: 70
                    , total: Double(self.view.frame.width)), height: tamañoPorcentaje(porcentage: 10, total: Double(self.view.frame.height))))
                sampleTextField.placeholder = "Introduce tu nombre..."
                sampleTextField.font = UIFont.systemFont(ofSize: 20)
                sampleTextField.layer.cornerRadius = 10
                sampleTextField.addTarget(self, action: #selector(nameRecord(_:)), for: .editingChanged)
                self.view.addSubview(sampleTextField)
                
                UserDefaults.standard.set(puntuacion, forKey: "max_puntos")
                UserDefaults.standard.set("NULL", forKey: "name")
                
                x=tamañoPorcentaje(porcentage: 30, total: Double(self.view.frame.width))
                y=tamañoPorcentaje(porcentage: 60, total: Double(self.view.frame.height))
                width=tamañoPorcentaje(porcentage: 40
                    , total: Double(self.view.frame.width))
                height=tamañoPorcentaje(porcentage: 20, total: Double(self.view.frame.height))
            }else{
                x=tamañoPorcentaje(porcentage: 30, total: Double(self.view.frame.width))
                y=tamañoPorcentaje(porcentage: 30, total: Double(self.view.frame.height))
                width=tamañoPorcentaje(porcentage: 40
                    , total: Double(self.view.frame.width))
                height=tamañoPorcentaje(porcentage: 40, total: Double(self.view.frame.height))
            }
            
            let boton:UIButton = crearBoton(x: x, y: y, width: width, height: height, texto: "Volver a empezar", color:UIColor.gray)
            boton.addTarget(self, action: #selector(reset(_:)), for: .touchUpInside)
            
            self.view.addSubview(boton)
            
            puntuacion = 0
        }else{
            segundos -= 1
            cuenta_atras.text = String(segundos)
        }
    }
    
    //esta funcion se encarga de devolver un boton tu le pasa las cordenadas en la pantalla y el tamaño del boton
    func crearBoton(x:Double , y:Double, width:Double, height:Double, texto:String, color:UIColor) -> UIButton{
        let but = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
        but.backgroundColor = color
        but.setTitleColor(UIColor.black, for: .normal)
        but.setTitle(texto, for: .normal)
        but.layer.cornerRadius = 10
        return but
    }
    
    //esta es la funcion que comprueba que el boton pulsado sea el correcto
    @objc func clic(_ sender: UIButton) {
        if sender.currentTitle == String(array_enters_aleatoris[0]) {
            sender.isHidden = true
            array_enters_aleatoris.remove(at: 0)
            if array_enters_aleatoris.count == 0 {
                time.invalidate()
                let boton:UIButton = crearBoton(x: tamañoPorcentaje(porcentage: 30, total: Double(self.view.frame.width)), y: tamañoPorcentaje(porcentage: 30, total: Double(self.view.frame.height)), width: tamañoPorcentaje(porcentage: 40
                    , total: Double(self.view.frame.width)), height: tamañoPorcentaje(porcentage: 40, total: Double(self.view.frame.height)), texto: "Continuar",color:UIColor.purple)
                boton.addTarget(self, action: #selector(reset(_:)), for: .touchUpInside)
                self.view.addSubview(boton)
                puntuacion += segundos
                puntos.text = "Puntuación: \(puntuacion)"
            }
        }else{
            segundos -= 5
        }
    }
    
    //esta es la funcion que se le asocia al boton de resetar/continuar partida que lo que hace es dejar la view en blanco y iniciar todo el juego
    @objc func reset(_ sender: Any) {
        dejarViewBlanca()
        iniciarJuego()
    }
    
    //esta funcion es para actualizar el nombre del record
    @objc func nameRecord(_ sender: UITextField) {
        UserDefaults.standard.set(sender.text, forKey: "name")
    }
    
    //esta funcion devuelve un double equivalente a un porcentaje que tu le pases con el valor tottal
    func tamañoPorcentaje(porcentage:Double, total:Double) -> Double{
        return (total*porcentage)/100
    }
    
    //esta funcion deja tda la view en blanco
    func dejarViewBlanca(){
        for subview in self.view.subviews {
            subview.removeFromSuperview()
        }
    }
}

