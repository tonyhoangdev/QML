#ifndef ROLEENTRYMODEL_H
#define ROLEENTRYMODEL_H

#include <QtCore>
#include <QtGui>

class DynamicEntryModel  : public QAbstractListModel
{
    Q_OBJECT
    // gives the size of the model
    Q_PROPERTY(int count READ count NOTIFY countChanged)
    // gets a color at the index
    Q_INVOKABLE QColor get(int index);

public:
    explicit DynamicEntryModel(QObject *parent = 0);
    ~DynamicEntryModel();

    enum RoleNames {
        NameRole = Qt::UserRole,
        HueRole = Qt::UserRole+2,
        SaturationRole = Qt::UserRole+3,
        BrightnessRole = Qt::UserRole+4
    };

public: // QAbstractItemModel interface
    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;

    // inserts a color at the index (0 at begining, count-1 at end)
    Q_INVOKABLE void insert(int index, const QString& colorValue);
    // uses insert to insert a color at the end
    Q_INVOKABLE void append(const QString& colorValue);
    // removes a color from the index
    Q_INVOKABLE void remove(int index);
    // clear the whole model (e.g. reset)
    Q_INVOKABLE void clear();

protected:
    // return the roles mapping to be used by QML
    virtual QHash<int, QByteArray> roleNames() const override;
private:
    QList<QString> m_data;
    QHash<int, QByteArray> m_roleNames;
};

#endif // ROLEENTRYMODEL_H
