Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2402:b800:7003:1:1::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RPrS2-0004XZ-Du
 for kexec@lists.infradead.org; Mon, 14 Nov 2011 07:59:35 +0000
Date: Mon, 14 Nov 2011 18:53:29 +1100
From: Anton Blanchard <anton@samba.org>
Subject: [PATCH 1/3] kexec-tools: powerpc: Fix 64bit optimize for size (gcc
 -Os) build
Message-ID: <20111114185329.19ddc2b4@kryten>
Mime-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>, Matt Evans <matt@ozlabs.org>, Michael Neuling <mikey@neuling.org>, Milton Miller <miltonm@bga.com>, amodra@gmail.com
Cc: kexec@lists.infradead.org


commit 46b2d0b8a719 (kexec/powerpc fix optimization for size (gcc -Os)
build) added out of line GPR save/restore handlers for 32bit -Os
builds. This patch adds the handlers for 64bit builds.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: kexec-tools/purgatory/arch/ppc64/Makefile
===================================================================
--- kexec-tools.orig/purgatory/arch/ppc64/Makefile	2011-11-14 18:50:59.269323640 +1100
+++ kexec-tools/purgatory/arch/ppc64/Makefile	2011-11-14 18:51:01.361361348 +1100
@@ -7,6 +7,7 @@ ppc64_PURGATORY_SRCS += purgatory/arch/p
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/purgatory-ppc64.c
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/console-ppc64.c
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/crashdump_backup.c
+ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/misc.S
 
 ppc64_PURGATORY_EXTRA_CFLAGS += -m64 -mcall-aixdesc
 ppc64_PURGATORY_EXTRA_ASFLAGS += -m64 -mcall-aixdesc
