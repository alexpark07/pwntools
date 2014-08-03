<% from pwnlib.shellcraft import common %>
<% from pwnlib.asm import cpp %>
<%page args="in_fd=None, out_fd=None, size=255"/>
<%docstring>
sends a file to user in thumb mode

	Args: 
		in_fd  (str/iny): in file descriptor
		out_fd (str/iny): out file descriptor
</%docstring>

	.code 16
	movs r0, #${out_fd}
	movs r1, #${in_fd}
	subs r2, r2, r2
	movs r3, #${size}
	movs r7, #${cpp("SYS_sendfile", arch = "thumb", os = "linux")}
	svc 1

