Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1ThtiR-0005Iz-Nb
 for kexec@lists.infradead.org; Mon, 10 Dec 2012 03:07:37 +0000
Date: Mon, 10 Dec 2012 11:07:32 +0800
From: Dave Young <dyoung@redhat.com>
Subject: kexec: ppc exec stack fix
Message-ID: <20121210030732.GA6290@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, horms@verge.net.au


execstack shows ppc kexec has an executable stack,
this leaves it vulnerable to buffer overflows.

Fix it by adding ASFLAGS --noexecstack

Tested on PowerMac G4 Macmini:
Without the patch:
dave@darkstar:~/kexec-tools$ execstack build/sbin/kexec 
X build/sbin/kexec

With the patch:
dave@darkstar:~/kexec-tools$ execstack build/sbin/kexec 
- build/sbin/kexec

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/ppc/Makefile |    2 ++
 1 file changed, 2 insertions(+)

--- kexec-tools.orig/kexec/arch/ppc/Makefile	2011-11-08 20:52:43.000000000 +0800
+++ kexec-tools/kexec/arch/ppc/Makefile	2012-12-10 10:52:56.000000000 +0800
@@ -23,6 +23,8 @@ CPPFLAGS+=-I$(srcdir)/kexec/arch/$(ARCH)
 
 ppc_KEXEC_SRCS += $(libfdt_SRCS)
 
+ASFLAGS	+= -Wa,--noexecstack
+
 dist += kexec/arch/ppc/Makefile $(ppc_KEXEC_SRCS)			\
 	kexec/arch/ppc/crashdump-powerpc.h kexec/arch/ppc/fixup_dtb.h	\
 	kexec/arch/ppc/kexec-ppc.h kexec/arch/ppc/ops.h			\

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
