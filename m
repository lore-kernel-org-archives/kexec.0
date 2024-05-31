Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF85C25B7E
	for <kexec@archiver.kernel.org>; Fri, 31 May 2024 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yB4xop93uz8A7vst1bJQzgUWqsx4xT8gRuntKXpWUZg=; b=xlAp2sQzOd6mHx
	EPMuWKVAahMfzolpNmRyGTsvo/D70QTA0XL99F8kqxefBMlT1tGlYSlr5FxywsI5pkIqzwSRPVMH3
	mAs5cESeemgkdCY095oCUWnkra4ZkggKqJ45ZCP1MVPMiP4tlu8jO1uFAMOddrGDr4Kso4gKAtQSs
	cJdQFIwYQLKbmH6M0PPzGmYMCWway7bBnOiA9JJ7jdrfnn0ncyB2rOZo9UJ0k7VZ+sRY7WojIwNKo
	ZxzEj4XEQ5sKYJsf1tiiVVFcGsik2CP4vtkXbghUT6rlcbNJEafnAHruzXc223lRukDXeNqJ4Dwrm
	nG3AdGCx8zqa5E020hFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD3yW-0000000AeE6-0xHQ;
	Fri, 31 May 2024 15:15:24 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD3yT-0000000AeDI-0CPR
	for kexec@lists.infradead.org;
	Fri, 31 May 2024 15:15:22 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2049540E0192;
	Fri, 31 May 2024 15:15:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FSUEfZbijwTn; Fri, 31 May 2024 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717168515; bh=CimpYdG8QQl3X2QgMhhHzMQn8EofMmTYe+oEbL8ZrvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6PLaDRJ86E0OGNAGCUojT3CX1WrSdqZh8RMU8h1+IyOWZ5wR7SbnPUJ9+JopYOFv
	 q6Fp7di+pKi+J6Crq/DKHAQ+2EGmF+N1koju13pL4DfyJYqefqB3sQqgJYx5+HGISW
	 6VTzbQeP6POrjfvVR4P5rrQ4oMqOWFKQMIaeAOFhJuA0/PMPI9HWMMxKWusnekNmCP
	 QoYmcSSfNhePOXGbxoOtwzrcQYoBCx9bspLdrll9T0F+xNAgYMNOVZnjGuqkMGspDP
	 RN/A/cW8YUxtgTdzfkaxdOMYbTI7Uh2v4FI/FEVyho3WEtZMnSoTAzFSg1vHRQ64A7
	 cstm5aWVt74OCKGk5mh9a4lKEnCEVC39eTqTx8O7vMWhhRHSwHkN5CpUvbi/5XWzaY
	 TO9nnirQSbxwiRXDOUP09aArD1c1hXdVDCEGCKIOKLRFL47YJnlcsdICo8O558IfgS
	 BXElZk75qTe+R78bwi/7qQnfjxrvjasBQoFstD5smrSvO1W7O3NNBxNjMWkFAm6JFd
	 aap8w2d0O7pwC1loUtrtasJ1MhDev3vvHWwJsG53Bva9khDOU5UmXgkROfJBQMpaNA
	 8uawK2joAgByCDPLKKjLV+41+FquZPhLac+8bRKLlYLRPDhtPFDm4ptYa0YYyOxThQ
	 eHGxqsqNGnZSsEix9vDbesbc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9041840E01E8;
	Fri, 31 May 2024 15:14:48 +0000 (UTC)
Date: Fri, 31 May 2024 17:14:42 +0200
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
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 11/19] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-12-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240528095522.509667-12-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_081521_252797_38B82C36 
X-CRM114-Status: GOOD (  23.12  )
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

On Tue, May 28, 2024 at 12:55:14PM +0300, Kirill A. Shutemov wrote:
> +static void tdx_kexec_finish(void)
> +{
> +	unsigned long addr, end;
> +	long found = 0, shared;
> +
> +	lockdep_assert_irqs_disabled();
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
> +			set_pte(pte, __pte(0));
> +

Format the below into a comment here:

/* 

The only thing one can do at this point on failure is panic. It is
reasonable to proceed, especially for the crash case because the
kexec-ed kernel is using a different page table so there won't be
a mismatch between shared/private marking of the page so it doesn't
matter.

Also, even if the failure is real and the page cannot be touched as
private, the kdump kernel will boot fine as it uses pre-reserved memory.
What happens next depends on what the dumping process does and there's
a reasonable chance to produce useful dump on crash.

Regardless, the print leaves a trace in the log to give a clue for
debug.

One possible reason for the failure is if kdump raced with memory
conversion. In this case shared bit in page table got set (or not
cleared form shared->private conversion), but the page is actually
private. So this failure is not going to affect the kexec'ed kernel.

*/

<---

> +			if (!tdx_enc_status_changed(addr, pages, true)) {
> +				pr_err("Failed to unshare range %#lx-%#lx\n",
> +				       addr, addr + size);
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
> +}

...

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
> +
> +		ret = __set_memory_enc_pgtable(addr, numpages, enc);
> +
> +		up_read(&mem_enc_lock);
> +	}

So CC_ATTR_MEM_ENCRYPT is set for SEV* guests too. You need to change
that code here to take the lock only on TDX, where you want it, not on
the others.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
