Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58710CD1284
	for <kexec@archiver.kernel.org>; Fri,  5 Apr 2024 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GN6Pz277HTQsz0ZhUq1Lp0Id5v1fOMh6lXC2z4ZBPek=; b=QMjfqh+27v9Od0
	oqdNly1t3hWflgNSYR17CUX7F/Z8vphNS4wyu6QjTZ3RbQuO+49b8VAMgsCbQZMZ/GdXuQbNT51Fm
	qcmlGn2kvWLqsJr+pUh6arOPu54Voi1Hecu4+OllBAgQyaGu7o9y6lkYMEqP6r9HI9Ynln/AVu7Ju
	vztJN5AfVrpISeycJgxDfgNIPAqH+RqaDnTP92E8BKGjxKJa/wZt9zUQc53QUACAlM6CijCzOlLIO
	7PWqnmiWe1EpYU1NwDO5jhC4hcCjNXFT28IOpZnuYi7veGp6XcD1E2ZfibRGknjnhMt6iPkdyf4tB
	JPmWujycPT3NVA9tRXIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsn0N-000000088Sq-2c0X;
	Fri, 05 Apr 2024 17:05:31 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsn0K-000000088R3-0VQ6
	for kexec@lists.infradead.org;
	Fri, 05 Apr 2024 17:05:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712336728; x=1743872728;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/AEsABMgIL9oKeChIdc/eQy55s/yNzx6q1zHRQyyKiI=;
  b=EmFMazvqNqSlqOF3rRZ5wQAXTokQrJyjU8/8Qp5HlJhhyPQ4htV/mkvV
   d2VBWU21UVCV2q9xX4nbuIs2Mt5O41A0TxfveKwgWQT4z6Ce12meOzocV
   F4sCIszhstv1ZPMySshm1j0pL34k7ew+2d+SALbsjhk2ZJiKdX7+ixMi/
   llL3l/sTgHHCkNzqKOw8KBb7BmKhDx4jyVxWDpDtsGTAk86ZAt7OmZvSQ
   E1bIZ/L0nd/nUCFZzcEOZPqCQuRzeECs9BHRBWK+Ienc6bQgfvEMz8Voz
   x9x5VyBQp26UbSKU7voQEtBoEvewoAQE0PZIJpitGVamW1KG/oWFlhLbI
   g==;
X-CSE-ConnectionGUID: JQoyNZzWQYCNsvU+EaU5jQ==
X-CSE-MsgGUID: 20dDQxeqRNGHcifVJ3n1rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18284827"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18284827"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:05:26 -0700
X-CSE-ConnectionGUID: +MFNCUHzRv2kuSn9OWymFg==
X-CSE-MsgGUID: prsXshp8Tu6fZbMcXuf3OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19659692"
Received: from twwright-mobl1.amr.corp.intel.com (HELO [10.209.65.212]) ([10.209.65.212])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:05:25 -0700
Message-ID: <7cd4b4d5-a7b4-41d9-8bd3-ad41401fec61@linux.intel.com>
Date: Fri, 5 Apr 2024 10:05:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] x86/boot/compressed: Skip Video Memory access in
 Decompressor for SEV-ES/SNP.
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
 <1027427fafa350a41234f5061c8c48fc77c58326.1712270976.git.ashish.kalra@amd.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <1027427fafa350a41234f5061c8c48fc77c58326.1712270976.git.ashish.kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_100528_246606_B79CEAA6 
X-CRM114-Status: GOOD (  16.52  )
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
> Accessing guest video memory/RAM during kernel decompressor
> causes guest termination as boot stage2 #VC handler for
> SEV-ES/SNP systems does not support MMIO handling.
>
> This issue is observed with SEV-ES/SNP guest kexec as
> kexec -c adds screen_info to the boot parameters
> passed to the kexec kernel, which causes console output to
> be dumped to both video and serial.
>
> As the decompressor output gets cleared really fast, it is
> preferable to get the console output only on serial, hence,
> skip accessing video RAM during decompressor stage to
> prevent guest termination.
>
> Serial console output during decompressor stage works as
> boot stage2 #VC handler already supports handling port I/O.
>
> Suggested-by: Thomas Lendacy <thomas.lendacky@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/boot/compressed/misc.c | 6 ++++--
>  arch/x86/boot/compressed/misc.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index b70e4a21c15f..47b4db200e1f 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -427,8 +427,10 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
>  		vidport = 0x3d4;
>  	}
>  
> -	lines = boot_params_ptr->screen_info.orig_video_lines;
> -	cols = boot_params_ptr->screen_info.orig_video_cols;
> +	if (!sev_es_enabled()) {
> +		lines = boot_params_ptr->screen_info.orig_video_lines;
> +		cols = boot_params_ptr->screen_info.orig_video_cols;
> +	}
>  
>  	init_default_io_ops();
>  
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index b353a7be380c..3c12ca987554 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -37,6 +37,7 @@
>  #include <asm/desc_defs.h>
>  
>  #include "tdx.h"
> +#include "sev.h"
>  
>  #define BOOT_CTYPE_H
>  #include <linux/acpi.h>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
