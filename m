Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB25AC30658
	for <kexec@archiver.kernel.org>; Fri,  5 Jul 2024 14:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B+f2TwKswKb+LCo2Z9BSp74yLK2273A58/+f6cm6Aus=; b=KLdYFdmICpRsRL
	+UDELQpLtnFR8znId8NpIQ7gSaPFvcn0I5MgZt4yWxtRx2xKrX+/Mn+1UQsgYRef+0jqJ7J7Ntqba
	v0Up9uc1vrSaDtW+mC6tsBgu3gcwIROEQuthTy0iojHSwiMQUMEg+qpTLxNXl9+OtbXikhmwNC6WW
	fJr71eTalieTvdByoKZLnLe3qPoJa2qhWH98hOI+6i4182l8/BVNjeKPaCGFy9cRk/2NdohlVS+nR
	qsEuBd/qyc/9M00gMkkdbvMB4i97XIsTWdJ+TVV9Ss6wwj+qRZGuGewpbpyRNUGoAqi33FUAYlkjG
	wVFG1w9VxpJ6fwDwFRjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPjvy-0000000GCq5-1jBz;
	Fri, 05 Jul 2024 14:29:10 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPjvv-0000000GCo1-2LVn
	for kexec@lists.infradead.org;
	Fri, 05 Jul 2024 14:29:09 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 779D340E0177;
	Fri,  5 Jul 2024 14:29:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6cKDbcrtIBvA; Fri,  5 Jul 2024 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720189742; bh=YF0KsnKaZaCiX1t5IcuNZnzLBHM/kNxnGffyLGgs1r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZhyOtPHKvgy3VbdAWfjYEx2AfjjYC69QlPTFKTDF3FH8CN7yV3MbvNsXmd7jUP9D
	 550wAb8nDVjI0kXZosh0axvpbIlBEeZffI1SjrsFrLb5Hrg0a1AwgJ+03RSXwgHI7d
	 PUx1bBE2YPtea8lvxQPuIOaRPAvGc+uabkNU5XFegE0Zk48WWJB4J/PHql7iVv2oTr
	 IoQM7VppJgwq/awiaKJJQe0QWSlKp4kNABrnJKFqo/qWdcHZmVqXWPL55MjaT4RqP9
	 LJf/VHbiDByLyy6w3oBF/vxmJQwyeSIu0abTnBFecBY6/Pii/fvHsPG75HnT5g+xai
	 QiGBodj7mznM7d/tuYuikzzoK0bCyGpK3lEwre3yLllrdr7IzEa1Tv96U6eWfZ+ZkW
	 y3b81G0FH3RiK5cw7w5KVz1aFJdkKNFdU6amOFD8V7yws2IV2dnrMjOVqODPMYB6D7
	 0BrPR9TEp50P3p0ZKieZDuLj2vcaMNLqXZlTdW1vrdHEeq7GGsF3kTY5iu+HwKGvMC
	 Ak4EXpRK77+ayR86BzN9r7Mo8DYyCQmgCE9TeVVrMFWuk7vaVajZD9HArxzrpfJ2k3
	 wiHLpDch8bUNtG1ltpqwn95dF9twYXvQGL+PRfa/VDRPYgDHD2jLR3TDSYTEcMYI8Q
	 pLwa3XXkIjafcMq3f4kd7+1s=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3311040E0187;
	Fri,  5 Jul 2024 14:28:34 +0000 (UTC)
Date: Fri, 5 Jul 2024 16:28:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	kirill.shutemov@linux.intel.com, rick.p.edgecombe@intel.com,
	linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, bdas@redhat.com, vkuznets@redhat.com,
	dionnaglaze@google.com, anisinha@redhat.com, ardb@kernel.org,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, jroedel@suse.de
Subject: Re: [PATCH v11 3/3] x86/snp: Convert shared memory back to private
 on kexec
