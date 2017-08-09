#include <QGuiApplication>
#include <QQuickView>

int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);

    QQuickView view;
    QSurfaceFormat fmt;
    fmt.setDepthBufferSize(24);
    fmt.setStencilBufferSize(8);
    if (!QCoreApplication::arguments().contains(QStringLiteral("--nomultisample")))
        fmt.setSamples(4);
    view.setFormat(fmt);

    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.setSource(QUrl("qrc:/qmlshapedemo.qml"));
    view.resize(1024, 768);
    view.show();

    return app.exec();
}
