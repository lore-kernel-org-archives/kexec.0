Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B42BC54798
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PCr2SrYksgQgrJGpd4ckfQYQOIAazq7jMAZsNQUp78k=; b=MEXZaE8nmDUqyW
	Q5gWSNyMRR0SDSpBt9vWcJMGm2wIciSlAfyrvLmnpyeg2SW9hLzIap3zKS7xsF272ld00MEgedj6k
	FExtXsTPQlKn68+VaRfUS4AbQjnRvJPI+YWJDjXdn66AQ+nlQIu+hQJ/Co79BLGT2WVwQoYwAinHA
	MLmS8JbS3AM6nnjyzrTwfmqIHEpelYHKISTcJ52mz/NEeTcjxtVmTIJ7a4et1xXAf2qQrCaNt5fIN
	nuzJyRJlsJRtEn30QfaLUoREiwcCmuEKuPE+sKC/GXoKW64I5TkXX0UOy5w8hdgdWOn+NIc2WuaTC
	itY62cjlNp5KcznEWAJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdXrs-0000000A5LF-0QE4;
	Fri, 23 Feb 2024 15:53:44 +0000
Received: from smtp-fw-80007.amazon.com ([99.78.197.218])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdXrl-0000000A5Fg-01ud;
	Fri, 23 Feb 2024 15:53:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1708703617; x=1740239617;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0WhTIN9W38rHyOc22G1vQ7ixEZgYslJzQI/6oPVT4RA=;
  b=L8zf5HVyhIbMnMN2vjYL9dXWR5r/77Bp3Q0Ce8eRT6lYyOgWO4zpJIRF
   JJyHiQ4gp4g/CZnaPtD+Z6P9cCR/mL6FydVZTHWPcCuAr5mturxmb5N3n
   Kk5WPRpdiZK0vl7NDyqXpydzggQ9cXhgOaX+vrWfaJbWx5WH5J+bPEnWy
   0=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="276297960"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 15:53:29 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.0.204:49000]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.11.226:2525] with esmtp (Farcaster)
 id 8c10934d-ba88-400b-b524-af83d373a694; Fri, 23 Feb 2024 15:53:28 +0000 (UTC)
X-Farcaster-Flow-ID: 8c10934d-ba88-400b-b524-af83d373a694
Received: from EX19D008UEC003.ant.amazon.com (10.252.135.194) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 15:53:26 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEC003.ant.amazon.com (10.252.135.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 15:53:26 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 23 Feb 2024 15:53:26 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id BF2E820D24; Fri, 23 Feb 2024 16:53:25 +0100 (CET)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Alexander Graf <graf@amazon.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
	<rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>
Subject: Re: [PATCH v3 02/17] memblock: Declare scratch memory as CMA
In-Reply-To: <20240117144704.602-3-graf@amazon.com> (Alexander Graf's message
	of "Wed, 17 Jan 2024 14:46:49 +0000")
References: <20240117144704.602-1-graf@amazon.com>
	<20240117144704.602-3-graf@amazon.com>
Date: Fri, 23 Feb 2024 16:53:25 +0100
Message-ID: <mafs0r0h36utm.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_075337_182780_7D08C27F 
X-CRM114-Status: GOOD (  20.24  )
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

Hi,

On Wed, Jan 17 2024, Alexander Graf wrote:

> When we finish populating our memory, we don't want to lose the scratch
> region as memory we can use for useful data. Do do that, we mark it as
> CMA memory. That means that any allocation within it only happens with
> movable memory which we can then happily discard for the next kexec.
>
> That way we don't lose the scratch region's memory anymore for
> allocations after boot.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
>
[...]
> @@ -2188,6 +2185,16 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
>  	}
>  }
>  
> +static void mark_phys_as_cma(phys_addr_t start, phys_addr_t end)
> +{
> +	ulong start_pfn = pageblock_start_pfn(PFN_DOWN(start));
> +	ulong end_pfn = pageblock_align(PFN_UP(end));
> +	ulong pfn;
> +
> +	for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages)
> +		set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_CMA);

This fails to compile if CONFIG_CMA is disabled. I think you should add
it as a dependency for CONFIG_MEMBLOCK_SCRATCH.

> +}
> +
>  static unsigned long __init __free_memory_core(phys_addr_t start,
>  				 phys_addr_t end)
>  {
> @@ -2249,6 +2256,17 @@ static unsigned long __init free_low_memory_core_early(void)
>  
>  	memmap_init_reserved_pages();
>  
> +	if (IS_ENABLED(CONFIG_MEMBLOCK_SCRATCH)) {
> +		/*
> +		 * Mark scratch mem as CMA before we return it. That way we
> +		 * ensure that no kernel allocations happen on it. That means
> +		 * we can reuse it as scratch memory again later.
> +		 */
> +		__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> +				     MEMBLOCK_SCRATCH, &start, &end, NULL)
> +			mark_phys_as_cma(start, end);
> +	}
> +
>  	/*
>  	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
>  	 *  because in some case like Node0 doesn't have RAM installed

-- 
Regards,
Pratyush Yadav



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