Index: kexec-tools/purgatory/arch/ppc64/misc.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools/purgatory/arch/ppc64/misc.S	2011-11-14 18:51:01.361361348 +1100
@@ -0,0 +1,197 @@
+/*
+ * This is from linux/arch/powerpc/lib/crtsavres.S:
+ *
+ * Special support for eabi and SVR4
+ *
+ *   Copyright (C) 1995, 1996, 1998, 2000, 2001 Free Software Foundation, Inc.
+ *   Copyright 2008 Freescale Semiconductor, Inc.
+ *   Written By Michael Meissner
+ *
+ * Based on gcc/config/rs6000/crtsavres.asm from gcc
+ * 64 bit additions from reading the PPC elf64abi document.
+ *
+ * This file is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * In addition to the permissions in the GNU General Public License, the
+ * Free Software Foundation gives you unlimited permission to link the
+ * compiled version of this file with other programs, and to distribute
+ * those programs without any restriction coming from the use of this
+ * file.  (The General Public License restrictions do apply in other
+ * respects; for example, they cover modification of the file, and
+ * distribution when not linked into another program.)
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; see the file COPYING.  If not, write to
+ * the Free Software Foundation, 51 Franklin Street, Fifth Floor,
+ * Boston, MA 02110-1301, USA.
+ *
+ *    As a special exception, if you link this library with files
+ *    compiled with GCC to produce an executable, this does not cause
+ *    the resulting executable to be covered by the GNU General Public License.
+ *    This exception does not however invalidate any other reasons why
+ *    the executable file might be covered by the GNU General Public License.
+ */
+
+#define	r0	0
+#define	r1	1
+#define	r2	2
+#define	r3	3
+#define	r4	4
+#define	r5	5
+#define	r6	6
+#define	r7	7
+#define	r8	8
+#define	r9	9
+#define	r10	10
+#define	r11	11
+#define	r12	12
+#define	r13	13
+#define	r14	14
+#define	r15	15
+#define	r16	16
+#define	r17	17
+#define	r18	18
+#define	r19	19
+#define	r20	20
+#define	r21	21
+#define	r22	22
+#define	r23	23
+#define	r24	24
+#define	r25	25
+#define	r26	26
+#define	r27	27
+#define	r28	28
+#define	r29	29
+#define	r30	30
+#define	r31	31
+
+	.text
+
+.globl	_savegpr0_14
+_savegpr0_14:
+	std	r14,-144(r1)
+.globl	_savegpr0_15
+_savegpr0_15:
+	std	r15,-136(r1)
+.globl	_savegpr0_16
+_savegpr0_16:
+	std	r16,-128(r1)
+.globl	_savegpr0_17
+_savegpr0_17:
+	std	r17,-120(r1)
+.globl	_savegpr0_18
+_savegpr0_18:
+	std	r18,-112(r1)
+.globl	_savegpr0_19
+_savegpr0_19:
+	std	r19,-104(r1)
+.globl	_savegpr0_20
+_savegpr0_20:
+	std	r20,-96(r1)
+.globl	_savegpr0_21
+_savegpr0_21:
+	std	r21,-88(r1)
+.globl	_savegpr0_22
+_savegpr0_22:
+	std	r22,-80(r1)
+.globl	_savegpr0_23
+_savegpr0_23:
+	std	r23,-72(r1)
+.globl	_savegpr0_24
+_savegpr0_24:
+	std	r24,-64(r1)
+.globl	_savegpr0_25
+_savegpr0_25:
+	std	r25,-56(r1)
+.globl	_savegpr0_26
+_savegpr0_26:
+	std	r26,-48(r1)
+.globl	_savegpr0_27
+_savegpr0_27:
+	std	r27,-40(r1)
+.globl	_savegpr0_28
+_savegpr0_28:
+	std	r28,-32(r1)
+.globl	_savegpr0_29
+_savegpr0_29:
+	std	r29,-24(r1)
+.globl	_savegpr0_30
+_savegpr0_30:
+	std	r30,-16(r1)
+.globl	_savegpr0_31
+_savegpr0_31:
+	std	r31,-8(r1)
+	std	r0,16(r1)
+	blr
+
+.globl	_restgpr0_14
+_restgpr0_14:
+	ld	r14,-144(r1)
+.globl	_restgpr0_15
+_restgpr0_15:
+	ld	r15,-136(r1)
+.globl	_restgpr0_16
+_restgpr0_16:
+	ld	r16,-128(r1)
+.globl	_restgpr0_17
+_restgpr0_17:
+	ld	r17,-120(r1)
+.globl	_restgpr0_18
+_restgpr0_18:
+	ld	r18,-112(r1)
+.globl	_restgpr0_19
+_restgpr0_19:
+	ld	r19,-104(r1)
+.globl	_restgpr0_20
+_restgpr0_20:
+	ld	r20,-96(r1)
+.globl	_restgpr0_21
+_restgpr0_21:
+	ld	r21,-88(r1)
+.globl	_restgpr0_22
+_restgpr0_22:
+	ld	r22,-80(r1)
+.globl	_restgpr0_23
+_restgpr0_23:
+	ld	r23,-72(r1)
+.globl	_restgpr0_24
+_restgpr0_24:
+	ld	r24,-64(r1)
+.globl	_restgpr0_25
+_restgpr0_25:
+	ld	r25,-56(r1)
+.globl	_restgpr0_26
+_restgpr0_26:
+	ld	r26,-48(r1)
+.globl	_restgpr0_27
+_restgpr0_27:
+	ld	r27,-40(r1)
+.globl	_restgpr0_28
+_restgpr0_28:
+	ld	r28,-32(r1)
+.globl	_restgpr0_29
+_restgpr0_29:
+	ld	r0,16(r1)
+	ld	r29,-24(r1)
+	mtlr	r0
+	ld	r30,-16(r1)
+	ld	r31,-8(r1)
+	blr
+
+.globl	_restgpr0_30
+_restgpr0_30:
+	ld	r30,-16(r1)
+.globl	_restgpr0_31
+_restgpr0_31:
+	ld	r0,16(r1)
+	ld	r31,-8(r1)
+	mtlr	r0
+	blr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
