<% from pwnlib.shellcraft import arm, common %>
<%docstring>setregid(0, 0)</%docstring>
<%page args="rgid=0, egid=0"/>
<%docstring>
	setregid to escalate privilege to rgid/egid
	Args: 
		rgid (str/int): real gid
		egid (str/int): effective gid
</%docstring>

	mov r0, ${rgid}
	mov r1, ${egid}
	svc SYS_setregid
