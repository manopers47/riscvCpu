8000018c <test_2>:
8000018c:	00200193          	li	gp,2
80000190:	00000093          	li	ra,0
80000194:	00000113          	li	sp,0
80000198:	00208733          	add	a4,ra,sp
8000019c:	00000393          	li	t2,0
800001a0:	4c771663          	bne	a4,t2,8000066c <fail>

80000204 <test_7>:
80000204:	00700193          	li	gp,7
80000208:	800000b7          	lui	ra,0x80000
8000020c:	ffff8137          	lui	sp,0xffff8
80000210:	00208733          	add	a4,ra,sp
80000214:	7fff83b7          	lui	t2,0x7fff8
80000218:	44771a63          	bne	a4,t2,8000066c <fail>

800002a0 <test_12>:
800002a0:	00c00193          	li	gp,12
800002a4:	800000b7          	lui	ra,0x80000
800002a8:	fff08093          	add	ra,ra,-1 # 7fffffff <_start-0x1>
800002ac:	ffff8137          	lui	sp,0xffff8
800002b0:	00208733          	add	a4,ra,sp
800002b4:	7fff83b7          	lui	t2,0x7fff8
800002b8:	fff38393          	add	t2,t2,-1 # 7fff7fff <_start-0x8001>
800002bc:	3a771863          	bne	a4,t2,8000066c <fail>

80000324 <test_17>:
80000324:	01100193          	li	gp,17
80000328:	00d00093          	li	ra,13
8000032c:	00b00113          	li	sp,11
80000330:	002080b3          	add	ra,ra,sp
80000334:	01800393          	li	t2,24
80000338:	32709a63          	bne	ra,t2,8000066c <fail>

8000058c <test_32>:
8000058c:	02000193          	li	gp,32
80000590:	00000213          	li	tp,0
80000594:	00b00113          	li	sp,11
80000598:	00000013          	nop
8000059c:	00d00093          	li	ra,13
800005a0:	00208733          	add	a4,ra,sp
800005a4:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
800005a8:	00200293          	li	t0,2
800005ac:	fe5214e3          	bne	tp,t0,80000594 <test_32+0x8>
800005b0:	01800393          	li	t2,24
800005b4:	0a771c63          	bne	a4,t2,8000066c <fail>

800001a0 <test_3>:
800001a0:	00300193          	li	gp,3
800001a4:	00100093          	li	ra,1
800001a8:	00108713          	add	a4,ra,1
800001ac:	00200393          	li	t2,2
800001b0:	26771263          	bne	a4,t2,80000414 <fail>

80000208 <test_8>:
80000208:	00800193          	li	gp,8
8000020c:	00000093          	li	ra,0
80000210:	7ff08713          	add	a4,ra,2047
80000214:	7ff00393          	li	t2,2047
80000218:	1e771e63          	bne	a4,t2,80000414 <fail>

80000288 <test_13>:
80000288:	00d00193          	li	gp,13
8000028c:	00000093          	li	ra,0
80000290:	fff08713          	add	a4,ra,-1
80000294:	fff00393          	li	t2,-1
80000298:	16771e63          	bne	a4,t2,80000414 <fail>

800002f0 <test_18>:
800002f0:	01200193          	li	gp,18
800002f4:	00000213          	li	tp,0
800002f8:	00d00093          	li	ra,13
800002fc:	00b08713          	add	a4,ra,11
80000300:	00070313          	mv	t1,a4
80000304:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
80000308:	00200293          	li	t0,2
8000030c:	fe5216e3          	bne	tp,t0,800002f8 <test_18+0x8>
80000310:	01800393          	li	t2,24
80000314:	10731063          	bne	t1,t2,80000414 <fail>

800003c0 <test_23>:
800003c0:	01700193          	li	gp,23
800003c4:	00000213          	li	tp,0
800003c8:	00d00093          	li	ra,13
800003cc:	00000013          	nop
800003d0:	00000013          	nop
800003d4:	00908713          	add	a4,ra,9
800003d8:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
800003dc:	00200293          	li	t0,2
800003e0:	fe5214e3          	bne	tp,t0,800003c8 <test_23+0x8>
800003e4:	01600393          	li	t2,22
800003e8:	02771663          	bne	a4,t2,80000414 <fail>

