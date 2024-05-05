Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600CAC04FFE
	for <kexec@archiver.kernel.org>; Sun,  5 May 2024 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=490qsBDJ6qV1AaTmgvBR4ZirxvOBLGq73d4+lReBjyY=; b=DSoEtzd3j2hxHU
	p6tgcDT4OivcUNytkUmhzfgbyx9DkxB2kBKwJDZ0olA47H6wPq0/OZEF0QL1cOLqnCWEksnm8jjz3
	ClMy2Fjd7rEffanew7sJwVjsdW6Hi8QsX967jrrt+Fzcl5I/DxbJirsM7vNaUBhVmwIHidRs+fC05
	LD8AVh0VqIvzdCfExx/7Gkp3T+JgXWMAFSIuIBRVxaa1r06zc4EREDK6yQzZITDLBdlSrK/2kysQe
	GSw122Umj4WM4TrHuD13y/ZXhPkafjUlAcadTm9ZiIvcoFiw/WzdzzIN6qsvpmuDHWyUXnv11ATOB
	jA3tSjs0TM54X0H67cVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3akt-00000004DlG-21kE;
	Sun, 05 May 2024 12:14:11 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3ako-00000004Dg5-1WJb
	for kexec@lists.infradead.org;
	Sun, 05 May 2024 12:14:08 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1604540E0244;
	Sun,  5 May 2024 12:13:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gQ7-V4k4tIs6; Sun,  5 May 2024 12:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714911227; bh=iXuHyguEjq+GHMucvMpZ87uVJIcG+yLUxh9sVFXvkHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2dxPyvi3Sqg9Z1LdkGhza8vVMmHxp8Md+i+zkn+1EotL5dqt+pVond5T2ABRSNJy
	 +XVTq99P5he2yHmxcGm5ZZYYBEsq+Yb3xRzGf0dSbkbfLhv3VRKSxBZM5tUSOnZ4TO
	 xvnexOTY1/5g3Bfzx/Z14AcLhnvAV/POqQXYq8DSsUn0hbwn2ZPxhyhEjHICB3Nssd
	 6BYnNwDOWC49d8siFpAOLIv9fJx6EeVBSl0rS/1skF5PbiyOHebrUmDz13gIbjJxEj
	 NJN5U43CgsXmKQRtkJbVloP0v6G38fXumNRWkrmjWPkk2aCG6SCvVa+kBIRmJ2t6I8
	 bcrLoI/nqKvlBJsXdHUMGwwxjDJgjsvDy/8Uy/WMhXKWoakOmerVGJj/8MHPQMVzNO
	 Fmyk4oNwtOahs+pGU+sU+3FszuYhK2mZe5+/R8CWa7C3JgjfOSdzNIrW5AHQIvGN+i
	 UtbL3An6aG+erzleTXWOXV/HI7au55/ozIULyePR4qyBptFlXbcbfPoW+k+N+NfVAH
	 yUxs/WgoYM3LIVd7febnZWnlv5yuQqTLanlZe5IsV+6vwvlgVmLrUcRSUX8skJbCHX
	 Btq9axNuZWb6xEYL8KTHISPA2chGh4zdXeFTQlua0yBqsTC7LZ/QniAQmwZp/eI9yC
	 7Of1o/WQMG+6taOBnkJuzUsA=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3FEFF40E0192;
	Sun,  5 May 2024 12:13:26 +0000 (UTC)
