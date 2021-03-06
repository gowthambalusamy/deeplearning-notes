# -*- coding: utf-8 -*-
'''
QSlider控件
'''
from PyQt5.QtGui import *
from PyQt5.QtCore import *
from PyQt5.QtWidgets import *
import sys

class Form(QMainWindow):
    def __init__(self,parent=None):
        super().__init__(parent)
        centerWidget = QWidget()
        layout = QHBoxLayout()
        
        # 添加控件代码
        slider = QSlider(Qt.Horizontal,centerWidget)
        slider.setRange(0,100)
        slider.setValue(50)
        
        label = QLabel()
        slider.valueChanged.connect(lambda value: label.setText("%d" %(slider.value())))

        layout.addWidget(slider)
        layout.addWidget(label)
        centerWidget.setLayout(layout)
        self.setCentralWidget(centerWidget)
        self.resize(640,480)
        self.setWindowTitle("PyQt5-")

if __name__ == '__main__':
     
    app = QApplication(sys.argv)
    ex = Form()
    ex.show()
    sys.exit(app.exec_())