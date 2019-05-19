//
//  MenuCadastrarSaborViewController.swift
//  IPizza
//
//  Created by PUCPR on 17/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import Firebase

class MenuSaboresPizzasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var txtSabor: UITextField!
    @IBOutlet weak var txtTamanho: UITextField!
    @IBOutlet weak var txtValor: UITextField!
    @IBOutlet weak var txtTipo: UITextField!
    
    @IBOutlet weak var lblListaSabores: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var btnAdicionar: UIButton!
    @IBOutlet weak var btnDeletar: UIButton!
    
    
    var saboresSalgados : [Sabor]!
    var saboresDoces : [Sabor]!
    var sabor : Sabor!
    var editarSabor: Sabor!
    var key : String!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Sabores", image: UIImage(named: "icons8-pizza-32"), tag: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnDeletar.isHidden = true
        btnAdicionar.setTitle("CADASTRAR", for: .normal)
        
        key = Auth.auth().currentUser?.uid
        
        MenuSaboresPizzasViewModel.shared.loadDataFireBase(owner: self, key: key)
        
//        for x in 0...10 {
//            sabor = Sabor()
//            sabor.nomeSabor = String("Sabor \(x)")
//            sabor.tamanho = "G"
//            sabor.valor = String(x+10)
//            if x > 5 {
//                sabor.tipo = "Doce"
//            }else {
//                sabor.tipo = "Salgada"
//            }
//            sabores.append(sabor)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        btnDeletar.isHidden = true
        btnAdicionar.setTitle("CADASTRAR", for: .normal)
    }
    
    @IBAction func segmentedControlOnClick(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            print("Salgada")
            lblListaSabores.text = "Lista de Sabores Salgados"
            limpaCampos()
            tableView.reloadData()
        }else if segmentedControl.selectedSegmentIndex == 1 {
            print("Doce")
            lblListaSabores.text = "Lista de Sabores Doces"
            limpaCampos()
            tableView.reloadData()
        }
    }
    
    @IBAction func btnAdicionarOnClick(_ sender: Any) {
        if editarSabor != nil {
            let json: [String : Any]? = montaJson(key: self.editarSabor.key)
            if json != nil {
                MenuSaboresPizzasViewModel.shared.alteraSabor(owner: self, json: json, key: self.editarSabor.key)
            }
        }else {
            let key = MenuSaboresPizzasViewModel.shared.refUsuarios.child(LoginViewModel.shared.users[0].key!).child("Pizzas").childByAutoId().key
            let json: [String : Any]? = montaJson(key: key!)
            if json != nil {
                MenuSaboresPizzasViewModel.shared.criaSabor(owner: self, json: json, key: key!)
            }
        }
    }
    
    @IBAction func btnLimparOnCLick(_ sender: Any) {
        //self.navigationController?.popViewController(animated: true)
        //self.tabBarController?.dismiss(animated: true, completion: nil)
        limpaCampos()
    }
    
    @IBAction func btnDeletarOnClick(_ sender: Any) {
        let alert = UIAlertController(title: "Deseja realmente deletar esse sabor?", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "NÃO", style: .default, handler: { (action) in
        }))
        
        alert.addAction(UIAlertAction(title: "SIM", style: .default, handler: { (action) in
            MenuSaboresPizzasViewModel.shared.deletaSabor(owner: self, key: self.editarSabor.key)
            self.limpaCampos()
        }))
        // show the alert
        present(alert, animated: true, completion: nil)
        return
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cells : Int = 0
        if segmentedControl.selectedSegmentIndex == 0 {
            if saboresSalgados != nil {
                cells = saboresSalgados.count
            }
        }else if segmentedControl.selectedSegmentIndex == 1 {
            if saboresDoces != nil {
                cells = saboresDoces.count
            }
        }
        return cells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSabor", for: indexPath)
        
        if segmentedControl.selectedSegmentIndex == 0 {
            cell.textLabel?.text = saboresSalgados[indexPath.row].nomeSabor
            //cell.detailTextLabel?.text = pizzas.listaPizzas[indexPath.row].tamanho!
        }else if segmentedControl.selectedSegmentIndex == 1 {
            cell.textLabel?.text = saboresDoces[indexPath.row].nomeSabor
            //cell.detailTextLabel?.text = pizzas.listaPizzas[indexPath.row].tamanho!
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentedControl.selectedSegmentIndex == 0 {
            txtSabor.text = saboresSalgados[indexPath.row].nomeSabor
            txtTamanho.text = saboresSalgados[indexPath.row].detalhes.tamanho
            txtValor.text = String(saboresSalgados[indexPath.row].detalhes.valor!)
            txtTipo.text = saboresSalgados[indexPath.row].detalhes.tipo
            editarSabor = Sabor()
            editarSabor = saboresSalgados[indexPath.row]
            btnAdicionar.setTitle("ALTERAR", for: .normal)
            btnDeletar.isHidden = false
        }else if segmentedControl.selectedSegmentIndex == 1 {
            txtSabor.text = saboresDoces[indexPath.row].nomeSabor
            txtTamanho.text = saboresDoces[indexPath.row].detalhes.tamanho
            txtValor.text = String(saboresDoces[indexPath.row].detalhes.valor!)
            txtTipo.text = saboresDoces[indexPath.row].detalhes.tipo
            editarSabor = Sabor()
            editarSabor = saboresDoces[indexPath.row]
            btnAdicionar.setTitle("ALTERAR", for: .normal)
            btnDeletar.isHidden = false
        }
    }
    
    func limpaCampos() {
        txtSabor.text = ""
        txtTamanho.text = ""
        txtValor.text = ""
        txtTipo.text = ""
        btnAdicionar.setTitle("CADASTRAR", for: .normal)
        btnDeletar.isHidden = true
        editarSabor = nil
    }
    
    func separaSabores() {
        saboresSalgados = []
        saboresDoces = []
        for x in MenuSaboresPizzasViewModel.shared.sabores {
            if x.detalhes.salgada == true {
                saboresSalgados.append(x)
            }else {
                saboresDoces.append(x)
            }
        }
    }
    
    func montaJson(key: String) -> [String : Any]? {
        
        var sabor: [String : Any] = [:]
        
        var camposObrigatorios : Bool = false
        
        if txtSabor.text == "" || txtTamanho.text == "" || txtValor.text == "" || txtTipo.text == "" {
            
            camposObrigatorios = true
            
            let alert = UIAlertController(title: "Todos os campos são Obrigatórios!", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            }))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            return nil
            
        } else if camposObrigatorios == false {
            if self.segmentedControl.selectedSegmentIndex == 0 {
                sabor = [
                    "Key": key,
                    "NomeSabor": txtSabor.text! as String,
                    "Tamanho": txtTamanho.text! as String,
                    "Valor": txtValor.text! as String,
                    "Salgada": true,
                    "Tipo": txtTipo.text! as String
                ]
            }else {
                sabor = [
                    "Key": key,
                    "NomeSabor": txtSabor.text! as String,
                    "Tamanho": txtTamanho.text! as String,
                    "Valor": txtValor.text! as String,
                    "Salgada": false,
                    "Tipo": txtTipo.text! as String
                ]
            }
            
            return sabor
        }
    }
}
