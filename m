Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Oo3qX-00073E-Oc
	for kexec@lists.infradead.org; Wed, 25 Aug 2010 00:28:07 +0000
Date: Wed, 25 Aug 2010 10:22:58 +1000
From: Anton Blanchard <anton@samba.org>
Subject: [PATCH 1/2] kdump: Allow shrinking of kdump region to be overridden
Message-ID: <20100825002258.GD28360@kryten>
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
To: benh@kernel.crashing.org, ebiederm@xmission.com, akpm@linux-foundation.org
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org


On ppc64 the crashkernel region almost always overlaps an area of firmware.
This works fine except when using the sysfs interface to reduce the kdump
region. If we free the firmware area we are guaranteed to crash.

Rename free_reserved_phys_range to crash_free_reserved_phys_range and make
it a weak function so we can override it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/kernel/kexec.c
===================================================================
--- powerpc.git.orig/kernel/kexec.c	2010-08-25 10:12:11.493863566 +1000
+++ powerpc.git/kernel/kexec.c	2010-08-25 10:12:35.907264327 +1000
@@ -1097,7 +1097,8 @@ size_t crash_get_memory_size(void)
 	return size;
 }
 
-static void free_reserved_phys_range(unsigned long begin, unsigned long end)
+void __weak crash_free_reserved_phys_range(unsigned long begin,
+					   unsigned long end)
 {
 	unsigned long addr;
 
@@ -1133,7 +1134,7 @@ int crash_shrink_memory(unsigned long ne
 	start = roundup(start, PAGE_SIZE);
 	end = roundup(start + new_size, PAGE_SIZE);
 
-	free_reserved_phys_range(end, crashk_res.end);
+	crash_free_reserved_phys_range(end, crashk_res.end);
 
 	if ((start == end) && (crashk_res.parent != NULL))
 		release_resource(&crashk_res);
Index: powerpc.git/include/linux/kexec.h
===================================================================
--- powerpc.git.orig/include/linux/kexec.h	2010-08-25 10:12:11.483862172 +1000
+++ powerpc.git/include/linux/kexec.h	2010-08-25 10:12:13.664166570 +1000
@@ -208,6 +208,7 @@ int __init parse_crashkernel(char *cmdli
 		unsigned long long *crash_size, unsigned long long *crash_base);
 int crash_shrink_memory(unsigned long new_size);
 size_t crash_get_memory_size(void);
+void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
 
 #else /* !CONFIG_KEXEC */
 struct pt_regs;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
