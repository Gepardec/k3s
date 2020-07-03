**************
Bastion Host
**************

Verbindung zu Raspberry Pi mit SSH und Key Authentifizierung

In diesem Abschnitt seht Ihr wie Ihr die SSH Keys auf dem Raspberry Pi einrichtet und dann nutzt um eine gesicherte Verbindung zum Bastion Host auf nehmt.

Als erstes müssen wir ein Schlüsselpaar erstellen mit dem wir uns mittels public/private Schlüssel Authentifizieren können.

SSH Schlüssel generieren in Linux:

Das Generieren der SSH Schlüssel ist einfacher in Linux als in Windows da die benötigte Software bereits in das Betriebssystem integriert ist.

1.) Öffne ein Terminal und führe das folgende Kommando aus: 
    # ssh-keygen

2.) Mit dem laufenden ssh-keygen Tool wirst du als erstes gefragt eine Datei anzugeben in dem die       Schlüssel gespeichert werden sollen. Wählst du keine Datei aus wird der default Pfad               /home/pi/.ssh/id_rsa genommen.
3.) Als nächstes solltest du ein Passphrase eingeben welche deine SSH Keys vor unbefugten Zugang       schützt. Sollstest du keine Passphrase angeben sind die SSH schlüssel ungeschützt vor Diebstahl     oder unbefugten Nutzern.
4.) Jetzt hast du die Auswahl den SSH public Key mittels ssh-copy-id Tool zu kopieren oder manuell     den Schlüssel selbst zu kopieren. Entscheidest du dich dazu den Schlüssel manuell zu kopieren,     folge den Stufen 5 und 6. Sonst springe direkt zu nächsten Sektion mit dem Titel “Kopiere den       public Key mittels SSH Tools”.
5.) Der SSH Schlüssel sollte jetzt generiert sein damit wir uns den den Inhalt des public Keyfiles     schnappen können. Führe den folgenden Befehl aus um den Inhalt des Keyfiles in den                 Zwischenspeicher zu legen:
    # cat ~/.ssh/id_rsa.pub 
6.) Mit dem Inhalt des public Keyfiles zu hand können wir jetzt zum Abschnitt mit dem Titel             “Manuelles Kopieren des public Keys” springen.

Kopiere den public Key mittels SSH Tools

1.) Führe auf deiner Maschine den folgenden Befehl aus, um den Schlüssel über das Netzwerk zum         gewünschten Raspberry Pi zu übertragen. Ändere IP_ADDRESS zur richtigen Adresse des Raspberry       Pi’s zu dem du den Key schicken willst. Der Raspberry wird dich auffordern deinen Username und     dein Passwort einzugeben damit der Schlüssel zum Raspberry geschickt werden kann.
    #  ssh-copy-id -i ~/.ssh/id_rsa IP_ADDRESS

    Ist das erledigt, wird der Schlüssel automatisch den authorized_keys File angefügt.

Manuelles Kopieren des public Keys

Logge dich in deinen Raspberry Pi ein und führe die folgenden Befehle aus:
1.) Als erstes erzeugen wir den korrekten Ordner für den Schlüssel und setzen die richtigen Rechte     dafür:
    # install -d -m 700 ~/.ssh
2.) Als nächstes öffnen wir das File in welches wir den Schlüssel speichern wollen:
    # nano ~/.ssh/authorized_keys
3.) Copy und paste den Schlüssel in das File. SSH wird alle Verbindungsanfragen gegen diesen           öffentlichen Schlüssel authentifizieren.
4.) Ist das erledigt, speichere die Änderungen durch drücken von Strg + X , dann Y und anschließend     Enter.
5.) Anschließen werden wir noch die richtigen Rechte zuweisen damit es auch gelesen werden kann         wenn jemand versucht sich über SSH anzumelden. Solltest du nicht der standard Nutzer “pi” sein,     stelle sicher dass du das vorkommen des Textes “pi” im Befehl zum Namen des richtigen Nutzer       änderst.
    #  sudo chmod 644 ~/.ssh/authorized_keys
    #  sudo chown pi:pi ~/.ssh/authorized_keys
6.) Abschließend führen wir einen Test-Login durch um zu prüfen das alles korrekt funktioniert         bevor wir das Anmelden mittels Passwort/Username sperren und nur mehr Authentifizierung mittel     Key erlauben. 

