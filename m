Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c4MnJ-0005cs-6M
 for kexec@lists.infradead.org; Wed, 09 Nov 2016 06:55:38 +0000
Date: Wed, 9 Nov 2016 14:55:12 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 2/2] makedumpfile: Clean up unused KERNEL_IMAGE_SIZE
Message-ID: <20161109065512.GC3598@x1>
References: <1478595319-9299-1-git-send-email-bhe@redhat.com>
 <1478595319-9299-3-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1478595319-9299-3-git-send-email-bhe@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: panand@redhat.com, kexec@lists.infradead.org, anderson@redhat.com, ebiederm@xmission.com, tglx@linutronix.de, dyoung@redhat.com

Sorry, I am not familiar with DWARF format, and KERNEL_IMAGE_SIZE is a
defined MACRO. I don't know what DW_TAG_XXX_type should be taken to
retrieve it when specify "-g" to generate vmcoreinfo file from vmlinux.

So drop this patch for now though it doesn't affect Dave's Crash code,
will make time to try to add it later, I need work on other urgent
things now. Or someone who is interested can add this.

Now only patch 1/2 is available.

Thanks
Baoquan

On 11/08/16 at 04:55pm, Baoquan He wrote:
> The old MODULES_VADDR need be decided by KERNEL_IMAGE_SIZE when kaslr
> enabled. Now MODULES_VADDR is not needed any more since Pratyush makes
> all VA to PA converting done by page table lookup. So remove its related
> code.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  makedumpfile.c | 11 +----------
>  makedumpfile.h |  3 ---
>  2 files changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index a3f711e..1c95306 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1994,14 +1994,7 @@ get_value_for_old_linux(void)
>  			NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) =
>  			PAGE_BUDDY_MAPCOUNT_VALUE_v2_6_39_to_latest_version;
>  	}
> -#ifdef __x86_64__
> -	if (NUMBER(KERNEL_IMAGE_SIZE) == NOT_FOUND_NUMBER) {
> -		if (info->kernel_version < KERNEL_VERSION(2, 6, 26))
> -			NUMBER(KERNEL_IMAGE_SIZE) = KERNEL_IMAGE_SIZE_ORIG;
> -		else
> -			NUMBER(KERNEL_IMAGE_SIZE) = KERNEL_IMAGE_SIZE_2_6_26;
> -	}
> -#endif
> +
>  	if (SIZE(pageflags) == NOT_FOUND_STRUCTURE) {
>  		if (info->kernel_version >= KERNEL_VERSION(2, 6, 27))
>  			SIZE(pageflags) =
> @@ -2258,7 +2251,6 @@ write_vmcoreinfo_data(void)
>  	WRITE_NUMBER("PG_hwpoison", PG_hwpoison);
>  
>  	WRITE_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
> -	WRITE_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
>  	WRITE_NUMBER("phys_base", phys_base);
>  
>  	WRITE_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
> @@ -2606,7 +2598,6 @@ read_vmcoreinfo(void)
>  	READ_SRCFILE("pud_t", pud_t);
>  
>  	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
> -	READ_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
>  	READ_NUMBER("phys_base", phys_base);
>  
>  	READ_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 422b6be..b627e32 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -573,8 +573,6 @@ int get_va_bits_arm64(void);
>  #define VMEMMAP_END_2_6_31	(0xffffeaffffffffff) /* 2.6.31, or later  */
>  
>  #define __START_KERNEL_map	(0xffffffff80000000)
> -#define KERNEL_IMAGE_SIZE_ORIG		(0x0000000008000000) /* 2.6.25, or former */
> -#define KERNEL_IMAGE_SIZE_2_6_26	(0x0000000020000000) /* 2.6.26, or later  */
>  #define KVBASE			PAGE_OFFSET
>  #define _SECTION_SIZE_BITS	(27)
>  #define _MAX_PHYSMEM_BITS_ORIG		(40)
> @@ -1713,7 +1711,6 @@ struct number_table {
>  	long    PG_hwpoison;
>  
>  	long	PAGE_BUDDY_MAPCOUNT_VALUE;
> -	long	KERNEL_IMAGE_SIZE;
>  	long	SECTION_SIZE_BITS;
>  	long	MAX_PHYSMEM_BITS;
>  	long    HUGETLB_PAGE_DTOR;
> -- 
> 2.5.5
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
