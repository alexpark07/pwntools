<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.asm import cpp %>
<%docstring>setreuid(0, 0) in thumb mode</%docstring>
<%page args="ruid=0, euid=0"/>
<%docstring>
	setreuid to escalate privilege to ruid/euid in thumb mode
	Args: 
		ruid (str/int): real uid
		euid (str/int): effective uid
</%docstring>

	movs r0, ${ruid}
	movs r1, ${euid}
	movs r7, ${cpp("SYS_setreuid", arch = "thumb", os = "linux")}
	svc 1
