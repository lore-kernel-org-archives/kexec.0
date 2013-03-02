Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UClxb-0007Df-1d
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 07:06:52 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 50B533EE0B6
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:06:49 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2E58F45DE54
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:06:49 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0C17445DE56
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:06:49 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 00C051DB804B
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:06:49 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id AADACE08003
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:06:48 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 20/20] vmcore: introduce mmap_vmcore()
Date: Sat, 02 Mar 2013 17:37:42 +0900
Message-ID: <20130302083742.31252.67291.stgit@localhost6.localdomain6>
In-Reply-To: <20130302083447.31252.93914.stgit@localhost6.localdomain6>
References: <20130302083447.31252.93914.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@redhat.com, ebiederm@xmission.com, cpw@sgi.com, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com, heiko.carstens@de.ibm.com, akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

This patch introduces mmap_vmcore().

If flag MEM_TYPE_CURRENT_KERNEL is set, remapped is the buffer on the
2nd kernel. If not set, remapped is some area in old memory.

Neither writable nor executable mapping is permitted even with
mprotect(). Non-writable mapping is also requirement of
remap_pfn_range() when mapping linear pages on non-consequtive
physical pages; see is_cow_mapping().

On x86-32 PAE kernels, mmap() supports at most 16TB memory only. This
limitation comes from the fact that the third argument of
remap_pfn_range(), pfn, is of 32-bit length on x86-32: unsigned long.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 709d21a..9433ef0 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -185,9 +185,81 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
 	return acc;
 }
 
+static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
+{
+	size_t size = vma->vm_end - vma->vm_start;
+	u64 start, end, len, tsz;
+	struct vmcore *m;
+
+	if (!support_mmap_vmcore)
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
+			if (m->flag & MEM_TYPE_CURRENT_KERNEL) {
+				pfn = __pa(m->buf + start - m->offset)
+					>> PAGE_SHIFT;
+			} else {
+				pfn = (m->paddr + (start - m->offset))
+					>> PAGE_SHIFT;
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