SSH Schlüssel generieren in Windows:

Um Schlüssel auf einen Windows-basierenden System erstellen zu können nutzen wir das “PuTTY” SSH Programm. Stellt sicher dass Ihr euch das volle Softwarepaket von PuTTY downloaded welches auch PuTTYgen enthält.

1.) Als erstes müssen wir die heruntergeladene Software auf unserem Windows Rechner installieren       und dann die Software PuTTYgen öffnen.
2.) Wenn PuTTYgen geöffnet ist, klick auf den “Generate” Button und bewege deine Maus auf der           offenen Oberfläche zufällig hin und her. Diese zufälligen Bewegungen werden als “echtes”           Zufälliges Element für die generierung der Keys genutzt.
3.) Sind die Schlüssel generiert, müssen wir noch ein paar Dinge erledigen.
    Setzte einen Namen für die Schlüssel.
    (OPTIONAL) Setzte einen Passkey welcher eine zweite Sicherheitsschicht bietet sollte der           Schlüssel in die falschen Hände geraten.
    Speichere den public und private Key auf deinem Rechner.
    Kopiere den public Key aus der Textbox in PuTTYgen.
4.) Der nächste Schritt ist wie wir den public SSH Schlüssel in den Raspberry Pi integrieren.

Verbinden mit dem privaten Schlüssel in Linux

1.) Solange du den Rechner verwendest auf dem wir das Schlüsselpaar erstellt haben für die             Verbindung nutzt, ist das nutzen des privaten Schlüssels sehr einfach. Das SSH tool versucht       standardmäßig den Schlüssel für die Verbindung zu nutzen, wenn du eine SSH Verbindung aufbauen     willst. Wenn es der Fall ist das du den gleichen Rechner verwendest kannst du den Befehl eins       zu eins übernehmen.
    # ssh IP_ADDRESS
2.) Wenn du eine Passphrase gesetzt hast wirst du jetzt um diese gebeten. Nachdem du die korrekte       Passphrase eingegeben hast solltest du mit dem Remote Host verbunden sein. Wenn du nicht jedes     mal die Passphrase eingeben willst, keine Sorge wir werden später sehen wie wir die Passphrase     cache’n können.

Verbinden mit dem privaten Schlüssel mit PuTTY und Windows

Das Verbinden über PuTTY ist ein recht einfacher Vorgang der niemandem Probleme bereiten sollte.
1.) Starte PuTTY auf deinem Windows Rechner und gib die IP des Raspberries ein.
2.) Danach klicke auf “Connections” => “SSH” => Auth => Browse. Wähle dann deine  privaten             Schlüssel aus und dann drücke auf “Open”.
3.) Wenn jetzt die Verbindung aufgebaut wird wirst du als erstes um deinen Username gefragt,           gefolgt von der Passphrase. Nachdem du die richtigen Daten eingegeben hast solltest du mit dem     Raspberry verbunden sein.

Entfernen der Passwort Authentifizierung

1.) Um die Passwort Authentifizierung zu deaktivieren müssen wir die “sshd-config” Datei verändern.     Damit können wir das Verhalten des SSH-Daemon beeinflussen.
    # sudo nano /etc/ssh/sshd_config
2.) Wir müssen jetzt die Zeile mit dem Inhalt “#PasswordAuthentication yes” finden und das yes auf     no ändern und das # muss entfernt werden. Wenn du Probleme mit dem finden hast kannst du           mittels Strg + W dir die Sucher erleichtern (wenn du nano Editor verwendest).
    Finde:
    #PasswordAuthentication yes
    Ändere zu:
    PasswordAuthentication no
3.) Speichere und verlasse den Editor mittels Strg + X, Y und Enter.
4.) Starte jetzt den Raspberry Pi neu damit die Änderungen wirkung zeigen. Stelle sicher das die       Verbindung über SSH und dem Schlüssel funktioniert bevor du die User und Passwort                   Authentifizierung deaktivierst oder du sperrst dich aus deinem Raspberry aus.
5.) Wenn alles funktioniert hat sollte es nicht mehr möglich sein sich mit dem Raspberry zu             verbinden ohne den richtigen Schlüssel zu haben.

