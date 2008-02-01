Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from web26713.mail.ukl.yahoo.com ([217.146.177.70])
	by bombadil.infradead.org with smtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JKw3m-0003uo-Vy
	for kexec@lists.infradead.org; Fri, 01 Feb 2008 13:36:09 +0000
Date: Fri, 1 Feb 2008 14:35:57 +0100 (CET)
From: Matteo Pampolini <matteo_pampolini@yahoo.it>
Subject: Still on kexec for SH4 architecture, please help
MIME-Version: 1.0
Message-ID: <971512.87994.qm@web26713.mail.ukl.yahoo.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello there,

my name is Matteo and I'm writing from Italy. As you
can probably understand from the subject, I work with
Paolo Cortesi that recently asked for help on this
issue, unfortunately he has problems posting a
readable message, so here I am.

We are working on an SH4 architecture and we have to
need to replace our running kernel with a new one,
that's why we are using kexec, of course (BTW, a
stupid question: the new kernel will have all the RAM
available as the first one, am I right? No memory
pages are wasted during the transition, aren't they?).

We downloaded kexec-tools-testing-20071030 package, we
enabled kexec support in kernel, and launched:

./kexec --load --type=zImage-sh
--append="console=ttyAS1,115200" --empty-zero=84401000
zImage

./kexec -e

and the result is always an oops:

Starting new kernel
kexec information
  segment[0]: 0x0c001000 - 0x0c002000 (0x00001000)
  segment[1]: 0x0c210000 - 0x0c387000 (0x00177000)
  start     : 0x8c210000

illegal slot instruction: 01a0 [#1]

Pid : 92, Comm:                kexec
PC is at 0x8c210008
PC  : 8c210008 SP  : 8a710000 SR  : 400080f0 TEA :
2966e480    Not tainted
R0  : 00000004 R1  : fffffff0 R2  : a0000000 R3  :
00000000
R4  : aa7105ec R5  : ac387000 R6  : 8c210000 R7  :
80000000
R8  : 00001000 R9  : a0000000 R10 : 8a89c600 R11 :
8a70f000
R12 : 8441ab00 R13 : 0a710002 R14 : 00000000
MACH: 00000000 MACL: 00000000 GBR : 29573b18 PR  :
84411b02

Apparently is the old kernel that crashes during
relocation, but I'm not sure of it.

The empty_zero value is grabbed from System.map, but
please tell me, why start is 8c210000? I had a look at
kexec sources for SH, saw that some masks are applied
to addresses, but did not understand why.

Any help is really really appreciated, thank you all.

Matteo.


      ___________________________________ 
L'email della prossima generazione? Puoi averla con la nuova Yahoo! Mail: http://it.docs.yahoo.com/nowyoucan.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
