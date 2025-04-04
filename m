Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E73BC3DA4A
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dYSO4GIkP5mEnRMwoEieSemMGmNulVoN4UaB4qKT8KA=; b=RjKxXRX01JPRmNdmiLOgYhG4Ps
	SyI177QrHY/8MqmczPtYc+THwfdJTU5C63/5PLu0d4iikpNnlSReJQuS2Qz6/58DfsAs7nWnmhdB2
	l/1d5oRgcRXqAxAQ/0rm+u6C+a1vgAfSvKVhZllull2LaVNh7/yy1mZP0B7unkuqxfL4wpYA5+JGO
	FCJ8zm5WDGf29M2TUyKCh3KQpMHceQssh0bLoFHSEBh40IbFURWNxTyHzWr9gH+5MeJTKqC02FSpu
	S8Nm7H94M2gLf+QPBQMpXDkIzTuPmtpqVRzVVNcxRLMiO5v8keHrbe1EYgw7fFcm728ZKZBlurxTT
	gAGSbvTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FJL-000000017Lm-3Ths;
	Mon, 14 Apr 2025 08:36:59 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0j8h-0000000CBsY-0AvZ;
	Fri, 04 Apr 2025 15:39:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1743781168; x=1775317168;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=dYSO4GIkP5mEnRMwoEieSemMGmNulVoN4UaB4qKT8KA=;
  b=u1W1mVEeVAYKzwwm4mPWFrO3ZIiyLnqx9wTIwoGxbVfxTrXtMRNnqyb7
   rs8ksq8krPma0rO8qmlBujYHBW+BfKZBlS/Ejiz641Tvh6ewikPg0zPTn
   vNTxIJ11FXkY1BkODWguQTm58gBhxgIxv7s2N3ldsNLf7BUM07tBdIyPw
   8=;
X-IronPort-AV: E=Sophos;i="6.15,188,1739836800"; 
   d="scan'208";a="480423186"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 15:39:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:13293]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id 83d3bfe4-40f1-416b-8ad0-21163f094fcc; Fri, 4 Apr 2025 15:39:19 +0000 (UTC)
X-Farcaster-Flow-ID: 83d3bfe4-40f1-416b-8ad0-21163f094fcc
Received: from EX19D020UWA002.ant.amazon.com (10.13.138.222) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 15:39:16 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D020UWA002.ant.amazon.com (10.13.138.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 15:39:16 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 15:39:16 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTP id 8865A4034B;
	Fri,  4 Apr 2025 15:39:15 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 454F452B6; Fri,  4 Apr 2025 15:39:15 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Changyuan Lyu <changyuanl@google.com>, <linux-kernel@vger.kernel.org>,
	<graf@amazon.com>, <akpm@linux-foundation.org>, <luto@kernel.org>,
	<anthony.yznaga@oracle.com>, <arnd@arndb.de>, <ashish.kalra@amd.com>,
	<benh@kernel.crashing.org>, <bp@alien8.de>, <catalin.marinas@arm.com>,
	<dave.hansen@linux.intel.com>, <dwmw2@infradead.org>,
	<ebiederm@xmission.com>, <mingo@redhat.com>, <jgowans@amazon.com>,
	<corbet@lwn.net>, <krzk@kernel.org>, <rppt@kernel.org>,
	<mark.rutland@arm.com>, <pbonzini@redhat.com>, <pasha.tatashin@soleen.com>,
	<hpa@zytor.com>, <peterz@infradead.org>, <robh+dt@kernel.org>,
	<robh@kernel.org>, <saravanak@google.com>,
	<skinsburskii@linux.microsoft.com>, <rostedt@goodmis.org>,
	<tglx@linutronix.de>, <thomas.lendacky@amd.com>, <usama.arif@bytedance.com>,
	<will@kernel.org>, <devicetree@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory preservation
In-Reply-To: <20250404125421.GI342109@nvidia.com>
References: <20250320015551.2157511-1-changyuanl@google.com>
	<20250320015551.2157511-10-changyuanl@google.com>
	<mafs01pu9qm6r.fsf@amazon.de> <20250403161001.GG342109@nvidia.com>
	<mafs0tt75p2nx.fsf@amazon.de> <20250404125421.GI342109@nvidia.com>
Date: Fri, 4 Apr 2025 15:39:15 +0000
Message-ID: <mafs0h634os0s.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_083927_237958_D0E35F15 
X-CRM114-Status: GOOD (  29.35  )
X-Mailman-Approved-At: Mon, 14 Apr 2025 01:36:58 -0700
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

On Fri, Apr 04 2025, Jason Gunthorpe wrote:

> On Thu, Apr 03, 2025 at 05:37:06PM +0000, Pratyush Yadav wrote:
>
[...]
>> > This should be more like:
>> >
>> > union {
>> >       void *table;
>> >       phys_addr_t table_phys;
>> > };
>> >
>> > Since we are not using the low bits right now and it is alot cheaper
>> > to convert from va to phys only once during the final step. __va is
>> > not exactly fast.
>> 
>> The descriptor is used on _every_ level of the table, not just the
>> top.
>
> Yes
>
>> So if we use virtual addresses, at serialize time we would have to walk
>> the whole table and covert all addresses to physical.
>
> Yes
>
>> And __va() does
>> not seem to be doing too much. On x86, it expands to:
>> 
>>     #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
>> 
>> and on ARM64 to:
>> 
>>     #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
>>     #define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET) | PAGE_OFFSET)
>
> Hmm, I was sure sparsemem added a bunch of stuff to this path, maybe
> I'm thinking of page_to_phys

Yep, page_to_phys for sparsemem is somewhat expensive, but __va() seems
to be fine.

    #define __page_to_pfn(pg)					\
    ({	const struct page *__pg = (pg);				\
            int __sec = page_to_section(__pg);			\
            (unsigned long)(__pg - __section_mem_map_addr(__nr_to_section(__sec)));	\
    })

>
>> >> +struct kho_mem_track {
>> >> +	/* Points to L4 KHOMEM descriptor, each order gets its own table. */
>> >> +	struct xarray orders;
>> >> +};
>> >
>> > I think it would be easy to add a 5th level and just use bits 63:57 as
>> > a 6 bit order. Then you don't need all this stuff either.
>> 
>> I am guessing you mean to store the order in the table descriptor
>> itself, instead of having a different table for each order.
>
> Not quite, I mean to index the per-order sub trees by using the high
> order bits. You still end up with N seperate bitmap trees, but instead
> of using an xarray to hold their top pointers you hold them in a 5th
> level.
>
>> Though now that I think of it, it is probably much simpler to just use
>> khomem_desc_t orders[NR_PAGE_ORDERS] instead of the xarray.
>
> Which is basically this, but encoding the index to orders in the address

I think this is way easier to wrap your head around compared to trying
to encode orders in address. That doesn't even work that well since
address has pretty much no connection to order. So a page at address say
0x100000 might be any order. So we would have to encode the order into
the address, and then decode it when doing table operations. Just having
a separate table indexed separately by orders is way simpler.

-- 
Regards,
Pratyush Yadav

