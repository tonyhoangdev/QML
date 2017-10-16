#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include <QFileInfo>
#include <QDirIterator>
#include <QDir>
#include <QDebug>
#include <QAbstractListModel>
#include <QQmlContext>
#include <QtQml>
#include "valuemodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<DataObject>("my.lib", 1, 0, "DataObject");

    ValueModel dataModel;

    // Gets files on folder
    //QString folderMusic = "C:/Users/minh.hoang/Music/LenMood";
    QString folderMusic = QDir::currentPath()  + "/data";
    QString ipMusic = "http://10.218.141.171:8081";
    QDir dir(folderMusic);

    QStringList musics = dir.entryList(QStringList() << "*.mp3" << "*.MP3",QDir::Files);
    if (!musics.empty()) {
        foreach(QString fileName, musics) {
            qDebug() << dir.filePath(fileName);
            DataObject *dao = new DataObject();
            dao->setShowButton(false);
            dao->setTitle(fileName);
            dao->setIsPlay(false);
            dao->setSource("play.png");
            dao->setTime("1:20");
            dao->setFileName(dir.filePath(fileName));

            dataModel.addObject(*dao);
        }
    }

    QQuickView view;
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    QQmlContext *ctxt = view.rootContext();
    ctxt->setContextProperty("myModel", &dataModel);
    view.setSource(QUrl("qrc:///main.qml"));
    view.show();

//    QObject *pRootObject = dynamic_cast<QObject*>(view.rootObject());
//    QObject *pobjFrame = pRootObject->findChild<QObject *>("txtPath");
//    pobjFrame->setProperty("text", folderMusic);

    return app.exec();
}
