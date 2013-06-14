Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UnaIX-0008Nc-Hy
 for kexec@lists.infradead.org; Fri, 14 Jun 2013 20:08:39 +0000
Date: Fri, 14 Jun 2013 16:08:08 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 4/5] s390/vmcore: Implement remap_oldmem_pfn_range for
 s390
Message-ID: <20130614200808.GO12023@redhat.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-5-git-send-email-holzheu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1370624161-2298-5-git-send-email-holzheu@linux.vnet.ibm.com>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Fri, Jun 07, 2013 at 06:56:00PM +0200, Michael Holzheu wrote:
> From: Jan Willeke <willeke@de.ibm.com>
> 
> This patch introduces the s390 specific way to map pages from oldmem.
> The memory area below OLDMEM_SIZE is mapped with offset OLDMEM_BASE.
> The other old memory is mapped directly.
> 

If we get rid of swap logic in copy_oldmem_page(), quite some amount
of code can be cleaned up. One has to spcial case only zfcpdump to
read from HSA memory.

Anyway sounds like a s390 specific cleanup in a separate series.

Thanks
Vivek


> Signed-off-by: Jan Willeke <willeke@de.ibm.com>
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> ---
>  arch/s390/kernel/crash_dump.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> index a17f8d4..12ccc3c 100644
> --- a/arch/s390/kernel/crash_dump.c
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -56,6 +56,32 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
>  }
>  
>  /*
> + * Remap "oldmem"
> + *
> + * For the kdump reserved memory this functions performs a swap operation:
> + * [0 - OLDMEM_SIZE] is mapped to [OLDMEM_BASE - OLDMEM_BASE + OLDMEM_SIZE]
> + */
> +int remap_oldmem_pfn_range(struct vm_area_struct *vma, unsigned long from,
> +			   unsigned long pfn, unsigned long size, pgprot_t prot)
> +{
> +	unsigned long size_old;
> +	int rc;
> +
> +	if (pfn < OLDMEM_SIZE >> PAGE_SHIFT) {
> +		size_old = min(size, OLDMEM_SIZE - (pfn << PAGE_SHIFT));
> +		rc = remap_pfn_range(vma, from,
> +				     pfn + (OLDMEM_BASE >> PAGE_SHIFT),
> +				     size_old, prot);
> +		if (rc || size == size_old)
> +			return rc;
> +		size -= size_old;
> +		from += size_old;
> +		pfn += size_old >> PAGE_SHIFT;
> +	}
> +	return remap_pfn_range(vma, from, pfn, size, prot);
> +}
> +
> +/*
>   * Copy memory from old kernel
>   */
>  int copy_from_oldmem(void *dest, void *src, size_t count)
> -- 
> 1.8.1.6

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
