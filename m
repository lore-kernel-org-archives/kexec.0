Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USlFU-0000Dv-7P
 for kexec@lists.infradead.org; Thu, 18 Apr 2013 09:35:25 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 9B4613EE0B6
 for <kexec@lists.infradead.org>; Thu, 18 Apr 2013 18:35:22 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7D91E45DEB6
 for <kexec@lists.infradead.org>; Thu, 18 Apr 2013 18:35:22 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5AE7945DEB2
 for <kexec@lists.infradead.org>; Thu, 18 Apr 2013 18:35:22 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3FD7D1DB8041
 for <kexec@lists.infradead.org>; Thu, 18 Apr 2013 18:35:22 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E1A7F1DB803C
 for <kexec@lists.infradead.org>; Thu, 18 Apr 2013 18:35:21 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v4 8/8] vmcore: support mmap() on /proc/vmcore
Date: Sat, 13 Apr 2013 09:21:51 +0900
Message-ID: <20130413002151.18245.23358.stgit@localhost6.localdomain6>
In-Reply-To: <20130413002000.18245.21513.stgit@localhost6.localdomain6>
References: <20130413002000.18245.21513.stgit@localhost6.localdomain6>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, zhangyanfei@cn.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, cpw@sgi.com, jingbai.ma@hp.com

This patch introduces mmap_vmcore().

If flag MEM_TYPE_CURRENT_KERNEL is set, map buffer on the 2nd
kernel. If not set, map some area in old memory.

Neither writable nor executable mapping is permitted even with
mprotect(). Non-writable mapping is also requirement of
remap_pfn_range() when mapping linear pages on non-consequtive
physical pages; see is_cow_mapping().

On x86-32 PAE kernels, mmap() supports at most 16TB memory only. This
limitation comes from the fact that the third argument of
remap_pfn_range(), pfn, is of 32-bit length on x86-32: unsigned long.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index cd0f9d9..aecdc72 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -176,9 +176,77 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
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
+			u64 paddr = 0;
+
+			tsz = m->offset + m->size - start;
+			if (size < tsz)
+				tsz = size;
+			if (m->flag & MEM_TYPE_CURRENT_KERNEL) {
+				paddr = __pa(m->buf + start - m->offset);
+			} else {
+				paddr = m->paddr + start - m->offset;
+			}
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
