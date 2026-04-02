![C'est de l'humour, btw](public/logo.png)

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
