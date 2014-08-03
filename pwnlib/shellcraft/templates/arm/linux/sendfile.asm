<% from pwnlib.shellcraft import common %>
<%page args="in_fd=None, out_fd=None, size=255"/>
<%docstring>
sends a file to user

	Args: 
		in_fd  (str/iny): in file descriptor
		out_fd (str/iny): out file descriptor
</%docstring>

	mov r0, #${out_fd}
	mov r1, #${in_fd}
	sub r2, r2, r2
	mov r3, #${size}
	svc SYS_sendfile

