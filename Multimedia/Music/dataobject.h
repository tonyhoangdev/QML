#ifndef DATAOBJECT_H
#define DATAOBJECT_H

#include <QObject>
#include <QDebug>

class DataObject : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool showButton READ showButton WRITE setShowButton NOTIFY showButtonChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(bool isPlay READ isPlay WRITE setIsPlay NOTIFY isPlayChanged)
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QString time READ time WRITE setTime NOTIFY timeChanged)
    Q_PROPERTY(QString fileName READ fileName WRITE setFileName NOTIFY fileNameChanged)

public:
    explicit DataObject(QObject *parent = nullptr);
    explicit DataObject(const bool &showButton, const QString &title, const bool &isPlay, const QString &source, const QString &time, const QString &fileName, QObject *parent=nullptr);

    bool showButton() const;
    void setShowButton(const bool &showButton);

    QString title() const;
    void setTitle(const QString &title);

    bool isPlay() const;
    void setIsPlay(const bool &isPlay);

    QString source() const;
    void setSource(const QString &source);

    QString time() const;
    void setTime(const QString &time);

    QString fileName() const;
    void setFileName(const QString &fileName);

    Q_INVOKABLE void deleteRow(int index);


private:
    bool m_showButton;
    QString m_title;
    bool m_isPlay;
    QString m_source;
    QString m_time;
    QString m_fileName;

signals:
    void showButtonChanged();
    void titleChanged();
    void isPlayChanged();
    void sourceChanged();
    void timeChanged();
    void fileNameChanged();

public slots:
};

#endif // DATAOBJECT_H
