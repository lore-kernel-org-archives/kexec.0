Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZSSRO-0002JA-1Y
 for kexec@lists.infradead.org; Thu, 20 Aug 2015 16:11:46 +0000
Message-ID: <cd279166af08eba11be211481f319ab8.squirrel@www.codeaurora.org>
In-Reply-To: <20150820112150.GA26132@dhcppc13.redhat.com>
References: <d76572d93d25b0196cb2b32c88fd15dc4eb78682.1431714565.git.panand@redhat.com>
 <CAOZdJXWjZmL_K=FmvBU=U3VSDY9R4AucFU16v8CAgQCEe8HYDg@mail.gmail.com>
 <20150624033241.GA22348@localhost.localdomain>
 <558A25A3.60504@codeaurora.org>
 <20150627082256.GE21646@localhost.localdomain>
 <ddc87d025100347122b078b5104ec88c.squirrel@www.codeaurora.org>
 <20150703043241.GC21990@dhcppc13.redhat.com>
 <2c41ac3516494a1cc5d05462494b333b.squirrel@www.codeaurora.org>
 <c0ce0a0ea4482e9fca97b5c811f4693b.squirrel@www.codeaurora.org>
 <d0d13b96c02d5b54afcda30723667dab.squirrel@www.codeaurora.org>
 <20150820112150.GA26132@dhcppc13.redhat.com>
Date: Thu, 20 Aug 2015 16:11:24 -0000
Subject: Re: [PATCH] makedumpfile: Support ARM64
From: sgoel@codeaurora.org
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
To: Pratyush Anand <panand@redhat.com>
Cc: Timur Tabi <timur@codeaurora.org>, Azriel Samson <asamson@codeaurora.org>, kexec@lists.infradead.org, sgoel@codeaurora.org, virajm@codeaurora.org, ats-kumagai@wm.jp.nec.com

Hi Pratush,
I have made the change now.

The reason for changing the KVBASE was to get non zero value for mem_map
as seen from the crash tool. If KVBASE stays at page offset we do not get
into the function that looks for the free pages.

After looking at the page usage using the crash tool it seems that ~80% of
the pages are free.

Maybe there is something else that I am missing here. The page look up
fails when writing the crashdump file.
Thanks,
Sameer

> Hi Sameer,
>
> On 19/08/2015:11:16:07 PM, sgoel@codeaurora.org wrote:
>> Hi Pratyush,
>>
>> I made the following changes to the code:
>>
>> KVBASE was being mapped to page_offset, so the mem_map that I saw using
>> the kmem command in crash did not seem to audit with the data generated
>> by
>> make dumpfile. I changed this to vmalloc_start.
>
> I am not sure if KVBASE should be VMALLOC_START. May be Atsushi can
> comment on
> that. But if so, did you correct info->page_offset definition in
> get_machdep_info_arm64? Something like following...
>
> diff --git a/arch/arm64.c b/arch/arm64.c
> index 4d50012529c3..a94a4ba16dd5 100644
> --- a/arch/arm64.c
> +++ b/arch/arm64.c
> @@ -199,7 +199,8 @@ get_machdep_info_arm64(void)
>  {
>  	info->max_physmem_bits = PHYS_MASK_SHIFT;
>  	info->section_size_bits = SECTIONS_SIZE_BITS;
> -	info->page_offset = KVBASE;
> +	info->page_offset = SYMBOL(_stext)
> +		& (0xffffffffffffffffUL << (VA_BITS - 1));
>  	info->vmalloc_start = 0xffffffffffffffffUL << VA_BITS;
>  	info->vmalloc_end = PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - 0x10000;
>  	info->vmemmap_start = VMALLOC_END + 0x10000;
> diff --git a/makedumpfile.h b/makedumpfile.h
> index c33b5f321d9a..f7d6fbefe98e 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -488,8 +488,7 @@ int get_va_bits_arm64(void);
>  #define ARM64_PGTABLE_LEVELS	get_pgtable_level_arm64()
>  #define VA_BITS			get_va_bits_arm64()
>  #define PAGE_SHIFT		get_page_shift_arm64()
> -#define KVBASE_MASK		(0xffffffffffffffffUL << (VA_BITS - 1))
> -#define KVBASE			(SYMBOL(_stext) & KVBASE_MASK)
> +#define KVBASE			VMALLOC_START
>  #endif /* aarch64 */
>
>  #ifdef __arm__
>
> ~Pratyush
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
