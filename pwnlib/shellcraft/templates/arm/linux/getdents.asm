<% from pwnlib.shellcraft import common, arm %>
<%page args="in_fd = None"/>
<%docstring>
``getdents`` - lists specific directory 

	Args: 
		in_fd  (int/str): in  file descriptor
</%docstring>

	mov r0, #${in_fd}
	mov r1, sp
	mov r2, #255
	svc SYS_getdents