800001bc <test_4>:
800001bc:	00400193          	li	gp,4
800001c0:	00300093          	li	ra,3
800001c4:	00700113          	li	sp,7
800001c8:	40208733          	sub	a4,ra,sp
800001cc:	ffc00393          	li	t2,-4
800001d0:	46771e63          	bne	a4,t2,8000064c <fail>

8000023c <test_9>:
8000023c:	00900193          	li	gp,9
80000240:	800000b7          	lui	ra,0x80000
80000244:	fff08093          	add	ra,ra,-1 # 7fffffff <_start-0x1>
80000248:	00000113          	li	sp,0
8000024c:	40208733          	sub	a4,ra,sp
80000250:	800003b7          	lui	t2,0x80000
80000254:	fff38393          	add	t2,t2,-1 # 7fffffff <_start-0x1>
80000258:	3e771a63          	bne	a4,t2,8000064c <fail>

800002d4 <test_14>:
800002d4:	00e00193          	li	gp,14
800002d8:	fff00093          	li	ra,-1
800002dc:	00100113          	li	sp,1
800002e0:	40208733          	sub	a4,ra,sp
800002e4:	ffe00393          	li	t2,-2
800002e8:	36771263          	bne	a4,t2,8000064c <fail>

80000348 <test_19>:
80000348:	01300193          	li	gp,19
8000034c:	00000213          	li	tp,0
80000350:	00d00093          	li	ra,13
80000354:	00b00113          	li	sp,11
80000358:	40208733          	sub	a4,ra,sp
8000035c:	00070313          	mv	t1,a4
80000360:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
80000364:	00200293          	li	t0,2
80000368:	fe5214e3          	bne	tp,t0,80000350 <test_19+0x8>
8000036c:	00200393          	li	t2,2
80000370:	2c731e63          	bne	t1,t2,8000064c <fail>

8000042c <test_24>:
8000042c:	01800193          	li	gp,24
80000430:	00000213          	li	tp,0
80000434:	00f00093          	li	ra,15
80000438:	00b00113          	li	sp,11
8000043c:	00000013          	nop
80000440:	00000013          	nop
80000444:	40208733          	sub	a4,ra,sp
80000448:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
8000044c:	00200293          	li	t0,2
80000450:	fe5212e3          	bne	tp,t0,80000434 <test_24+0x8>
80000454:	00400393          	li	t2,4
80000458:	1e771a63          	bne	a4,t2,8000064c <fail>

800001f8 <test_5>:
800001f8:	00500193          	li	gp,5
800001fc:	f00ff0b7          	lui	ra,0xf00ff
80000200:	00f08093          	add	ra,ra,15 # f00ff00f <_end+0x700fd00f>
80000204:	f0f0f137          	lui	sp,0xf0f0f
80000208:	0f010113          	add	sp,sp,240 # f0f0f0f0 <_end+0x70f0d0f0>
8000020c:	0020f733          	and	a4,ra,sp
80000210:	f000f3b7          	lui	t2,0xf000f
80000214:	42771863          	bne	a4,t2,80000644 <fail>

800002b4 <test_10>:
800002b4:	00a00193          	li	gp,10
800002b8:	00000213          	li	tp,0
800002bc:	0ff010b7          	lui	ra,0xff01
800002c0:	ff008093          	add	ra,ra,-16 # ff00ff0 <_start-0x700ff010>
800002c4:	f0f0f137          	lui	sp,0xf0f0f
800002c8:	0f010113          	add	sp,sp,240 # f0f0f0f0 <_end+0x70f0d0f0>
800002cc:	0020f733          	and	a4,ra,sp
800002d0:	00000013          	nop
800002d4:	00070313          	mv	t1,a4
800002d8:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
800002dc:	00200293          	li	t0,2
800002e0:	fc521ee3          	bne	tp,t0,800002bc <test_10+0x8>
800002e4:	00f003b7          	lui	t2,0xf00
800002e8:	0f038393          	add	t2,t2,240 # f000f0 <_start-0x7f0fff10>
800002ec:	34731c63          	bne	t1,t2,80000644 <fail>

