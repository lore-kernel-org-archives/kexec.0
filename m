Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UezEJ-0005co-Qb
 for kexec@lists.infradead.org; Wed, 22 May 2013 02:56:44 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 2AEFC3EE0C1
 for <kexec@lists.infradead.org>; Wed, 22 May 2013 11:56:22 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id F007645DE55
 for <kexec@lists.infradead.org>; Wed, 22 May 2013 11:56:21 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id CAAF945DE54
 for <kexec@lists.infradead.org>; Wed, 22 May 2013 11:56:21 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id B89241DB8037
 for <kexec@lists.infradead.org>; Wed, 22 May 2013 11:56:21 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5EFC4E08004
 for <kexec@lists.infradead.org>; Wed, 22 May 2013 11:56:21 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v7 8/8] vmcore: support mmap() on /proc/vmcore
Date: Wed, 22 May 2013 11:56:18 +0900
Message-ID: <20130522025618.12215.76429.stgit@localhost6.localdomain6>
In-Reply-To: <20130522025410.12215.16793.stgit@localhost6.localdomain6>
References: <20130522025410.12215.16793.stgit@localhost6.localdomain6>
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: vgoyal@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org
Cc: riel@redhat.com, hughd@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, zhangyanfei@cn.fujitsu.com, kosaki.motohiro@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, walken@google.com, cpw@sgi.com, jingbai.ma@hp.com

This patch introduces mmap_vmcore().

Don't permit writable nor executable mapping even with mprotect()
because this mmap() is aimed at reading crash dump memory.
Non-writable mapping is also requirement of remap_pfn_range() when
mapping linear pages on non-consecutive physical pages; see
is_cow_mapping().

Set VM_MIXEDMAP flag to remap memory by remap_pfn_range and by
remap_vmalloc_range_pertial at the same time for a single
vma. do_munmap() can correctly clean partially remapped vma with two
functions in abnormal case. See zap_pte_range(), vm_normal_page() and
their comments for details.

On x86-32 PAE kernels, mmap() supports at most 16TB memory only. This
limitation comes from the fact that the third argument of
remap_pfn_range(), pfn, is of 32-bit length on x86-32: unsigned long.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
---

 fs/proc/vmcore.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 9f3e256..6ba32f8 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/crash_dump.h>
 #include <linux/list.h>
+#include <linux/vmalloc.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include "internal.h"
@@ -200,9 +201,94 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
 	return acc;
 }
 
+static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
+{
+	size_t size = vma->vm_end - vma->vm_start;
+	u64 start, end, len, tsz;
+	struct vmcore *m;
+
+	start = (u64)vma->vm_pgoff << PAGE_SHIFT;
+	end = start + size;
+
+	if (size > vmcore_size || end > vmcore_size)
+		return -EINVAL;
+
+	if (vma->vm_flags & (VM_WRITE | VM_EXEC))
+		return -EPERM;
+
+	vma->vm_flags &= ~(VM_MAYWRITE | VM_MAYEXEC);
+	vma->vm_flags |= VM_MIXEDMAP;
+
+	len = 0;
+
+	if (start < elfcorebuf_sz) {
+		u64 pfn;
+
+		tsz = elfcorebuf_sz - start;
+		if (size < tsz)
+			tsz = size;
+		pfn = __pa(elfcorebuf + start) >> PAGE_SHIFT;
+		if (remap_pfn_range(vma, vma->vm_start, pfn, tsz,
+				    vma->vm_page_prot))
+			return -EAGAIN;
+		size -= tsz;
+		start += tsz;
+		len += tsz;
+
+		if (size == 0)
+			return 0;
+	}
+
+	if (start < elfcorebuf_sz + elfnotes_sz) {
+		void *kaddr;
+
+		tsz = elfcorebuf_sz + elfnotes_sz - start;
+		if (size < tsz)
+			tsz = size;
+		kaddr = elfnotes_buf + start - elfcorebuf_sz;
+		if (remap_vmalloc_range_partial(vma, vma->vm_start + len,
+						kaddr, tsz)) {
+			do_munmap(vma->vm_mm, vma->vm_start, len);
+			return -EAGAIN;
+		}
+		size -= tsz;
+		start += tsz;
+		len += tsz;
+
+		if (size == 0)
+			return 0;
+	}
+
+	list_for_each_entry(m, &vmcore_list, list) {
+		if (start < m->offset + m->size) {
+			u64 paddr = 0;
+
+			tsz = m->offset + m->size - start;
+			if (size < tsz)
+				tsz = size;
+			paddr = m->paddr + start - m->offset;
+			if (remap_pfn_range(vma, vma->vm_start + len,
+					    paddr >> PAGE_SHIFT, tsz,
+					    vma->vm_page_prot)) {
+				do_munmap(vma->vm_mm, vma->vm_start, len);
+				return -EAGAIN;
+			}
+			size -= tsz;
+			start += tsz;
+			len += tsz;
+
+			if (size == 0)
+				return 0;
+		}
+	}
+
+	return 0;
+}
+
 static const struct file_operations proc_vmcore_operations = {
 	.read		= read_vmcore,
 	.llseek		= default_llseek,
+	.mmap		= mmap_vmcore,
 };
 
 static struct vmcore* __init get_new_element(void)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
