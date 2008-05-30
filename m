Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K1wvq-00018w-CB
	for kexec@lists.infradead.org; Fri, 30 May 2008 05:13:38 +0000
Date: Fri, 30 May 2008 14:13:33 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: [PATCH] Add xen_phys_start value in the crash info note
Message-Id: <20080530134554.1647.ODA@valinux.co.jp>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xen-devel@lists.xensource.com
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

Hi,

This patch makes the vmcore utilities (ex. crash, makedumpfile) be
able to get the relocation address of the xen hypervisor from a vmcore. 
It is necessary for the utilities to find the data of the hypervisor 
structures.

Note that this patch does not raise any comptibility issue for the
utilities (which I know) nor the other components of xen.

Signed-off-by: Itsuro Oda <oda@valinux.co.jp>

diff -r f681c4de91fc xen/arch/x86/crash.c
--- a/xen/arch/x86/crash.c	Wed May 28 16:14:10 2008 +0100
+++ b/xen/arch/x86/crash.c	Fri May 30 08:40:50 2008 +0900
@@ -102,6 +102,7 @@ void machine_crash_shutdown(void)
     hvm_cpu_down();
 
     info = kexec_crash_save_info();
+    info->xen_phys_start = xen_phys_start;
     info->dom0_pfn_to_mfn_frame_list_list =
         arch_get_pfn_to_mfn_frame_list_list(dom0);
 }
diff -r f681c4de91fc xen/include/xen/elfcore.h
--- a/xen/include/xen/elfcore.h	Wed May 28 16:14:10 2008 +0100
+++ b/xen/include/xen/elfcore.h	Fri May 30 08:39:40 2008 +0900
@@ -66,6 +66,7 @@ typedef struct {
     unsigned long xen_compile_time;
     unsigned long tainted;
 #if defined(__i386__) || defined(__x86_64__)
+    unsigned long xen_phys_start;
     unsigned long dom0_pfn_to_mfn_frame_list_list;
 #endif
 #if defined(__ia64__)

-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
