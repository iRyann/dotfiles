![C'est de l'humour, btw](public/logo.png)

---

## Stack technique

```
Windows
├── Windows Terminal   → terminal, SSH
├── VcXsrv             → Xserver pour zathura via X11 forwarding
└── ~/.ssh/config      → ForwardX11 yes

AlmaLinux VM
├── xauth + zathura
└── DISPLAY auto-set par SSH
```

## SSH — `almadev`

Le fichier `~/.ssh/config` sur Windows se trouve dans `C:\Users\<toi>\.ssh\config` (crée-le s'il n'existe pas).

```
# C:\Users\<toi>\.ssh\config

Host almadev
    HostName      192.168.x.x        # IP de ta VM VirtualBox — voir ci-dessous
    User          ryan               # ton user sur AlmaLinux
    Port          22
    ForwardX11    yes
    ForwardX11Trusted yes
    Compression   yes
    ServerAliveInterval 60
    ServerAliveCountMax 3
    IdentityFile  ~/.ssh/id_almadev  # optionnel, si tu veux une clé dédiée
```

**Trouver l'IP de la VM :**

```bash
# Sur AlmaLinux
ip a | grep inet
# Cherche une ligne genre 192.168.x.x sur enp0s3 ou eth0
```

**Configurer VirtualBox pour que SSH soit accessible :**

Tu as deux options réseau dans VirtualBox :

```
NAT (défaut)
  → VM invisible depuis Windows directement
  → Faut faire du port forwarding :
     VirtualBox > ta VM > Configuration > Réseau > Avancé > Redirection de ports
     Nom: SSH | Protocole: TCP | IP hôte: 127.0.0.1 | Port hôte: 2222 | Port invité: 22
  → Dans ~/.ssh/config : HostName 127.0.0.1 + Port 2222

Réseau par pont (Bridge) — plus simple
  → La VM a sa propre IP sur ton réseau local
  → SSH direct sans port forwarding
  → HostName = l'IP de la VM directement
```

Le bridge est plus simple, NAT est plus sûr en entreprise si tu ne veux pas exposer la VM sur le réseau.

---

**Générer une clé SSH pour ne pas taper le mot de passe à chaque fois :**

```powershell
# Dans PowerShell / Windows Terminal
ssh-keygen -t ed25519 -f "$env:USERPROFILE\.ssh\id_almadev" -C "almadev"
ssh-copy-id -i "$env:USERPROFILE\.ssh\id_almadev.pub" ryan@192.168.x.x
# (ou port 2222 si NAT : ssh-copy-id -p 2222 ...)
```

---

## VcXsrv

**Installation :**
Télécharger `vcxsrv-64.x.x.x.installer.exe` sur [sourceforge.net/projects/vcxsrv](https://sourceforge.net/projects/vcxsrv/).

**Lancement — le plus simple :** utiliser XLaunch (installé avec VcXsrv) avec ces paramètres :

```
Étape 1 — Display settings : Multiple windows
Étape 2 — Client startup  : Start no client
Étape 3 — Extra settings  :
           ☑ Clipboard
           ☑ Primary Selection
           ☑ Native opengl
           ☑ Disable access control   ← IMPORTANT pour X11 forwarding SSH
Étape 4 — Finish : Save configuration → bureau ou Startup
```

"Disable access control" correspond au flag `-ac` — sans ça, VcXsrv refuse les connexions X11 venant du tunnel SSH.

**Pour qu'il démarre automatiquement avec Windows :**

```
Win+R → shell:startup
→ colle le raccourci vers ton fichier .xlaunch ici
```

---

**Côté AlmaLinux, vérifier que sshd autorise le forwarding :**

```bash
sudo grep -E "X11Forwarding|X11UseLocalhost" /etc/ssh/sshd_config
# Doit retourner :
# X11Forwarding yes
# X11UseLocalhost yes   (ou absent, c'est la valeur par défaut)

# Si X11Forwarding est à "no" :
sudo sed -i 's/^X11Forwarding no/X11Forwarding yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd
```

---

## Tester que tout fonctionne

```bash
# 1. Connexion SSH depuis Windows Terminal
ssh almadev

# 2. Vérifier que DISPLAY est bien set
echo $DISPLAY
# doit afficher : localhost:10.0  (ou 11.0, 12.0...)

# 3. Test graphique minimal
xeyes   # une paire d'yeux doit apparaître dans une fenêtre Windows

# 4. Test zathura
zathura /chemin/vers/un.pdf
```

Si `$DISPLAY` est vide alors que X11Forwarding est activé des deux côtés, c'est quasi toujours `xauth` qui manque :

```bash
sudo dnf install -y xauth
# puis reconnecter SSH
```
