Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uw7ky-0004Qp-6J
 for kexec@lists.infradead.org; Mon, 08 Jul 2013 09:29:17 +0000
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 8 Jul 2013 10:23:01 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 98C0F1B08023
 for <kexec@lists.infradead.org>; Mon,  8 Jul 2013 10:28:43 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r689SWB746923980
 for <kexec@lists.infradead.org>; Mon, 8 Jul 2013 09:28:32 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r689Sg6U013991
 for <kexec@lists.infradead.org>; Mon, 8 Jul 2013 03:28:42 -0600
Date: Mon, 8 Jul 2013 11:28:39 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
Message-ID: <20130708112839.498ccfc6@holzheu>
In-Reply-To: <51DA4ED9.60903@jp.fujitsu.com>
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <51DA4ED9.60903@jp.fujitsu.com>
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
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On Mon, 08 Jul 2013 14:32:09 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> (2013/07/02 4:32), Michael Holzheu wrote:
> > For zfcpdump we can't map the HSA storage because it is only available
> > via a read interface. Therefore, for the new vmcore mmap feature we have
> > introduce a new mechanism to create mappings on demand.
> >
> > This patch introduces a new architecture function remap_oldmem_pfn_range()
> > that should be used to create mappings with remap_pfn_range() for oldmem
> > areas that can be directly mapped. For zfcpdump this is everything besides
> > of the HSA memory. For the areas that are not mapped by remap_oldmem_pfn_range()
> > a generic vmcore a new generic vmcore fault handler mmap_vmcore_fault()
> > is called.
> >
> 
> This fault handler is only for s390 specific issue. Other architectures don't need
> this for the time being.
> 
> Also, from the same reason, I'm doing this review based on source code only.
> I cannot run the fault handler on meaningful system, which is currently s390 only.

You can test the code on other architectures if you do not map anything in advance.
For example you could just "return 0" in remap_oldmem_pfn_range():

/*
 * Architectures may override this function to map oldmem
 */
int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
                                  unsigned long from, unsigned long pfn,
                                  unsigned long size, pgprot_t prot)
{
        return 0;
}

In that case for all pages the new mechanism would be used.

> 
> I'm also concerned about the fault handler covers a full range of vmcore, which
> could hide some kind of mmap() bug that results in page fault.
> 
> So, the fault handler should be enclosed by ifdef CONFIG_S390 for the time being.

I personally do not like that, but if Vivek and you prefer this, of course we
can do that.

What about something like:

#ifdef CONFIG_S390
static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
{
...
}
#else
static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
{
	BUG();
}
#endif

> 
> > This handler works as follows:
> >
> > * Get already available or new page from page cache (find_or_create_page)
> > * Check if /proc/vmcore page is filled with data (PageUptodate)
> > * If yes:
> >    Return that page
> > * If no:
> >    Fill page using __vmcore_read(), set PageUptodate, and return page
> >
> 
> It seems good to me on this page-in logic.
> 
> <cut>
> > @@ -225,6 +250,48 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
> >   	return acc;
> >   }
> >
> > +static ssize_t read_vmcore(struct file *file, char __user *buffer,
> > +			   size_t buflen, loff_t *fpos)
> > +{
> > +	return __read_vmcore(buffer, buflen, fpos, 1);
> > +}
> > +
> > +/*
> > + * The vmcore fault handler uses the page cache and fills data using the
> > + * standard __vmcore_read() function.
> > + */
> 
> Could you describe usecase of this fault handler on s390?

ok.

