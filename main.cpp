#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "box2dplugin.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    Box2DPlugin plugin;
    plugin.registerTypes("Box2D");

    QScopedPointer<QmlApplicationViewer> viewer(QmlApplicationViewer::create());

    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);
    viewer->setMainQmlFile(QLatin1String("qml/Quickanoid/main.qml"));
    viewer->showExpanded();

    return app->exec();
}
