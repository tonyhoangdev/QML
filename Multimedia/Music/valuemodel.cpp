#include "valuemodel.h"
#include <QDebug>

ValueModel::ValueModel(QObject *parent) : QAbstractListModel(parent)
{
    //    m_roleNames[NameRole] = "name";
}


ValueModel::~ValueModel()
{
}

int ValueModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_data.count();
}

QVariant ValueModel::data(const QModelIndex &index, int role) const
{
    // the index returns the requested row and column information.
    // we ignore the column and only use the row information
    int row = index.row();

    // boundary check for the row
    if(row < 0 || row >= m_data.count()) {
        return QVariant();
    }

    const DataObject* data = m_data[row];
    //qDebug() << row << role;// << data;

    // A model can return data for different roles.
    // The default role is the display role.
    // it can be accesses in QML with "model.display"
    switch(role) {
    case ShowButtonRole:
        return data->showButton();
    case TitleRole:
        return data->title();
    case IsPlayRole:
        return data->isPlay();
    case SourceRole:
        return data->source();
    case TimeRole:
        return data->time();
    case FileNameRole:
        return data->fileName();
    }
    // The view asked for other data, just return an empty QVariant
    return QVariant();
}

QHash<int, QByteArray> ValueModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[ShowButtonRole] = "showButton";
    roles[TitleRole] = "title";
    roles[IsPlayRole] = "isPlay";
    roles[SourceRole] = "source";
    roles[TimeRole] = "time";
    roles[FileNameRole] = "fileName";

    return roles;

}

void ValueModel::addObject(const DataObject &data)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data.append(const_cast<DataObject*>(&data));
    endInsertRows();
}

void ValueModel::deleteRow(int index)
{
    if(index < 0 || index >= m_data.count()) {
        return;
    }
    beginRemoveRows(QModelIndex(), index, index);
    m_data.removeAt(index);
    endRemoveRows();
}

DataObject* ValueModel::get(int index)
{
    if(index < 0 || index >= m_data.count()) {
        return 0;
    }

    return m_data[index];
}

void ValueModel::set(int row, const DataObject * data)
{
    if (row < 0 || row >= m_data.count()) {
        return;
    }
    m_data.replace(row, const_cast<DataObject *>(data));
    emit dataChanged(this->index(row), this->index(row));
}

// refresh a single row
void ValueModel::refreshRow(int row)
{
    emit dataChanged(index(row), index(row));
}
