Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1STiQO-0005XC-0T
 for kexec@lists.infradead.org; Sun, 13 May 2012 23:42:08 +0000
Date: Mon, 14 May 2012 08:39:11 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: a bug of "arch/x86_64.c"
Message-Id: <20120514083911.7c5b9d24.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <001201cd2ea5$7bb58e70$7320ab50$%zhang@huawei.com>
References: <001201cd2ea5$7bb58e70$7320ab50$%zhang@huawei.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Zhangfengwei <fngw.zhang@huawei.com>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org


Hi Zhangfengwei,

Thank you for your patch.
I'm out of makedumpfile development, and the maintainer is Kumagai-San now.
So he will review this patch.

Kumagai-San, can you review this patch ?


Thanks
Ken'ichi Ohmichi

---

On Thu, 10 May 2012 20:07:33 +0800
Zhangfengwei <fngw.zhang@huawei.com> wrote:
>
> Hello,
>      I find a bug of makedumpfile in a server with pages of 4KB,2MB and 1GB
> .
>      The reason:
>      When we get physical address by " kvtop_xen_x86_64()",Sometimes it is
> wrong;
> because the address maybe is an address of a page of 1GB ,when we get the
> physical address of L3 by L4.
> so we should judge if the address is in a page of 1GB ,which is the same
> with xen does.
> 
> The xen codes(4.1.2) like this: 
> in do_page_walk() of mm.c it does: if ( (l3e_get_flags(l3e) & _PAGE_PSE) )
> return mfn_to_virt(mfn) + (addr & ((1UL << L3_PAGETABLE_SHIFT) - 1));
> 
> the code:
> void *do_page_walk(struct vcpu *v, unsigned long addr)
> {
> ...
>     l4t = mfn_to_virt(mfn);
>     l4e = l4t[l4_table_offset(addr)];
>     mfn = l4e_get_pfn(l4e);
>     if ( !(l4e_get_flags(l4e) & _PAGE_PRESENT) )
>         return NULL;
>     l3t = mfn_to_virt(mfn);
>     l3e = l3t[l3_table_offset(addr)];
>     mfn = l3e_get_pfn(l3e);
>     if ( !(l3e_get_flags(l3e) & _PAGE_PRESENT) || !mfn_valid(mfn) )
>         return NULL;
>     if ( (l3e_get_flags(l3e) & _PAGE_PSE) )
>         return mfn_to_virt(mfn) + (addr & ((1UL << L3_PAGETABLE_SHIFT) -
> 1));
> ...
> }
> 
>      So the patch is like this:
> 
> diff -urN makedumpfile-org/x86_64.c makedumpfile/x86_64.c
> --- makedumpfile-org/x86_64.c	2012-05-07 04:29:19.000000000 -0500
> +++ makedumpfile/x86_64.c	2012-05-07 04:29:39.000000000 -0500
> @@ -392,6 +392,13 @@
>  	if (!(entry & _PAGE_PRESENT))
>  		return NOT_PADDR;
>  
> +        if (entry & _PAGE_PSE) {
> +                entry = (entry & ENTRY_MASK) + (kvaddr & ((1UL <<
> PGDIR_SHIFT) - 1));
> +                if( is_xen_frametable_addr(kvaddr) )
> +                        insert_xvaddr_xpaddr_fn(kvaddr,entry);
> +                return entry;
> +        }
> + 
>  	dirp = entry & ENTRY_MASK;
>  	dirp += pmd_index(kvaddr) * sizeof(unsigned long long);
>  	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
> 
>     I am looking forward to receive your reply as soon as possible. 
>     thanks
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
