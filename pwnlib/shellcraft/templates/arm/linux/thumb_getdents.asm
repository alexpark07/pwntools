<% from pwnlib.shellcraft import common, arm %>
<% from pwnlib.asm import cpp %>
<%page args="in_fd = None"/>
<%docstring>
``getdents`` - lists specific directory in thumb mode

	Args: 
		in_fd  (int/str): in  file descriptor
</%docstring>

	movs r0, #${in_fd}
	mov r1, sp
	movs r2, #255
	movs r7, ${cpp("SYS_getdents", arch = "thumb", os = "linux")}
	svc 1
