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
        chartView.backgroundColor = .green
        chartView.rightAxis.enabled = false
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .black
        yAxis.axisLineColor = .black
        yAxis.labelPosition = .insideChart
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .black
        chartView.xAxis.axisLineColor = .black
        chartView.animate(xAxisDuration: 1)
        return chartView
    }()
    
    var sensorName: String!
    
    let data = [ChartDataEntry.init(x: 0, y: 38), ChartDataEntry.init(x: 1, y: 38),
    ChartDataEntry.init(x: 2, y: 39), ChartDataEntry.init(x: 3, y: 38), ChartDataEntry.init(x: 4, y: 38), ChartDataEntry.init(x: 5, y: 38), ChartDataEntry.init(x: 6, y: 38), ChartDataEntry.init(x: 7, y: 25), ChartDataEntry.init(x: 8, y: 40), ChartDataEntry.init(x: 10, y: 40), ChartDataEntry.init(x: 11, y: 30), ChartDataEntry.init(x: 12, y: 10), ChartDataEntry.init(x: 13, y: 5), ChartDataEntry.init(x: 14, y: 38), ChartDataEntry.init(x: 15, y: 10), ChartDataEntry.init(x: 16, y: 50), ChartDataEntry.init(x: 17, y: 2), ChartDataEntry.init(x: 18, y: 60), ChartDataEntry.init(x: 19, y: 3)
    ]

    init(sensorName: String){
        self.sensorName = sensorName
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
        
        self.setData()
        // Do any additional setup after loading the view.
    }
    
    func setData() {
        let set = LineChartDataSet(entries: data, label: self.sensorName)
        set.mode = .cubicBezier
        set.lineWidth = 3
        set.setColor(.black)
        set.drawCirclesEnabled = false
        set.fill = Fill(color: .black)
        set.fillAlpha = 0.7
        set.highlightColor = .black
        set.drawFilledEnabled = true
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        self.lineChartView.data = data
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    
}