> 
> > +static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
> > +{
> > +	struct address_space *mapping = vma->vm_file->f_mapping;
> > +	pgoff_t index = vmf->pgoff;
> > +	struct page *page;
> > +	loff_t src;
> > +	char *buf;
> > +	int rc;
> > +
> 
> You should check where faulting address points to valid range.
> If the fault happens on invalid range, return VM_FAULT_SIGBUS.
> 
> On s390 case, I think the range except for HSA should be thought of as invalid.
> 

Hmmm, this would require another architecture backend interface. If we get a fault
for a page outside of the HSA this would be a programming error in our code. Not
sure if we should introduce new architecture interfaces just for sanity checks.

> > +	page = find_or_create_page(mapping, index, GFP_KERNEL);
> > +	if (!page)
> > +		return VM_FAULT_OOM;
> > +	if (!PageUptodate(page)) {
> > +		src = index << PAGE_CACHE_SHIFT;
> 
> src = (loff_t)index << PAGE_CACHE_SHIFT;
> 
> loff_t has long long while index has unsigned long.

Ok.

> On s390 both might have the same byte length.

On s390x both are 64 bit. On our 32 bit s390 archtecture long long is 64 bit
and unsigned long 32 bit.

> Also I prefer offset to src, but this is minor suggestion.

Yes, I agree.

> 
> > +		buf = (void *) (page_to_pfn(page) << PAGE_SHIFT);
> 
> I found page_to_virt() macro.

Looks like page_to_virt() is not usable on most architectures and probably
pfn_to_kaddr(pfn) would be the correct thing here. Unfortunately is also not
defined on s390.

But when I discussed your comment with Martin, we found out that the current

buf = (void *) (page_to_pfn(page) << PAGE_SHIFT);

is not correct on x86. It should be:

buf = __va((page_to_pfn(page) << PAGE_SHIFT));

So would be the following patch ok for you?
---
 fs/proc/vmcore.c           |   94 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/crash_dump.h |    3 +
 2 files changed, 89 insertions(+), 8 deletions(-)

--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -21,6 +21,7 @@
 #include <linux/crash_dump.h>
 #include <linux/list.h>
 #include <linux/vmalloc.h>
+#include <linux/pagemap.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include "internal.h"
@@ -153,11 +154,35 @@ ssize_t __weak elfcorehdr_read_notes(cha
 	return read_from_oldmem(buf, count, ppos, 0);
 }
 
+/*
+ * Architectures may override this function to map oldmem
+ */
+int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
+				  unsigned long from, unsigned long pfn,
+				  unsigned long size, pgprot_t prot)
+{
+	return remap_pfn_range(vma, from, pfn, size, prot);
+}
+
+/*
+ * Copy to either kernel or user space
+ */
+static int copy_to(void *target, void *src, size_t size, int userbuf)
+{
+	if (userbuf) {
+		if (copy_to_user(target, src, size))
+			return -EFAULT;
+	} else {
+		memcpy(target, src, size);
+	}
+	return 0;
+}
+
 /* Read from the ELF header and then the crash dump. On error, negative value is
  * returned otherwise number of bytes read are returned.
  */
-static ssize_t read_vmcore(struct file *file, char __user *buffer,
-				size_t buflen, loff_t *fpos)
+static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
+			     int userbuf)
 {
 	ssize_t acc = 0, tmp;
 	size_t tsz;
@@ -174,7 +199,7 @@ static ssize_t read_vmcore(struct file *
 	/* Read ELF core header */
 	if (*fpos < elfcorebuf_sz) {
 		tsz = min(elfcorebuf_sz - (size_t)*fpos, buflen);
-		if (copy_to_user(buffer, elfcorebuf + *fpos, tsz))
+		if (copy_to(buffer, elfcorebuf + *fpos, tsz, userbuf))
 			return -EFAULT;
 		buflen -= tsz;
 		*fpos += tsz;
@@ -192,7 +217,7 @@ static ssize_t read_vmcore(struct file *
 
 		tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, buflen);
 		kaddr = elfnotes_buf + *fpos - elfcorebuf_sz;
-		if (copy_to_user(buffer, kaddr, tsz))
+		if (copy_to(buffer, kaddr, tsz, userbuf))
 			return -EFAULT;
 		buflen -= tsz;
 		*fpos += tsz;
@@ -208,7 +233,7 @@ static ssize_t read_vmcore(struct file *
 		if (*fpos < m->offset + m->size) {
 			tsz = min_t(size_t, m->offset + m->size - *fpos, buflen);
 			start = m->paddr + *fpos - m->offset;
-			tmp = read_from_oldmem(buffer, tsz, &start, 1);
+			tmp = read_from_oldmem(buffer, tsz, &start, userbuf);
 			if (tmp < 0)
 				return tmp;
 			buflen -= tsz;
@@ -225,6 +250,58 @@ static ssize_t read_vmcore(struct file *
 	return acc;
 }
 
+static ssize_t read_vmcore(struct file *file, char __user *buffer,
+			   size_t buflen, loff_t *fpos)
+{
+	return __read_vmcore(buffer, buflen, fpos, 1);
+}
+
+#ifdef CONFIG_S390
+/*
+ * The vmcore fault handler uses the page cache and fills data using the
+ * standard __vmcore_read() function.
+ *
+ * On s390 the fault handler is used for memory regions that can't be mapped
+ * directly with remap_pfn_range().
+ */
+static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	pgoff_t index = vmf->pgoff;
+	struct page *page;
+	loff_t offset;
+	char *buf;
+	int rc;
+
+	page = find_or_create_page(mapping, index, GFP_KERNEL);
+	if (!page)
+		return VM_FAULT_OOM;
+	if (!PageUptodate(page)) {
+		offset = (loff_t) index << PAGE_CACHE_SHIFT;
+		buf = __va((page_to_pfn(page) << PAGE_SHIFT));
+		rc = __read_vmcore(buf, PAGE_SIZE, &offset, 0);
+		if (rc < 0) {
+			unlock_page(page);
+			page_cache_release(page);
+			return (rc == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
+		}
+		SetPageUptodate(page);
+	}
+	unlock_page(page);
+	vmf->page = page;
+	return 0;
+}
+#else
+static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	BUG();
+}
+#endif
+
+static const struct vm_operations_struct vmcore_mmap_ops = {
+	.fault = mmap_vmcore_fault,
+};
+
 static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 {
 	size_t size = vma->vm_end - vma->vm_start;
@@ -242,6 +319,7 @@ static int mmap_vmcore(struct file *file
 
 	vma->vm_flags &= ~(VM_MAYWRITE | VM_MAYEXEC);
 	vma->vm_flags |= VM_MIXEDMAP;
+	vma->vm_ops = &vmcore_mmap_ops;
 
 	len = 0;
 
@@ -283,9 +361,9 @@ static int mmap_vmcore(struct file *file
 
 			tsz = min_t(size_t, m->offset + m->size - start, size);
 			paddr = m->paddr + start - m->offset;
-			if (remap_pfn_range(vma, vma->vm_start + len,
-					    paddr >> PAGE_SHIFT, tsz,
-					    vma->vm_page_prot))
+			if (remap_oldmem_pfn_range(vma, vma->vm_start + len,
+						   paddr >> PAGE_SHIFT, tsz,
+						   vma->vm_page_prot))
 				goto fail;
 			size -= tsz;
 			start += tsz;
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -17,6 +17,9 @@ extern int __weak elfcorehdr_alloc(unsig
 extern void __weak elfcorehdr_free(unsigned long long addr);
 extern ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos);
 extern ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos);
+extern int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
+					 unsigned long from, unsigned long pfn,
+					 unsigned long size, pgprot_t prot);
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
