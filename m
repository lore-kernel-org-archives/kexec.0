Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LIrA2-0002iQ-FG
	for kexec@lists.infradead.org; Fri, 02 Jan 2009 21:02:26 +0000
From: Milton Miller <miltonm@bga.com>
Message-Id: <kexec-29-1-6.miltonm@bga.com>
In-Reply-To: <kexec-29-1.miltonm@bga.com>
Subject: [PATCH] powerpc: make dummy section a valid note header
Date: Fri, 02 Jan 2009 14:46:04 -0600
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Cc: Michael Ellerman <michael@ellerman.id.au>, "M. Mohan Kumar" <mohan@in.ibm.com>, kexec@lists.infradead.org

We are declaring the dummy section (used to work around a binutils
bug) as PT_NOTE, but we don't have enough bytes for it to be a valid
note header, and kexec userspace complains:

Warning: Elf Note name is not null terminated
Warning: append= option is not passed. Using the first kernel root partition
Warning: Elf Note name is not null terminated

Instead of using the arbitray value 0xf177 (aka "fill"), declare a
no-name no-description note of type 0.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
verified on binutils-2.6.17 that the workaround still works (that
is we get a phdr that does not have all zeros in the paddr field,
and a relocatable kernel booted).

Index: common/arch/powerpc/kernel/vmlinux.lds.S
===================================================================
--- common.orig/arch/powerpc/kernel/vmlinux.lds.S	2009-01-02 01:07:12.000000000 -0600
+++ common/arch/powerpc/kernel/vmlinux.lds.S	2009-01-02 01:18:00.000000000 -0600
@@ -87,7 +87,9 @@ SECTIONS
 	/* The dummy segment contents for the bug workaround mentioned above
 	   near PHDRS.  */
 	.dummy : AT(ADDR(.dummy) - LOAD_OFFSET) {
-		LONG(0xf177)
+		LONG(0)
+		LONG(0)
+		LONG(0)
 	} :kernel :dummy
 
 /*

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
