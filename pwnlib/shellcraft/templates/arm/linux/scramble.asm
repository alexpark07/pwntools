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

	add r6, pc, ${mainendlabel}-8
	bx r6

${mainlabel}:
	mov r4, #${256-int(size)}
	add r6, pc, ${synclabel}-20

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
	movs r7, #2
	movs r1, #2 
	mov r7, r7, lsl #19
	mov r1, r1, lsl #15
	sub r7, r7, r1
	add r7, r7, #2
	add r0, lr, #0
	add r1, lr, #${int(size)+1}
	sub r2, r2 ,r2
	svc 0
	b ${scodelabel}

${mainendlabel}:
	bl ${mainlabel}

${scodelabel}:

