Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A48C47DB3
	for <kexec@archiver.kernel.org>; Wed, 31 Jan 2024 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sGpII+nW6561xDicEMFLMG6O9+FYx8K6yGNQir9tI6g=; b=Z8NIgGr8nyyTid
	2ZTanuTYTwXs50nhFp8JG2Srm7FjPQT4bCSwLrHZmZs6DC3sxPOJgyWpXxyEJPe+nkpejPJvfCtjJ
	DjAofuY1qb2sd5ngy8Q8xB/9G7iE/Xs50rjDeSLOV2rlhMeJGBqj22VfHn1YGctkHnw9QofiOsbbs
	lowblhzofMQ9SeZ/oiLO7xiTY90ecSUTxw/tOFw8sG4lsR2apyD/Wb40iLfLiGeRpoY8lI92JEZvR
	vVmhDJV5wlZLQD8vPiyQH3Hm9cUJghQDQjM9BSIv2O4Vq5oAMsKN6JX62gkV+chO5hkssIB+dOQpz
	MBE3if94EAqwk3v9GL2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVBuU-00000003zw5-1aBf;
	Wed, 31 Jan 2024 14:49:54 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVBuR-00000003zuY-2rsV;
	Wed, 31 Jan 2024 14:49:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 76915CE2138;
	Wed, 31 Jan 2024 14:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC5CC433C7;
	Wed, 31 Jan 2024 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706712581;
	bh=2yHAEIfWo9jtDG3p0AkHhbA/aM0nxnP2vXRtqVa7teY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QW+u4gkxi4Y+A1kx9nhpvAQ1EP8rM+k3jqjMGovujJJB59p7806HWkXfBEj0gLi/3
	 dpE9ybCf48GATqlB1ESTepI2Vpc3Gz5mcuduAC0xO4CA3jImqCFl1onHVBM3vgNgve
	 P7WRiiNDNwbi/bBxQFbHMPjLCcSFpaECoKh3R4IzGBz8kKHS0VLNM+83cFVzXFslcS
	 ElzySdf458R0htk5byWFQGchyYXTxhGF1QstYas278sioSKd3GxQvzlRYyXl412lt1
	 JdArA3NOIlG6ngKW+zO3XK46/bMum/FZUw4ptS5PISyPW2hhEUfe+LEN6JUngCsW63
	 Vc+Yrx6EsRs4Q==
Date: Wed, 31 Jan 2024 08:49:39 -0600
From: Rob Herring <robh@kernel.org>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 08/17] arm64: Add KHO support
Message-ID: <20240131144939.GA1241147-robh@kernel.org>
References: <20240117144704.602-1-graf@amazon.com>
 <20240117144704.602-9-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240117144704.602-9-graf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_064952_083667_A11AB405 
X-CRM114-Status: GOOD (  26.13  )
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

On Wed, Jan 17, 2024 at 02:46:55PM +0000, Alexander Graf wrote:
> We now have all bits in place to support KHO kexecs. This patch adds
> awareness of KHO in the kexec file as well as boot path for arm64 and
> adds the respective kconfig option to the architecture so that it can
> use KHO successfully.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> ---
> 
> v1 -> v2:
> 
>   - test bot warning fix
>   - Change kconfig option to ARCH_SUPPORTS_KEXEC_KHO
>   - s/kho_reserve_mem/kho_reserve_previous_mem/g
>   - s/kho_reserve/kho_reserve_scratch/g
>   - Remove / reduce ifdefs for kho fdt code
> ---
>  arch/arm64/Kconfig        |  3 +++
>  arch/arm64/kernel/setup.c |  2 ++
>  arch/arm64/mm/init.c      |  8 ++++++
>  drivers/of/fdt.c          | 39 ++++++++++++++++++++++++++++
>  drivers/of/kexec.c        | 54 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 106 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 8f6cf1221b6a..44d8923d9db4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1496,6 +1496,9 @@ config ARCH_SUPPORTS_KEXEC_IMAGE_VERIFY_SIG
>  config ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
>  	def_bool y
>  
> +config ARCH_SUPPORTS_KEXEC_KHO
> +	def_bool y
> +
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
>  
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 417a8a86b2db..9aa05b84d202 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -346,6 +346,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  
>  	paging_init();
>  
> +	kho_reserve_previous_mem();
> +
>  	acpi_table_upgrade();
>  
>  	/* Parse the ACPI tables for possible boot-time configuration */
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 74c1db8ce271..1a8fc91509af 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -358,6 +358,8 @@ void __init bootmem_init(void)
>  	 */
>  	arch_reserve_crashkernel();
>  
> +	kho_reserve_scratch();
> +
>  	memblock_dump_all();
>  }
>  
> @@ -386,6 +388,12 @@ void __init mem_init(void)
>  	/* this will put all unused low memory onto the freelists */
>  	memblock_free_all();
>  
> +	/*
> +	 * Now that all KHO pages are marked as reserved, let's flip them back
> +	 * to normal pages with accurate refcount.
> +	 */
> +	kho_populate_refcount();
> +
>  	/*
>  	 * Check boundaries twice: Some fundamental inconsistencies can be
>  	 * detected at build time already.
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index bf502ba8da95..f9b9a36fb722 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1006,6 +1006,42 @@ void __init early_init_dt_check_for_usable_mem_range(void)
>  		memblock_add(rgn[i].base, rgn[i].size);
>  }
>  
> +/**
> + * early_init_dt_check_kho - Decode info required for kexec handover from DT
> + */
> +static void __init early_init_dt_check_kho(void)
> +{
> +	unsigned long node = chosen_node_offset;
> +	u64 kho_start, scratch_start, scratch_size, mem_start, mem_size;
> +	const __be32 *p;
> +	int l;
> +
> +	if (!IS_ENABLED(CONFIG_KEXEC_KHO) || (long)node < 0)
> +		return;
> +
> +	p = of_get_flat_dt_prop(node, "linux,kho-dt", &l);

These need to be documented. chosen node schema lives in dtschema.

> +	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
> +		return;

I would just make all these fixed 64-bit values rather than based on 
address and size cells. That's what we've done on more recent chosen 
properties describing regions.

Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
