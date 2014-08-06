<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.asm import cpp %>
<%docstring>setregid(0, 0) in thumb mode</%docstring>
<%page args="rgid=0, egid=0"/>
<%docstring>
	setregid to escalate privilege to rgid/egid in thumb mode
	Args: 
		rgid (str/int): real gid
		egid (str/int): effective gid
</%docstring>

	movs r0, ${rgid}
	movs r1, ${egid}
	movs r7, ${cpp("SYS_setregid", arch = "thumb", os = "linux")}
	svc 1
