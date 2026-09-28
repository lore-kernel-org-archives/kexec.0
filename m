Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD5AC9833F
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 10:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ksFkQeR/mSa3Mz1iwDhfUYANT9IVs/8bPwbPPKQtI4E=; b=f+9D393Py92WxH8IvyVYMB0rPd
	E0afyuu05Wg3HYLVHo637jbqsiDpt1GCh5tk82zR/y+nOHPysIvfRVy+b5mKY/X3ZV+LmB7waNaOx
	rt/2OlVKAgS1KhuKo/+4gx9FAJoLc+uI4mxA50EPOyk095Dl4e5X7t3avKHkBDIZNJzLfNavoL834
	4prF95poWbYPp6A1GPjKETR5ee+xnRyvfT2rRgraNuRJjzYEzYZ4+p/ZbEvmJuksEjpX2BW6iNuZB
	yVRwbXScETbk3K2PVokIPG5gHHHgIVTLYZPChrm/c70j+b1l9P15029pSSddjoQ32YZHyFLiYTts7
	RWXOtMiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB8XT-00000000LDS-3vQo;
	Mon, 28 Sep 2026 10:24:51 +0000
Received: from out-39.mta1.migadu.com ([2001:41d0:203:375::27] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB8XQ-00000000LCn-3LMH
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 10:24:50 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=2qsLTZUYXNCuyy8IDZLxqiAQMXwe8wqDNcAp0qKJ77U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790591086; v=1; x=1791195886;
 b=ZxChjhdka8T9HHrheFzIARwO+z8rjGb2e+UsJSBUtaTvxRux583nCGaQchonxreIuO7xt6lU
 gsKGN4ED2zSUNU4o+P0UJS48q9NwyUlkBBThrIz15ItZIcaMWjn1OzoWCaSGuElIpDSiTUQzmmS
 30rsYgMqpR2TSrTedIsnJs2o=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 8692f2c2c9228f5e;
	Mon, 28 Sep 2026 10:24:46 +0000
X-Mizu-Trace-ID: 8692f2c2c9228f5e
X-Migadu-Flow: FLOW_OUT
Message-ID: <9c47dad9-2716-4ae0-b6e2-9e6b5c718859@linux.dev>
Date: Mon, 28 Sep 2026 18:23:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vmcoreinfo: export SECTION_HAS_MEM_MAP
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He
 <baoquan.he@linux.dev>, David Carlier <devnexen@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kexec@lists.infradead.org
References: <20260928-section_has_mem_map-v1-1-4129f6ba2838@kernel.org>
Content-Language: en-US, en-GB
From: Dave Young <ruirui.yang@linux.dev>
In-Reply-To: <20260928-section_has_mem_map-v1-1-4129f6ba2838@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_032449_071765_3F205953 
X-CRM114-Status: GOOD (  17.47  )
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

On 9/28/26 4:48 PM, David Hildenbrand (Arm) wrote:
> The crash tool currently hardcodes SECTION_HAS_MEM_MAP, and makedumpfile
> needs similar information (although still relying on
> SECTION_MARKED_PRESENT, it should switch to SECTION_HAS_MEM_MAP).
> 
> Let's just export the value instead, so tools that work on vmcoreinfo
> will not have to guess.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> Result of the discussion in reply to "[PATCH v2 00/13] mm/sparse: remove
> SECTION_MARKED_PRESENT and further cleanups" [1]
> 
> This patch can go in independently. It would be preferable if both
> go into the same kernel release ;)
> 
> [1] https://lore.kernel.org/r/20260921-b4-sparsemem_cleanups-v2-0-54d81d65e125@kernel.org 
> ---
>  kernel/vmcore_info.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
> index 5a417f8a922a..7833a36064a8 100644
> --- a/kernel/vmcore_info.c
> +++ b/kernel/vmcore_info.c
> @@ -182,6 +182,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_STRUCT_SIZE(mem_section);
>  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
>  	VMCOREINFO_NUMBER(SECTION_SIZE_BITS);
> +	VMCOREINFO_NUMBER(SECTION_HAS_MEM_MAP);
>  	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>  #endif
>  	VMCOREINFO_STRUCT_SIZE(page);

Current crash code looks below:
#define SECTION_MARKED_PRESENT          (1UL<<0)
#define SECTION_HAS_MEM_MAP             (1UL<<1)
#define SECTION_IS_ONLINE               (1UL<<2)
#define SECTION_IS_EARLY                (1UL<<3)
#define SECTION_TAINT_ZONE_DEVICE       (1UL<<4)
#define SECTION_MAP_LAST_BIT            (1UL<<5)
#define SECTION_MAP_MASK                (~(SECTION_MAP_LAST_BIT-1))


And it does not match the kernel for below chunk with ifdef
#ifdef CONFIG_ZONE_DEVICE
        SECTION_TAINT_ZONE_DEVICE_BIT,
#endif
#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
        SECTION_IS_VMEMMAP_PREINIT_BIT,
#endif

The last bit could be wrong in crash.  So all numbers should be exported in vmcoreinfo.

Thoughts?


ThanksDave

