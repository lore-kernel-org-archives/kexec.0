Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R38qj-00032A-Ik
	for kexec@lists.infradead.org; Mon, 12 Sep 2011 15:55:11 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p8CFt4nl019255
	for <kexec@lists.infradead.org>; Mon, 12 Sep 2011 15:55:04 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p8CFt3312384084
	for <kexec@lists.infradead.org>; Mon, 12 Sep 2011 16:55:03 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p8CFt21M012021
	for <kexec@lists.infradead.org>; Mon, 12 Sep 2011 09:55:03 -0600
Subject: Re: [RFC][patch 1/2] kdump: Add infrastructure for unmapping
	crashkernel memory
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110909182325.GD15748@redhat.com>
References: <20110908132609.177038405@linux.vnet.ibm.com>
	<20110908132652.189920773@linux.vnet.ibm.com>
	<20110909182325.GD15748@redhat.com>
Date: Mon, 12 Sep 2011 17:55:02 +0200
Message-ID: <1315842902.3602.9.camel@br98xy6r>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

Hello Vivek,

On Fri, 2011-09-09 at 14:23 -0400, Vivek Goyal wrote:
> On Thu, Sep 08, 2011 at 03:26:10PM +0200, Michael Holzheu wrote:
> > From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > 
> > This patch introduces a mechanism that allows architecture backends to
> > remove page tables for the crashkernel memory. This can protect the loaded
> > kdump kernel from being overwritten by broken kernel code.
> > A new function crash_map_pages() is added that can be implemented by
> > architecture code. This function has the following syntax:
> 
> I guess having separate functions for mapping and unmapping pages might
> look cleaner. Because we are not passing a page range, so specifying
> what pages we are talking about in function name might make it more
> clear.
> 
> crash_map_reserved_pages()
> crash_unmap_reserved_pages().

Ok fine, no problem.

> Secondly, what happens to the code which runs after crash (crash_kexec()).
> Current x86 code assumes that reserved region is mapped at the time of
> crash and does few things with control page there. 

For s390, purgatory code can run in real mode. No page tables are
required.

> So this generic approach is not valid atleast for x86, because it does
> not tackle the scenario about how to map reserved range again once 
> kernel crashes. It will only work if there is assumption that after
> a crash, we don't expect reserved range/pages to be mapped.

All architectures that support unmapping of crashkernel memory have to
deal with this problem somehow. Either remap the crashkernel memory in
machine_kexec() again or be able to run in real mode.

I adjusted that patch regarding your comment above. Will the following
patch be ok for you?
---
Subject: kdump: Add infrastructure for unmapping crashkernel memory

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

This patch introduces a mechanism that allows architecture backends to
remove page tables for the crashkernel memory. This can protect the loaded
kdump kernel from being overwritten by broken kernel code.  Two new
functions crash_map_reserved_pages() and crash_unmap_reserved_pages() are
added that can be implemented by architecture code.  The
crash_map_reserved_pages() function is called before and
crash_unmap_reserved_pages() after the crashkernel segments are loaded.  The
functions are also called in crash_shrink_memory() to create/remove page
tables when the crashkernel memory size is reduced.

To support architectures that have large pages this patch also introduces
a new define KEXEC_CRASH_MEM_ALIGN. The crashkernel start and size must 
always be aligned with KEXEC_CRASH_MEM_ALIGN.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 include/linux/kexec.h |    6 ++++++
 kernel/kexec.c        |   21 +++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

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
@@ -133,6 +137,8 @@ extern void crash_kexec(struct pt_regs *
 int kexec_should_crash(struct task_struct *);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
 void crash_save_vmcoreinfo(void);
+void crash_map_reserved_pages(void);
+void crash_unmap_reserved_pages(void);
 void arch_crash_save_vmcoreinfo(void);
 void vmcoreinfo_append_str(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -999,6 +999,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
 			kimage_free(xchg(&kexec_crash_image, NULL));
 			result = kimage_crash_alloc(&image, entry,
 						     nr_segments, segments);
+			crash_map_reserved_pages();
 		}
 		if (result)
 			goto out;
@@ -1015,6 +1016,8 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
 				goto out;
 		}
 		kimage_terminate(image);
+		if (flags & KEXEC_ON_CRASH)
+			crash_unmap_reserved_pages();
 	}
 	/* Install the new kernel, and  Uninstall the old */
 	image = xchg(dest_image, image);
@@ -1026,6 +1029,18 @@ out:
 	return result;
 }
 
+/*
+ * Add and remove page tables for crashkernel memory
+ *
+ * Provide an empty default implementation here -- architecture
+ * code may override this
+ */
+void __weak crash_map_reserved_pages(void)
+{}
+
+void __weak crash_unmap_reserved_pages(void)
+{}
+
 #ifdef CONFIG_COMPAT
 asmlinkage long compat_sys_kexec_load(unsigned long entry,
 				unsigned long nr_segments,
@@ -1134,14 +1149,16 @@ int crash_shrink_memory(unsigned long ne
 		goto unlock;
 	}
 
-	start = roundup(start, PAGE_SIZE);
-	end = roundup(start + new_size, PAGE_SIZE);
+	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
+	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
 
+	crash_map_reserved_pages();
 	crash_free_reserved_phys_range(end, crashk_res.end);
 
 	if ((start == end) && (crashk_res.parent != NULL))
 		release_resource(&crashk_res);
 	crashk_res.end = end - 1;
+	crash_unmap_reserved_pages();
 
 unlock:
 	mutex_unlock(&kexec_mutex);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
