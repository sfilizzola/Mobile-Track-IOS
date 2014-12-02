//
//  MainViewController.swift
//  Mobile Track
//
//  Created by Samuel Filizzola on 09/11/14.
//  Copyright (c) 2014 ECX Card. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var MapTypeSegment: UISegmentedControl!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    var usuarioLogado:Usuario?
    var veiculosCliente:[Veiculo]?
    var veiculoSelecionado:Veiculo?
    var ultimoEventoVeiculoSelecionado:Evento?
    var polyLineGeral:MKPolyline?
   
    @IBAction func SegmentAction(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex
        {
            case 0:
                self.map.mapType =  MKMapType.Standard
                break
            case 1:
                self.map.mapType = MKMapType.Satellite
                break
            case 2:
                self.map.mapType = MKMapType.Hybrid
                break
            default:
                self.map.mapType = MKMapType.Standard
                break
        }
    }
    var CodUsuarioLogado:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MapTypeSegment.selectedSegmentIndex = 0
        self.activityIndicator.hidesWhenStopped = true
        map.delegate = self
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool){
        
        var userPrefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        var CodUsuarioLogado:Int = userPrefs.integerForKey("CodUsuarioLogado")

        //carrega dados dos carros
        var DALVeiculos:Veiculos = Veiculos()
        
        veiculosCliente = DALVeiculos.VeiculosPorUsuario(CodUsuarioLogado)
    
        
        
        
        //se for iPad
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad
        {
            navBar.hidden = false
        }
        else if UIDevice.currentDevice().userInterfaceIdiom == .Phone // iPhone ou iPod Touch
        {
            if veiculoSelecionado != nil
            {
                var funcBarButton:UIBarButtonItem = UIBarButtonItem(title: "Opções", style: UIBarButtonItemStyle.Plain, target: self, action: "DisparaFuncoes")
                navBar.hidden = true
                self.navigationItem.rightBarButtonItem = funcBarButton;
            }
        }
        else if UIDevice.currentDevice().userInterfaceIdiom == .Unspecified // Qualquer outra coisa
        {
            navBar.hidden = true
        }
        
        
        
        if veiculoSelecionado != nil {
            NSLog("Veiculo: \(veiculoSelecionado!.Placa)")
            self.navigationItem.title = veiculoSelecionado!.Placa
            self.activityIndicator.startAnimating()
            NSThread.detachNewThreadSelector("PlotaVeiculo", toTarget: self, withObject: nil)
        } else
        {
            self.navigationItem.title = "ECX Track Mobile"
        }
        
    }
    
    func PlotaVeiculo(){
        let veicDAL:Veiculos = Veiculos()
        
        let ultimoEventoVeiculo:Evento? = veicDAL.UltimoEventoVeiculo(veiculoSelecionado!)
        ultimoEventoVeiculoSelecionado = ultimoEventoVeiculo
        
        if ultimoEventoVeiculo != nil
        {
            let center = CLLocationCoordinate2DMake(ultimoEventoVeiculo!.Latitude, ultimoEventoVeiculo!.Longitude)
            
            //TODO - legenda em hora  
            let pontoMapa: PontoMapa = PontoMapa(newCoordinate: center, newTitle: veiculoSelecionado!.Placa!, newSubTitle: "")
 
            var imageCarro:UIImage
            if ultimoEventoVeiculo!.StatusIgnicao!
            {
                pontoMapa.image = UIImage(named: "ic_list_gcar.png")
            } else {
                pontoMapa.image = UIImage(named: "ic_list_rcar.png")
            }
            
            self.map.addAnnotation(pontoMapa)
            
            let span = MKCoordinateSpanMake(0.005, 0.005)
            let region = MKCoordinateRegionMake(center, span)
            self.map.setRegion(region, animated: true)
            
            
        }
        else
        {
            //TODO -  popup de ultima posicao do carro nao eh valida
        }
        self.activityIndicator.stopAnimating()
        
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if (overlay is MKPolyline) {
            var pr = MKPolylineRenderer(overlay: overlay);
            pr.strokeColor = UIColor.blueColor().colorWithAlphaComponent(0.5);
            pr.lineWidth = 5;
            return pr;
        }
        return nil
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        /*if !(annotation is PontoMapa) {
            return nil
        }*/
    
        var PinId:String = "AnnotationId"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(PinId)
    
        if anView == nil
        {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: PinId)
            anView.canShowCallout = true
        }
        else
        {
            anView.annotation = annotation
        }
    
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
    
        let cpa = annotation as PontoMapa
        if (cpa.image != nil)
        {
            anView.image = cpa.image
        }
        return anView
    }
    
    func DisparaFuncoes(){
        
        var menuFuncoes: UIAlertController = UIAlertController(title: "Funções", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        var atualizarAction:UIAlertAction = UIAlertAction(title: "Atualizar", style: UIAlertActionStyle.Default, handler:
            {(alert:UIAlertAction!) in
                if self.veiculoSelecionado != nil {
                    self.map.removeAnnotations(self.map.annotations)
                    self.activityIndicator.startAnimating()
                    NSThread.detachNewThreadSelector("PlotaVeiculo", toTarget: self, withObject: nil)
                }
        })
        
        var rotaAction:UIAlertAction = UIAlertAction(title: "Rota até o carro", style: UIAlertActionStyle.Default, handler:
            {(alert:UIAlertAction!) in
                var ourApp:UIApplication = UIApplication.sharedApplication()
                var path:String = "http://maps.apple.com/?daddr=\(self.ultimoEventoVeiculoSelecionado!.Latitude),\(self.ultimoEventoVeiculoSelecionado!.Longitude)"
                var url:NSURL = NSURL(string: path)!
                
                ourApp.openURL(url)
                
        })
        
        var trajetosAction:UIAlertAction = UIAlertAction(title: "Trajetos", style: UIAlertActionStyle.Default, handler:
            {(alert:UIAlertAction!) in
                var tfvc = self.storyboard?.instantiateViewControllerWithIdentifier("Trajetos") as TrajetosFormViewController
                tfvc.TopViewControler = self
                self.presentViewController(tfvc, animated: true, completion: nil)
        })
        
        
        var sair:UIAlertAction = UIAlertAction(title: "Sair", style: UIAlertActionStyle.Destructive, handler: {
            (alert:UIAlertAction!) in
            
            var alert:UIAlertController = UIAlertController(title: "Sair do Ecx Track Mobile?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            
            var alertOK:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:
                {(alert:UIAlertAction!) in
                    exit(0)
            })
            
            var cancelar:UIAlertAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler:  nil)
            
            alert.addAction(alertOK)
            alert.addAction(cancelar)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        })
        
        var cancelar:UIAlertAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler:
            nil)
        
        
        menuFuncoes.addAction(atualizarAction)
        menuFuncoes.addAction(rotaAction)
        menuFuncoes.addAction(trajetosAction)
        menuFuncoes.addAction(sair)
        menuFuncoes.addAction(cancelar)
        
        self.presentViewController(menuFuncoes, animated: true, completion: nil)
        
        NSLog("Que coisa funciona<<<<<<<<<<<<<<<<<<")
    }
    
    func startaTrajetos()
    {
        //self.activityIndicator.startAnimating()
        //NSThread.detachNewThreadSelector("plotaTrajetos", toTarget: self, withObject: nil)
    }
    
    func plotaTrajetos(dtIni:NSDate, dtFim:NSDate){
        self.activityIndicator.startAnimating()
        let veicDAL:Veiculos = Veiculos()
        var listaEvento:[Evento] = veicDAL.Trajetos(dtIni, DataFinal: dtFim, CodVeiculo: veiculoSelecionado!.CodVeiculo!)
        //plota no mapa
        
        var coordenadas:UnsafeMutablePointer<CLLocationCoordinate2D> = UnsafeMutablePointer<CLLocationCoordinate2D>()
        var count:Int = 0
        
        var coords: [CLLocationCoordinate2D] = []
        //coords.reserveCapacity(polyline.pointCount)
        ///polyline.getCoordinates(&coords, range: NSMakeRange(0, polyline.pointCount))
        
        for evt:Evento in listaEvento
        {
            //coordenadas.put(CLLocationCoordinate2D(latitude: evt.Latitude, longitude: evt.Longitude))
            coords.append(CLLocationCoordinate2D(latitude: evt.Latitude, longitude: evt.Longitude))
            count++
        }
        
        //var polyline:MKPolyline = MKPolyline(coordinates: coordenadas, count: count)
        
        var poly: MKPolyline = MKPolyline(coordinates: &coords, count: count)
        
        self.map.addOverlay(poly)
        
        self.polyLineGeral = poly
        
        self.activityIndicator.stopAnimating()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
