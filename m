Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505E2C3DA79
	for <kexec@archiver.kernel.org>; Mon, 15 Jan 2024 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4BAprSXyRJty3k6ryah8Ln0mwI35r9YYbi8Uubs5N2U=; b=HVdWbzM+eFkNJ5
	6wz/g/e9URStDY5ZkR3EDIg36x0qsHPp2QQgBG6R2Xn4dAEjONU7mVhkqbd/aXeO/dgva49JtF/O3
	q+JVfzmNMJEXUuBdz6PzU0ptPObK4/yp7hdgb4i2L/NUs9svfY3hWoskdPAy8azLHyP5t/TAwU36L
	U4cfTdYyxW7xTBv3EU8iMSZrLz6yusSoZJG+jSrmQkwuOVbt0mw7twZ3RUpIMzWc83rpzLYd9CXJr
	3cLZ+9aK064gCPrrbqoPE77XhC2CVtTYPKDzgskmtUIzlwNlvWYn2aTDttX8ojp7vfTfC4GKgRrzS
	OhRSTeMrzzxXAXcwIH+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPN0Y-0094ef-2x;
	Mon, 15 Jan 2024 13:28:06 +0000
Received: from smtp-fw-9105.amazon.com ([207.171.188.204])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPN0W-0094do-09;
	Mon, 15 Jan 2024 13:28:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705325284; x=1736861284;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CRE66M5NAo6zqtyZQM3AWAf6gOvFh/lPcxTLxUzKJu0=;
  b=kAKZvyXeBKPfQKPc1sCGVs3njxLBshcOwigB8aCWSlc4fSIv2BholQAb
   CUK6hdatZYZ7f7+0YK3IJIZcR2vVt8g0aTPwV7NTkD2ZPfnXU92cKq/O5
   EgIS9NBvIRHOtxUTNVYJYlfI3kSGXlxp+8QDWJJXhJb4ck2xQlY4L6NNZ
   I=;
X-IronPort-AV: E=Sophos;i="6.04,196,1695686400"; 
   d="scan'208";a="697876050"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 13:27:52 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com (Postfix) with ESMTPS id 18BD5A0A25;
	Mon, 15 Jan 2024 13:27:44 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:24915]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.210:2525] with esmtp (Farcaster)
 id 00e71d69-8a91-48a6-b14b-66e164da46e8; Mon, 15 Jan 2024 13:27:44 +0000 (UTC)
X-Farcaster-Flow-ID: 00e71d69-8a91-48a6-b14b-66e164da46e8
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 13:27:43 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 15 Jan
 2024 13:27:34 +0000
Message-ID: <64047065-41a1-4235-b600-bf3530c76722@amazon.com>
Date: Mon, 15 Jan 2024 14:27:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/17] kexec: Add KHO parsing support
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring
	<robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, <arnd@arndb.de>, <pbonzini@redhat.com>,
	<madvenka@linux.microsoft.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222193607.15474-5-graf@amazon.com> <20240101033301.GA765@skinsburskii.>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20240101033301.GA765@skinsburskii.>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_052804_150489_2250C753 
X-CRM114-Status: GOOD (  19.76  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


On 01.01.24 04:33, Stanislav Kinsburskii wrote:
> On Fri, Dec 22, 2023 at 07:35:54PM +0000, Alexander Graf wrote:
>> +/**
>> + * kho_reserve_previous_mem - Adds all memory reservations into memblocks
>> + * and moves us out of the scratch only phase. Must be called after page tables
>> + * are initialized and memblock_allow_resize().
>> + */
>> +void __init kho_reserve_previous_mem(void)
>> +{
>> +     void *mem_virt = __va(mem_phys);
>> +     int off, err;
>> +
>> +     if (!handover_phys || !mem_phys)
>> +             return;
>> +
>> +     /*
>> +      * We reached here because we are running inside a working linear map
>> +      * that allows us to resize memblocks dynamically. Use the chance and
>> +      * populate the global fdt pointer
>> +      */
>> +     fdt = __va(handover_phys);
>> +
>> +     off = fdt_path_offset(fdt, "/");
>> +     if (off < 0) {
>> +             fdt = NULL;
>> +             return;
>> +     }
>> +
>> +     err = fdt_node_check_compatible(fdt, off, "kho-v1");
>> +     if (err) {
>> +             pr_warn("KHO has invalid compatible, disabling.");
> It looks like KHO preserved regions won't be reserved in this case.
> Should KHO DT state be destroyed here to prevent KHO memory regions
> reuse upon rollback?


Good catch. I'll set fdt to NULL in that case in v3.


>
>> +
>> +void __init kho_populate(phys_addr_t handover_dt_phys, phys_addr_t scratch_phys,
>> +                      u64 scratch_len, phys_addr_t mem_cache_phys,
>> +                      u64 mem_cache_len)
>> +{
>> +     void *handover_dt;
>> +
>> +     /* Determine the real size of the DT */
>> +     handover_dt = early_memremap(handover_dt_phys, sizeof(struct fdt_header));
>> +     if (!handover_dt) {
>> +             pr_warn("setup: failed to memremap kexec FDT (0x%llx)\n", handover_dt_phys);
>> +             return;
>> +     }
>> +
>> +     if (fdt_check_header(handover_dt)) {
>> +             pr_warn("setup: kexec handover FDT is invalid (0x%llx)\n", handover_dt_phys);
>> +             early_memunmap(handover_dt, PAGE_SIZE);
>> +             return;
>> +     }
>> +
>> +     handover_len = fdt_totalsize(handover_dt);
>> +     handover_phys = handover_dt_phys;
>> +
>> +     /* Reserve the DT so we can still access it in late boot */
>> +     memblock_reserve(handover_phys, handover_len);
>> +
>> +     /* Reserve the mem cache so we can still access it later */
>> +     memblock_reserve(mem_cache_phys, mem_cache_len);
>> +
>> +     /*
>> +      * We pass a safe contiguous block of memory to use for early boot purporses from
>> +      * the previous kernel so that we can resize the memblock array as needed.
>> +      */
>> +     memblock_add(scratch_phys, scratch_len);
>> +
>> +     if (WARN_ON(memblock_mark_scratch(scratch_phys, scratch_len))) {
>> +             pr_err("Kexec failed to mark the scratch region. Disabling KHO.");
>> +             handover_len = 0;
>> +             handover_phys = 0;
> Same question here: doesn't all the KHO state gets invalid in case of any
> restoration error?


It does, which is what the error case here does, no? Or are you 
referring to the fact that we're not unrolling the memblock 
reservations? If we can't mark the scratch region, I'd rather leave 
everything else alone. It means the scratch region is in a hole, which 
should never happen.


Alex




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
