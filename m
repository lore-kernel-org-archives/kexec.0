Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7B2C282DE
	for <kexec@archiver.kernel.org>; Mon, 10 Mar 2025 19:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t2kgoLFT4qUSZ2F0yqgtgSevpsGwxq4Ha+KacT6rcOc=; b=WqnVrIphKkSSTNupklBBrkwPJF
	0B+tpR/UAwEqwI3P/t7McCUKh3DdG/bT+Ho8WXsOH47NnH5MCEuOu+7TSMYoguCsU6CziqfsghevY
	ZZXZ1RNq5SoobjV7UbNJxObBRjbs9FeGRt3MUnrI005jEb5Hd3rdrQrHFM7l6VFdwF7ktJAq8OVEY
	++I/BHpbw08mwM85jEZ6uadnoSMIdzHYM974ruzGed04kdcpMxx7RajUvcCYbN7Wrx27CdL4e9Acn
	VEcLkQKX44j/QqGR4I/podNu+vPLOyQwBGnqx3WDGrC4XY4IUkXVkwO2Fhh0U9iwyYk2zOtuwPeTY
	N8D8yv1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trifw-00000003iyw-3pkW;
	Mon, 10 Mar 2025 19:20:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trgc4-00000003S4h-0qCV;
	Mon, 10 Mar 2025 17:08:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4CB5E5C3EFD;
	Mon, 10 Mar 2025 17:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD209C4CEEB;
	Mon, 10 Mar 2025 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741626502;
	bh=BDPwHEQJtDtD2d6bq3wswYDHcfGQePvakq3VHHuiDXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dP64LCSwb0qvMdmxNsq4aBgEkKCWTngBOaUBShh/E456amPJ+27bT3yYrEE5Gbe2Y
	 pF1oiiVL7+YWc6JNBHa7O2WtXGhJjTJsTLGJyLtE+bAmPCfq/3Pc4kAd9bqycwPSz5
	 Adjk1OWKoidmg9OiT3mJIBc1IgB4uMqcUHbsgzJ+KzsaRTD5TKEwDpPg4x9PsZvD/4
	 EZ7Q2cZdK8XAVDyjTOEv9MAuloiaC6ai4D/YMIbH2cPTCon/hLkqajOt3wbw54YP15
	 wU2ay6wa88LQr0FNFLZu5rhY2ee46XOCZ7yoC5WtWWFs0NwciIsHg/fMOPeT7J/JrC
	 2y2dbOxSiNHfA==
Date: Mon, 10 Mar 2025 19:08:01 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <ptyadav@amazon.de>
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
Subject: Re: [PATCH v4 06/14] kexec: Add KHO parsing support
Message-ID: <Z88ccZat5wm_iXx1@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-7-rppt@kernel.org>
 <mafs0zfhs97ta.fsf@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0zfhs97ta.fsf@amazon.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_100824_323623_37F11801 
X-CRM114-Status: GOOD (  32.00  )
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

Hi Pratyush,

On Mon, Mar 10, 2025 at 04:20:01PM +0000, Pratyush Yadav wrote:
> Hi Mike,
> 
> On Thu, Feb 06 2025, Mike Rapoport wrote:
> [...]
> > @@ -444,7 +576,141 @@ static void kho_reserve_scratch(void)
> >  	kho_enable = false;
> >  }
> >  
> > +/*
> > + * Scan the DT for any memory ranges and make sure they are reserved in
> > + * memblock, otherwise they will end up in a weird state on free lists.
> > + */
> > +static void kho_init_reserved_pages(void)
> > +{
> > +	const void *fdt = kho_get_fdt();
> > +	int offset = 0, depth = 0, initial_depth = 0, len;
> > +
> > +	if (!fdt)
> > +		return;
> > +
> > +	/* Go through the mem list and add 1 for each reference */
> > +	for (offset = 0;
> > +	     offset >= 0 && depth >= initial_depth;
> > +	     offset = fdt_next_node(fdt, offset, &depth)) {
> > +		const struct kho_mem *mems;
> > +		u32 i;
> > +
> > +		mems = fdt_getprop(fdt, offset, "mem", &len);
> > +		if (!mems || len & (sizeof(*mems) - 1))
> > +			continue;
> > +
> > +		for (i = 0; i < len; i += sizeof(*mems)) {
> > +			const struct kho_mem *mem = &mems[i];
> 
> i goes from 0 to len in steps of 16, but you use it to dereference an
> array of type struct kho_mem. So you end up only looking at only one of
> every 16 mems and do an out of bounds access. I found this when testing
> the memfd patches and any time the file was more than 1 page, it started
> to crash randomly.

Thanks! Changyuan already pointed that out privately.
But I'm going to adopt the memory reservation scheme Jason proposed so
this code is going to go away anyway :)

> Below patch should fix that:
> 
> ---- 8< ----
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index c26753d613cbc..40d1d8ac68d44 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -685,13 +685,15 @@ static void kho_init_reserved_pages(void)
>              offset >= 0 && depth >= initial_depth;
>              offset = fdt_next_node(fdt, offset, &depth)) {
>                 const struct kho_mem *mems;
> -               u32 i;
> +               u32 i, nr_mems;
>  
>                 mems = fdt_getprop(fdt, offset, "mem", &len);
>                 if (!mems || len & (sizeof(*mems) - 1))
>                         continue;
>  
> -               for (i = 0; i < len; i += sizeof(*mems)) {
> +               nr_mems = len / sizeof(*mems);
> +
> +               for (i = 0; i < nr_mems; i++) {
>                         const struct kho_mem *mem = &mems[i];
>  
>                         memblock_reserve(mem->addr, mem->size);
> ---- >8 ----
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

