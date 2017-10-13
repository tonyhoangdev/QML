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
#include "dynamicentrymodel.h"
#include <QtGui>
#include <QtQml>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<DynamicEntryModel>("org.example", 1, 0, "DynamicEntryModel");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
