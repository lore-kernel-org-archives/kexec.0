Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPHoF-0002tJ-6e
 for kexec@lists.infradead.org; Wed, 21 Nov 2018 02:00:08 +0000
Date: Tue, 20 Nov 2018 20:59:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 3/8] kexec: export PG_offline to VMCOREINFO
Message-ID: <20181120205822-mutt-send-email-mst@kernel.org>
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101616.8901-4-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181119101616.8901-4-david@redhat.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>, linux-pm@vger.kernel.org, pv-drivers@vmware.com, linux-doc@vger.kernel.org, kexec-ml <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Borislav Petkov <bp@alien8.de>, xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, devel@linuxdriverproject.org, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Omar Sandoval <osandov@fb.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lianbo Jiang <lijiang@redhat.com>

On Mon, Nov 19, 2018 at 11:16:11AM +0100, David Hildenbrand wrote:
> Right now, pages inflated as part of a balloon driver will be dumped
> by dump tools like makedumpfile. While XEN is able to check in the
> crash kernel whether a certain pfn is actuall backed by memory in the
> hypervisor (see xen_oldmem_pfn_is_ram) and optimize this case, dumps of
> other balloon inflated memory will essentially result in zero pages getting
> allocated by the hypervisor and the dump getting filled with this data.
> 
> The allocation and reading of zero pages can directly be avoided if a
> dumping tool could know which pages only contain stale information not to
> be dumped.
> 
> We now have PG_offline which can be (and already is by virtio-balloon)
> used for marking pages as logically offline. Follow up patches will
> make use of this flag also in other balloon implementations.
> 
> Let's export PG_offline via PAGE_OFFLINE_MAPCOUNT_VALUE, so
> makedumpfile can directly skip pages that are logically offline and the
> content therefore stale.
> 
> Please note that this is also helpful for a problem we were seeing under
> Hyper-V: Dumping logically offline memory (pages kept fake offline while
> onlining a section via online_page_callback) would under some condicions
> result in a kernel panic when dumping them.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Lianbo Jiang <lijiang@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  kernel/crash_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 933cb3e45b98..093c9f917ed0 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -464,6 +464,8 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
>  #ifdef CONFIG_HUGETLB_PAGE
>  	VMCOREINFO_NUMBER(HUGETLB_PAGE_DTOR);
> +#define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
> +	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
>  #endif
>  
>  	arch_crash_save_vmcoreinfo();
> -- 
> 2.17.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