800003d8 <test_15>:
800003d8:	00f00193          	li	gp,15
800003dc:	00000213          	li	tp,0
800003e0:	ff0100b7          	lui	ra,0xff010
800003e4:	f0008093          	add	ra,ra,-256 # ff00ff00 <_end+0x7f00df00>
800003e8:	00000013          	nop
800003ec:	0f0f1137          	lui	sp,0xf0f1
800003f0:	f0f10113          	add	sp,sp,-241 # f0f0f0f <_start-0x70f0f0f1>
800003f4:	0020f733          	and	a4,ra,sp
800003f8:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
800003fc:	00200293          	li	t0,2
80000400:	fe5210e3          	bne	tp,t0,800003e0 <test_15+0x8>
80000404:	0f0013b7          	lui	t2,0xf001
80000408:	f0038393          	add	t2,t2,-256 # f000f00 <_start-0x70fff100>
8000040c:	22771c63          	bne	a4,t2,80000644 <fail>

800001f0 <test_6>:
800001f0:	00600193          	li	gp,6
800001f4:	ff0100b7          	lui	ra,0xff010
800001f8:	f0008093          	add	ra,ra,-256 # ff00ff00 <_end+0x7f00df00>
800001fc:	0f00f093          	and	ra,ra,240
80000200:	00000393          	li	t2,0
80000204:	14709463          	bne	ra,t2,8000034c <fail>

800002c4 <test_11>:
800002c4:	00b00193          	li	gp,11
800002c8:	00000213          	li	tp,0
800002cc:	00ff00b7          	lui	ra,0xff0
800002d0:	0ff08093          	add	ra,ra,255 # ff00ff <_start-0x7f00ff01>
800002d4:	00000013          	nop
800002d8:	0f00f713          	and	a4,ra,240
800002dc:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
800002e0:	00200293          	li	t0,2
800002e4:	fe5214e3          	bne	tp,t0,800002cc <test_11+0x8>
800002e8:	0f000393          	li	t2,240
800002ec:	06771063          	bne	a4,t2,8000034c <fail>

8000018c <test_102>:
8000018c:	00200193          	li	gp,2
80000190:	00000093          	li	ra,0
80000194:	0100026f          	jal	tp,800001a4 <target_2>

80000198 <linkaddr_2>:
80000198:	00000013          	nop
8000019c:	00000013          	nop
800001a0:	0400006f          	j	800001e0 <fail>

800001a4 <target_2>:
800001a4:	00000117          	auipc	sp,0x0
800001a8:	ff410113          	add	sp,sp,-12 # 80000198 <linkaddr_2>
800001ac:	02411a63          	bne	sp,tp,800001e0 <fail>

800001b0 <test_103>:
800001b0:	00300193          	li	gp,3
800001b4:	00100093          	li	ra,1
800001b8:	0140006f          	j	800001cc <test_3+0x1c>
800001bc:	00108093          	add	ra,ra,1
800001c0:	00108093          	add	ra,ra,1
800001c4:	00108093          	add	ra,ra,1
800001c8:	00108093          	add	ra,ra,1
800001cc:	00108093          	add	ra,ra,1
800001d0:	00108093          	add	ra,ra,1
800001d4:	00300393          	li	t2,3
800001d8:	00709463          	bne	ra,t2,800001e0 <fail>
800001dc:	02301063          	bne	zero,gp,800001fc <pass>

800002fc <test_107>:
800002fc:	00700193          	li	gp,7
80000300:	00100293          	li	t0,1
80000304:	00000317          	auipc	t1,0x0
80000308:	01c30313          	add	t1,t1,28 # 8000026c <test_7+0x24> :: 320
8000030c:	ffc30067          	jr	-4(t1) # 31c
80000310:	00128293          	add	t0,t0,1
80000314:	00128293          	add	t0,t0,1
80000318:	00128293          	add	t0,t0,1
8000031c:	00128293          	add	t0,t0,1
80000320:	00128293          	add	t0,t0,1
80000324:	00128293          	add	t0,t0,1
80000328:	00400393          	li	t2,4
8000032c:	00729463          	bne	t0,t2,80000280 <fail>
#80000330:	02301063          	bne	zero,gp,8000029c <pass>

8000021c <test_106>:
8000021c:	00600193          	li	gp,6
80000220:	00ff07b7          	lui	a5,0xff0
80000224:	0ff78793          	add	a5,a5,255 # ff00ff <_start-0x7f00ff01>
80000228:	00002097          	auipc	ra,0x2
8000022c:	de408093          	add	ra,ra,-540 # 8000200c <tdat4>
80000230:	ff40a703          	lw	a4,-12(ra)
80000234:	00ff03b7          	lui	t2,0xff0
80000238:	0ff38393          	add	t2,t2,255 # ff00ff <_start-0x7f00ff01>
8000023c:	20771e63          	bne	a4,t2,80000458 <fail>

