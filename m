Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E689C36010
	for <kexec@archiver.kernel.org>; Fri,  4 Apr 2025 20:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UwmZQcYi1EXxCwhNIY+HYLc1u5vQgnMlKARAIkaxeao=; b=c2p27qlq9JRn7ucsVir9QloTdL
	Br/LKoPHeEyOXEu5DvDI7J3K0DA2t17yjqocRep67n1wg7EPRA7PVTOv6QSJkC4rYNilObEcrDxhF
	vWCJx4uQ4RF7nWOadL5IvA+iJgqL6xeIy5VBMfcnEhjKpJ/P/KhGD09saphUNXcKMFMguOLebDZj1
	cZvtA1GXlP+g97VCn297n1Nb3r6WmW5dlEzE3DQRAV+upHKQObfqCKfdVW95++/XLmCk54pZmLeMF
	tnvZRNKi5g1ZPeKoHqp3ZtEYpZWAYG4BYwDjdqWLmVK2dKkfmFx+wy4/VtwnVLl8XFFAHCjElwK+A
	+4aVIT0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0nox-0000000CoEZ-22cd;
	Fri, 04 Apr 2025 20:39:23 +0000
Received: from out-186.mta1.migadu.com ([2001:41d0:203:375::ba])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0nor-0000000CoE9-2Dfp
	for kexec@lists.infradead.org;
	Fri, 04 Apr 2025 20:39:19 +0000
Date: Fri, 4 Apr 2025 22:39:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1743799154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UwmZQcYi1EXxCwhNIY+HYLc1u5vQgnMlKARAIkaxeao=;
	b=JHzHGY91ox3IAo0IRB+jqoMBGsT6uZCdh1MIkzseecBUO+zjOOjgj3XnVNPTa0P6HfMVBs
	JVWGYnjNMviqmPTnPS9aQsB/8ViM+GaJCk6ZHq034qylvN2VvRPmFh9IN8PLD2rh6rBptK
	d/lqxJzBsILZrY6D2kIv0yromlwIfA4Q5IsdRJTBAG812xqRbnCyV+xpKxUC5neQelP7uM
	kYdAESpN7V1tq1TG0pNFtzsOICDFIyYoQts9factYnBi9AoEla2g2v5d4luFuSdyapo3Dp
	xQE0wczRGHyGPb1vhybRrx9Gog9fDIr5QkpjiOjoiQhJ4QwghaTGPrQunFeHgA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: msizanoen <msizanoen@qtmlabs.xyz>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z_BDbwmFV6wxDPV1@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z4WGSMdF6seQm9GV@desktop0a>
 <b9f6ed5a-74b9-47c0-b073-9922dbe6119b@qtmlabs.xyz>
 <Z-8E-LLs1dFWfn6J@desktop0a>
 <691be719-7d4c-4cb1-87d6-cca7834547fe@qtmlabs.xyz>
 <004d85e4-d23d-43af-87ca-8d037abba51d@qtmlabs.xyz>
 <4081fbd9-0a5f-49d6-9553-4f964bf5ef27@qtmlabs.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4081fbd9-0a5f-49d6-9553-4f964bf5ef27@qtmlabs.xyz>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_133917_931531_30BE65F2 
X-CRM114-Status: GOOD (  17.44  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2025-04-04 12:50 +0700, msizanoen wrote:
> Here's an updated version of the patch that better handles pathological e820
> tables.
> 
> On 4/4/25 11:56, msizanoen wrote:
> > Also, can you reproduce this issue with a target kernel (the kernel
> > being kexec-ed) that has one of the patches attached (select the correct
> > one according to your kernel version) applied, with either kexec_load or
> > kexec_file_load?
> > [snip]
>
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 4893d30ce438..5d963df63b7a 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -754,22 +754,21 @@ void __init e820__memory_setup_extended(u64 phys_addr, u32 data_len)
>  void __init e820__register_nosave_regions(unsigned long limit_pfn)
>  {
>  	int i;
> -	unsigned long pfn = 0;
> +	u64 last_addr = 0;
>  
>  	for (i = 0; i < e820_table->nr_entries; i++) {
>  		struct e820_entry *entry = &e820_table->entries[i];
>  
> -		if (pfn < PFN_UP(entry->addr))
> -			register_nosave_region(pfn, PFN_UP(entry->addr));
> -
> -		pfn = PFN_DOWN(entry->addr + entry->size);
> -
>  		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> -			register_nosave_region(PFN_UP(entry->addr), pfn);
> +			continue;
>  
> -		if (pfn >= limit_pfn)
> -			break;
> +		if (last_addr < entry->addr)
> +			register_nosave_region(PFN_UP(last_addr), PFN_DOWN(entry->addr));
> +
> +		last_addr = entry->addr + entry->size;
>  	}
> +
> +	register_nosave_region(PFN_UP(last_addr), limit_pfn);
>  }

Your patch applied to v6.14 fixes the issue with kexec_file_load, but
kexec_load keeps not working.

>  #ifdef CONFIG_ACPI
>
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 57120f0749cc..656ed7abd28d 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -753,22 +753,21 @@ void __init e820__memory_setup_extended(u64 phys_addr, u32 data_len)
>  void __init e820__register_nosave_regions(unsigned long limit_pfn)
>  {
>  	int i;
> -	unsigned long pfn = 0;
> +	u64 last_addr = 0;
>  
>  	for (i = 0; i < e820_table->nr_entries; i++) {
>  		struct e820_entry *entry = &e820_table->entries[i];
>  
> -		if (pfn < PFN_UP(entry->addr))
> -			register_nosave_region(pfn, PFN_UP(entry->addr));
> -
> -		pfn = PFN_DOWN(entry->addr + entry->size);
> -
>  		if (entry->type != E820_TYPE_RAM)
> -			register_nosave_region(PFN_UP(entry->addr), pfn);
> +			continue;
>  
> -		if (pfn >= limit_pfn)
> -			break;
> +		if (last_addr < entry->addr)
> +			register_nosave_region(PFN_UP(last_addr), PFN_DOWN(entry->addr));
> +
> +		last_addr = entry->addr + entry->size;
>  	}
> +
> +	register_nosave_region(PFN_UP(last_addr), limit_pfn);
>  }
>  
>  #ifdef CONFIG_ACPI

On master, kexec_file_load already worked due to the patch series you
mentioned in earlier emails. The kexec_load issue isn't affected by your
patch.

