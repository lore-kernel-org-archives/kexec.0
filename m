Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRjrK-00034K-Vq
 for kexec@lists.infradead.org; Mon, 04 Nov 2019 21:26:01 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: Fix off-by-one issue in
 exclude_nodata_pages()
Date: Mon, 4 Nov 2019 21:24:36 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035945E5@BPXM09GP.gisp.nec.co.jp>
References: <20191104130515.26741-1-zaslonko@linux.ibm.com>
In-Reply-To: <20191104130515.26741-1-zaslonko@linux.ibm.com>
Content-Language: en-US
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
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: "prudo@linux.ibm.com" <prudo@linux.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "dyoung@redhat.com" <dyoung@redhat.com>

Hi Mikhail,

> -----Original Message-----
> When building a dump bitmap (2nd bitmap) for the ELF dump, the last pfn
> of the cycle is always ignored in exclude_nodata_pages() function due to
> off-by-one error on cycle boundary check. Thus, the respective bit of
> the bitmap is never cleared.
> That can lead to the error when such a pfn should not be dumpable (e.g.
> the last pfn of the ELF-load of zero filesize). Based on the bit in the
> bitmap the page is treated as dumpable in write_elf_pages_cyclic() function
> and the follow on error is triggered in write_elf_load_segment() function
> due to the failing sanity check of paddr_to_offset2():

Good catch.  I could reproduce this issue with a vmcore on hand and
confirm that the patch fixed it.  Looks good to me, applied.

Thanks,
Kazu

> 
>    $ makedumpfile -E dump.elf dump.elf.E
>    Checking for memory holes                         : [100.0 %] |
>    write_elf_load_segment: Can't convert physaddr(7ffff000) to an offset.
>    makedumpfile Failed.
> 
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> ---
>  makedumpfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index de0973f..4a00011 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -4740,7 +4740,7 @@ exclude_nodata_pages(struct cycle *cycle)
>  		if (pfn < cycle->start_pfn)
>  			pfn = cycle->start_pfn;
>  		if (pfn_end >= cycle->end_pfn)
> -			pfn_end = cycle->end_pfn - 1;
> +			pfn_end = cycle->end_pfn;
>  		while (pfn < pfn_end) {
>  			clear_bit_on_2nd_bitmap(pfn, cycle);
>  			++pfn;
> --
> 2.17.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
