Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uw44I-00010B-CI
 for kexec@lists.infradead.org; Mon, 08 Jul 2013 05:32:59 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A58273EE0C0
 for <kexec@lists.infradead.org>; Mon,  8 Jul 2013 14:32:25 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8EB1845DE4E
 for <kexec@lists.infradead.org>; Mon,  8 Jul 2013 14:32:25 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 74C0C45DE52
 for <kexec@lists.infradead.org>; Mon,  8 Jul 2013 14:32:25 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 64EE31DB803F
 for <kexec@lists.infradead.org>; Mon,  8 Jul 2013 14:32:25 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 04A8F1DB803A
 for <kexec@lists.infradead.org>; Mon,  8 Jul 2013 14:32:25 +0900 (JST)
Message-ID: <51DA4ED9.60903@jp.fujitsu.com>
Date: Mon, 08 Jul 2013 14:32:09 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
In-Reply-To: <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

(2013/07/02 4:32), Michael Holzheu wrote:
> For zfcpdump we can't map the HSA storage because it is only available
> via a read interface. Therefore, for the new vmcore mmap feature we have
> introduce a new mechanism to create mappings on demand.
>
> This patch introduces a new architecture function remap_oldmem_pfn_range()
> that should be used to create mappings with remap_pfn_range() for oldmem
> areas that can be directly mapped. For zfcpdump this is everything besides
> of the HSA memory. For the areas that are not mapped by remap_oldmem_pfn_range()
> a generic vmcore a new generic vmcore fault handler mmap_vmcore_fault()
> is called.
>

This fault handler is only for s390 specific issue. Other architectures don't need
this for the time being.

Also, from the same reason, I'm doing this review based on source code only.
I cannot run the fault handler on meaningful system, which is currently s390 only.

I'm also concerned about the fault handler covers a full range of vmcore, which
could hide some kind of mmap() bug that results in page fault.

So, the fault handler should be enclosed by ifdef CONFIG_S390 for the time being.

> This handler works as follows:
>
> * Get already available or new page from page cache (find_or_create_page)
> * Check if /proc/vmcore page is filled with data (PageUptodate)
> * If yes:
>    Return that page
> * If no:
>    Fill page using __vmcore_read(), set PageUptodate, and return page
>

It seems good to me on this page-in logic.

<cut>
> @@ -225,6 +250,48 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
>   	return acc;
>   }
>
> +static ssize_t read_vmcore(struct file *file, char __user *buffer,
> +			   size_t buflen, loff_t *fpos)
> +{
> +	return __read_vmcore(buffer, buflen, fpos, 1);
> +}
> +
> +/*
> + * The vmcore fault handler uses the page cache and fills data using the
> + * standard __vmcore_read() function.
> + */

Could you describe usecase of this fault handler on s390?

> +static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
> +{
> +	struct address_space *mapping = vma->vm_file->f_mapping;
> +	pgoff_t index = vmf->pgoff;
> +	struct page *page;
> +	loff_t src;
> +	char *buf;
> +	int rc;
> +

You should check where faulting address points to valid range.
If the fault happens on invalid range, return VM_FAULT_SIGBUS.

On s390 case, I think the range except for HSA should be thought of as invalid.

> +	page = find_or_create_page(mapping, index, GFP_KERNEL);
> +	if (!page)
> +		return VM_FAULT_OOM;
> +	if (!PageUptodate(page)) {
> +		src = index << PAGE_CACHE_SHIFT;

src = (loff_t)index << PAGE_CACHE_SHIFT;

loff_t has long long while index has unsigned long.
On s390 both might have the same byte length.

Also I prefer offset to src, but this is minor suggestion.

> +		buf = (void *) (page_to_pfn(page) << PAGE_SHIFT);

I found page_to_virt() macro.

> +		rc = __read_vmcore(buf, PAGE_SIZE, &src, 0);
> +		if (rc < 0) {
> +			unlock_page(page);
> +			page_cache_release(page);
> +			return (rc == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
> +		}
> +		SetPageUptodate(page);
> +	}
> +	unlock_page(page);
> +	vmf->page = page;
> +	return 0;
> +}
> +
> +static const struct vm_operations_struct vmcore_mmap_ops = {
> +	.fault = mmap_vmcore_fault,
> +};
> +
>   static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
>   {
>   	size_t size = vma->vm_end - vma->vm_start;
> @@ -242,6 +309,7 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
>
>   	vma->vm_flags &= ~(VM_MAYWRITE | VM_MAYEXEC);
>   	vma->vm_flags |= VM_MIXEDMAP;
> +	vma->vm_ops = &vmcore_mmap_ops;
>
>   	len = 0;
>

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
