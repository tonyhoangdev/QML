#include "dataobject.h"
#include <QDebug>

DataObject::DataObject(QObject *parent) : QObject(parent)
{

}

DataObject::DataObject(const bool &showButton, const QString &title, const bool &isPlay, const QString &source, const QString &time, const QString &fileName, QObject *parent) : QObject(parent), m_showButton(showButton), m_title(title), m_isPlay(isPlay), m_source(source), m_time(time), m_fileName(fileName)
{

}

bool DataObject::showButton() const
{
    return m_showButton;
}

void DataObject::setShowButton(const bool &showButton)
{
    m_showButton = showButton;
}

QString DataObject::title() const
{
    return m_title;
}

void DataObject::setTitle(const QString &title)
{
    m_title = title;
}

bool DataObject::isPlay() const
{
    return m_isPlay;
}
void DataObject::setIsPlay(const bool &isPlay)
{
    qDebug() << "Set Is Play: " << isPlay;

    if (m_isPlay != isPlay)
    {
        m_isPlay = isPlay;
        if (!isPlay)
        {
            setSource("play.png");
        }
        else
        {
            setSource("pause.png");
        }

        emit isPlayChanged(isPlay);
    }

}

QString DataObject::source() const
{
    return m_source;
}

void DataObject::setSource(const QString &source)
{
    if (m_source != source)
    {
        m_source = source;

        emit sourceChanged(source);
    }
}

QString DataObject::time() const
{
    return m_time;
}
void DataObject::setTime(const QString &time)
{
    m_time = time;
}

QString DataObject::fileName() const
{
    return m_fileName;
}
void DataObject::setFileName(const QString &fileName)
{
    m_fileName = fileName;
}