Date: Sun, 5 May 2024 14:13:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 10/18] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <20240505121319.GAZjd337gHC0uhk6aM@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-11-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240409113010.465412-11-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240505_051406_669479_2866D77E 
X-CRM114-Status: GOOD (  38.39  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Apr 09, 2024 at 02:30:02PM +0300, Kirill A. Shutemov wrote:
> TDX guests allocate shared buffers to perform I/O. It is done by
> allocating pages normally from the buddy allocator and converting them
> to shared with set_memory_decrypted().
> 
> The second kernel has no idea what memory is converted this way. It only

"The kexec-ed kernel..."

is more precise.

> sees E820_TYPE_RAM.
> 
> Accessing shared memory via private mapping is fatal. It leads to
> unrecoverable TD exit.
> 
> On kexec walk direct mapping and convert all shared memory back to
> private. It makes all RAM private again and second kernel may use it
> normally.
> 
> The conversion occurs in two steps: stopping new conversions and
> unsharing all memory. In the case of normal kexec, the stopping of
> conversions takes place while scheduling is still functioning. This
> allows for waiting until any ongoing conversions are finished. The
> second step is carried out when all CPUs except one are inactive and
> interrupts are disabled. This prevents any conflicts with code that may
> access shared memory.

This is the missing bit of information I was looking for in the previous
patch. This needs to be documented in the code.

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Tao Liu <ltao@redhat.com>
> ---
>  arch/x86/coco/tdx/tdx.c           | 72 +++++++++++++++++++++++++++++++
>  arch/x86/include/asm/pgtable.h    |  5 +++
>  arch/x86/include/asm/set_memory.h |  3 ++
>  arch/x86/mm/pat/set_memory.c      | 35 +++++++++++++--
>  4 files changed, 112 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 979891e97d83..59776ce1c1d7 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -7,6 +7,7 @@
>  #include <linux/cpufeature.h>
>  #include <linux/export.h>
>  #include <linux/io.h>
> +#include <linux/kexec.h>
>  #include <asm/coco.h>
>  #include <asm/tdx.h>
>  #include <asm/vmx.h>
> @@ -14,6 +15,7 @@
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
>  #include <asm/pgtable.h>
> +#include <asm/set_memory.h>
>  
>  /* MMIO direction */
>  #define EPT_READ	0
> @@ -831,6 +833,73 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
>  	return 0;
>  }
>  
> +/* Stop new private<->shared conversions */
> +static void tdx_kexec_stop_conversion(bool crash)
> +{
> +	/*
> +	 * Crash kernel reaches here with interrupts disabled: can't wait for
> +	 * conversions to finish.
> +	 *
> +	 * If race happened, just report and proceed.
> +	 */
> +	bool wait_for_lock = !crash;

You don't need that bool - use crash.

> +
> +	if (!stop_memory_enc_conversion(wait_for_lock))
> +		pr_warn("Failed to stop shared<->private conversions\n");
> +}
> +
> +static void tdx_kexec_unshare_mem(void)
> +{
> +	unsigned long addr, end;
> +	long found = 0, shared;
> +
> +	/*
> +	 * Walk direct mapping and convert all shared memory back to private,
> +	 */

Over the function name and end with a fullstop.

> +
> +	addr = PAGE_OFFSET;
> +	end  = PAGE_OFFSET + get_max_mapped();
> +
> +	while (addr < end) {
> +		unsigned long size;
> +		unsigned int level;
> +		pte_t *pte;
> +
> +		pte = lookup_address(addr, &level);
> +		size = page_level_size(level);
> +
> +		if (pte && pte_decrypted(*pte)) {
> +			int pages = size / PAGE_SIZE;
> +
> +			/*
> +			 * Touching memory with shared bit set triggers implicit
> +			 * conversion to shared.
> +			 *
> +			 * Make sure nobody touches the shared range from
> +			 * now on.
> +			 */

lockdep_assert_irqs_disabled() ?

> +			set_pte(pte, __pte(0));
> +
> +			if (!tdx_enc_status_changed(addr, pages, true)) {
> +				pr_err("Failed to unshare range %#lx-%#lx\n",
> +				       addr, addr + size);

Why are we printing something here if we're not really acting up on it?

Who should care here?

> +			}
> +
> +			found += pages;
> +		}
> +
> +		addr += size;
> +	}
> +
> +	__flush_tlb_all();
> +
> +	shared = atomic_long_read(&nr_shared);
> +	if (shared != found) {
> +		pr_err("shared page accounting is off\n");
> +		pr_err("nr_shared = %ld, nr_found = %ld\n", shared, found);
> +	}

Ok, we failed unsharing. And yet we don't do anything.

But if we fail unsharing, we will die on a unrecoverable TD exit or
whatever.

Why aren't we failing kexec here?

> +}
> +
>  void __init tdx_early_init(void)
>  {
>  	struct tdx_module_args args = {
> @@ -890,6 +959,9 @@ void __init tdx_early_init(void)
>  	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
>  	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
>  
> +	x86_platform.guest.enc_kexec_stop_conversion = tdx_kexec_stop_conversion;
> +	x86_platform.guest.enc_kexec_unshare_mem     = tdx_kexec_unshare_mem;
> +
>  	/*
>  	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
>  	 * bringup low level code. That raises #VE which cannot be handled
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 315535ffb258..17f4d97fae06 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -140,6 +140,11 @@ static inline int pte_young(pte_t pte)
>  	return pte_flags(pte) & _PAGE_ACCESSED;
>  }
>  
> +static inline bool pte_decrypted(pte_t pte)
> +{
> +	return cc_mkdec(pte_val(pte)) == pte_val(pte);
> +}
> +
>  #define pmd_dirty pmd_dirty
>  static inline bool pmd_dirty(pmd_t pmd)
>  {
> diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
> index 9aee31862b4a..44b6d711296c 100644
> --- a/arch/x86/include/asm/set_memory.h
> +++ b/arch/x86/include/asm/set_memory.h
> @@ -49,8 +49,11 @@ int set_memory_wb(unsigned long addr, int numpages);
>  int set_memory_np(unsigned long addr, int numpages);
>  int set_memory_p(unsigned long addr, int numpages);
>  int set_memory_4k(unsigned long addr, int numpages);
> +
> +bool stop_memory_enc_conversion(bool wait);
>  int set_memory_encrypted(unsigned long addr, int numpages);
>  int set_memory_decrypted(unsigned long addr, int numpages);
> +
>  int set_memory_np_noalias(unsigned long addr, int numpages);
>  int set_memory_nonglobal(unsigned long addr, int numpages);
>  int set_memory_global(unsigned long addr, int numpages);
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 6c49f69c0368..21835339c0e6 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2188,12 +2188,41 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  	return ret;
>  }
>  

<--- insert comment here what this thing is guarding.

> +static DECLARE_RWSEM(mem_enc_lock);
> +
> +/*
> + * Stop new private<->shared conversions.
> + *
> + * Taking the exclusive mem_enc_lock waits for in-flight conversions to complete.
> + * The lock is not released to prevent new conversions from being started.
> + *
> + * If sleep is not allowed, as in a crash scenario, try to take the lock.
> + * Failure indicates that there is a race with the conversion.
> + */
> +bool stop_memory_enc_conversion(bool wait)

This is a global function which means, it should be called:

set_memory_enc_stop_conversion()

or so. With the proper prefix and so on.

> +{
> +	if (!wait)
> +		return down_write_trylock(&mem_enc_lock);
> +
> +	down_write(&mem_enc_lock);
> +
> +	return true;
> +}
> +
>  static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>  {
> -	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> -		return __set_memory_enc_pgtable(addr, numpages, enc);
> +	int ret = 0;
>  
> -	return 0;
> +	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> +		if (!down_read_trylock(&mem_enc_lock))
> +			return -EBUSY;

This function is called on SEV* and HyperV and the respective folks need
to at least ack this new approach.

I see Ashish's patch adds the respective stuff:

https://lore.kernel.org/r/c24516a4636a36d57186ea90ae26495b3c1cfb8b.1714148366.git.ashish.kalra@amd.com

which leaves HyperV. You'd need to Cc them on the next submission.

Thx.


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