800002cc <test_111>:
800002cc:	00b00193          	li	gp,11
800002d0:	00002097          	auipc	ra,0x2
800002d4:	d3008093          	add	ra,ra,-720 # 80002000 <begin_signature>
800002d8:	ffd08093          	add	ra,ra,-3
800002dc:	0070a283          	lw	t0,7(ra)
800002e0:	ff0103b7          	lui	t2,0xff010
800002e4:	f0038393          	add	t2,t2,-256 # ff00ff00 <_end+0x7f00def0>
800002e8:	16729863          	bne	t0,t2,80000458 <fail>

8000018c <test_202>:
8000018c:	00200193          	li	gp,2
80000190:	00000093          	li	ra,0
80000194:	00100113          	li	sp,1
80000198:	00209663          	bne	ra,sp,800001a4 <test_2+0x18>
8000019c:	2a301a63          	bne	zero,gp,80000450 <fail>
800001a0:	00301663          	bne	zero,gp,800001ac <test_3>
800001a4:	fe209ee3          	bne	ra,sp,800001a0 <test_2+0x14>
800001a8:	2a301463          	bne	zero,gp,80000450 <fail>

80000228 <test_207>:
80000228:	00700193          	li	gp,7
8000022c:	00100093          	li	ra,1
80000230:	00100113          	li	sp,1
80000234:	00209463          	bne	ra,sp,8000023c <test_7+0x14>
80000238:	00301463          	bne	zero,gp,80000240 <test_7+0x18>
8000023c:	20301a63          	bne	zero,gp,80000450 <fail>
80000240:	fe209ee3          	bne	ra,sp,8000023c <test_7+0x14>

800003e0 <test_320>:
800003e0:	01400193          	li	gp,20
800003e4:	00000213          	li	tp,0
800003e8:	fff00093          	li	ra,-1
800003ec:	00000113          	li	sp,0
800003f0:	00000013          	nop
800003f4:	00000013          	nop
800003f8:	0a20da63          	bge	ra,sp,800004ac <fail>
800003fc:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
80000400:	00200293          	li	t0,2
80000404:	fe5212e3          	bne	tp,t0,800003e8 <test_320+0x8>

80000408 <test_321>:
80000408:	01500193          	li	gp,21
8000040c:	00000213          	li	tp,0
80000410:	fff00093          	li	ra,-1
80000414:	00000013          	nop
80000418:	00000113          	li	sp,0
8000041c:	0820d863          	bge	ra,sp,800004ac <fail>
80000420:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
80000424:	00200293          	li	t0,2
80000428:	fe5214e3          	bne	tp,t0,80000410 <test_321+0x8>

800003f4 <test_420>:
800003f4:	01400193          	li	gp,20
800003f8:	00000213          	li	tp,0
800003fc:	00000093          	li	ra,0
80000400:	00000013          	nop
80000404:	00000013          	nop
80000408:	fff00113          	li	sp,-1
8000040c:	0420c063          	blt	ra,sp,8000044c <fail>
80000410:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
80000414:	00200293          	li	t0,2
80000418:	fe5212e3          	bne	tp,t0,800003fc <test_420+0x8>

8000041c <test_421>:
8000041c:	01500193          	li	gp,21
80000420:	00100093          	li	ra,1
80000424:	00104a63          	bgtz	ra,80000438 <test_421+0x1c>
80000428:	00108093          	add	ra,ra,1
8000042c:	00108093          	add	ra,ra,1
80000430:	00108093          	add	ra,ra,1
80000434:	00108093          	add	ra,ra,1
80000438:	00108093          	add	ra,ra,1
8000043c:	00108093          	add	ra,ra,1
80000440:	00300393          	li	t2,3
80000444:	00709463          	bne	ra,t2,8000044c <fail>
80000448:	02301063          	bne	zero,gp,80000468 <pass>

