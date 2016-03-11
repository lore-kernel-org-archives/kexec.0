Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aeGc3-00034l-Gs
 for kexec@lists.infradead.org; Fri, 11 Mar 2016 06:31:52 +0000
Message-Id: <20160311062953.623220113@redhat.com>
Date: Fri, 11 Mar 2016 14:21:58 +0800
From: dyoung@redhat.com
Subject: [PATCH 2/2] [PATCH 2/2] proc-vmcore: wrong data type casting fix
MIME-Version: 1.0
Content-Disposition: inline;
 filename=0002-proc-vmcore-wrong-data-type-casting-fix.patch
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
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, d.hatayama@jp.fujitsu.com, bhe@redhat.com, vgoyal@redhat.com
Cc: kexec@lists.infradead.org, dyoung@redhat.com

On i686 PAE enabled machine the contiguous physical area could be large
and it can cause triming down variables in below calculation in
read_vmcore() and mmap_vmcore():

	tsz = min_t(size_t, m->offset + m->size - *fpos, buflen);

Then the real size passed down is not correct any more.
Suppose m->offset + m->size - *fpos being truncated to 0, buflen >0 then
we will get tsz = 0. It is of course not an expected result.

During out test there are two problems caused by it:
1) read_vmcore will refuse to continue so makedumpfile fails.
2) mmap_vmcore will trigger BUG_ON() in remap_pfn_range().

Use min_lt instead so that the variables are not truncated.

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Dave Young <dyoung@redhat.com>
---
 fs/proc/vmcore.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux.orig/fs/proc/vmcore.c
+++ linux/fs/proc/vmcore.c
@@ -231,7 +231,8 @@ static ssize_t __read_vmcore(char *buffe
 
 	list_for_each_entry(m, &vmcore_list, list) {
 		if (*fpos < m->offset + m->size) {
-			tsz = min_t(size_t, m->offset + m->size - *fpos, buflen);
+			tsz = (size_t)min_lt(m->offset + m->size - *fpos,
+					    buflen);
 			start = m->paddr + *fpos - m->offset;
 			tmp = read_from_oldmem(buffer, tsz, &start, userbuf);
 			if (tmp < 0)
@@ -461,7 +462,7 @@ static int mmap_vmcore(struct file *file
 		if (start < m->offset + m->size) {
 			u64 paddr = 0;
 
-			tsz = min_t(size_t, m->offset + m->size - start, size);
+			tsz = (size_t)min_lt(m->offset + m->size - start, size);
 			paddr = m->paddr + start - m->offset;
 			if (vmcore_remap_oldmem_pfn(vma, vma->vm_start + len,
 						    paddr >> PAGE_SHIFT, tsz,



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
