Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBFBC2BD09
	for <kexec@archiver.kernel.org>; Mon, 24 Jun 2024 18:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P24peKave1mtny2rN9Irhu00OYEfqfbh+lVkBqZdvuI=; b=MEDli2haZhiO5w
	m5ZjGpmcgcsGcixUCSRpkMnkaCzMvF02dBmPE9HZilQjoaf4jUt1coGwc3emQQe6Oo+PsFffaTpvd
	SV0jHPCQHH+F6RjagPMXLLcdPEwhIwmdqV8PdmPrJsxL/C9V9QdjO14V02iCowTBHVjfdPLJHUFGi
	DtNGQPDS2d4U7kXaYsuaM3ln4GjPuzLovaBbPUU9oZMXVOzBnJt0c8llEQPmKO9izf4htAAyVFf0/
	ESZjdsetWh1kYGZWJ7wDsPZ91vEyl1Jo0XVYoghFpNaAbPwiQ2b32nRqUxF+EcCCcjST1chzpecaR
	umCEdo7y5JK6W/+MpuGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLoPG-00000000Hjp-0O7W;
	Mon, 24 Jun 2024 18:27:10 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLoPB-00000000Heh-0R7S
	for kexec@lists.infradead.org;
	Mon, 24 Jun 2024 18:27:07 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AEEB040E01D6;
	Mon, 24 Jun 2024 18:26:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YhcAhENbR_WH; Mon, 24 Jun 2024 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719253609; bh=fXBniNOuUrC5AGYiVs4PLfsvA4GQHtYMsgsNMOxALm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h2+L2ArAjnVtpNtjTXIsYwgHNdbGwaWF8PXEmAs1qB0SlNZF0QUk1HYOaHbSlJIui
	 viSCdg7TaroT2VnwNwVZ4C+9YD0rg/L2sCP5Y9s81qU0Y78fm8MG2fjMOr4ODt3QFW
	 kOFiXZphJZA+3pzx3jeNs5UltFEsGSNwV5r9NMQlFo1E/AVoeTuMpvHjtypHXWMhr2
	 OCJazXAsbqYzbCoHu/78daIwWXHa0qEHxF6Whsq6YabVaPLJicAlfjiexwQfdmA6wI
	 5SyvrtFobGhxIrUDEPz8qxgM7EsRCOgeNJw62ZPNe8YIP6keb0KaZWVRezMn2XamEn
	 SKDaurjw/Gdb80OxsUQaEnMfMOwM1ozJGUIXDW8g8WgUEUYf97KoTGU0s0+PcUgNYY
	 a1Flsfh+/bvdCvQf7Q8uqxm1A8Nb5LBvRkavxSKHIahIZk5ZS67wMSsmniIGYp0k5E
	 apvDcRfV6UfLT/VxDOGTZu1Wy0KBBm5gCgAuw0MRyCROcQHxdbxcVU0btWvm2t+Pf0
	 fzBsyzKqtdzAJfO1HaKeJTJmJfVlaOVhhoEow2OdPcIrTG+DA9c7v5GRWXL1fR7XfM
	 kKw786IMPpxU1KokfzZJsgd+sY9lzwol9eEh7OrAsMPYIQM+QDQexaF5bTARc0a4A1
	 R3Uz8o0Ezn7Ahaw68OiYxY5A=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D62A40E0177;
	Mon, 24 Jun 2024 18:26:21 +0000 (UTC)
Date: Mon, 24 Jun 2024 20:26:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, hpa@zytor.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/3] x86/snp: Convert shared memory back to private on
 kexec
Message-ID: <20240624182615.GLZnm6R4hLvnlF16aP@fat_crate.local>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1718920799.git.ashish.kalra@amd.com>
 <f6c0ddfd15579674bc234d6e1b84e92768531050.1718920799.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f6c0ddfd15579674bc234d6e1b84e92768531050.1718920799.git.ashish.kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_112705_384178_49B27EB4 
X-CRM114-Status: GOOD (  26.29  )
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

On Thu, Jun 20, 2024 at 10:23:59PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> SNP guests allocate shared buffers to perform I/O. It is done by
> allocating pages normally from the buddy allocator and converting them
> to shared with set_memory_decrypted().
> 
> The second kernel has no idea what memory is converted this way. It only

The secon, kexec-ed, kernel...

> sees E820_TYPE_RAM.

...

