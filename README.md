Beispielprojekt Shopware mit Docker-Deployment
======================================================
Dieses Projekt ist ein Beispiel für eine Umgebung von Shopware mit Docker.
Das Konfigurationsfile docker-compose.yml beinhaltet alle notwendigen Ressourcen um den Shop ausführen zu können. Dazu gehören neben einer Datenbankinstanz (shopwaredb) auch der Webserver (shopware) und ein Server der ssh-Dienste bereitstellt.

Ausführen der Docker-Instanz
======================================================
Die Docker-Dienste müssen zur Ausführung konfiguriert sein. Ich empfehle die Docker-Toolbox, welche alle notwendigen Abhängigkeiten beinhaltet. [Docker-Toolbox](https://www.docker.com/products/docker-toolbox)
Nach dem Checkout des Beispielprojektes muss in der Konsole in das Projektverzeichnis gewechselt werden (ebene der docker-compose.yml), die Dienste können dann per Kommandozeile ausgeführt werden:
```bash
# Dienste Starten
docker-compose up - d

# Build ausführen (bei gestarteter Maschine)
docker-compose exec shopware sh build.sh

# Dienste stoppen
docker-compose stop

# Bash in maschine shopware starten (z.B. um apache neuzustarten)
docker-compose exec shopware bash

```