800003ac <test_512>:
800003ac:	00c00193          	li	gp,12
800003b0:	00000213          	li	tp,0
800003b4:	aabbd0b7          	lui	ra,0xaabbd
800003b8:	cdd08093          	add	ra,ra,-803 # aabbccdd <_end+0x2abbacad>
800003bc:	00002117          	auipc	sp,0x2
800003c0:	c4410113          	add	sp,sp,-956 # 80002000 <begin_signature>
800003c4:	00112023          	sw	ra,0(sp)
800003c8:	00012703          	lw	a4,0(sp)
800003cc:	aabbd3b7          	lui	t2,0xaabbd
800003d0:	cdd38393          	add	t2,t2,-803 # aabbccdd <_end+0x2abbacad>
800003d4:	2a771e63          	bne	a4,t2,80000690 <fail>
800003d8:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
800003dc:	00200293          	li	t0,2
800003e0:	fc521ae3          	bne	tp,t0,800003b4 <test_512+0x8>

800004dc <test_17>:
800004dc:	01100193          	li	gp,17
800004e0:	00000213          	li	tp,0
800004e4:	bccde0b7          	lui	ra,0xbccde
800004e8:	aab08093          	add	ra,ra,-1365 # bccddaab <_end+0x3ccdba7b>
800004ec:	00000013          	nop
800004f0:	00000013          	nop
800004f4:	00002117          	auipc	sp,0x2
800004f8:	b0c10113          	add	sp,sp,-1268 # 80002000 <begin_signature>
800004fc:	00112a23          	sw	ra,20(sp)
80000500:	01412703          	lw	a4,20(sp)
80000504:	bccde3b7          	lui	t2,0xbccde
80000508:	aab38393          	add	t2,t2,-1365 # bccddaab <_end+0x3ccdba7b>
8000050c:	18771263          	bne	a4,t2,80000690 <fail>
80000510:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
80000514:	00200293          	li	t0,2
80000518:	fc5216e3          	bne	tp,t0,800004e4 <test_17+0x8>

800001f8 <test_505>:
800001f8:	00500193          	li	gp,5
800001fc:	f00ff0b7          	lui	ra,0xf00ff
80000200:	00f08093          	add	ra,ra,15 # f00ff00f <_end+0x700fd00f>
80000204:	f0f0f137          	lui	sp,0xf0f0f
80000208:	0f010113          	add	sp,sp,240 # f0f0f0f0 <_end+0x70f0d0f0>
8000020c:	0020e733          	or	a4,ra,sp
80000210:	f0fff3b7          	lui	t2,0xf0fff
80000214:	0ff38393          	add	t2,t2,255 # f0fff0ff <_end+0x70ffd0ff>
80000218:	42771c63          	bne	a4,t2,80000650 <fail>

800002b8 <test_510>:
800002b8:	00a00193          	li	gp,10
800002bc:	00000213          	li	tp,0
800002c0:	0ff010b7          	lui	ra,0xff01
800002c4:	ff008093          	add	ra,ra,-16 # ff00ff0 <_start-0x700ff010>
800002c8:	f0f0f137          	lui	sp,0xf0f0f
800002cc:	0f010113          	add	sp,sp,240 # f0f0f0f0 <_end+0x70f0d0f0>
800002d0:	0020e733          	or	a4,ra,sp
800002d4:	00000013          	nop
800002d8:	00070313          	mv	t1,a4
800002dc:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
800002e0:	00200293          	li	t0,2
800002e4:	fc521ee3          	bne	tp,t0,800002c0 <test_510+0x8>
800002e8:	fff103b7          	lui	t2,0xfff10
800002ec:	ff038393          	add	t2,t2,-16 # fff0fff0 <_end+0x7ff0dff0>
800002f0:	36731063          	bne	t1,t2,80000650 <fail>

800002ec <test_613>:
800002ec:	00d00193          	li	gp,13
800002f0:	00000213          	li	tp,0
800002f4:	00000093          	li	ra,0
800002f8:	00000013          	nop
800002fc:	fff00113          	li	sp,-1
80000300:	00000013          	nop
80000304:	14208463          	beq	ra,sp,8000044c <fail>
80000308:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
8000030c:	00200293          	li	t0,2
80000310:	fe5212e3          	bne	tp,t0,800002f4 <test_613+0x8>

80000314 <test_614>:
80000314:	00e00193          	li	gp,14
80000318:	00000213          	li	tp,0
8000031c:	00000093          	li	ra,0
80000320:	00000013          	nop
80000324:	00000013          	nop
80000328:	fff00113          	li	sp,-1
8000032c:	12208063          	beq	ra,sp,8000044c <fail>
80000330:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
80000334:	00200293          	li	t0,2
80000338:	fe5212e3          	bne	tp,t0,8000031c <test_614+0x8>

