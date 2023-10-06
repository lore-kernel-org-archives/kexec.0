Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B8DE81E1E
	for <kexec@archiver.kernel.org>; Fri,  6 Oct 2023 18:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3da4fZQp+nufqj0C0WkTJW11S/SO+KARojEdZWHhnbg=; b=w3o3SW9k9eIFHl
	O5WImyvW6GxY0f8u/TwRhZGSpCrEJbsfwK05AwlwDeWpL3ujPvy6qUuGTEcKhuuKwdLdul++Xs/y1
	/0auOv8ebI+JAXsCBBZc0WP+TYuEWYi/2dlSKLlUjx66U4RV7xG31PPtt5RPBLwkpwHxiB/OZatt6
	dPy5BvfypBdEbbj/3wjda/5Tf+Z7il5ztD34XIj/afFNkSrEazVacksENg7nJDTuIXKMDeL4mG7oU
	FbfA3NJ07If3Wpl9h4vnrSVlWDWGNWBkw2q26dQizSSfFHcxWIPnyOYQKff4Tj//iO9u5iCzkh0lC
	UiNfAWLrStXK02P+rjkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qope2-006K5r-1W;
	Fri, 06 Oct 2023 18:33:50 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qope0-006K5H-1d
	for kexec@lists.infradead.org;
	Fri, 06 Oct 2023 18:33:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696617228; x=1728153228;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LLZX7zRwrS6v1TQS+z2JHoWVTzAPsFpDcoMbYNf7c0Y=;
  b=Lan3nlUkP4VT0Cz1joHAyqKwbjTQCOTe3gdKfWnh5pF1yvPCXt/kC9Zp
   Mqil6wOlTndqAMAGPk+P/h+GorYFMA0J8kjL3b2SDNntBiV9CRKoUhp+V
   io88TYzZeWEJPE1je2mz7bCvuyqgELSQF7snSa87zicFcndV0+ZpntW5p
   zGpTry2r1boRRV4bS/UVpqCwvZMXNbHYrQgnzLO1Wyo3pATk4/s7USF8p
   CpPsV9nfPrePUk+P061bBJFdhANGfKzREbpxdjbRYZ9akV0+wYTm5x7hq
   vr534ursMnfGOO0vS3YiElD/xLPVo4Te9SDODYAo4dRfLrqFaqeaiX5KN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="387688608"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="387688608"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 11:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="745950981"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="745950981"
Received: from wangz2-mobl.amr.corp.intel.com (HELO [10.209.88.26]) ([10.209.88.26])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 11:33:46 -0700
Message-ID: <2be8a356-79c8-49a0-ba93-2a92df119af3@linux.intel.com>
Date: Fri, 6 Oct 2023 11:33:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-2-kirill.shutemov@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231005131402.14611-2-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231006_113348_612040_517CEB68 
X-CRM114-Status: GOOD (  16.99  )
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

Hi Kirill,

On 10/5/2023 6:13 AM, Kirill A. Shutemov wrote:
> In order to prepare for the expansion of support for the ACPI MADT
> wakeup method, the relevant code has been moved into a separate file.
> A new configuration option has been introduced to clearly indicate
> dependencies without the use of ifdefs.
> 
> There have been no functional changes.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/Kconfig                   |  7 +++
>  arch/x86/include/asm/acpi.h        |  5 ++
>  arch/x86/kernel/acpi/Makefile      | 11 ++--
>  arch/x86/kernel/acpi/boot.c        | 86 +-----------------------------
>  arch/x86/kernel/acpi/madt_wakeup.c | 80 +++++++++++++++++++++++++++
>  5 files changed, 99 insertions(+), 90 deletions(-)
>  create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 3154dbc49cf5..7368d254d01f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1108,6 +1108,13 @@ config X86_LOCAL_APIC
>  	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
>  	select IRQ_DOMAIN_HIERARCHY
>  
> +config X86_ACPI_MADT_WAKEUP
> +	def_bool y
> +	depends on X86_64
> +	depends on ACPI
> +	depends on SMP
> +	depends on X86_LOCAL_APIC
> +
>  config X86_IO_APIC
>  	def_bool y
>  	depends on X86_LOCAL_APIC || X86_UP_IOAPIC
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index c8a7fc23f63c..b536b5a6a57b 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -73,6 +73,11 @@ static inline bool acpi_skip_set_wakeup_address(void)
>  
>  #define acpi_skip_set_wakeup_address acpi_skip_set_wakeup_address
>  
> +union acpi_subtable_headers;
> +
> +int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> +			      const unsigned long end);
> +

IMO, you don't need to declare acpi_parse_mp_wake() in asm/acpi.h. Since the
only user of this function is in arch/x86/kernel/acpi, you can either create
a header file there or re-use sleep.h.

If you want to leave it here, do you want to protect it with
CONFIG_X86_ACPI_MADT_WAKEUP?


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
