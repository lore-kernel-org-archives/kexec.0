Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R1edA-0005Nk-Km
	for kexec@lists.infradead.org; Thu, 08 Sep 2011 13:27:01 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p88DQrWO031568
	for <kexec@lists.infradead.org>; Thu, 8 Sep 2011 13:26:53 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p88DQrBE2498688
	for <kexec@lists.infradead.org>; Thu, 8 Sep 2011 14:26:53 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p88DQq98008897
	for <kexec@lists.infradead.org>; Thu, 8 Sep 2011 07:26:52 -0600
Message-Id: <20110908132652.189920773@linux.vnet.ibm.com>
Date: Thu, 08 Sep 2011 15:26:10 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [RFC][patch 1/2] kdump: Add infrastructure for unmapping crashkernel
	memory
References: <20110908132609.177038405@linux.vnet.ibm.com>
Content-Disposition: inline; filename=s390-kdump-common-crash_map_pages.patch
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

This patch introduces a mechanism that allows architecture backends to
remove page tables for the crashkernel memory. This can protect the loaded
kdump kernel from being overwritten by broken kernel code.
A new function crash_map_pages() is added that can be implemented by
architecture code. This function has the following syntax:

void crash_map_pages(int enable);

"enable" can be 0 for removing or 1 for adding page tables.  The function is
called before and after the crashkernel segments are loaded. It is also
called in crash_shrink_memory() to create new page tables when the
crashkernel memory size is reduced.

To support architectures that have large pages this patch also introduces
a new define KEXEC_CRASH_MEM_ALIGN. The crashkernel start and size must 
always be aligned with KEXEC_CRASH_MEM_ALIGN.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 include/linux/kexec.h |    5 +++++
 kernel/kexec.c        |   16 ++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -37,6 +37,10 @@
 #define KEXEC_CRASH_CONTROL_MEMORY_LIMIT KEXEC_CONTROL_MEMORY_LIMIT
 #endif
 
+#ifndef KEXEC_CRASH_MEM_ALIGN
+#define KEXEC_CRASH_MEM_ALIGN PAGE_SIZE
+#endif
+
 #define KEXEC_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
 #define KEXEC_CORE_NOTE_NAME "CORE"
 #define KEXEC_CORE_NOTE_NAME_BYTES ALIGN(sizeof(KEXEC_CORE_NOTE_NAME), 4)
@@ -133,6 +137,7 @@ extern void crash_kexec(struct pt_regs *
 int kexec_should_crash(struct task_struct *);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
 void crash_save_vmcoreinfo(void);
+void crash_map_pages(int enable);
 void arch_crash_save_vmcoreinfo(void);
 void vmcoreinfo_append_str(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -999,6 +999,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
 			kimage_free(xchg(&kexec_crash_image, NULL));
 			result = kimage_crash_alloc(&image, entry,
 						     nr_segments, segments);
+			crash_map_pages(1);
 		}
 		if (result)
 			goto out;
@@ -1015,6 +1016,8 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
 				goto out;
 		}
 		kimage_terminate(image);
+		if (flags & KEXEC_ON_CRASH)
+			crash_map_pages(0);
 	}
 	/* Install the new kernel, and  Uninstall the old */
 	image = xchg(dest_image, image);
@@ -1026,6 +1029,13 @@ out:
 	return result;
 }
 
+/*
+ * provide an empty default implementation here -- architecture
+ * code may override this
+ */
+void __weak crash_map_pages(int enable)
+{}
+
 #ifdef CONFIG_COMPAT
 asmlinkage long compat_sys_kexec_load(unsigned long entry,
 				unsigned long nr_segments,
@@ -1134,14 +1144,16 @@ int crash_shrink_memory(unsigned long ne
 		goto unlock;
 	}
 
-	start = roundup(start, PAGE_SIZE);
-	end = roundup(start + new_size, PAGE_SIZE);
+	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
+	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
 
+	crash_map_pages(1);
 	crash_free_reserved_phys_range(end, crashk_res.end);
 
 	if ((start == end) && (crashk_res.parent != NULL))
 		release_resource(&crashk_res);
 	crashk_res.end = end - 1;
+	crash_map_pages(0);
 
 unlock:
 	mutex_unlock(&kexec_mutex);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
