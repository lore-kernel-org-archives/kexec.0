Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C2CD33998
	for <kexec@archiver.kernel.org>; Mon, 28 Oct 2024 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BQBTEbu4NLoHuTOMvEQqU7SbPJ9aVM4kBse6yXVhL8I=; b=h1IipJhuvGT6pL
	fKPnWjUojFpHRXxrAzcUnMDYD+KJHSZVkIa1Ie0K4r2+g6dw029MJwDAl+ncUnSAQkLlSz/5te/H3
	GTalwbCnQm17vYdcvt23mFmlf4tZnWXFLqk7TqJ/lxXCzK5EeyRc32msA2ffRvPFYiG8P5LrvODD+
	xs2umW45ehp3WJRsc038T+VHIYF75oUVdcnrJerknDMGvQd086JBnOtmltLexfHS/eetKF7Nh2N9/
	7dYs1OrQ3vTmZgSlodUWhpL4rQVP+kgBdotlFB0emlMO+3TyLFx8+oeaNl+xuq5APwMG6u5N+zEGb
	794ocE/BH7ky5z7ECFfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5SFV-0000000BPry-00SS;
	Mon, 28 Oct 2024 16:05:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Rrb-0000000BLVs-2dlW;
	Mon, 28 Oct 2024 15:41:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E3FD25C5B61;
	Mon, 28 Oct 2024 15:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0E1C4CEC3;
	Mon, 28 Oct 2024 15:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730130062;
	bh=1OnKnskO1uPXHT57ko80fWNSrAKlqsEB3xePdsqM5Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+bslp5nYFB5IdzYlqcPXUe0Deg2tPLvvs4TWlciZJnyPqj4C7msUDWod/mZ74Wbi
	 V+npdeWkLAM2YaCU68ORi88AWKUdk+SexkhRmxohs3rLk/42hVRfWw3lmcgEXhKfmW
	 l+9bfe1QEI3TUsTCQUmiCfe1cOZzdBeIsDmI24fTFiyKZwDu9f4TeXEh9Tmi9Z7A4g
	 RQuSC3lG7y94YkqEIK4qkURF8Scn98uwTY1D6XvZn72zlsfH7cHelHDCN5wkvgpceU
	 yWqXIdxX1dAjLGXoC7cRczTCjM1LzpGhlbBh2ntrVJVtMMwopnozbfMsplC2SfLpCE
	 /bnM2cMZeJadg==
Date: Mon, 28 Oct 2024 15:40:55 +0000
From: Will Deacon <will@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: robh@kernel.org, mark.rutland@arm.com, leitao@debian.org,
	catalin.marinas@arm.com, tglx@linutronix.de, chris@zankel.net,
	saravanak@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, loongarch@lists.linux.dev,
	linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-openrisc@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH v2] of/fdt: add dt_phys arg to early_init_dt_scan and
 early_init_dt_verify
Message-ID: <20241028154054.GE2484@willie-the-truck>
References: <20241023171426.452688-1-usamaarif642@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241023171426.452688-1-usamaarif642@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_084103_782861_F97875F6 
X-CRM114-Status: GOOD (  20.04  )
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

On Wed, Oct 23, 2024 at 06:14:26PM +0100, Usama Arif wrote:
>  __pa() is only intended to be used for linear map addresses and using
> it for initial_boot_params which is in fixmap for arm64 will give an
> incorrect value. Hence save the physical address when it is known at
> boot time when calling early_init_dt_scan for arm64 and use it at kexec
> time instead of converting the virtual address using __pa().
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
> ---
> v1 -> 2:
> - pass dt_phys in early_init_dt_scan instead of creating
>   anorther arch->dt function (Rob Herring)
> ---
>  arch/arc/kernel/devtree.c              |  2 +-
>  arch/arm/kernel/devtree.c              |  2 +-
>  arch/arm64/kernel/setup.c              |  6 +++++-
>  arch/csky/kernel/setup.c               |  4 ++--
>  arch/loongarch/kernel/setup.c          |  2 +-
>  arch/microblaze/kernel/prom.c          |  2 +-
>  arch/mips/kernel/prom.c                |  2 +-
>  arch/mips/kernel/relocate.c            |  2 +-
>  arch/nios2/kernel/prom.c               |  4 ++--
>  arch/openrisc/kernel/prom.c            |  2 +-
>  arch/powerpc/kernel/dt_cpu_ftrs.c      |  2 +-
>  arch/powerpc/kernel/prom.c             |  2 +-
>  arch/powerpc/platforms/pseries/plpks.c |  2 +-
>  arch/riscv/kernel/setup.c              |  2 +-
>  arch/sh/kernel/setup.c                 |  2 +-
>  arch/um/kernel/dtb.c                   |  2 +-
>  arch/x86/kernel/devicetree.c           |  2 +-
>  arch/xtensa/kernel/setup.c             |  2 +-
>  drivers/of/fdt.c                       | 14 ++++++++------
>  drivers/of/kexec.c                     |  2 +-
>  include/linux/of_fdt.h                 |  5 +++--
>  21 files changed, 36 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arc/kernel/devtree.c b/arch/arc/kernel/devtree.c
> index 4c9e61457b2f..cc6ac7d128aa 100644
> --- a/arch/arc/kernel/devtree.c
> +++ b/arch/arc/kernel/devtree.c
> @@ -62,7 +62,7 @@ const struct machine_desc * __init setup_machine_fdt(void *dt)
>  	const struct machine_desc *mdesc;
>  	unsigned long dt_root;
>  
> -	if (!early_init_dt_scan(dt))
> +	if (!early_init_dt_scan(dt, __pa(dt)))
>  		return NULL;
>  
>  	mdesc = of_flat_dt_match_machine(NULL, arch_get_next_mach);
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index fdb74e64206a..3b78966e750a 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -200,7 +200,7 @@ const struct machine_desc * __init setup_machine_fdt(void *dt_virt)
>  
>  	mdesc_best = &__mach_desc_GENERIC_DT;
>  
> -	if (!dt_virt || !early_init_dt_verify(dt_virt))
> +	if (!dt_virt || !early_init_dt_verify(dt_virt, __pa(dt_virt)))
>  		return NULL;
>  
>  	mdesc = of_flat_dt_match_machine(mdesc_best, arch_get_next_mach);
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index b22d28ec8028..177262739c49 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -175,7 +175,11 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
>  	if (dt_virt)
>  		memblock_reserve(dt_phys, size);
>  
> -	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
> +	/*
> +	 * dt_virt is a fixmap address, hence __pa(dt_virt) can't be used.
> +	 * Pass dt_phys directly.
> +	 */
> +	if (!dt_virt || !early_init_dt_scan(dt_virt, dt_phys)) {

nit: It looks like early_init_dt_verify() will now return false if
!dt_virt, so we can drop the additional check here.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
