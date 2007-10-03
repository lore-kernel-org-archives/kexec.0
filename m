Return-path: <kexec-bounces@lists.infradead.org>
Received: from wa-out-1112.google.com ([209.85.146.180])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Icu3Q-0004dL-LG
	for kexec@lists.infradead.org; Wed, 03 Oct 2007 03:33:43 +0100
Received: by wa-out-1112.google.com with SMTP id v33so5036372wah
	for <kexec@lists.infradead.org>; Tue, 02 Oct 2007 19:33:08 -0700 (PDT)
Message-ID: <fdaac4d50710021933u144595f0nc9f96e1eb9169071@mail.gmail.com>
Date: Wed, 3 Oct 2007 11:33:08 +0900
From: "Jun Koi" <junkoi2004@gmail.com>
Subject: My kernel fails with kexec
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces@lists.infradead.org
To: kexec@lists.infradead.org

Hi,

I have a kernel (which is not Linux kernel), and want to have it
worked with kexec. Fortunately, kexec crashes when booting it. (kexec
-e command)

My suspect is that my kernel is not written to "support" kexec. So
could anybody tell me what is the requirement of a kernel, so it works
with kexec?

kexec spits out the below message on QEMU when booting my kernel. Any
hint on how to debug the problem?


(qemu) qemu: fatal: triple fault
EAX=00001500 EBX=001001f1 ECX=00000000 EDX=00004081
ESI=002ae8c0 EDI=002ac8c0 EBP=0000e098 ESP=00008ffe
EIP=00000d05 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0018 00000000 ffffffff 00cf9300
CS =4020 00040200 ffffffff 008f9f00
SS =4000 00040000 0000ffff 00009300
DS =0018 00000000 ffffffff 00cf9300
FS =0018 00000000 ffffffff 00cf9300
GS =0018 00000000 ffffffff 00cf9300
LDT=0000 00000000 00000000 00008000
TR =0080 c1fd7000 00002073 c10089fd
GDT=     0040a938 00000017
IDT=     c0000000 00000000
CR0=00000010 CR2=b7ed6200 CR3=00000000 CR4=00000000
CCS=00008000 CCD=00004000 CCO=SARL
FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
FPR6=f424000000000000 4012 FPR7=0000000000000000 0000
XMM00=00000000000000000000000000000000 XMM01=00000000000000000000000000000000
XMM02=00000000000000000000000000000000 XMM03=00000000000000000000000000000000
XMM04=00000000000000000000000000000000 XMM05=00000000000000000000000000000000
XMM06=00000000000000000000000000000000 XMM07=00000000000000000000000000000000


(Please CC, as I am not a list subscriber)

Many thanks,
Jun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
