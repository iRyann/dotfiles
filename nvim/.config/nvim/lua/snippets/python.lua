local ls = require("luasnip")
local s, t, i = ls.snippet, ls.text_node, ls.insert_node

return {
	s("pwn", {
		t({
			"#!/usr/bin/env python3",
			"from pwn import *",
			"context.update(arch='amd64', timeout=2)",
			"",
			"# petite condition pour faciliter le debug.",
			"# si je passe GDB ou LOCAL en argument a ./exploit.py,",
			"# l'exploit s'execute en local avec ou sans gdb:",
			"if args.GDB:  # debug: local exploit with tmux/gef",
			'    context.terminal = ["tmux", "splitw", "-h"]',
			'    p = gdb.debug("',
		}),
		i(1, "./bin"),
		t({ '", """', "    source /home/user/.gdbinit-gef.py", "    break *(" }),
		i(2, "tuto+122"),
		t({ ")", "    continue", '    """)', "elif args.LOCAL:  # exploit locally", '    p = process("' }),
		i(3, "./bin"),
		t({ '")', "else:  # exploit online", '    p = remote("' }),
		i(4, "mytarget.com"),
		t({ '", ' }),
		i(5, "5222"),
		t({ ")", "", "# --- payload ici ---", '# p.sendline(b"...")', "# print(p.recvall(timeout=1).decode())" }),
	}),
}
