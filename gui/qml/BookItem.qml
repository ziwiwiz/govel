import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0


Rectangle{
    id:bookItem
    width: parent.width
    height:root.width/5
    // anchors.fill: parent    
    // anchors.margins: height/15
    property alias authorName: authorText.text
    property alias title: titleText.text
    property alias intro: introTextMetrics.text
    property alias bookSource: bookSourceText.text
    default property alias cover: coverImg.source
    property string bookUrl: ""
    
    signal clicked

    Row {
        width: parent.width
        Item{
            // width: parent.width/4
            id:coverImgItem
            height: bookItem.height
            width: height/5*4           
            // anchors.margins: height/20           
            // radius: 20
            Image{
                id: coverImg      
                asynchronous: true                    
                anchors.fill: parent                
                // anchors.margins: height/20
                source: source?source:"qrc:/images/drawer.png"
            }
            Rectangle{
                id: mask
                anchors.fill: parent
                visible: false
                radius: 5
            }
            OpacityMask{    
                anchors.fill: parent
                source: coverImg
                maskSource: mask
            }
        }
        
        Column {                                  
            // leftPadding: height/10  
            padding:height/10
            spacing: height/15     
            width: parent.width-coverImgItem.width    
            Text{
                id: titleText
                color: "lightsteelblue"
                font.bold: true
                // font.pixelSize: font.pixelSize*1.2
                text: "书名"
            }
            Text{
                id: authorText              
                text: "作者"
            }
            TextMetrics {
                id: introTextMetrics
                // width: parent.width
                // font.family: "Arial"
                elide: Text.ElideRight
                elideWidth: parent.width*2
                text: "介绍"
            }
            Text{
                id: introText
                width:parent.width
                wrapMode: Text.WordWrap
                text: introTextMetrics.elidedText
            }
            Text{
                id: bookSourceText
                wrapMode: Text.WordWrap
                text: "书源"
            }
        }
        
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: {
            // console.log(title+" clicked!"+" root.y:"+root.y+" root.height:"+root.height+" popup.y:"+bookPopup.y+" popup.x:"+bookPopup.x+" item.y:"+bookItem.y);
            console.log("model is "+ title+" .index is:"+index);            
            myShelf.currentIndex=index;
            
            // bookPopup.open()
            
            // bookItem.clicked()
        }
    }
    ListView.onAdd:{
        console.log("new item added. title:"+title+" url:"+bookUrl+"cover:\'"+cover+"\'");
        if (cover!=""){
            coverImg.source=cover
        }else{
            coverImg.source="qrc:/images/drawer.png"
        }
    } 
    Rectangle {
        color: "black"      
        width: parent.width
        height:1
        anchors.top: parent.bottom        
    } 
    Popup {
        id:bookPopup
        width: root.width/4*3
        height: root.height/1.5
        x: Math.round((parent.width - width) / 2)

        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside

    }
   
}