Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8FEC67861
	for <kexec@archiver.kernel.org>; Fri,  5 Apr 2024 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8qd0uOmjEhUEPAappx5GIN/Bwa4Kscuwy0Zc3jZGeys=; b=AK2dlzjHKB1GTy
	k/gsnR+ep182gbCOFGj2GD4cHeIJHIxXEj2V2OHgAN3O2iyZFS/eXn9ft+Onh8ihxMOdwwYQTkri2
	Y6ZJR/kuKprcviWROyqgF3jaOsK/AkUIoGjYHaaK0MVU3160jWox8fUzhB11frfJdlmqqh+UG/Fvp
	atIPyqasRB+3bJCJASyjzeFof2QIoia7e12TMg/s0/WYFnNjXPU2Mih+fbWFOw6SLw7jopd1uKUnm
	r1hwHCiCzpo4wclT7yTB7QKi6uFnj9zEU2pY26+j5UXG+0kDscq/uNWFzS3slZa+kngHg2QCtNGZg
	Af8VdMsk99oEe0T5qmtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsmxc-000000087oR-0yQX;
	Fri, 05 Apr 2024 17:02:40 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsmxY-000000087mo-0Urz
	for kexec@lists.infradead.org;
	Fri, 05 Apr 2024 17:02:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712336556; x=1743872556;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MOYV1921efHrJ07Pg46Tj17i+5Tr+D9vo4vTZzq2bUc=;
  b=XKBrZe46IMyQAznfG7dNPgSPSCX44eZinbIySRAlBuEzcSAgl89E8skO
   ldHKPOU74pN/qNkwbgPzEg7M90fVT9F2J5Ox1vM3XnuAA1SivdmwCpdJm
   DFD/mEa67RQQyQa/tw2xGPrjOfdcsMNkq1jtnh6p0oGWwRd5X4kkep9b0
   xOaOhYFPsV+tuVx4UJWOl78qYHqm4+SPyDYHBJSSrIFJMnc8rYsSPU+xS
   r017n1dvMlpaJifoVmXGkXd+QkEQikwmt8R2VEtJ08JIINzhUctQgdqxF
   BmrFUqUwR8EyMqVzwF/iCKNpGweCfXcvPBMi9PgpYi0Bgxwbif6aJK/aS
   A==;
X-CSE-ConnectionGUID: IrRPlFeLQTaL9OHo/te7wg==
X-CSE-MsgGUID: t7xLr75/TWyngcY95mUcvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="33075380"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="33075380"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:02:34 -0700
X-CSE-ConnectionGUID: ue9lL3lvQfORewbsYQn0Iw==
X-CSE-MsgGUID: mxkQdWVLS7uJsFH/c2LUZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23941152"
Received: from twwright-mobl1.amr.corp.intel.com (HELO [10.209.65.212]) ([10.209.65.212])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:02:32 -0700
Message-ID: <c6e8a19b-e6a6-4fa0-81dc-d8747ba648c0@linux.intel.com>
Date: Fri, 5 Apr 2024 10:02:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc: rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <cover.1712270975.git.ashish.kalra@amd.com>
 <7ca8179d7671a149f2808d8d081b6e736eea4394.1712270976.git.ashish.kalra@amd.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <7ca8179d7671a149f2808d8d081b6e736eea4394.1712270976.git.ashish.kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_100236_244790_CB0C22EC 
X-CRM114-Status: GOOD (  20.06  )
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


On 4/4/24 4:11 PM, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> For kexec use case, need to use and stick to the EFI memmap passed
> from the first kernel via boot-params/setup data, hence,
> skip efi_arch_mem_reserve() during kexec.
>
> Additionally during SNP guest kexec testing discovered that EFI memmap
> is corrupted during chained kexec. kexec_enter_virtual_mode() during
> late init will remap the efi_memmap physical pages allocated in
> efi_arch_mem_reserve() via memblock & then subsequently cause random
> EFI memmap corruption once memblock is freed/teared-down.
>
> Suggested-by: Dave Young <dyoung@redhat.com>
> [Dave Young: checking the md attribute instead of checking the efi_setup]
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/platform/efi/quirks.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index f0cc00032751..2b65b3863912 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -255,15 +255,32 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>  	struct efi_memory_map_data data = { 0 };
>  	struct efi_mem_range mr;
>  	efi_memory_desc_t md;
> -	int num_entries;
> +	int num_entries, ret;
>  	void *new;
>  
> -	if (efi_mem_desc_lookup(addr, &md) ||
> -	    md.type != EFI_BOOT_SERVICES_DATA) {
> +	/*
> +	 * For kexec use case, we need to use the EFI memmap passed from the first
> +	 * kernel via setup data, so we need to skip this.
> +	 * Additionally kexec_enter_virtual_mode() during late init will remap
> +	 * the efi_memmap physical pages allocated here via memboot & then
> +	 * subsequently cause random EFI memmap corruption once memblock is freed.
> +	 */
> +
> +	ret = efi_mem_desc_lookup(addr, &md);

Since you are not using ret, why not directly use if (efi_mem_desc_lookup(..))?

> +	if (ret) {
>  		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
>  		return;
>  	}
>  
> +	if (md.type != EFI_BOOT_SERVICES_DATA) {
> +		pr_err("Skip reserving non EFI Boot Service Data memory for %pa\n", &addr);
> +		return;
> +	}
> +
> +	/* Kexec copied the efi memmap from the first kernel, thus skip the case */
> +	if (md.attribute & EFI_MEMORY_RUNTIME)
> +		return;
> +
>  	if (addr + size > md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT)) {
>  		pr_err("Region spans EFI memory descriptors, %pa\n", &addr);
>  		return;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
