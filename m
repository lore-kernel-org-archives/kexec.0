Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ud52x-0005Wt-Tt
 for kexec@lists.infradead.org; Thu, 16 May 2013 20:45:09 +0000
Date: Thu, 16 May 2013 16:44:37 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v6 8/8] vmcore: support mmap() on /proc/vmcore
Message-ID: <20130516204437.GH5904@redhat.com>
References: <20130515090507.28109.28956.stgit@localhost6.localdomain6>
 <20130515090626.28109.95938.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130515090626.28109.95938.stgit@localhost6.localdomain6>
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
Cc: riel@redhat.com, hughd@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, kosaki.motohiro@jp.fujitsu.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, walken@google.com, cpw@sgi.com, jingbai.ma@hp.com

On Wed, May 15, 2013 at 06:06:26PM +0900, HATAYAMA Daisuke wrote:
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
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---

This one looks fine to me assuming vm folks like
remap_vmalloc_range_partial().

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

> 
>  fs/proc/vmcore.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 86 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 7f2041c..2c72487 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -20,6 +20,7 @@
>  #include <linux/init.h>
>  #include <linux/crash_dump.h>
>  #include <linux/list.h>
> +#include <linux/vmalloc.h>
>  #include <asm/uaccess.h>
>  #include <asm/io.h>
>  #include "internal.h"
> @@ -200,9 +201,94 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
>  	return acc;
>  }
>  
> +static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
> +{
> +	size_t size = vma->vm_end - vma->vm_start;
> +	u64 start, end, len, tsz;
> +	struct vmcore *m;
> +
> +	start = (u64)vma->vm_pgoff << PAGE_SHIFT;
> +	end = start + size;
> +
> +	if (size > vmcore_size || end > vmcore_size)
> +		return -EINVAL;
> +
> +	if (vma->vm_flags & (VM_WRITE | VM_EXEC))
> +		return -EPERM;
> +
> +	vma->vm_flags &= ~(VM_MAYWRITE | VM_MAYEXEC);
> +	vma->vm_flags |= VM_MIXEDMAP;
> +
> +	len = 0;
> +
> +	if (start < elfcorebuf_sz) {
> +		u64 pfn;
> +
> +		tsz = elfcorebuf_sz - start;
> +		if (size < tsz)
> +			tsz = size;
> +		pfn = __pa(elfcorebuf + start) >> PAGE_SHIFT;
> +		if (remap_pfn_range(vma, vma->vm_start, pfn, tsz,
> +				    vma->vm_page_prot))
> +			return -EAGAIN;
> +		size -= tsz;
> +		start += tsz;
> +		len += tsz;
> +
> +		if (size == 0)
> +			return 0;
> +	}
> +
> +	if (start < elfcorebuf_sz + elfnotes_sz) {
> +		void *kaddr;
> +
> +		tsz = elfcorebuf_sz + elfnotes_sz - start;
> +		if (size < tsz)
> +			tsz = size;
> +		kaddr = elfnotes_buf + start - elfcorebuf_sz;
> +		if (remap_vmalloc_range_partial(vma, vma->vm_start + len,
> +						kaddr, tsz)) {
> +			do_munmap(vma->vm_mm, vma->vm_start, len);
> +			return -EAGAIN;
> +		}
> +		size -= tsz;
> +		start += tsz;
> +		len += tsz;
> +
> +		if (size == 0)
> +			return 0;
> +	}
> +
> +	list_for_each_entry(m, &vmcore_list, list) {
> +		if (start < m->offset + m->size) {
> +			u64 paddr = 0;
> +
> +			tsz = m->offset + m->size - start;
> +			if (size < tsz)
> +				tsz = size;
> +			paddr = m->paddr + start - m->offset;
> +			if (remap_pfn_range(vma, vma->vm_start + len,
> +					    paddr >> PAGE_SHIFT, tsz,
> +					    vma->vm_page_prot)) {
> +				do_munmap(vma->vm_mm, vma->vm_start, len);
> +				return -EAGAIN;
> +			}
> +			size -= tsz;
> +			start += tsz;
> +			len += tsz;
> +
> +			if (size == 0)
> +				return 0;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct file_operations proc_vmcore_operations = {
>  	.read		= read_vmcore,
>  	.llseek		= default_llseek,
> +	.mmap		= mmap_vmcore,
>  };
>  
>  static struct vmcore* __init get_new_element(void)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
