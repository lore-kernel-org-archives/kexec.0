Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F28CC46CD2
	for <kexec@archiver.kernel.org>; Tue,  2 Jan 2024 19:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AEn6fvAv87UC1KEJX1n8/o4u23bBdD8K26vE2F/zEKg=; b=lcshIeGBDkOfr1
	jX5l/7Zs22a32SMHuK/sRq4fbbKJr2ffx0t2ENIHGF/Bg4/AL0ePxwS/vl7wRXBK31qFU7TMbzuKz
	hgJcz8A/UEJIj7TpHSm1iALs2vxl4cu635KQaITDRVOsWqDMkmvJGHpyVZOIj/mJB/JL9awb1w9nU
	2hzC6R0Wi0X4gqNiiJTk9tqMa5Ln6xrBZHpHKwiDZzVSXqMirhgbsA61gWEYWxQWTyRAo2h8p/PYc
	87jjd0+gOI78MkyB3jWcGUue/HTZxhh10geIslZvFzOO6PSw42QV61uE6XMfENkcM5m9TErnq3MGr
	GgsVPlEpKvKtoir9XnSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKku0-008suU-2c;
	Tue, 02 Jan 2024 19:58:16 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKkty-008stn-1l;
	Tue, 02 Jan 2024 19:58:15 +0000
Received: from skinsburskii. (c-73-239-240-195.hsd1.wa.comcast.net [73.239.240.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2C6DD20B3CC1;
	Tue,  2 Jan 2024 11:58:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C6DD20B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704225493;
	bh=2UaDwV/oGm+Epqzq+iuoXLl1XYKs/iiOjHPSgAf4WNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sf+h60AikfAoNDWIfOQf+gp/7n62YjqR91jk021dI0v+1a8M9a0OEjS7fQlNbGHtT
	 ipeSl4ZqBYQjVEH3GZlLaVHYTWm8e6nUV0SEqCtKnbq135a3/00oHsQNKX3wd4Z7BD
	 ICaDdMQVBMMzyyO3sadV/R66AVE4C1KSJe3ErDtk=
Date: Sun, 31 Dec 2023 19:33:01 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, arnd@arndb.de,
	pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 04/17] kexec: Add KHO parsing support
Message-ID: <20240101033301.GA765@skinsburskii.>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222193607.15474-5-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231222193607.15474-5-graf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_115814_632749_74529233 
X-CRM114-Status: GOOD (  19.42  )
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

On Fri, Dec 22, 2023 at 07:35:54PM +0000, Alexander Graf wrote:
> +/**
> + * kho_reserve_previous_mem - Adds all memory reservations into memblocks
> + * and moves us out of the scratch only phase. Must be called after page tables
> + * are initialized and memblock_allow_resize().
> + */
> +void __init kho_reserve_previous_mem(void)
> +{
> +	void *mem_virt = __va(mem_phys);
> +	int off, err;
> +
> +	if (!handover_phys || !mem_phys)
> +		return;
> +
> +	/*
> +	 * We reached here because we are running inside a working linear map
> +	 * that allows us to resize memblocks dynamically. Use the chance and
> +	 * populate the global fdt pointer
> +	 */
> +	fdt = __va(handover_phys);
> +
> +	off = fdt_path_offset(fdt, "/");
> +	if (off < 0) {
> +		fdt = NULL;
> +		return;
> +	}
> +
> +	err = fdt_node_check_compatible(fdt, off, "kho-v1");
> +	if (err) {
> +		pr_warn("KHO has invalid compatible, disabling.");

It looks like KHO preserved regions won't be reserved in this case.
Should KHO DT state be destroyed here to prevent KHO memory regions
reuse upon rollback?

> +
> +void __init kho_populate(phys_addr_t handover_dt_phys, phys_addr_t scratch_phys,
> +			 u64 scratch_len, phys_addr_t mem_cache_phys,
> +			 u64 mem_cache_len)
> +{
> +	void *handover_dt;
> +
> +	/* Determine the real size of the DT */
> +	handover_dt = early_memremap(handover_dt_phys, sizeof(struct fdt_header));
> +	if (!handover_dt) {
> +		pr_warn("setup: failed to memremap kexec FDT (0x%llx)\n", handover_dt_phys);
> +		return;
> +	}
> +
> +	if (fdt_check_header(handover_dt)) {
> +		pr_warn("setup: kexec handover FDT is invalid (0x%llx)\n", handover_dt_phys);
> +		early_memunmap(handover_dt, PAGE_SIZE);
> +		return;
> +	}
> +
> +	handover_len = fdt_totalsize(handover_dt);
> +	handover_phys = handover_dt_phys;
> +
> +	/* Reserve the DT so we can still access it in late boot */
> +	memblock_reserve(handover_phys, handover_len);
> +
> +	/* Reserve the mem cache so we can still access it later */
> +	memblock_reserve(mem_cache_phys, mem_cache_len);
> +
> +	/*
> +	 * We pass a safe contiguous block of memory to use for early boot purporses from
> +	 * the previous kernel so that we can resize the memblock array as needed.
> +	 */
> +	memblock_add(scratch_phys, scratch_len);
> +
> +	if (WARN_ON(memblock_mark_scratch(scratch_phys, scratch_len))) {
> +		pr_err("Kexec failed to mark the scratch region. Disabling KHO.");
> +		handover_len = 0;
> +		handover_phys = 0;

Same question here: doesn't all the KHO state gets invalid in case of any
restoration error?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
