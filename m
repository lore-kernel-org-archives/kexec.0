Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1To35B-0006fX-SN
 for kexec@lists.infradead.org; Thu, 27 Dec 2012 02:20:30 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:41014 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1645333Ab2L0CTB
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Thu, 27 Dec 2012 03:19:01 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v3 03/11] xen: Introduce architecture independent data for
 kexec/kdump
Date: Thu, 27 Dec 2012 03:18:52 +0100
Message-Id: <1356574740-6806-4-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
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

Introduce architecture independent constants and structures
required by Xen kexec/kdump implementation.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 include/xen/interface/xen.h |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/include/xen/interface/xen.h b/include/xen/interface/xen.h
index 886a5d8..09c16ab 100644
--- a/include/xen/interface/xen.h
+++ b/include/xen/interface/xen.h
@@ -57,6 +57,7 @@
 #define __HYPERVISOR_event_channel_op     32
 #define __HYPERVISOR_physdev_op           33
 #define __HYPERVISOR_hvm_op               34
+#define __HYPERVISOR_kexec_op             37
 #define __HYPERVISOR_tmem_op              38
 
 /* Architecture-specific hypercall definitions. */
@@ -231,7 +232,39 @@ DEFINE_GUEST_HANDLE_STRUCT(mmuext_op);
 #define VMASST_TYPE_pae_extended_cr3     3
 #define MAX_VMASST_TYPE 3
 
+/*
+ * Commands to HYPERVISOR_kexec_op().
+ */
+#define KEXEC_CMD_kexec			0
+#define KEXEC_CMD_kexec_load		1
+#define KEXEC_CMD_kexec_unload		2
+#define KEXEC_CMD_kexec_get_range	3
+
+/*
+ * Memory ranges for kdump (utilized by HYPERVISOR_kexec_op()).
+ */
+#define KEXEC_RANGE_MA_CRASH		0
+#define KEXEC_RANGE_MA_XEN		1
+#define KEXEC_RANGE_MA_CPU		2
+#define KEXEC_RANGE_MA_XENHEAP		3
+#define KEXEC_RANGE_MA_BOOT_PARAM	4
+#define KEXEC_RANGE_MA_EFI_MEMMAP	5
+#define KEXEC_RANGE_MA_VMCOREINFO	6
+
 #ifndef __ASSEMBLY__
+struct xen_kexec_exec {
+	int type;
+};
+
+struct xen_kexec_range {
+	int range;
+	int nr;
+	unsigned long size;
+	unsigned long start;
+};
+
+extern unsigned long xen_vmcoreinfo_maddr;
+extern unsigned long xen_vmcoreinfo_max_size;
 
 typedef uint16_t domid_t;
 
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
