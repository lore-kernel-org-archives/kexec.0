Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gOm4u-0001IX-7U
 for kexec@lists.infradead.org; Mon, 19 Nov 2018 16:07:13 +0000
Subject: Re: [PATCH v1 2/8] mm: convert PG_balloon to PG_offline
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101616.8901-3-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <94387ebe-9fb3-9471-9fb3-b66abf899a3f@redhat.com>
Date: Mon, 19 Nov 2018 17:06:12 +0100
MIME-Version: 1.0
In-Reply-To: <20181119101616.8901-3-david@redhat.com>
Content-Language: en-US
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
To: linux-mm@kvack.org
Cc: Michal Hocko <mhocko@suse.com>, linux-doc@vger.kernel.org, pv-drivers@vmware.com, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Matthew Wilcox <willy@infradead.org>, Konstantin Khlebnikov <koct9i@gmail.com>, David Rientjes <rientjes@google.com>, xen-devel@lists.xenproject.org, Alexey Dobriyan <adobriyan@gmail.com>, linux-pm@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Christian Hansen <chansen3@cisco.com>, kexec-ml <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Miles Chen <miles.chen@mediatek.com>, linux-fsdevel@vger.kernel.org, devel@linuxdriverproject.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

>  
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 50ce1bddaf56..f91da3d0a67e 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -670,7 +670,7 @@ PAGEFLAG_FALSE(DoubleMap)
>  #define PAGE_TYPE_BASE	0xf0000000
>  /* Reserve		0x0000007f to catch underflows of page_mapcount */
>  #define PG_buddy	0x00000080
> -#define PG_balloon	0x00000100
> +#define PG_offline	0x00000100
>  #define PG_kmemcg	0x00000200
>  #define PG_table	0x00000400
>  
> @@ -700,10 +700,13 @@ static __always_inline void __ClearPage##uname(struct page *page)	\
>  PAGE_TYPE_OPS(Buddy, buddy)
>  
>  /*
> - * PageBalloon() is true for pages that are on the balloon page list
> - * (see mm/balloon_compaction.c).
> + * PageOffline() indicates that the pages is logically offline although the

s/pages/page/

:)


-- 

Thanks,

David / dhildenb

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
