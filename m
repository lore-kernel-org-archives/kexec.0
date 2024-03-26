Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A8CC6FD1F
	for <kexec@archiver.kernel.org>; Tue, 26 Mar 2024 17:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vIrNmOgMHs7zS08XOX/So6VxizH8TjxiUHMA7plirbQ=; b=mO/u5ghXXBamGJ
	+/8kxBcNR0rgrOZEcAVA+i0C+FqEAihqD9kcaHhMoe36O8bCavJAOGOxn0dP3J26PCEUQrbjPBlOb
	iFptJ4rafkYdZP7I0qrTd4uDfSxlkyXj487nOS9c0V98Ka1zuAJprrIrqPFdwaqGEIgkA5Kha7Jq+
	LH+JtUbLhLg/tD2CJ1ovNCdwvxl67eJtnxv0oJeBmv39g6RVqVMz4kMUAbdHI4uTPpQaVi6N9OcHv
	xccyj/6j5xCQRjjiYXj0+rxGo8n5/uVvTscEydVW0TjvBecx4IFttgGw302gLnIZ4m10a4TBeG6Mo
	AEogwTtneWMsTFKmM/fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpAzi-00000005p7S-46SZ;
	Tue, 26 Mar 2024 17:53:54 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpAzb-00000005p5i-0Woi
	for kexec@lists.infradead.org;
	Tue, 26 Mar 2024 17:53:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711475627; x=1743011627;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wU0JE4kouoaua5oyHsX4nd5C2asEXFa3mxPJlgLUrxk=;
  b=BirKAMP8+SgZ0Uj1MA/Ng0oiHDd/5TJOQTi/Qw/7bJmIux8bonXSmnBb
   +LzzwelS4qBjN12H3kAMldimwjDSTPjqZeC6aDJyz3qagkcWXmRSDt31X
   UHYzeOh4vaPuh2Mky9E6fyS8UYjAOM2CpIyT1G7HWC1BlKw8W/cHpE1Xl
   lUFwZe607EnI1UCiQ0ZFP31ZDi3FjNam4pMAIpccGPXrLlkWHrm83aFFI
   C258j3n9PW2VrZ/MZ949LDZ5I6D6MQ7JTAUUkJHuaEwQQylQUayO9isHm
   fnSasi496XlVhiI3rHjzLhvf+74fcbw0dS8Fw4rl2P2CFSd0wxoTzq7KG
   Q==;
X-CSE-ConnectionGUID: GPqt5xwERcihzHm7BYlR/w==
X-CSE-MsgGUID: yIrziHtQSdqj2fJ5ou6QKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6651554"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6651554"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="53500100"
Received: from pwimalas-mobl.amr.corp.intel.com (HELO [10.251.11.118]) ([10.251.11.118])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:53:41 -0700
Message-ID: <0582b182-3293-43d5-a4be-5e0c6e97f7ff@linux.intel.com>
Date: Tue, 26 Mar 2024 10:53:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 17/17] ACPI: tables: Print MULTIPROC_WAKEUP when MADT is
 parsed
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
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-18-kirill.shutemov@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240325103911.2651793-18-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_105347_254494_6F82BB5B 
X-CRM114-Status: GOOD (  14.55  )
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


On 3/25/24 3:39 AM, Kirill A. Shutemov wrote:
> When MADT is parsed, print MULTIPROC_WAKEUP information:
>
> ACPI: MP Wakeup (version[1], mailbox[0x7fffd000], reset[0x7fffe068])
>
> This debug information will be very helpful during bring up.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Baoquan He <bhe@redhat.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/acpi/tables.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index b976e5fc3fbc..9e1b01c35070 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -198,6 +198,20 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		}
>  		break;
>  
> +	case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
> +		{
> +			struct acpi_madt_multiproc_wakeup *p =
> +				(struct acpi_madt_multiproc_wakeup *)header;
> +			u64 reset_vector = 0;
> +
> +			if (p->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1)
> +				reset_vector = p->reset_vector;
> +
> +			pr_debug("MP Wakeup (version[%d], mailbox[%#llx], reset[%#llx])\n",
> +				 p->version, p->mailbox_address, reset_vector);
> +		}
> +		break;
> +
>  	case ACPI_MADT_TYPE_CORE_PIC:
>  		{
>  			struct acpi_madt_core_pic *p = (struct acpi_madt_core_pic *)header;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
