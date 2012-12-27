Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1To35R-0006fX-Fd
 for kexec@lists.infradead.org; Thu, 27 Dec 2012 02:20:46 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:41014 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1645334Ab2L0CTB
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Thu, 27 Dec 2012 03:19:01 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v3 04/11] x86/xen: Introduce architecture dependent data for
 kexec/kdump
Date: Thu, 27 Dec 2012 03:18:53 +0100
Message-Id: <1356574740-6806-5-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1356574740-6806-4-git-send-email-daniel.kiper@oracle.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-4-git-send-email-daniel.kiper@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: andrew.cooper3@citrix.com, ebiederm@xmission.com, hpa@zytor.com, jbeulich@suse.com, konrad.wilk@oracle.com, maxim.uvarov@oracle.com, mingo@redhat.com, tglx@linutronix.de, vgoyal@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Introduce architecture dependent constants, structures and
functions required by Xen kexec/kdump implementation.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 arch/x86/include/asm/xen/hypercall.h |    6 +++
 arch/x86/include/asm/xen/kexec.h     |   79 ++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 0 deletions(-)
 create mode 100644 arch/x86/include/asm/xen/kexec.h

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index c20d1ce..e76a1b8 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -459,6 +459,12 @@ HYPERVISOR_hvm_op(int op, void *arg)
 }
 
 static inline int
+HYPERVISOR_kexec_op(unsigned long op, void *args)
+{
+	return _hypercall2(int, kexec_op, op, args);
+}
+
+static inline int
 HYPERVISOR_tmem_op(
 	struct tmem_op *op)
 {
diff --git a/arch/x86/include/asm/xen/kexec.h b/arch/x86/include/asm/xen/kexec.h
new file mode 100644
index 0000000..d09b52f
--- /dev/null
+++ b/arch/x86/include/asm/xen/kexec.h
@@ -0,0 +1,79 @@
+/*
+ * Copyright (c) 2011 Daniel Kiper
+ * Copyright (c) 2012 Daniel Kiper, Oracle Corporation
+ *
+ * kexec/kdump implementation for Xen was written by Daniel Kiper.
+ * Initial work on it was sponsored by Google under Google Summer
+ * of Code 2011 program and Citrix. Konrad Rzeszutek Wilk from Oracle
+ * was the mentor for this project.
+ *
+ * Some ideas are taken from:
+ *   - native kexec/kdump implementation,
+ *   - kexec/kdump implementation for Xen Linux Kernel Ver. 2.6.18,
+ *   - PV-GRUB.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ASM_X86_XEN_KEXEC_H
+#define _ASM_X86_XEN_KEXEC_H
+
+#define KEXEC_XEN_NO_PAGES	17
+
+#define XK_MA_CONTROL_PAGE	0
+#define XK_VA_CONTROL_PAGE	1
+#define XK_MA_PGD_PAGE		2
+#define XK_VA_PGD_PAGE		3
+#define XK_MA_PUD0_PAGE		4
+#define XK_VA_PUD0_PAGE		5
+#define XK_MA_PUD1_PAGE		6
+#define XK_VA_PUD1_PAGE		7
+#define XK_MA_PMD0_PAGE		8
+#define XK_VA_PMD0_PAGE		9
+#define XK_MA_PMD1_PAGE		10
+#define XK_VA_PMD1_PAGE		11
+#define XK_MA_PTE0_PAGE		12
+#define XK_VA_PTE0_PAGE		13
+#define XK_MA_PTE1_PAGE		14
+#define XK_VA_PTE1_PAGE		15
+#define XK_MA_TABLE_PAGE	16
+
+#ifndef __ASSEMBLY__
+struct xen_kexec_image {
+	unsigned long page_list[KEXEC_XEN_NO_PAGES];
+	unsigned long indirection_page;
+	unsigned long start_address;
+};
+
+struct xen_kexec_load {
+	int type;
+	struct xen_kexec_image image;
+};
+
+extern unsigned int xen_kexec_control_code_size;
+
+#ifdef CONFIG_X86_32
+extern void xen_relocate_kernel(unsigned long indirection_page,
+				unsigned long *page_list,
+				unsigned long start_address,
+				unsigned int has_pae,
+				unsigned int preserve_context);
+#else
+extern void xen_relocate_kernel(unsigned long indirection_page,
+				unsigned long *page_list,
+				unsigned long start_address,
+				unsigned int preserve_context);
+#endif
+#endif
+#endif /* _ASM_X86_XEN_KEXEC_H */
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
