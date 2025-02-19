Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E87CC021AA
	for <kexec@archiver.kernel.org>; Wed, 19 Feb 2025 07:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jnJdwFcCP5YS3M6eDMp4EEzAiQ1HzVDUaylHfaqpvE0=; b=Mm5M/deS6zCui6zp0KQAu04d8c
	n/d8froR+weQhJ1kZO866bcXn6D4/VjaA1CVIJMj85/C1Alh51Wsqmgd45697U19dGj00LYXuBkCB
	wMsPNFQrb1VrYMdYUq23RMXdFliu6kA3A480c7dH/J0gUsMRWZtbupKs3cuSPWI4JDG+P9yGflGF9
	qNNt2cW6PS6xJkgU3eA93mWtkTy91KOwKnvezNb65aT9yPDE5WKaK27eR+YCjsqiZAJr0BRHciGjy
	jWhabUcBKKW/u59VI+F/fPiybNi5bPG0bXBIzoBWNSD9O9nEo71lvAGAowFMiSya4AkRLCtWbyDMe
	AhFTN+Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkeIN-0000000BBe1-2yG2;
	Wed, 19 Feb 2025 07:14:59 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkeHD-0000000BBGK-0Mfr;
	Wed, 19 Feb 2025 07:13:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A5ED7A41D17;
	Wed, 19 Feb 2025 07:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC035C4CED1;
	Wed, 19 Feb 2025 07:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739949225;
	bh=OOkIIvDjmX+t2iEfuOMs0YPPPkHDOiOCixy3iRv3A8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qduPPg28qy6v/QB2ER32fPvjQoDtpyv930crMRnp0aN8TEE8OmFoqthIOFykZwRUv
	 Pu5NZzJrifM/eee11PWKY563kbOVj9pdGQINPO0kLF/ykiEYMlFp8If0rTc0bF+qMH
	 z4jFYGZUOaph33hZ8GK2cqPKJAyLPh1mo2vjjrA51c1No2p8SQlBkCAgrWnZQda/KS
	 v6D8f2jjdG79HKjq8kSAwlDcO8BzV7Sa2td93q5On4iUy0BIocozKb6VSGbhwKR88x
	 Ia27HNWGMlRKtVxcp2oFAUWuILbF8hDquZj1kRt4RWMWLpZKKmNxCS+wn4F23U8iXo
	 Mew6Mqit71sDA==
Date: Wed, 19 Feb 2025 09:13:22 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 01/14] mm/mm_init: rename init_reserved_page to
 init_deferred_page
Message-ID: <Z7WEktyNoCPylytL@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-2-rppt@kernel.org>
 <20250218145904.x57chhz3whvckzu3@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218145904.x57chhz3whvckzu3@master>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_231347_187172_26547FDC 
X-CRM114-Status: GOOD (  16.98  )
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

Hi,

On Tue, Feb 18, 2025 at 02:59:04PM +0000, Wei Yang wrote:
> On Thu, Feb 06, 2025 at 03:27:41PM +0200, Mike Rapoport wrote:
> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> >When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, init_reserved_page()
> >function performs initialization of a struct page that would have been
> >deferred normally.
> >
> >Rename it to init_deferred_page() to better reflect what the function does.
> 
> Would it be confused with deferred_init_pages()?

Why? It initializes a single page, deferred_init_pages() initializes many.

> And it still calls __init_reserved_page_zone(), even we __SetPageReserved()
> after it. Current logic looks not clear.

There's no __init_reserved_page_zone(). Currently init_reserved_page()
detects the zone of the page and calls __init_single_page(), so essentially
it initializes one struct page.

And we __SetPageReserved() in reserve_bootmem_region() after call to
init_reseved_page() because pages there are indeed reserved.
 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

