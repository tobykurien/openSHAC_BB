
#include "Config.hpp"

namespace shac
{
    namespace config
    {
        Configurator::Configurator()
        {
            read();
        }

        Configurator::~Configurator()
        {
        }

        void Configurator::read()
        {
            if (!settings.value("accessToken").isNull())
            {
                accessToken = settings.value("accessToken").toString();
            }
            if (!settings.value("server").isNull())
            {
                server = settings.value("server").toString();
            }
            if (!settings.value("port").isNull())
            {
                port = settings.value("port").toString();
            }
        }

        void Configurator::write()
        {
            if (!accessToken.isNull())
            {
                settings.setValue("accessToken", accessToken);
            }
            if (!server.isNull())
            {
                settings.setValue("server", server);
            }
            if (!port.isNull())
            {
                settings.setValue("port", port);
            }
        }

        QString Configurator::getAccessToken()
        {
            return accessToken;
        }

        void Configurator::setAccessToken(QString _accessToken)
        {
            accessToken = _accessToken;
            write();
        }

        void Configurator::resetAccessToken()
        {
            accessToken.clear();
            write();
        }


        QString Configurator::getServer()
        {
            return server;
        }

        void Configurator::setServer(QString _server)
        {
            server = _server;
            write();
        }

        void Configurator::resetServer()
        {
            server.clear();
            write();
        }

        QString Configurator::getPort()
        {
            return port;
        }

        void Configurator::setPort(QString _port)
        {
            port = _port;
            write();
        }

        void Configurator::resetPort()
        {
            port.clear();
            write();
        }

    }
}
