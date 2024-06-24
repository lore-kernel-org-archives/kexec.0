Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84B7C2BD05
	for <kexec@archiver.kernel.org>; Mon, 24 Jun 2024 11:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G/m5R1mQHBjmOrfg5k0KCy6Js7/niyaHt55uhunHIk4=; b=cQc1mYhG8/p32Y
	3jqpZ4/YEoJeZIuyxZXmlBzAmGC/CWal9Rwtojkfe7c0J+9B1qEgjUpmI+0hufIiaheB8QpjTKKB3
	cIJrLKdhDyqGxKQEdcRuu5JaMoLaHfpLfvGwBvL6pyQ9X/IDXH/gmIDklWQZk3qicC5b1iXxm8RBS
	pVN2V0RIZVLrPyEDjFm7souSKNqUNgu3w5/amirg3SRVSCuNPcMXvckeXsNwURLnw2oGyDzbzwLfU
	O6yGt7yWHh/eTE0Hpm9uspLD273wKjJUKbzLDY83/3Jbdka9h9vXGXJ4IFxkR+wEufIy3NLx5T6RU
	M4vRGWRyGcdtDl6wuOyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLhzm-0000000GdNQ-0mjK;
	Mon, 24 Jun 2024 11:36:26 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLhzi-0000000GdMA-1vbv;
	Mon, 24 Jun 2024 11:36:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1C4CECE1133;
	Mon, 24 Jun 2024 11:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0EDC32781;
	Mon, 24 Jun 2024 11:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719228979;
	bh=MvwZjItdTj3jVNywb/qeja+xBNx+IiB/OSvMaL4tkFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LReg06hzhHSajdDviQTSV7kwqaR48Pa4BIhCtHrcjz+5/cJmn67bWOchxL4cul3XW
	 K85aZ8meaiEsynwHaMu/+gN+sIHUvlFH+fG2bN6v4ROUAHOlUpiMsH2MFKv4L8pOJf
	 Kk8Pimtc33xuzGwfiyqBagi4OJ03Eb7VOL7Oh6FcvjNE5gc8U++Y8Jb/9qyw5T+oD3
	 fbW+6194iGMZfixqZqtb+Hp0oUwur70QJ2jWo7BaoMpJY9D4WSgujrti33c5YGCQFT
	 QPsjl0MIDHq6xsNkhEaH+uvsOj68wJ1YdpwfqxvuTIzi5ISXic7EV3Mc076BNK5q/Y
	 KfUySwm+CORQw==
Date: Mon, 24 Jun 2024 12:36:14 +0100
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Breno Leitao <leitao@debian.org>, Rob Herring <robh@kernel.org>,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, catalin.marinas@arm.com, rmikey@meta.com
Subject: Re: arm64: Kexec: Warning: virt_to_phys used for non-linear address
Message-ID: <20240624113614.GA8361@willie-the-truck>
References: <ZnFKEtqfqJkYflwL@gmail.com>
 <ZnFxI-jCoJcO8WPw@J2N7QTR9R3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZnFxI-jCoJcO8WPw@J2N7QTR9R3>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_043622_873452_D4BDA6C1 
X-CRM114-Status: GOOD (  30.85  )
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

