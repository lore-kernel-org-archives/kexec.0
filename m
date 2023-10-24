Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A679C25B48
	for <kexec@archiver.kernel.org>; Tue, 24 Oct 2023 12:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EE8ECXgbtK/o3r3EvSl7tBqHoA6uKtCv8/12MenjZzs=; b=2Gcx4H+vfs2fuF
	F8nnmGkMT2lACmPMogSxwsdgHzEKIILnRZzCNsb7JAuRds2MV1LB0DY7HQXEsmIn4kzdtLJU6RUQh
	BLxKq6LhBXDQXZe2Rg/WWCB9S78FYztr33Vq91VSSaiygzyHTwq0p8c0DNbxZANs3M/vh1SxQZltE
	h8l1c3ZmKeWd2I6yBF6AxoE1goIyvZHc3fsxHZWc0g5XLzg+38pDeoHFMCBvLMMjDjvALBny4qzU0
	hILzdZztmsJQmhpyHrZ5Sp9QCwUigW0W4EgwyUmbBSHXv5nuQzYXY7cTdnMS5eHdJbUQcPFAPIbyc
	uPCogAgW7oypKudrGmMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvGo2-009msk-0G;
	Tue, 24 Oct 2023 12:46:46 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvGnz-009mru-33
	for kexec@lists.infradead.org;
	Tue, 24 Oct 2023 12:46:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698151603; x=1729687603;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wgfr8w1cbLPQHYG5iVU1irgIBoi2fm60vn3H7o4w7c8=;
  b=UI8piLALP1T0cmGCJU8yhiTYS3B+9FIh3Bw244aa6SjX+zwBNhq3JjOV
   DTYPlkhFuP9pjPLoFxW1eVFUtgoouoP4EFuSIxGovLc2v/SzVgFnv6fFW
   2gxXlreBOPI5wcIgPYNf36ECACRzCleBNE7HUoOPontOQA3MCpINgu78f
   LrO6YueDSOLq79gX4qivFV/yZndSfHxpZC2Rqw7PkVNZmtKKnIHALo3Jt
   iprWsIcz4445hgV9eG6EirYRn7NDjSWN/vcfMg/+Sbta+Ylk/fCebDSSK
   ppwixKnDg0q36s47RoOp+VJOT02eU/X4atKPypVnjTZktiI5Wwg25LnA4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="453506415"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="453506415"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6438628"
Received: from marynguy-mobl1.amr.corp.intel.com (HELO [10.209.14.133]) ([10.209.14.133])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:46:34 -0700
Message-ID: <af33711f-9240-429f-92ba-b0e67c572839@linux.intel.com>
Date: Tue, 24 Oct 2023 05:46:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 12/13] x86/acpi: Rename fields in
 acpi_madt_multiproc_wakeup structure
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
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-13-kirill.shutemov@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231020151242.1814-13-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_054644_047154_958CACE3 
X-CRM114-Status: GOOD (  16.81  )
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



On 10/20/2023 8:12 AM, Kirill A. Shutemov wrote:
> To prepare for the addition of support for MADT wakeup structure version
> 1, it is necessary to provide more appropriate names for the fields in
> the structure.
> 
> The field 'mailbox_version' renamed as 'version'. This field signifies
> the version of the structure and the related protocols, rather than the
> version of the mailbox. This field has not been utilized in the code
> thus far.
> 
> The field 'base_address' renamed as 'mailbox_address' to clarify the
> kind of address it represents. In version 1, the structure includes the
> reset vector address. Clear and distinct naming helps to prevent any
> confusion.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/kernel/acpi/madt_wakeup.c | 4 ++--
>  include/acpi/actbl2.h              | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index 9bbe829737e7..ad170def2367 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -79,7 +79,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  
>  	acpi_table_print_madt_entry(&header->common);
>  
> -	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
> +	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
>  
>  	cpu_hotplug_disable_offlining();
>  
> @@ -98,7 +98,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  	 *
>  	 * This is Linux-specific protocol and not reflected in ACPI spec.
>  	 */
> -	mp_wake->base_address = 0;
> +	mp_wake->mailbox_address = 0;
>  
>  	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
>  
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 3751ae69432f..23b4cfb640fc 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -1109,9 +1109,9 @@ struct acpi_madt_generic_translator {
>  
>  struct acpi_madt_multiproc_wakeup {
>  	struct acpi_subtable_header header;
> -	u16 mailbox_version;
> +	u16 version;
>  	u32 reserved;		/* reserved - must be zero */
> -	u64 base_address;
> +	u64 mailbox_address;
>  };
>  
>  #define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE        2032

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
