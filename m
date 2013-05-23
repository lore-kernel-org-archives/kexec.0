Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UfdwZ-0000ud-Ea
 for kexec@lists.infradead.org; Thu, 23 May 2013 22:25:08 +0000
Date: Thu, 23 May 2013 15:24:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 9/9] vmcore: support mmap() on /proc/vmcore
Message-Id: <20130523152445.17549682ae45b5aab3f3cde0@linux-foundation.org>
In-Reply-To: <20130523052547.13864.83306.stgit@localhost6.localdomain6>
References: <20130523052421.13864.83978.stgit@localhost6.localdomain6>
 <20130523052547.13864.83306.stgit@localhost6.localdomain6>
Mime-Version: 1.0
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: riel@redhat.com, hughd@google.com, jingbai.ma@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, kosaki.motohiro@jp.fujitsu.com, zhangyanfei@cn.fujitsu.com, walken@google.com, cpw@sgi.com, vgoyal@redhat.com

On Thu, 23 May 2013 14:25:48 +0900 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> This patch introduces mmap_vmcore().
> 
> Don't permit writable nor executable mapping even with mprotect()
> because this mmap() is aimed at reading crash dump memory.
> Non-writable mapping is also requirement of remap_pfn_range() when
> mapping linear pages on non-consecutive physical pages; see
> is_cow_mapping().
> 
> Set VM_MIXEDMAP flag to remap memory by remap_pfn_range and by
> remap_vmalloc_range_pertial at the same time for a single
> vma. do_munmap() can correctly clean partially remapped vma with two
> functions in abnormal case. See zap_pte_range(), vm_normal_page() and
> their comments for details.
> 
> On x86-32 PAE kernels, mmap() supports at most 16TB memory only. This
> limitation comes from the fact that the third argument of
> remap_pfn_range(), pfn, is of 32-bit length on x86-32: unsigned long.

More reviewing and testing, please.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: vmcore-support-mmap-on-proc-vmcore-fix

use min(), switch to conventional error-unwinding approach

Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Lisa Mitchell <lisa.mitchell@hp.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/proc/vmcore.c |   27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff -puN fs/proc/vmcore.c~vmcore-support-mmap-on-proc-vmcore-fix fs/proc/vmcore.c
--- a/fs/proc/vmcore.c~vmcore-support-mmap-on-proc-vmcore-fix
+++ a/fs/proc/vmcore.c
@@ -218,9 +218,7 @@ static int mmap_vmcore(struct file *file
 	if (start < elfcorebuf_sz) {
 		u64 pfn;
 
-		tsz = elfcorebuf_sz - start;
-		if (size < tsz)
-			tsz = size;
+		tsz = min(elfcorebuf_sz - (size_t)start, size);
 		pfn = __pa(elfcorebuf + start) >> PAGE_SHIFT;
 		if (remap_pfn_range(vma, vma->vm_start, pfn, tsz,
 				    vma->vm_page_prot))
@@ -236,15 +234,11 @@ static int mmap_vmcore(struct file *file
 	if (start < elfcorebuf_sz + elfnotes_sz) {
 		void *kaddr;
 
-		tsz = elfcorebuf_sz + elfnotes_sz - start;
-		if (size < tsz)
-			tsz = size;
+		tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)start, size);
 		kaddr = elfnotes_buf + start - elfcorebuf_sz;
 		if (remap_vmalloc_range_partial(vma, vma->vm_start + len,
-						kaddr, tsz)) {
-			do_munmap(vma->vm_mm, vma->vm_start, len);
-			return -EAGAIN;
-		}
+						kaddr, tsz))
+			goto fail;
 		size -= tsz;
 		start += tsz;
 		len += tsz;
@@ -257,16 +251,12 @@ static int mmap_vmcore(struct file *file
 		if (start < m->offset + m->size) {
 			u64 paddr = 0;
 
-			tsz = m->offset + m->size - start;
-			if (size < tsz)
-				tsz = size;
+			tsz = min_t(size_t, m->offset + m->size - start, size);
 			paddr = m->paddr + start - m->offset;
 			if (remap_pfn_range(vma, vma->vm_start + len,
 					    paddr >> PAGE_SHIFT, tsz,
-					    vma->vm_page_prot)) {
-				do_munmap(vma->vm_mm, vma->vm_start, len);
-				return -EAGAIN;
-			}
+					    vma->vm_page_prot))
+				goto fail;
 			size -= tsz;
 			start += tsz;
 			len += tsz;
@@ -277,6 +267,9 @@ static int mmap_vmcore(struct file *file
 	}
 
 	return 0;
+fail:
+	do_munmap(vma->vm_mm, vma->vm_start, len);
+	return -EAGAIN;
 }
 
 static const struct file_operations proc_vmcore_operations = {
_


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