On Tue, Jun 18, 2024 at 12:36:03PM +0100, Mark Rutland wrote:
> On Tue, Jun 18, 2024 at 01:49:22AM -0700, Breno Leitao wrote:
> > I am setting the following warning when loading a kdump kernel in
> > ACPI-based aarch64 box, running upstream and linux-next (stack below
> > against 5f703ce5c981).
> > 
> >   virt_to_phys used for non-linear address: 00000000cf9a4e41 (0xffffffffff5e0000)
> >   WARNING: CPU: 35 PID: 2279 at arch/arm64/mm/physaddr.c:15 __virt_to_phys (arch/arm64/mm/physaddr.c:17)
> >   Modules linked in: sunrpc(E) ipmi_ssif(E) nvidia_cspmu(E) arm_cspmu_module(E) arm_smmuv3_pmu(E) coresight_trbe(E) mlx5_ib(E) ib_uverbs(E) ipmi_devintf(E) ipmi_msghandler(E) coresight_stm(E) coresight_tmc(E) coresight_funnel(E) stm_core(E) coresight_etm4x(E) coresight(E) cppc_cpufreq(E) sch_fq_codel(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) crct10dif_ce(E) sm3_ce(E) sm3(E) sha3_ce(E) sha512_ce(E) sha512_arm64(E) xhci_pci(E) xhci_hcd(E) spi_tegra210_quad(E) nbd(E) acpi_power_meter(E) loop(E) efivarfs(E) autofs4(E)
> >   Hardware name: Quanta Java Island EVT 29F0EMAZ046/Java Island, BIOS F0EJ3A01 06/03/2024
> >   pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> >   pc : __virt_to_phys (arch/arm64/mm/physaddr.c:17)
> >   lr : __virt_to_phys (arch/arm64/mm/physaddr.c:17)
> >   sp : ffff8000be1cf9f0
> >   x29: ffff8000be1cf9f0 x28: dfff800000000000 x27: ffff800083ca9630
> >   x26: ffff800083ca9000 x25: 1ffff000107952c6 x24: ffff0000ff1b6800
> >   x23: 0000000000000000 x22: 0000000000001687 x21: ffff0001ecd46800
> >   x20: ffff000103524000 x19: ffffffffff5e0000 x18: ffffffffffffffff
> >   x17: ffff8000802d07d4 x16: 2930303030653566 x15: 0000000000000001
> >   x14: 1ffff00017c39ed8 x13: 0000000000000000 x12: 0000000000000000
> >   x11: ffff700017c39ed9 x10: 0000000000000002 x9 : e7a4565c7b34a200
> >   x8 : ffff800083c50000 x7 : 0000000000000001 x6 : 0000000000000001
> >   x5 : ffff8000be1cf6a0 x4 : ffff800084a5ff40 x3 : ffff800081580960
> >   x2 : 0000000000000001 x1 : ffff800083253340 x0 : 000000000000004f
> >   Call trace:
> >   __virt_to_phys (arch/arm64/mm/physaddr.c:17)
> >   of_kexec_alloc_and_setup_fdt (drivers/of/kexec.c:305)
> >   load_other_segments (arch/arm64/kernel/machine_kexec_file.c:162)
> >   image_load (arch/arm64/kernel/kexec_image.c:103)
> >   __arm64_sys_kexec_file_load (kernel/kexec_file.c:73 kernel/kexec_file.c:257 kernel/kexec_file.c:296 kernel/kexec_file.c:374 kernel/kexec_file.c:332 kernel/kexec_file.c:332)
> >   invoke_syscall (arch/arm64/kernel/syscall.c:? arch/arm64/kernel/syscall.c:48)
> >   el0_svc_common (./include/linux/thread_info.h:127 arch/arm64/kernel/syscall.c:141)
> >   do_el0_svc (arch/arm64/kernel/syscall.c:153)
> >   el0_svc (arch/arm64/kernel/entry-common.c:165 arch/arm64/kernel/entry-common.c:178 arch/arm64/kernel/entry-common.c:713)
> >   el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:781)
> >   el0t_64_sync (arch/arm64/kernel/entry.S:598)
> >   irq event stamp: 49964
> >   hardirqs last enabled at (49963): console_unlock (kernel/printk/printk.c:? kernel/printk/printk.c:2746 kernel/printk/printk.c:3065)
> >   hardirqs last disabled at (49964): el1_dbg (arch/arm64/kernel/entry-common.c:371 arch/arm64/kernel/entry-common.c:471)
> >   softirqs last enabled at (49942): handle_softirqs (./arch/arm64/include/asm/preempt.h:13 kernel/softirq.c:401 kernel/softirq.c:582)
> >   softirqs last disabled at (49937): __do_softirq (kernel/softirq.c:589)
> >   ---[ end trace 0000000000000000 ]---
> > 
> > 
> > This is happening on the following code:
> > 
> >         /* Remove memory reservation for the current device tree. */
> >         ret = fdt_find_and_del_mem_rsv(fdt, __pa(initial_boot_params),
> >                                        fdt_totalsize(initial_boot_params));
> > 
> > 
> > Where `initial_boot_params` contains a copy of the fdt allocated at init
> > time, and as I've analyzed, it is a virtual address and can be
> > translated by the MMU.
> 
> AFAICT, on arm64 'initial_boot_params' will be a pointer to the FDT in
> the fixmap that we mapped in setup_machine_fdt(). So that's not a linear
> address, and the warning is legitimate -- the use of __pa() here will
> give a bogus result and we could remove a memory reservation for an
> unrelated address.
> 
> It looks like this is a regression due to commit:
> 
>   ac10be5cdbfa8521 ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
> 
> ... as at that point arm64 had a fixmap'd fdt, and prior to that commit
> we didn't try to use __pa() on the fixmap pointer.
> 
> It looks like no-one's tested kexec_file_load() with
> CONFIG_DEBUG_VIRTUAL since then.

There's also this in early_init_fdt_reserve_self():

	memblock_reserve(__pa(initial_boot_params)

but it doesn't look like we call that on arm64. However, the core FDT
code is clearly assuming that the DTB is mapped in the linear map :/

> 
> > Since __pa() is a macro to __virt_to_phys():
> > 
> > 	#define __pa(x)                 __virt_to_phys((unsigned long)(x))
> > 
> > I am curious why this address is special that makes __virt_to_phys()
> > unhappy.
> 
> It's a fixmap address rather than a linear-map address. Confusingly
> 'virt' generally means the linear map rather than any virtual address,
> and usually virt_to_*() only work on linear map addresses.
> 
> I'm not sure how to fix this; the major reason we fixmap the FDT is so
> that it can be anywhere in memory (and e.g. may not be in the linear map
> at all), so we can't always generate a linear map VA.
> 
> We could stash the PA at boot time, and pass this as an argument to
> of_kexec_alloc_and_setup_fdt().

Yeah, if it was passed as an additional argument to early_init_dt_scan(),
then the core could could track it. Alternatively, we'd need a helper
macro to get the PA and have an arm64-variant for the fixmap (everybody
else could use __pa()).

> Rob, any thoughts? I couldn't see a neat way of doing this, but maybe we
> could initialise an initial_boot_params_phys at setup time, with a bit
> of churn to early_init_dt_verify() and friends?

Rob?

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
