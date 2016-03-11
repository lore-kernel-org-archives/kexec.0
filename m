Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aeIET-000617-Q0
 for kexec@lists.infradead.org; Fri, 11 Mar 2016 08:15:38 +0000
Date: Fri, 11 Mar 2016 16:15:01 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH] proc-vmcore: wrong data type casting fix
Message-ID: <20160311081501.GA9147@dhcp-128-65.nay.redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, d.hatayama@jp.fujitsu.com, bhe@redhat.com, vgoyal@redhat.com, kexec@lists.infradead.org
Cc: dyoung@redhat.com, nasa4836@gmail.com

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

Use unsigned long long in min_t instead so that the variables are not
truncated.

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Dave Young <dyoung@redhat.com>
---
 fs/proc/vmcore.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- linux-x86.orig/fs/proc/vmcore.c
+++ linux-x86/fs/proc/vmcore.c
@@ -231,7 +231,9 @@ static ssize_t __read_vmcore(char *buffe
 
 	list_for_each_entry(m, &vmcore_list, list) {
 		if (*fpos < m->offset + m->size) {
-			tsz = min_t(size_t, m->offset + m->size - *fpos, buflen);
+			tsz = (size_t)min_t(unsigned long long,
+					    m->offset + m->size - *fpos,
+					    buflen);
 			start = m->paddr + *fpos - m->offset;
 			tmp = read_from_oldmem(buffer, tsz, &start, userbuf);
 			if (tmp < 0)
@@ -461,7 +463,8 @@ static int mmap_vmcore(struct file *file
 		if (start < m->offset + m->size) {
 			u64 paddr = 0;
 
-			tsz = min_t(size_t, m->offset + m->size - start, size);
+			tsz = (size_t)min_t(unsigned long long,
+					    m->offset + m->size - start, size);
 			paddr = m->paddr + start - m->offset;
 			if (vmcore_remap_oldmem_pfn(vma, vma->vm_start + len,
 						    paddr >> PAGE_SHIFT, tsz,

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
