# Charger d'abord ta config commune
source ~/.gdbinit.d/common.gdb

# Commande pour charger pwndbg
define use_pwndbg
    source ~/.gdbinit.d/pwndbg.gdb
    echo Loaded pwndbg via selector\n
end

# Commande pour charger GEF
define use_gef
    source ~/.gdbinit.d/gef.gdb
    echo Loaded gef via selector\n
end

# Choix par défaut au démarrage
use_pwndbg

