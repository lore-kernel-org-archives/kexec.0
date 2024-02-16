Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A25C48260
	for <kexec@archiver.kernel.org>; Fri, 16 Feb 2024 15:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P3rzGv5nESyntjSxQO7K9CH7IWbG5lCKhF8K1qxUYkU=; b=u0+mtytO+1W4rC
	bitF397KYMuKvkzil+8ASwb09IZy4OeojFg0AgW5Cj7PkE2PvryACAPaqqbH1MHXXCBHqmU0tXEvO
	TtWJJ/zBpWNmAvH13YeA2WHrIETNEonGlkAuIMcNzyjmBUK3iR84rlt0/KrYoIi6KHP1yAtjfAIIs
	eDHkRYi/doCnPtGUuB08TgTggddpCdqmwuft6ABP3/vLG+0dYARr27Xo4y+9oou5tnSG9NtQIyEZT
	FjAogQw9+9chMYsanM+XusuzbsOqghVpRdNdckpuDobpefNRc4DdFiUVUw0V7iY5vPsuMJrmfYs5J
	AztFaOSpplTo2RDojX/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb0an-00000002vBx-2her;
	Fri, 16 Feb 2024 15:57:37 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb0ak-00000002vAu-2H47;
	Fri, 16 Feb 2024 15:57:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1708099055; x=1739635055;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ySlk5EP+5EPRFvPn7fKspQz+Y/lmLyPoeT8Lylq3p9Y=;
  b=INUCV6mqjR9bApW5bPO0D8ZD37F1XaWRtO+wK3N12g+gRywP9XEtWK7q
   ndTGY0ChLjMKu8+L1K953A1sZd20aXSOhg1LMfmMqY+yW1LdE/Wox4nkc
   X5kIvTHlyqVnclXMUhgTxt3+hLdbhTBmhYh6uejjdrWjQlLrKrWTap/YR
   E=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="327444091"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 15:57:26 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.0.204:20286]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.58.150:2525] with esmtp (Farcaster)
 id 5a50e3a4-7605-4a6b-bd7b-2201142338a7; Fri, 16 Feb 2024 15:57:25 +0000 (UTC)
X-Farcaster-Flow-ID: 5a50e3a4-7605-4a6b-bd7b-2201142338a7
Received: from EX19D008UEA002.ant.amazon.com (10.252.134.125) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:57:10 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA002.ant.amazon.com (10.252.134.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:57:09 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 16 Feb 2024 15:57:09 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 4FB1420D21; Fri, 16 Feb 2024 16:57:09 +0100 (CET)
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
Subject: Re: [PATCH v3 04/17] kexec: Add KHO parsing support
In-Reply-To: <20240117144704.602-5-graf@amazon.com> (Alexander Graf's message
	of "Wed, 17 Jan 2024 14:46:51 +0000")
References: <20240117144704.602-1-graf@amazon.com>
	<20240117144704.602-5-graf@amazon.com>
Date: Fri, 16 Feb 2024 16:57:09 +0100
Message-ID: <mafs0eddc8kru.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_075734_633475_43F40CAB 
X-CRM114-Status: GOOD (  21.34  )
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

> When we have a KHO kexec, we get a device tree, mem cache and scratch
> region to populate the state of the system. Provide helper functions
> that allow architecture code to easily handle memory reservations based
> on them and give device drivers visibility into the KHO DT and memory
> reservations so they can recover their own state.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
>
> ---
>
[...]
> +/**
> + * kho_return_mem - Notify the kernel that initially reserved memory is no
> + * longer needed. When the last consumer of a page returns their mem, kho
> + * returns the page to the buddy allocator as free page.
> + */
> +void kho_return_mem(const struct kho_mem *mem)
> +{
> +	uint64_t start_pfn, end_pfn, pfn;
> +
> +	start_pfn = PFN_DOWN(mem->addr);
> +	end_pfn = PFN_UP(mem->addr + mem->len);
> +
> +	for (pfn = start_pfn; pfn < end_pfn; pfn++)
> +		kho_return_pfn(pfn);
> +}
> +EXPORT_SYMBOL_GPL(kho_return_mem);
> +
> +static void kho_claim_pfn(ulong pfn)
> +{
> +	struct page *page = pfn_to_page(pfn);
> +
> +	WARN_ON(!page);
> +	if (WARN_ON(page_count(page) != 1))
> +		pr_err("Claimed non kho pfn %lx", pfn);

You do sanity checks but then never actually change anything on the
page. kho_claim_mem()'s documentation says: "This function removes the
reserved state for all pages that the mem spans". So this function
should at the very least call ClearPageReserved().

Also, checking the page count is a very rough heuristic. There can be
other non-KHO pages with page count == 1. Do you think it would make
more sense to use one of the private pageflags bits to mark a page
KHO-owned? If not, shouldn't you at least also check if the page is
reserved?

> +}
> +
> +/**
> + * kho_claim_mem - Notify the kernel that a handed over memory range is now in
> + * use by a kernel subsystem and considered an allocated page. This function
> + * removes the reserved state for all pages that the mem spans.
> + */
> +void *kho_claim_mem(const struct kho_mem *mem)
> +{
> +	u64 start_pfn, end_pfn, pfn;
> +	void *va = __va(mem->addr);
> +
> +	start_pfn = PFN_DOWN(mem->addr);
> +	end_pfn = PFN_UP(mem->addr + mem->len);
> +
> +	for (pfn = start_pfn; pfn < end_pfn; pfn++)
> +		kho_claim_pfn(pfn);
> +
> +	return va;
> +}
> +EXPORT_SYMBOL_GPL(kho_claim_mem);
> +
[...]

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
