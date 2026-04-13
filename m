Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC4DF34C49
	for <kexec@archiver.kernel.org>; Mon, 13 Apr 2026 13:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YH5qQfX70rEHFoofc9LsX2b9k0VOhQQFbPgsvMZwChk=; b=XL8rEvjtmTm7ZD/RCcnxhapA0H
	4fW03x7yezq7HroAbY17+iZ9mQAIH5lSWaknty9yDRI3xxAygYsOzeSEf8XfAftKIYWtnWzY6Q8o6
	115wN72LCGaAWjgscoE43WwDSWk/c6e2kECPHXY1wDlEVJq4eUQVt0eLv634TgXE88kewKq8aokvz
	65KO9X+czBgGVnui1ocRkRVNm6UOpTxbVtdpMVh6JE7AIRtcPC4VUwHJErC2PTpU8A4sKa/Rz3dpm
	PPVJ/GAE4iU2IbkEuNwIzR9NbG6A3i3a/8t6N0lRGzO2Eeh6M/U8Ws/B1HoXdSp1wWGD+uH3Tf6lN
	OrLqdaEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCHiZ-0000000FmcQ-1QSL;
	Mon, 13 Apr 2026 13:52:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCHiX-0000000FmcK-2XXj
	for kexec@lists.infradead.org;
	Mon, 13 Apr 2026 13:52:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 90E6360172;
	Mon, 13 Apr 2026 13:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBA4C2BCAF;
	Mon, 13 Apr 2026 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776088364;
	bh=bFM8U1JUGcAtq+1deURslVyXJrp61glVzYsdgs2qj18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=C7PENIbdL4MpkTgYARHVc5PRILUsKE02jNt5oWRDv8mPElXZvqAiLf723F5uLpd2I
	 8gw3DlLR4V+F09XGvDlcofho8IAyc70tF7s4UdIIUssRCGlzAxLgwafjkbJ0aKIq8z
	 BXxvmY8aZ2i1tIAgeBXSKenif7TJimEybUTMSJ1LdT46Qxe+DW2u1Q5CBlxy+2FCkH
	 jBhsVpz7XPeLpOb6cUEiAmFLTrDctBmnTyAhUmEBvoSssFtq9vgLpnLvKHrMvn7P6z
	 phOJOeebLrH5fk8vV9tmRzkIyvBkM7YIt3ILyY+eOt5nYOBGqNYbIXEDwq/drQPBu0
	 YsG+skO2IO2WQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,  Alexander Graf
 <graf@amazon.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  "Rob Herring" <robh@kernel.org>,  Saravana
 Kannan <saravanak@google.com>,  Changyuan Lyu <changyuanl@google.com>,
  Andrew Morton <akpm@linux-foundation.org>,  <kexec@lists.infradead.org>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <nh-open-source@amazon.com>
Subject: Re: [PATCH v2] kho: skip KHO for crash kernel
In-Reply-To: <20260410011609.1103-1-epetron@amazon.de> (Evangelos
	Petrongonas's message of "Fri, 10 Apr 2026 01:16:05 +0000")
References: <20260410011609.1103-1-epetron@amazon.de>
Date: Mon, 13 Apr 2026 13:52:40 +0000
Message-ID: <2vxztstf7ys7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Evangelos,

On Fri, Apr 10 2026, Evangelos Petrongonas wrote:

> kho_fill_kimage() unconditionally populates the kimage with KHO
> metadata for every kexec image type. When the image is a crash kernel,
> this can be problematic as the crash kernel can run in a small reserved
> region and the KHO scratch areas can sit outside it.
> The crash kernel then faults during kho_memory_init() when it
> tries phys_to_virt() on the KHO FDT address:
>
>   Unable to handle kernel paging request at virtual address xxxxxxxx
>   ...
>     fdt_offset_ptr+...
>     fdt_check_node_offset_+...
>     fdt_first_property_offset+...
>     fdt_get_property_namelen_+...
>     fdt_getprop+...
>     kho_memory_init+...
>     mm_core_init+...
>     start_kernel+...
>
> kho_locate_mem_hole() already skips KHO logic for KEXEC_TYPE_CRASH
> images, but kho_fill_kimage() was missing the same guard. As
> kho_fill_kimage() is the single point that populates image->kho.fdt
> and image->kho.scratch, fixing it here is sufficient for both arm64
> and x86 as the FDT and boot_params path are bailing out when these
> fields are unset.
>
> Fixes: d7255959b69a ("kho: allow kexec load before KHO finalization")
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
>
> v2: Per Mike's review [1], move the guard into kho_fill_kimage() instead
>     of patching the arch-level producers and consumers. This fixes
>     both arm64 and x86 in one place and avoids redundant checks. Tested again.
>
> Note regarding backporting
> The offending commit was deployed with 6.19. The only other supported
> kernel version with 6.18, unless I miss someting uses
> ```
> if (!kho_out.finalized)
> ```
> which in the case of crash kernel it shouldn't be finalised.

While normally you should load the crash kernel early in boot and at
that point KHO should not be finalized, I don't see anything that
prevents crash kernel from being loaded after finalize. In which case,
you can trigger this bug before d7255959b69a ("kho: allow kexec load
before KHO finalization") as well. Also, before f322a97aeb2a ("kho: only
fill kimage if KHO is finalized") (landed in v6.18) kho_fill_kimage()
was also guarded by if (!kho_enable). So you'd hit this bug in all
kernels before that point in the very same way as today.

So should we update Fixes to 3bdecc3c93f9 ("kexec: add KHO support to
kexec file loads") and Cc stable?

>
> [1] https://lore.kernel.org/all/ade2ExpM8ROXV-vy@kernel.org/
>
>  kernel/liveupdate/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index cc68a3692905..1029fe8778f2 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1551,7 +1551,7 @@ int kho_fill_kimage(struct kimage *image)
>  	int err = 0;
>  	struct kexec_buf scratch;
>  
> -	if (!kho_enable)
> +	if (!kho_enable || image->type == KEXEC_TYPE_CRASH)
>  		return 0;
>  
>  	image->kho.fdt = virt_to_phys(kho_out.fdt);

-- 
Regards,
Pratyush Yadav

