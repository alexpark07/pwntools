<% from pwnlib.shellcraft import arm, common %>
<%page args="size=None, key=None"/>
<%docstring>
scrambles shellcode to avoid bad chars such as 0x00
	Args:
		size (int): shellcode length
		key  (int): XOR key

	additional info:
		scrambler uses system call; __ARM_NR_cacheflush; to clear caches  
</%docstring>

<%
    mainlabel    = common.label("mainlabel")
    mainendlabel = common.label("mainendlabel")
    looplabel    = common.label("looplabel")
    synclabel    = common.label("synclabel")
    scodelabel   = common.label("scodelabel")
%>

	add r6, pc, #76
	bx r6

${mainlabel}:
	mov r4, #${256-int(size)}
	add r6, pc, #36

${looplabel}:
	cmp r4, #256
	bxhi r6
	sub r4, r4, #${256-int(size)}
	ldrb r5, [lr, r4]
	eor r5, r5, ${key}
	strb r5, [lr, r4]
	add r4, r4, #${256-int(size)+1}
	b ${looplabel}

${synclabel}:
	mov r2, #1
	mov r3, #2
	push {r2, r3}
	mov r0, sp
	mov r1, sp
	mov r7, #162
	svc 1
	b ${scodelabel}

${mainendlabel}:
	bl ${mainlabel}

${scodelabel}:

