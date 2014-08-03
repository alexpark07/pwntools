<% from pwnlib.shellcraft import common %>
<%page args="sock = 'r9'"/>
<%docstring>
	Args: [sock (imm/reg) = r9]
	Duplicates sock to stdin, stdout and stderr
</%docstring>
<%
	dup       = common.label("dup")
	looplabel = common.label("loop")
%>

	mov r9, ${sock}
	mov r8, #2

${looplabel}:
	mov r0, r9
	mov r1, r8
	svc SYS_dup2
	adds r8, #-1
	bpl ${looplabel}
