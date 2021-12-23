Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n0Pai-00CwQO-2b
 for kexec@lists.infradead.org; Thu, 23 Dec 2021 15:01:13 +0000
Message-ID: <beb50d46-e3ce-92fc-98b8-ea8c8222bd04@oracle.com>
Date: Thu, 23 Dec 2021 09:00:20 -0600
Subject: Re: [PATCH v4 1/3] mm_zone: add function to check if managed dma zone
 exists
Content-Language: en-US
References: <20211223094435.248523-1-bhe@redhat.com>
 <20211223094435.248523-2-bhe@redhat.com>
From: john.p.donnelly@oracle.com
In-Reply-To: <20211223094435.248523-2-bhe@redhat.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, cl@linux.com, kexec@lists.infradead.org, 42.hyeyoo@gmail.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, David.Laight@ACULAB.COM, david@redhat.com, x86@kernel.org, bp@alien8.de, John Donnelly <john.p.donnelly@oracle.com>

On 12/23/21 3:44 AM, Baoquan He wrote:
> In some places of the current kernel, it assumes that dma zone must have
> managed pages if CONFIG_ZONE_DMA is enabled. While this is not always true.
> E.g in kdump kernel of x86_64, only low 1M is presented and locked down
> at very early stage of boot, so that there's no managed pages at all in
> DMA zone. This exception will always cause page allocation failure if page
> is requested from DMA zone.
> 
> Here add function has_managed_dma() and the relevant helper functions to
> check if there's DMA zone with managed pages. It will be used in later
> patches.
> 
> Fixes: 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   include/linux/mmzone.h |  9 +++++++++
>   mm/page_alloc.c        | 15 +++++++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 58e744b78c2c..6e1b726e9adf 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1046,6 +1046,15 @@ static inline int is_highmem_idx(enum zone_type idx)
>   #endif
>   }
>   
> +#ifdef CONFIG_ZONE_DMA
> +bool has_managed_dma(void);
> +#else
> +static inline bool has_managed_dma(void)
> +{
> +	return false;
> +}
> +#endif
> +
>   /**
>    * is_highmem - helper function to quickly check if a struct zone is a
>    *              highmem zone or not.  This is an attempt to keep references
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c5952749ad40..7c7a0b5de2ff 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9460,3 +9460,18 @@ bool take_page_off_buddy(struct page *page)
>   	return ret;
>   }
>   #endif
> +
> +#ifdef CONFIG_ZONE_DMA
> +bool has_managed_dma(void)
> +{
> +	struct pglist_data *pgdat;
> +
> +	for_each_online_pgdat(pgdat) {
> +		struct zone *zone = &pgdat->node_zones[ZONE_DMA];
> +
> +		if (managed_zone(zone))
> +			return true;
> +	}
> +	return false;
> +}
> +#endif /* CONFIG_ZONE_DMA */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
