Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA1BC021BB
	for <kexec@archiver.kernel.org>; Mon, 24 Feb 2025 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U2kxLp8PGsF6no9olkoxvVLRBxQRM1JnR8fdH/vpckg=; b=L6Kcxyoz1Ty3118AK8xcVdh0OG
	I6OaI49jreCUC8Frr8N+dKmBd3Z0UzqnuFe0Vyc+3FMidqZIKNOq3O5Ow+68QRGJrV6A53h5qf4zQ
	r9Q10YZp0TmRsnQBWSxsmFoga8n58jixCkfN/XPPf/yYeXt07I2hcSUqsvMy5SK7NrW9rtaTYxwJe
	hn7u/7gBMx/fNJKrthN6vIxXGct2B6PEUboRl4hwQf86rzUefMey6oWbYcqxB64JyWZKsbxbITTYb
	dsdqmKDOtXddS1033P6KtG9f9/aHeqY9g/Wm0AICBYEx3B7nq0BliNSGLE1kLC7a16jdcAuoQgkJX
	EDIltNGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tma1k-0000000EDTC-3sdV;
	Mon, 24 Feb 2025 15:05:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmZZs-0000000E7Pt-0ZQZ;
	Mon, 24 Feb 2025 14:37:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 71174611B9;
	Mon, 24 Feb 2025 14:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36ADC4CEE6;
	Mon, 24 Feb 2025 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740407819;
	bh=ZPkqFHkfpEEXBvv/JiiAXJD73VY1MQPjnfI68AzNmMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMR9ZyF51+gCTr5O6+tVcp768/JhJHldAdQMuQdHABvUY7CdUug/Ab1wT3ObgQGAC
	 7NzdY7UbKVP+eM8BgNncEZMMwXw3Wso7TJk0q2VyeryHtrjfnrTE2e5UNcbDKvPLhE
	 5rK+17rtGXNWyA/lMLkVwP2uxrzQbGpoqpM86P+xp+fCHrb56wfT+YG6s+mEWHlMq7
	 +kkYVhJASr3nwSzp8WJx6sGZ3GtEKDCIWteAIxOWx0XP2wkAbG4nWMVBfM/fSU2Vi1
	 69Xel5I0sX2/L5q0XRAaPHw5kaC8vo10XnIAcPaeS8jvBssTAmWVUTy3s4cxy0sDjX
	 NCx7zo+hSuMbw==
Date: Mon, 24 Feb 2025 16:36:38 +0200
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
Subject: Re: [PATCH v4 12/14] x86: Add KHO support
Message-ID: <Z7yD9g1AgtUUfKr0@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-13-rppt@kernel.org>
 <20250224071355.xsl2dbupda4dhfzl@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224071355.xsl2dbupda4dhfzl@master>
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

On Mon, Feb 24, 2025 at 07:13:55AM +0000, Wei Yang wrote:
> On Thu, Feb 06, 2025 at 03:27:52PM +0200, Mike Rapoport wrote:
> >From: Alexander Graf <graf@amazon.com>
> [...]
> >diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> >index 82b96ed9890a..0b81cd70b02a 100644
> >--- a/arch/x86/kernel/e820.c
> >+++ b/arch/x86/kernel/e820.c
> >@@ -1329,6 +1329,24 @@ void __init e820__memblock_setup(void)
> > 		memblock_add(entry->addr, entry->size);
> > 	}
> > 
> >+	/*
> >+	 * At this point with KHO we only allocate from scratch memory.
> >+	 * At the same time, we configure memblock to only allow
> >+	 * allocations from memory below ISA_END_ADDRESS which is not
> >+	 * a natural scratch region, because Linux ignores memory below
> >+	 * ISA_END_ADDRESS at runtime. Beside very few (if any) early
> >+	 * allocations, we must allocate real-mode trapoline below
> >+	 * ISA_END_ADDRESS.
> >+	 *
> >+	 * To make sure that we can actually perform allocations during
> >+	 * this phase, let's mark memory below ISA_END_ADDRESS as scratch
> >+	 * so we can allocate from there in a scratch-only world.
> >+	 *
> >+	 * After real mode trampoline is allocated, we clear scratch
> >+	 * marking from the memory below ISA_END_ADDRESS
> >+	 */
> >+	memblock_mark_kho_scratch(0, ISA_END_ADDRESS);
> >+
> 
> At the beginning of e820__memblock_setup() we call memblock_allow_resize(),
> which means during adding memory region it could double the array. And the
> memory used here is from some region just added.

There are large KHO scratch areas that will be used for most allocations.
Marking the memory below ISA_END_ADDRESS as KHO scratch is required to
satisfy allocations that explicitly limit the allocation to ISA_END_ADDRESS,
e.g the real time trampoline.
 
> But with KHO, I am afraid it would fail?
> 
> > 	/* Throw away partial pages: */
> > 	memblock_trim_memory(PAGE_SIZE);
> > 
> 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

