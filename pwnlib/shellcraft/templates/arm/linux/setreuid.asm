<% from pwnlib.shellcraft import arm, common %>
<%docstring>setreuid(0, 0)</%docstring>
<%page args="ruid=0, euid=0"/>
<%docstring>
	setreuid to escalate privilege to ruid/euid
	Args: 
		ruid (str/int): real uid
		euid (str/int): effective uid
</%docstring>

	mov r0, ${ruid}
	mov r1, ${euid}
	svc SYS_setreuid
