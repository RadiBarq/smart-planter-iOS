//
//  SensorDetailsViewController.swift
//  SmartPlanter
//
//  Created by Harri on 5/19/20.
//  Copyright © 2020 Harri. All rights reserved.
//

import UIKit
import Charts

class SensorDetailsViewController: UIViewController, ChartViewDelegate {

    lazy var lineChartView: LineChartView =  {
       let chartView = LineChartView()
        chartView.backgroundColor = UIColor(red: 50/255, green: 168/255, blue: 81/255, alpha: 1)
        chartView.rightAxis.enabled = false
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .insideChart
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .white
        chartView.animate(xAxisDuration: 1)
        return chartView
    }()
    
    var sensorName: String!
    var sensorURL: String
    
    var data = [ChartDataEntry]()

    init(sensorName: String, sensorURL: String){
        self.sensorName = sensorName
        self.sensorURL = sensorURL
        super.init(nibName: nil, bundle: nil)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.lineChartView)
        self.title = self.sensorName
        self.view.backgroundColor = .white
        self.lineChartView.translatesAutoresizingMaskIntoConstraints = false
        self.lineChartView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.lineChartView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.lineChartView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.lineChartView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.lineChartView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.lineChartView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        NetworkModel.getJobHistory(jobURL: self.sensorURL) { respons in
            switch respons {
            case .success(let result):
                self.parseHistory(result: result)
            case .failure(let error):
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    private func parseHistory(result: [JobHistory]) {
        
        for history in result {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from: history.created)!
            let value = history.value
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            data.append(ChartDataEntry(x: Double(components.minute!), y: Double(value)))
        }
        self.setData()
    }
    
    func setData() {
        let set = LineChartDataSet(entries: data, label: self.sensorName)
        set.mode = .cubicBezier
        set.lineWidth = 3
        set.setColor(.white)
        set.drawCirclesEnabled = false
        set.fill = Fill(color: .white)
        set.fillAlpha = 0.7
        set.highlightColor = .white
        set.drawFilledEnabled = true
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        self.lineChartView.data = data
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}
