Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B2FD58E7A
	for <kexec@archiver.kernel.org>; Mon,  2 Mar 2026 09:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=shmynEMYMkjhZQ3jKGYprxwdYdcxao768C7xhBHyrTo=; b=W4A5VFWFO53/ZT1UR4vERMCXNg
	zca/0sn9LaZ2E9XYdbR4tj2TrpQCWlPSF5DESD2bKqokEn/idcgjGc9Cct69ZSDrTNZFgSKCQ29pb
	zsj4pmjMWXO5a65uL1E5cj3IW4m9cu4ONr5/p58R4syMN51iTtAofnPxiFvV/UZrNuwfes8qDl0fZ
	I//UXIArKE6sFP7HJ+W01WRlimtaI7P1tOAtuJ3xrPjoS9PORbAB2sZbAuBO07up1ufcOcNLMbu9h
	QWt30kitxKoDM9mfsfbX76cp7YKPHiCWi2SyTeWBQEk05a02PXR9pwfsp0GZNSFhAt4X8ij3l/WMa
	AfGPlTng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwzM8-0000000CZwi-3U9x;
	Mon, 02 Mar 2026 09:14:24 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwzM3-0000000CZwG-2y61
	for kexec@lists.infradead.org;
	Mon, 02 Mar 2026 09:14:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772442860; x=1803978860;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=RtwfrFeXBw7geJ5yg80jY4SyPRCqf59bPMWFOwQudjM=;
  b=Jyu1EGAGENKMovYfE4JhWZQj/J7AX9nRejL9eJDeX363Y1E+l4c94mTy
   QqTRqn8M3KH0CQvzoznHIqgzlhFE2fm3n5/smGIjGCJ76HYynHMOJ44Yw
   1hQzwixfoe3DSMFICOgLGEbcHSnybW5BRbHQ84xnYuC8tQVYZi3+GltiB
   B/etLXSAFHuAG+EJJmlu4CFN7h1VJfCEpZdDY7Cd/DlI4VVjzxRH06soF
   GGoJtHlYkKJjoUdGAwcZbCkHMcZflcxwcO+4Y0Hj8kTnTd7lggqBwVUgz
   OMRjBNHdmPDXyhTzF28SbbW9wMR87/7+NLFwDPTesR6n44iog6svfiatg
   A==;
X-CSE-ConnectionGUID: CzIGYbWJT4GBeKWJS/WIOA==
X-CSE-MsgGUID: +4Uh5N+kR+GOZVR60VK3mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="72471493"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="72471493"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:14:19 -0800
X-CSE-ConnectionGUID: V1+4rJOOTUizWJX3sjTvsg==
X-CSE-MsgGUID: UJISbN7eTKW3MJshlhNzPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="217705811"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.238])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:14:14 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Tao Liu <ltao@redhat.com>, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, imre.deak@intel.com
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH] i915: Fix NULL pointer dereference in
 intel_dmc_update_dc6_allowed_count()
In-Reply-To: <20260228130946.50919-2-ltao@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260228130946.50919-2-ltao@redhat.com>
Date: Mon, 02 Mar 2026 11:14:11 +0200
Message-ID: <31690b028081ba72ca9babf2d09417376e10f2f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_011419_764151_48CDB638 
X-CRM114-Status: GOOD (  18.69  )
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

On Sun, 01 Mar 2026, Tao Liu <ltao@redhat.com> wrote:
> There is a NULL pointer dereference issue noticed in i915 when 2nd kernel
> bootup during kdump. This will panic 2nd kernel and lead to no vmcore
> generation. The issue is observed in Meteorlake CPU(cpuid: 0xA06A2):

The previously posted fix is [1].

Imre, please R-b that. It's a NULL pointer dereference in the wild, in
stable kernels. We need to get it fixed instead of bikeshedding on
potential incorrect debugfs results.

BR,
Jani.


[1] https://lore.kernel.org/r/20251202183950.2450315-1-jani.nikula@intel.com


