#ifndef VALUEMODEL_H
#define VALUEMODEL_H

#include <QAbstractListModel>
#include <QStringList>
#include "dataobject.h"

class ValueModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int currentId READ currentId WRITE setCurrentId NOTIFY currentIdChanged)

public:
    explicit ValueModel(QObject *parent = nullptr);
    ~ValueModel();

    enum RoleNames {
        ShowButtonRole = Qt::UserRole,
        TitleRole = Qt::UserRole+2,
        IsPlayRole = Qt::UserRole+3,
        SourceRole = Qt::UserRole+4,
        TimeRole = Qt::UserRole+5,
        FileNameRole = Qt::UserRole+6,
    };

    void addObject(const DataObject &data);
    int rowCount(const QModelIndex & parent = QModelIndex()) const;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    Q_INVOKABLE void deleteRow(int index);
    Q_INVOKABLE DataObject* get(int index);
    Q_INVOKABLE void set(int row, const DataObject * data);
    Q_INVOKABLE void refreshRow(int row);


    int currentId() const;

    Q_INVOKABLE void next();
    Q_INVOKABLE void prev();

signals:
    void currentIdChanged(int currentId);

public slots:
    void setCurrentId(int currentId);

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<DataObject*> m_data;
    int m_currentId;

signals:
};

#endif // VALUEMODEL_H
