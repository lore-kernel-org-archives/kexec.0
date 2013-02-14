Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U5voH-0003Lo-7k
 for kexec@lists.infradead.org; Thu, 14 Feb 2013 10:12:58 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 95FC03EE0AE
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:55 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 7A95945DE59
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:55 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 59A7445DE54
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:55 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4C3F21DB8043
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:55 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 003AAE08002
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:55 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 13/13] vmcore: introduce mmap_vmcore()
Date: Thu, 14 Feb 2013 19:12:54 +0900
Message-ID: <20130214101254.22466.874.stgit@localhost6.localdomain6>
In-Reply-To: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ebiederm@xmission.com, vgoyal@redhat.com, cpw@sgi.com, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

This patch introduces mmap_vmcore().

If vmcore object has VMCORE_OLD_MEMORY type, remaped is a page on old
memory. If vmcore object has VMCORE_2ND_KERNEL type, remaped is buffer
on 2nd kernel.

Neither writable nor executable mapping is permitted even with
mprotect(). Non-writable mapping is also requirement of
remap_pfn_range() when mapping linear pags on non-consequtive physical
pages; see is_cow_mapping().

On ELF32 mmap() is not suppoted, returning -ENODEV, since then dump
file size must be less than 4GB; exiting read() interface is enough.

On x86-32 PAE kernels, mmap() supports at most 16TB memory only. This
limitation comes from the fact that the third argument of
remap_pfn_range(), pfn, is of 32-bit length on x86-32: unsigned long.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 99f5673..f521480 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -186,9 +186,85 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
 	return acc;
 }
 
+static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned char *e_ident = (unsigned char *)elfcorebuf;
+	size_t size = vma->vm_end - vma->vm_start;
+	u64 start, end, len, tsz;
+	struct vmcore *m;
+
+	if (e_ident[EI_CLASS] == ELFCLASS32)
+		return -ENODEV;
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
+	list_for_each_entry(m, &vmcore_list, list) {
+		if (start < m->offset + m->size) {
+			u64 pfn = 0;
+
+			tsz = m->offset + m->size - start;
+			if (size < tsz)
+				tsz = size;
+			switch (m->type) {
+			case VMCORE_OLD_MEMORY:
+				pfn = (m->paddr + (start - m->offset))
+					>> PAGE_SHIFT;
+				break;
+			case VMCORE_2ND_KERNEL:
+				pfn = __pa(m->buf + start - m->offset)
+					>> PAGE_SHIFT;
+				break;
+			}
+			if (remap_pfn_range(vma, vma->vm_start + len, pfn, tsz,
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
