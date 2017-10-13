#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include "dataobject.h"
#include <QFileInfo>
#include <QDirIterator>
#include <QDir>
#include <QDebug>
#include <QAbstractListModel>
#include <QQmlContext>
#include <QtQml>

//class DataModel : public QAbstractListModel {
//    Q_OBJECT
//    QList<DataObject *> m_dataList;
//public:
//    DataModel(QObject * parent=nullptr) : QAbstractListModel(parent){}
//    virtual ~DataModel(){}

//    int rowCount(const QModelIndex & parent) const {
//        Q_UNUSED(parent);
//        return m_dataList.count();
//    }

//    // pure virtuals implementations
//    QVariant                data(const QModelIndex &index, int role = Qt::DisplayRole) const{}
//    int                     columnCount(const QModelIndex &parent = QModelIndex()) const {}
//    QModelIndex             index(int row, int column, const QModelIndex &parent = QModelIndex()) const{}
//    QModelIndex             parent(const QModelIndex &child) const {}


//    Q_INVOKABLE bool add(DataObject *data, const QModelIndex &parent = QModelIndex()) {
//        Q_UNUSED(parent);
//        beginInsertRows(QModelIndex(), rowCount(parent), rowCount(parent));
//        m_dataList.append(data);
//        endInsertRows();
//        return true;
//    }

//    Q_INVOKABLE bool remove(int row, const QModelIndex &parent = QModelIndex()) {
//        Q_UNUSED(parent);
//        beginRemoveRows(QModelIndex(), row, row);
//        delete m_dataList.takeAt(row);
//        endRemoveRows();
//        return true;
//    }
//};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QList<QObject*> dataList;
//    DataModel dataModel;

    // Gets files on folder
    QString folderMusic = "C:/Users/minh.hoang/Music/LenMood";
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

           // dataModel.add(dao);
            dataList.append(dao);
        }
    }


    qDebug() << "number of music: " << dataList.size();

    dataList.removeAt(1);

    qDebug() << "number of music: " << dataList.length();

    QQuickView view;
    view.setResizeMode(QQuickView::SizeRootObjectToView);

    QQmlContext *ctxt = view.rootContext();
    //ctxt->setContextProperty("myModel", &dataModel);
    ctxt->setContextProperty("myModel", QVariant::fromValue(dataList));

    view.setSource(QUrl("qrc:///main.qml"));
    view.show();

    return app.exec();

    //    QQmlApplicationEngine engine;
    //    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    //    if (engine.rootObjects().isEmpty())
    //        return -1;

    //    return app.exec();
}
