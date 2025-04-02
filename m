Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC658C36010
	for <kexec@archiver.kernel.org>; Fri,  4 Apr 2025 13:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8umj+ndDF/ipCfwtuKdMZkQWmOijnGXaazU2k4hwCNY=; b=MBBLjo1ELREB/UtsvxsxrSP4/B
	6bPxE7g6AP+8qTZIkIWyUKJziCrxoeakmzgGSN9W3qaTSugxHWcSiJed9LtGNjYxlBm8aKgC0intm
	wCZM9W+5j9uHD182baR7bKlfGkXO4RH2MzQWg/q+uwInzCJp0Sbz6seXPdvsfwuqhHswTadRXhjTm
	JOI9jugAvZUtWjDG8DcC/y3p5SF8iE9hKV0QA4IyxwTCRpTTPF4HmCgPf+q8Z05PWZCl4LH10bp/r
	NlnT+FIhVSKvcqILxE1jcPPMvKRpM9BjhY5Nqo2nerr6hXmzh54UYQW67joqx233aqHIK6aPoFX50
	rlS9955g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0gl4-0000000BlCf-42af;
	Fri, 04 Apr 2025 13:06:54 +0000
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u03Zk-000000071rh-2jel;
	Wed, 02 Apr 2025 19:16:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1743621397; x=1775157397;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8umj+ndDF/ipCfwtuKdMZkQWmOijnGXaazU2k4hwCNY=;
  b=iRHE1DobpITxvIKwFSr7VZ3/+YI7EtW6fBkoKLP9AVJoEHINPrYiYYIf
   TCn4mwAQ/2r0kxyeg9XIcaWoMT8XCXQ9N/RqnyvgyO2gZKAyXJORopRBJ
   D052Je+b6KT8dTDxXUnQGOcV9Gvqx2MhUe9fRpXp9i2nshqSlw3S5cJzP
   I=;
X-IronPort-AV: E=Sophos;i="6.15,183,1739836800"; 
   d="scan'208";a="37530635"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 19:16:34 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:8453]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.148:2525] with esmtp (Farcaster)
 id 3d208980-fd57-4d9c-b742-ec30a98b0997; Wed, 2 Apr 2025 19:16:33 +0000 (UTC)
X-Farcaster-Flow-ID: 3d208980-fd57-4d9c-b742-ec30a98b0997
Received: from EX19D020UWC002.ant.amazon.com (10.13.138.147) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 19:16:29 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D020UWC002.ant.amazon.com (10.13.138.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 19:16:28 +0000
Received: from email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 19:16:28 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com (Postfix) with ESMTP id 88B30A046F;
	Wed,  2 Apr 2025 19:16:27 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 1CF466148; Wed,  2 Apr 2025 19:16:27 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Changyuan Lyu <changyuanl@google.com>
CC: <linux-kernel@vger.kernel.org>, <graf@amazon.com>,
	<akpm@linux-foundation.org>, <luto@kernel.org>, <anthony.yznaga@oracle.com>,
	<arnd@arndb.de>, <ashish.kalra@amd.com>, <benh@kernel.crashing.org>,
	<bp@alien8.de>, <catalin.marinas@arm.com>, <dave.hansen@linux.intel.com>,
	<dwmw2@infradead.org>, <ebiederm@xmission.com>, <mingo@redhat.com>,
	<jgowans@amazon.com>, <corbet@lwn.net>, <krzk@kernel.org>, <rppt@kernel.org>,
	<mark.rutland@arm.com>, <pbonzini@redhat.com>, <pasha.tatashin@soleen.com>,
	<hpa@zytor.com>, <peterz@infradead.org>, <robh+dt@kernel.org>,
	<robh@kernel.org>, <saravanak@google.com>,
	<skinsburskii@linux.microsoft.com>, <rostedt@goodmis.org>,
	<tglx@linutronix.de>, <thomas.lendacky@amd.com>, <usama.arif@bytedance.com>,
	<will@kernel.org>, <devicetree@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <x86@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory preservation
In-Reply-To: <20250320015551.2157511-10-changyuanl@google.com>
References: <20250320015551.2157511-1-changyuanl@google.com>
	<20250320015551.2157511-10-changyuanl@google.com>
Date: Wed, 2 Apr 2025 19:16:27 +0000
Message-ID: <mafs05xjmqsqc.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_121636_741665_9063EF92 
X-CRM114-Status: GOOD (  26.28  )
X-Mailman-Approved-At: Fri, 04 Apr 2025 06:06:48 -0700
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

Hi Changyuan,

On Wed, Mar 19 2025, Changyuan Lyu wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Introduce APIs allowing KHO users to preserve memory across kexec and
> get access to that memory after boot of the kexeced kernel
>
> kho_preserve_folio() - record a folio to be preserved over kexec
> kho_restore_folio() - recreates the folio from the preserved memory
> kho_preserve_phys() - record physically contiguous range to be
> preserved over kexec.
> kho_restore_phys() - recreates order-0 pages corresponding to the
> preserved physical range
>
> The memory preservations are tracked by two levels of xarrays to manage
> chunks of per-order 512 byte bitmaps. For instance the entire 1G order
> of a 1TB x86 system would fit inside a single 512 byte bitmap. For
> order 0 allocations each bitmap will cover 16M of address space. Thus,
> for 16G of memory at most 512K of bitmap memory will be needed for order 0.
>
> At serialization time all bitmaps are recorded in a linked list of pages
> for the next kernel to process and the physical address of the list is
> recorded in KHO FDT.
>
> The next kernel then processes that list, reserves the memory ranges and
> later, when a user requests a folio or a physical range, KHO restores
> corresponding memory map entries.
>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> ---
>  include/linux/kexec_handover.h |  38 +++
>  kernel/kexec_handover.c        | 486 ++++++++++++++++++++++++++++++++-
>  2 files changed, 522 insertions(+), 2 deletions(-)
[...]
> +int kho_preserve_phys(phys_addr_t phys, size_t size)
> +{
> +	unsigned long pfn = PHYS_PFN(phys), end_pfn = PHYS_PFN(phys + size);
> +	unsigned int order = ilog2(end_pfn - pfn);

This caught my eye when playing around with the code. It does not put
any limit on the order, so it can exceed NR_PAGE_ORDERS. Also, when
initializing the page after KHO, we pass the order directly to
prep_compound_page() without sanity checking it. The next kernel might
not support all the orders the current one supports. Perhaps something
to fix?

> +	unsigned long failed_pfn;
> +	int err = 0;
> +
> +	if (!kho_enable)
> +		return -EOPNOTSUPP;
> +
> +	down_read(&kho_out.tree_lock);
> +	if (kho_out.fdt) {
> +		err = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	for (; pfn < end_pfn;
> +	     pfn += (1 << order), order = ilog2(end_pfn - pfn)) {
> +		err = __kho_preserve(&kho_mem_track, pfn, order);
> +		if (err) {
> +			failed_pfn = pfn;
> +			break;
> +		}
> +	}
[...
> +struct folio *kho_restore_folio(phys_addr_t phys)
> +{
> +	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> +	unsigned long order = page->private;
> +
> +	if (!page)
> +		return NULL;
> +
> +	order = page->private;
> +	if (order)
> +		prep_compound_page(page, order);
> +	else
> +		kho_restore_page(page);
> +
> +	return page_folio(page);
> +}
[...]

-- 
Regards,
Pratyush Yadav

