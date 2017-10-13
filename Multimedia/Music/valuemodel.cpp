#include "valuemodel.h"

ValueModel::ValueModel(QObject *parent) : QAbstractListModel(parent)
{
    m_roleNames[NameRole] = "name";
}


ValueModel::~ValueModel()
{
}

int ValueModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    // return our data count
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

    const QColor &color = m_data.at(row);
    qDebug() << row << role << color;

    // A model can return data for different roles.
    // The default role is the display role.
    // it can be accesses in QML with "model.display"
    switch(role) {
    case NameRole:
        return color.name();
    case HueRole:
        return color.hueF();
    case SaturationRole:
        return color.saturationF();
    case BrightnessRole:
        return color.lightnessF();
    }
    // The view asked for other data, just return an empty QVariant
    return QVariant();
}

QHash<int, QByteArray> ValueModel::roleNames() const
{
    return m_roleNames;
}


void ValueModel::insert(int index, const QString &colorValue)
{
    if(index < 0 || index > m_data.count()) {
        return;
    }
    QColor color(colorValue);
    if(!color.isValid()) {
        return;
    }
    // view protocol (begin => manipulate => end]
    emit beginInsertRows(QModelIndex(), index, index);
    m_data.insert(index, colorValue);
    emit endInsertRows();
    // update our count property
    emit countChanged(m_data.count());
}

void ValueModel::append(const QString &colorValue)
{
    insert(count(), colorValue);
}

void ValueModel::remove(int index)
{
    if(index < 0 || index >= m_data.count()) {
        return;
    }
    emit beginRemoveRows(QModelIndex(), index, index);
    m_data.removeAt(index);
    emit endRemoveRows();
    // do not forget to update our count property
    emit countChanged(m_data.count());
}

int ValueModel::count() const
{
    return m_data.count();
}