>
>     BUG: kernel NULL pointer dereference, address: 0000000000000000
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 0 P4D 0
>     Oops: Oops: 0000 [#1] SMP NOPTI
>     ...
>     RIP: 0010:intel_dmc_update_dc6_allowed_count+0x16/0xa0 [i915]
>     ...
>
> It is easy to locate the NULL pointer dereference by disassembly:
>
>     00000000001171e0 <intel_dmc_update_dc6_allowed_count>:
>       1171e0:       f3 0f 1e fa             endbr64
>       1171e4:       e8 00 00 00 00          call   1171e9
>       1171e9:       41 55                   push   %r13
>       1171eb:       41 54                   push   %r12
>       1171ed:       55                      push   %rbp
>       1171ee:       53                      push   %rbx
>       1171ef:       4c 8b a7 18 03 00 00    mov    0x318(%rdi),%r12
>       1171f6:       49 8b 2c 24             mov    (%r12),%rbp
>
> To fix this, add a NULL pointer check before dereferencing.
>
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
>
> The issue doesn't happen in 1st kernel, but in 2nd kernel of kdump. I'm not
> an expert to i915 and unsure what lead to the NULL pointer. To help further
> analysis, here is the full stack:
>
> [    8.608520]  <TASK> 
> [    8.610652]  gen9_set_dc_state.part.0+0x25d/0x2f0 [i915] 
> [    8.616096]  icl_display_core_init+0x2d/0x620 [i915] 
> [    8.621266]  intel_power_domains_init_hw+0x1b2/0x500 [i915] 
> [    8.627047]  intel_display_driver_probe_noirq+0x87/0x300 [i915] 
> [    8.633188]  i915_driver_probe+0x207/0x5d0 [i915] 
> [    8.637977]  ? drm_privacy_screen_get+0x198/0x1c0 
> [    8.642832]  local_pci_probe+0x41/0x90 
> [    8.646646]  pci_call_probe+0x58/0x160 
> [    8.650458]  ? pci_assign_irq+0x2f/0x160 
> [    8.654447]  ? pci_match_device+0xf8/0x120 
> [    8.658522]  pci_device_probe+0x95/0x140 
> [    8.662582]  call_driver_probe+0x27/0x110 
> [    8.666570]  really_probe+0xcc/0x2c0 
> [    8.670190]  __driver_probe_device+0x78/0x120 
> [    8.674692]  driver_probe_device+0x1f/0xa0 
> [    8.678857]  __driver_attach+0xfa/0x230 
> [    8.682757]  ? __pfx___driver_attach+0x10/0x10 
> [    8.687185]  bus_for_each_dev+0x8e/0xe0 
> [    8.691159]  bus_add_driver+0x11f/0x200 
> [    8.694970]  driver_register+0x72/0xd0 
> [    8.698853]  i915_init+0x26/0x90 [i915] 
> [    8.702837]  ? __pfx_i915_init+0x10/0x10 [i915] 
> [    8.707433]  do_one_initcall+0x5c/0x320 
> [    8.711409]  do_init_module+0x60/0x240 
> [    8.715132]  init_module_from_file+0xd6/0x130 
> [    8.719634]  idempotent_init_module+0x114/0x310 
> [    8.724241]  __x64_sys_finit_module+0x71/0xe0 
> [    8.728671]  do_syscall_64+0x11b/0x6d0 
> [    8.732483]  ? ksys_read+0x6b/0xe0 
> [    8.735854]  ? arch_exit_to_user_mode_prepare.isra.0+0xa2/0xd0 
> [    8.741768]  ? do_syscall_64+0x153/0x6d0 
> [    8.745828]  ? do_syscall_64+0x153/0x6d0 
> [    8.749814]  ? do_syscall_64+0x153/0x6d0 
> [    8.753800]  ? clear_bhb_loop+0x30/0x80 
> [    8.757700]  entry_SYSCALL_64_after_hwframe+0x76/0x7e 
>
> ---
>  drivers/gpu/drm/i915/display/intel_dmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
> index 1006b060c3f3..fd2756badc0c 100644
> --- a/drivers/gpu/drm/i915/display/intel_dmc.c
> +++ b/drivers/gpu/drm/i915/display/intel_dmc.c
> @@ -1578,7 +1578,7 @@ void intel_dmc_update_dc6_allowed_count(struct intel_display *display,
>  	struct intel_dmc *dmc = display_to_dmc(display);
>  	u32 dc5_cur_count;
>  
> -	if (DISPLAY_VER(dmc->display) < 14)
> +	if (!dmc || DISPLAY_VER(dmc->display) < 14)
>  		return;
>  
>  	dc5_cur_count = intel_de_read(dmc->display, DG1_DMC_DEBUG_DC5_COUNT);

-- 
Jani Nikula, Intel

