<% from pwnlib.shellcraft import common %>
<%docstring>Exit with 0</%docstring>

	sub r0, r0, r0
	svc SYS_exit
