define pwndbg
    source ~/.gdbinit.d/pwndbg.gdb
    echo Loaded Pwndbg\n
end

define gef
    source ~/.gdbinit.d/gef.gdb
    echo Loaded GEF\n
end

# Charger automatiquement un choix par défaut :
pwndbg
