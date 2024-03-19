Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05444C54E5D
	for <kexec@archiver.kernel.org>; Tue, 19 Mar 2024 04:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BSHI5p68w3cN7zracLFXvIGLVl/Qrd+l6d+gYBx+w/U=; b=kd9qw/1souLhSY
	PCkxVfFncVq/FwmGSUfXy+SyxJt/NMbMQFThN6K5+Nk5vKo1kYLx5TinTjH5a+8AkbM+PoN4KbVIS
	2FgfPEPn9E1mhu/wdr7KcdzlO4m2VjjKiAM+VEZ3C4KJlIy86FzOiQL4iV1rM725d9nh2A6DcA6rq
	tUSXN5nEeGahMx0NRoxp265hYjczSQh3OZvHtvXZgAVdS+Dvz2MbMdCfhku2DblEfqIRsJ2b0arUB
	ST9umIAgejj7itLTPnrmzTf8H8gGEiaHKV1Q2HOt32/iXs4yAEh3cV7tKzbohYSBAn9dSQlkNyito
	AUa8f4r6DHFFViYLiK7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmQed-0000000B9FZ-2ML5;
	Tue, 19 Mar 2024 04:00:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmQeZ-0000000B9EL-33md
	for kexec@lists.infradead.org;
	Tue, 19 Mar 2024 04:00:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710820837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VCuT+KF0CFKXEteYACtgcd0bLY6/wFRR3VLA/HmQm5k=;
	b=H/Iq2sOno03ItU/MY09PkqkLCyPzynjl5AGLiJlmODmxxkGlTC1b/ebROjc+sQA9Ag0fNb
	xcd/lZmUann4TSUtFz5RTtFCiXunqV52HUji8QzfSynLi7JrEhu7dw9GxX8X5IPplBn57M
	76f4noz2E3sjVXM7/EG9qm8+82Kfpa8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-uhYCHd1lOYC1LAIgkUewmA-1; Tue, 19 Mar 2024 00:00:30 -0400
X-MC-Unique: uhYCHd1lOYC1LAIgkUewmA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 565D3852002;
	Tue, 19 Mar 2024 04:00:28 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.116.87])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 859973C20;
	Tue, 19 Mar 2024 04:00:16 +0000 (UTC)
Date: Tue, 19 Mar 2024 12:00:15 +0800
From: Dave Young <dyoung@redhat.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	elena.reshetova@intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	seanjc@google.com, michael.roth@amd.com, kai.huang@intel.com,
	bhe@redhat.com, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Message-ID: <ZfkNzyGl4J1ZxaGj@darkstar.users.ipa.redhat.com>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <cover.1710744412.git.ashish.kalra@amd.com>
 <7c2e6ae663da2e5eb41527f0d854f59a56b91ecd.1710744412.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7c2e6ae663da2e5eb41527f0d854f59a56b91ecd.1710744412.git.ashish.kalra@amd.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_210044_640958_4DF03A05 
X-CRM114-Status: GOOD (  22.71  )
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

Hi,

Added Ard in cc.

On 03/18/24 at 07:02am, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> For kexec use case, need to use and stick to the EFI memmap passed
> from the first kernel via boot-params/setup data, hence,
> skip efi_arch_mem_reserve() during kexec.
> 
> Additionally during SNP guest kexec testing discovered that EFI memmap
> is corrupted during chained kexec. kexec_enter_virtual_mode() during
> late init will remap the efi_memmap physical pages allocated in
> efi_arch_mem_reserve() via memboot & then subsequently cause random
> EFI memmap corruption once memblock is freed/teared-down.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/platform/efi/quirks.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index f0cc00032751..d4562d074371 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -258,6 +258,16 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>  	int num_entries;
>  	void *new;
>  
> +	/*
> +	 * For kexec use case, we need to use the EFI memmap passed from the first
> +	 * kernel via setup data, so we need to skip this.
> +	 * Additionally kexec_enter_virtual_mode() during late init will remap
> +	 * the efi_memmap physical pages allocated here via memboot & then
> +	 * subsequently cause random EFI memmap corruption once memblock is freed.

Can you elaborate a bit about the corruption, is it reproducible without
SNP?

> +	 */
> +	if (efi_setup)
> +		return;
> +

How about checking the md attribute instead of checking the efi_setup,
personally I feel it a bit better, something like below:

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..699332b075bb 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -255,15 +255,24 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	struct efi_memory_map_data data = { 0 };
 	struct efi_mem_range mr;
 	efi_memory_desc_t md;
-	int num_entries;
+	int num_entries, ret;
 	void *new;
 
-	if (efi_mem_desc_lookup(addr, &md) ||
-	    md.type != EFI_BOOT_SERVICES_DATA) {
+	ret = efi_mem_desc_lookup(addr, &md);
+	if (ret) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
 		return;
 	}
 
+	if (md.type != EFI_BOOT_SERVICES_DATA) {
+		pr_err("Skil reserving non EFI Boot Service Data memory for %pa\n", &addr);
+		return;
+	}
+
+	/* Kexec copied the efi memmap from the 1st kernel, thus skip the case. */
+	if (md.attribute & EFI_MEMORY_RUNTIME)
+		return;
+
 	if (addr + size > md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT)) {
 		pr_err("Region spans EFI memory descriptors, %pa\n", &addr);
 		return;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