8000018c <test_702>:
8000018c:	00200193          	li	gp,2
80000190:	00000293          	li	t0,0
80000194:	00000317          	auipc	t1,0x0
80000198:	01030313          	add	t1,t1,16 # 800001a4 <target_702>
8000019c:	000302e7          	jalr	t0,t1

800001a0 <linkaddr_702>:
800001a0:	0e00006f          	j	80000280 <fail>

800001a4 <target_702>:
800001a4:	00000317          	auipc	t1,0x0
800001a8:	ffc30313          	add	t1,t1,-4 # 800001a0 <linkaddr_702>
800001ac:	0c629a63          	bne	t0,t1,80000280 <fail>

800001b0 <test_703>:
800001b0:	00300193          	li	gp,3
800001b4:	00000297          	auipc	t0,0x0
800001b8:	01028293          	add	t0,t0,16 # 800001c4 <target_3>
800001bc:	000282e7          	jalr	t0,t0

800001c0 <linkaddr_3>:
800001c0:	0c00006f          	j	80000280 <fail>

800001c4 <target_3>:
800001c4:	00000317          	auipc	t1,0x0
800001c8:	ffc30313          	add	t1,t1,-4 # 800001c0 <linkaddr_3>
800001cc:	0a629a63          	bne	t0,t1,80000280 <fail>

800001d0 <test_704>:
800001d0:	00400193          	li	gp,4
800001d4:	00000213          	li	tp,0
800001d8:	00000317          	auipc	t1,0x0
800001dc:	01030313          	add	t1,t1,16 # 800001e8 <test_704+0x18>
800001e0:	000306e7          	jalr	a3,t1
800001e4:	08301e63          	bne	zero,gp,80000280 <fail>
800001e8:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
800001ec:	00200293          	li	t0,2
800001f0:	fe5214e3          	bne	tp,t0,800001d8 <test_4+0x8>

800001f4 <test_705>:
800001f4:	00500193          	li	gp,5
800001f8:	00000213          	li	tp,0
800001fc:	00000317          	auipc	t1,0x0
80000200:	01430313          	add	t1,t1,20 # 80000210 <test_705+0x1c>
80000204:	00000013          	nop
80000208:	000306e7          	jalr	a3,t1
8000020c:	06301a63          	bne	zero,gp,80000280 <fail>
80000210:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
80000214:	00200293          	li	t0,2
80000218:	fe5212e3          	bne	tp,t0,800001fc <test_705+0x8>

8000021c <test_706>:
8000021c:	00600193          	li	gp,6
80000220:	00000213          	li	tp,0
80000224:	00000317          	auipc	t1,0x0
80000228:	01830313          	add	t1,t1,24 # 8000023c <test_706+0x20>
8000022c:	00000013          	nop
80000230:	00000013          	nop
80000234:	000306e7          	jalr	a3,t1
80000238:	04301463          	bne	zero,gp,80000280 <fail>
8000023c:	00120213          	add	tp,tp,1 # 1 <_start-0x7fffffff>
80000240:	00200293          	li	t0,2
80000244:	fe5210e3          	bne	tp,t0,80000224 <test_706+0x8>

80000248 <test_707>:
80000248:	00700193          	li	gp,7
8000024c:	00100293          	li	t0,1
80000250:	00000317          	auipc	t1,0x0
80000254:	01c30313          	add	t1,t1,28 # 8000026c <test_707+0x24>
80000258:	ffc30067          	jr	-4(t1)
8000025c:	00128293          	add	t0,t0,1
80000260:	00128293          	add	t0,t0,1
80000264:	00128293          	add	t0,t0,1
80000268:	00128293          	add	t0,t0,1
8000026c:	00128293          	add	t0,t0,1
80000270:	00128293          	add	t0,t0,1
80000274:	00400393          	li	t2,4
80000278:	00729463          	bne	t0,t2,80000280 <fail>
8000027c:	02301063          	bne	zero,gp,8000029c <pass>

pass: #fence
li      x3,1
addi     x7, x0, 0x5a5
li      a0,0
jal	end


fail: #fence

#beqz    x3,80000670 <fail+0x4>
sll     x3,x3,0x1
or      x3,x3,1
addi     x7, x0, 0xa5
mv      a0,x3

end:  
nop
nop
nop
nop
nop