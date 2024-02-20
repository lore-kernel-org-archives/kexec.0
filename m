Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0249C48BC3
	for <kexec@archiver.kernel.org>; Tue, 20 Feb 2024 12:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a7g8EZOiU5pdUFRjyxGrZ6BDgW9ZmaO4tUSLlaxcmFk=; b=gnX7tmqG8VtIEc
	1as8oSDQlSIRyD1h4J1foHZguLs9HiVI/Ky4XNG/sv2iP2lGb5QWlusy4tU4CmVAizoaqFnETn8Lz
	/yPJGMa3RvNNyI217lt1AyZmA0+EtOwojSSqKmy2m5bFD9u8r3P37oByU5qtJGFU/dZOTn+DhSrDj
	YpzFOM19YlwcE2ZCubzylf0m/kFMJ3I+2Ye1UCiiB8SkVQAAZOG1Mx1DpKb/uHlUu2G3J6Ewg9AH2
	0BGkDZiahaEG0ulsl3b5PeBZuAmMqUFNdkz8YQi2YMWAoP7CLYLFseUMIOU7QRw20goOW9v9IN4tg
	8hUtJ8uvDcnKfTC2aOWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcPRy-0000000Ejoj-07Jj;
	Tue, 20 Feb 2024 12:42:18 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcPRu-0000000Ejnk-1jV5
	for kexec@lists.infradead.org;
	Tue, 20 Feb 2024 12:42:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708432935; x=1739968935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WQEMa0Zg8JWL+HJp+aoQ8wXzZKQIdgVqIXMBI4Y1QIA=;
  b=CH2Yxxp9UmlrMSnHTt14q9EoRV4l6sinp69o3irLXzgG4eiqB+qtjb8g
   kMDfS6OgqDQl5x1hLLHMFwbWbvM3Y1ztDherEUPK6RWagtHujxdyEAb+G
   D4ur1XvUhSiRcBskzIZN7GKUzu2izUpe6G+9Q9rbbklRltfGIkXODGnre
   3Gi3pSJ+V6lXpvyhV0LKlSS29Slbib7jaEnCJiO0dxLNTKoy4LMRA9Z1S
   HcEriOQ4kpqy9/wITZN7+agLiAzvNzxGSOBOFGvLCm94Nmb8c9sy+/U/Y
   w4ePTNpdj1puFU9tgMvpDNtAevaZgEcXHmW2AcVLEO2ObyfQMaGE0WhOS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2436853"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2436853"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 04:42:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936448498"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="936448498"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2024 04:42:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 20702305; Tue, 20 Feb 2024 14:42:05 +0200 (EET)
Date: Tue, 20 Feb 2024 14:42:05 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, luto@kernel.org, x86@kernel.org, ardb@kernel.org, hpa@zytor.com, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org, 
	peterz@infradead.org, adrian.hunter@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, elena.reshetova@intel.com, jun.nakajima@intel.com, 
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, seanjc@google.com, kai.huang@intel.com, 
	bhe@redhat.com, kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	anisinha@redhat.com, michael.roth@amd.com, bdas@redhat.com, vkuznets@redhat.com, 
	dionnaglaze@google.com, jroedel@suse.de, ashwin.kamat@broadcom.com
Subject: Re: [PATCH 1/2] x86/mm: Do not zap PMD entry mapping unaccepted
 memory table during kdump.
Message-ID: <ictdanmnsdn4qnzg42ett6om4r6qzypmxdc5spjwa2g5gz2s7p@drh7hoqdj4sc>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <cover.1708390906.git.ashish.kalra@amd.com>
 <a0bf771e1472eb1a6a241acd2e16c98ab8ac9253.1708390906.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a0bf771e1472eb1a6a241acd2e16c98ab8ac9253.1708390906.git.ashish.kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_044214_550917_4D4D9E9D 
X-CRM114-Status: GOOD (  19.97  )
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

On Tue, Feb 20, 2024 at 01:18:29AM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> During crashkernel boot only pre-allocated crash memory is presented as
> E820_TYPE_RAM. This can cause PMD entry mapping unaccepted memory table
> to be zapped during phys_pmd_init() as SNP/TDX guest use E820_TYPE_ACPI
> to store the unaccepted memory table and pass it between the kernels on
> kexec/kdump.
> 
> E820_TYPE_ACPI covers not only ACPI data, but also EFI tables and might
> be required by kernel to function properly.
> 
> The problem was discovered during debugging kdump for SNP guest. The
> unaccepted memory table stored with E820_TYPE_ACPI and passed between
> the kernels on kdump was getting zapped as the PMD entry mapping this
> is above the E820_TYPE_RAM range for the reserved crashkernel memory.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/mm/init_64.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index a0dffaca6d2b..207c6dddde0c 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -524,7 +524,9 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
>  			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
>  					     E820_TYPE_RAM) &&
>  			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
> -					     E820_TYPE_RESERVED_KERN))
> +					     E820_TYPE_RESERVED_KERN) &&
> +			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
> +					     E820_TYPE_ACPI))
>  				set_pmd_init(pmd, __pmd(0), init);
>  			continue;

Why do you single out phys_pmd_init()? I think it has to be addressed for
all page table levels as we do for E820_TYPE_RAM and E820_TYPE_RESERVED_KERN.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
