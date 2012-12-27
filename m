Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1To35G-0006fX-DP
 for kexec@lists.infradead.org; Thu, 27 Dec 2012 02:20:35 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:41014 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1645339Ab2L0CTB
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Thu, 27 Dec 2012 03:19:01 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v3 08/11] x86/xen: Add kexec/kdump Kconfig and makefile rules
Date: Thu, 27 Dec 2012 03:18:57 +0100
Message-Id: <1356574740-6806-9-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1356574740-6806-8-git-send-email-daniel.kiper@oracle.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-4-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-5-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-6-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-7-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-8-git-send-email-daniel.kiper@oracle.com>
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

Add kexec/kdump Kconfig and makefile rules.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 arch/x86/Kconfig      |    3 +++
 arch/x86/xen/Kconfig  |    1 +
 arch/x86/xen/Makefile |    3 +++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 79795af..e2746c4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1600,6 +1600,9 @@ config KEXEC_JUMP
 	  Jump between original kernel and kexeced kernel and invoke
 	  code in physical address mode via KEXEC
 
+config KEXEC_FIRMWARE
+	def_bool n
+
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)
 	default "0x1000000"
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 131dacd..8469c1c 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -7,6 +7,7 @@ config XEN
 	select PARAVIRT
 	select PARAVIRT_CLOCK
 	select XEN_HAVE_PVMMU
+	select KEXEC_FIRMWARE if KEXEC
 	depends on X86_64 || (X86_32 && X86_PAE && !X86_VISWS)
 	depends on X86_TSC
 	help
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index 96ab2c0..99952d7 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -22,3 +22,6 @@ obj-$(CONFIG_PARAVIRT_SPINLOCKS)+= spinlock.o
 obj-$(CONFIG_XEN_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_XEN_DOM0)		+= apic.o vga.o
 obj-$(CONFIG_SWIOTLB_XEN)	+= pci-swiotlb-xen.o
+obj-$(CONFIG_KEXEC_FIRMWARE)	+= kexec.o
+obj-$(CONFIG_KEXEC_FIRMWARE)	+= machine_kexec_$(BITS).o
+obj-$(CONFIG_KEXEC_FIRMWARE)	+= relocate_kernel_$(BITS).o
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