Message-ID: <20240705142833.GBZogDEZ1kk5bbDp7C@fat_crate.local>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1719948376.git.ashish.kalra@amd.com>
 <ee7d5134e67964bb5c602b5c5d69f5a1decf4597.1719948376.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ee7d5134e67964bb5c602b5c5d69f5a1decf4597.1719948376.git.ashish.kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240705_072907_815401_93BDEF67 
X-CRM114-Status: GOOD (  15.17  )
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

On Tue, Jul 02, 2024 at 07:58:11PM +0000, Ashish Kalra wrote:
> +static void unshare_all_bss_decrypted_memory(void)
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

Merge the whole unsharing dance into a single function:

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 5013c3afb0c4..f263ceada006 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1049,58 +1049,47 @@ static bool make_pte_private(pte_t *pte, unsigned long addr, int pages, int leve
 	return true;
 }
 
-static void unshare_all_bss_decrypted_memory(void)
-{
-	unsigned long vaddr, vaddr_end;
-	unsigned int level;
-	unsigned int npages;
-	pte_t *pte;
-
-	vaddr = (unsigned long)__start_bss_decrypted;
-	vaddr_end = (unsigned long)__start_bss_decrypted_unused;
-	npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
-	for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
-		pte = lookup_address(vaddr, &level);
-		if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
-			continue;
-
-		set_pte_enc(pte, level, (void *)vaddr);
-	}
-	vaddr = (unsigned long)__start_bss_decrypted;
-	snp_set_memory_private(vaddr, npages);
-}
-
+/* Walk the direct mapping and convert all shared memory back to private. */
 static void unshare_all_memory(void)
 {
-	unsigned long addr, end;
-
-	/*
-	 * Walk direct mapping and convert all shared memory back to private.
-	 */
+	unsigned long addr, end, size;
+	unsigned int npages, level;
+	pte_t *pte;
 
+	/* Unshare the direct mapping. */
 	addr = PAGE_OFFSET;
 	end  = PAGE_OFFSET + get_max_mapped();
 
 	while (addr < end) {
-		unsigned long size;
-		unsigned int level;
-		pte_t *pte;
-
 		pte = lookup_address(addr, &level);
 		size = page_level_size(level);
 
-		if (pte && pte_decrypted(*pte) && !pte_none(*pte)) {
-			int pages = size / PAGE_SIZE;
-
-			if (!make_pte_private(pte, addr, pages, level)) {
-				pr_err("Failed to unshare range %#lx-%#lx\n",
-				       addr, addr + size);
-			}
+		if (!pte || !pte_decrypted(*pte) || pte_none(*pte)) {
+			addr += size;
+			continue;
 		}
-		addr += size;
+
+		npages = size / PAGE_SIZE;
+
+		if (!make_pte_private(pte, addr, npages, level))
+			pr_err("Failed to unshare range %#lx-%#lx\n",
+				addr, addr + size);
 	}
 
-	unshare_all_bss_decrypted_memory();
+	/* Unshare all bss decrypted memory. */
+	addr = (unsigned long)__start_bss_decrypted;
+	end  = (unsigned long)__start_bss_decrypted_unused;
+	npages = (end - addr) >> PAGE_SHIFT;
+
+	for (; addr < end; addr += PAGE_SIZE) {
+		pte = lookup_address(addr, &level);
+		if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
+			continue;
+
+		set_pte_enc(pte, level, (void *)addr);
+	}
+	addr = (unsigned long)__start_bss_decrypted;
+	snp_set_memory_private(addr, npages);
 
 	__flush_tlb_all();
 
@@ -1114,8 +1103,9 @@ void snp_kexec_begin(void)
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
+
 	/*
-	 * Crash kernel reaches here with interrupts disabled: can't wait for
+	 * Crash kernel ends up here with interrupts disabled: can't wait for
 	 * conversions to finish.
 	 *
 	 * If race happened, just report and proceed.
@@ -1124,7 +1114,6 @@ void snp_kexec_begin(void)
 		pr_warn("Failed to stop shared<->private conversions\n");
 }
 
-/* Walk direct mapping and convert all shared memory back to private */
 void snp_kexec_finish(void)
 {
 	struct sev_es_runtime_data *data;


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