> @@ -92,6 +94,9 @@ static struct ghcb *boot_ghcb __section(".data");
>  /* Bitmap of SEV features supported by the hypervisor */
>  static u64 sev_hv_features __ro_after_init;
>  
> +/* Last address to be switched to private during kexec */
> +static unsigned long kexec_last_addr_to_make_private;

This is particularly yucky.

AFAIU, you want to:

1. Skip GHCB addresses when making all pages private

2. Once you're done converting, in snp_kexec_finish() go over the GHCB
   addresses and convert them explicitly, one-by-one, without this silly
   variable

>  /* #VC handler runtime per-CPU data */
>  struct sev_es_runtime_data {
>  	struct ghcb ghcb_page;
> @@ -1010,6 +1015,169 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>  	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
>  }
>  
> +static bool set_pte_enc(pte_t *kpte, int level, void *va)

Code duplication: __set_clr_pte_enc().

You need to refactor the code instead of adding just another, generically
looking helper just because it is easier this way.

> +{
> +	pte_t new_pte;
> +
> +	if (pte_none(*kpte))
> +		return false;
> +
> +	/*
> +	 * Change the physical page attribute from C=0 to C=1. Flush the
> +	 * caches to ensure that data gets accessed with the correct C-bit.
> +	 */
> +	if (pte_present(*kpte))
> +		clflush_cache_range(va, page_level_size(level));
> +
> +	new_pte = __pte(cc_mkenc(pte_val(*kpte)));
> +	set_pte_atomic(kpte, new_pte);
> +
> +	return true;
> +}
> +
> +static bool make_pte_private(pte_t *pte, unsigned long addr, int pages, int level)
> +{
> +	struct sev_es_runtime_data *data;
> +	struct ghcb *ghcb;
> +
> +	data = this_cpu_read(runtime_data);
> +	ghcb = &data->ghcb_page;
> +
> +	/* Check for GHCB for being part of a PMD range. */
> +	if ((unsigned long)ghcb >= addr &&
> +	    (unsigned long)ghcb <= (addr + (pages * PAGE_SIZE))) {
> +		/*
> +		 * Ensure that the current cpu's GHCB is made private

s/cpu/CPU/g

There are multiple places.

> +		 * at the end of unshared loop so that we continue to use the
> +		 * optimized GHCB protocol and not force the switch to
> +		 * MSR protocol till the very end.
> +		 */
> +		pr_debug("setting boot_ghcb to NULL for this cpu ghcb\n");
> +		kexec_last_addr_to_make_private = addr;
> +		return true;
> +	}
> +
> +	if (!set_pte_enc(pte, level, (void *)addr))
> +		return false;
> +
> +	snp_set_memory_private(addr, pages);
> +
> +	return true;
> +}
> +
> +static void unshare_all_memory(void)
> +{
> +	unsigned long addr, end;
> +
> +	/*
> +	 * Walk direct mapping and convert all shared memory back to private,

This ends with a ','. Is anything more coming?

> +	 */
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
> +		/*
> +		 * pte_none() check is required to skip physical memory holes in direct mapped.

This sentence needs to be written for humans. And come to think of it, you can
simply drop it. lookup_address() can return NULL so you simply need to check
its retval.

> +		 */
> +		if (pte && pte_decrypted(*pte) && !pte_none(*pte)) {
> +			int pages = size / PAGE_SIZE;
> +
> +			if (!make_pte_private(pte, addr, pages, level)) {
> +				pr_err("Failed to unshare range %#lx-%#lx\n",
> +				       addr, addr + size);

Might as well terminate the guest here.

> +			}
> +
> +		}
> +
> +		addr += size;
> +	}
> +	__flush_tlb_all();
> +
> +}
> +
> +static void unshare_all_bss_decrypted_memory(void)

Why is this a separate function and not part of unshare_all_memory()?

> +{
> +	unsigned long vaddr, vaddr_end;
> +	unsigned int level;
> +	unsigned int npages;
> +	pte_t *pte;
> +
> +	vaddr = (unsigned long)__start_bss_decrypted;
> +	vaddr_end = (unsigned long)__start_bss_decrypted_unused;
> +	npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
> +	for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
> +		pte = lookup_address(vaddr, &level);
> +		if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
> +			continue;
> +
> +		set_pte_enc(pte, level, (void *)vaddr);
> +	}
> +	vaddr = (unsigned long)__start_bss_decrypted;
> +	snp_set_memory_private(vaddr, npages);
> +}

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
