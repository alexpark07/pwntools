<% from pwnlib.shellcraft import common %>
<% from pwnlib.asm import cpp %>
<%docstring>Exit with 0 in thumb mode</%docstring>

	.code 16
	subs r0, r0, r0
	movs r7, #${cpp("SYS_exit", arch = "thumb", os = "linux")}
	svc 1
