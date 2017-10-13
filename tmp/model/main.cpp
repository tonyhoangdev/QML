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
#include "dataentrymodel.h"
#include <QtGui>
#include <QtQml>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<DataEntryModel>("org.example", 1, 0, "DataEntryModel");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
