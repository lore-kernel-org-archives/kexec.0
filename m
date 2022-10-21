Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22ACC4321E
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ClZHywcXrEYtIjYyTVIOAgX0MoIOnL6IeKVlEV1tL94=; b=QUlNr2bhy0Q/O9
	5wRAFO/nMGSO8DGIwQc8aq50/A5z5CdlG9c+O55deSILsC4U3V0q70SUqDgXkMJlEMgHbis62bGvq
	wi25NsI00R+lDLl9P01SKeOqJcPRjM+uvEWHFX6NtbypaigBTm5UoPaxXJLinn1noj7SKxVhpxkLq
	LduCx8PIleTmBnTVXq3OhcyJRbAxFK7e+PEabyrflOGx8VrWfcBu6dYqK+88+wO5GZdTuPXCvIiUm
	AZXRUNhH+xKOES8X79mCxiCsKwnQA6Z+pecgdVCkN/eB8gnrZ7/WJyOtKxwMjr37vudFEV9xQR4yP
	7Xh3QySY5+D8IHE2EJqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oltvh-008g9C-QW; Fri, 21 Oct 2022 15:27:25 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oltvc-008g82-62
	for kexec@lists.infradead.org; Fri, 21 Oct 2022 15:27:21 +0000
Received: from madeliefje.horms.nl (2a02-a44a-2918-403-201-8eff-fe22-8fea.fixed6.kpn.net [IPv6:2a02:a44a:2918:403:201:8eff:fe22:8fea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id D69F1201F8;
	Fri, 21 Oct 2022 15:27:10 +0000 (UTC)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
	id 4F3394555; Fri, 21 Oct 2022 17:27:10 +0200 (CEST)
Date: Fri, 21 Oct 2022 17:27:10 +0200
From: Simon Horman <horms@kernel.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: horms@kernel.org, kexec@lists.infradead.org, mick@ics.forth.gr,
	yixun.lan@gmail.com, guoren@kernel.org
Subject: Re: [PATCH V2] RISC-V: Add support for riscv kexec/kdump on
 kexec-tools
Message-ID: <Y1K6TsGGC3KnFlf8@vergenet.net>
References: <20221020031548.47587-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221020031548.47587-1-xianting.tian@linux.alibaba.com>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_082720_408606_BA65CA1D 
X-CRM114-Status: GOOD (  20.52  )
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

On Thu, Oct 20, 2022 at 11:15:48AM +0800, Xianting Tian wrote:
> From: Nick Kossifidis <mick@ics.forth.gr>
> 
> This patch adds support for loading the ELF kernel image. It parses
> the current/provided device tree to determine the system's memory
> layout, and /proc/iomem for the various kernel segments.
> 
> This patch was firstly developed by Nick Kossifidis, and two fixes (
>    1: fail to find free memory area for dtb load when using initrd image,
>       lists.infradead.org/pipermail/linux-riscv/2022-August/018398.html;
>    2: fix memory range size calculation,
>        kexec/arch/riscv/crashdump-riscv.c:line 85
> ) are contributed by Yixun Lan, Xianting Tian.
> 
> Tested on Qemu's rv64 virt machine and SoC of T-Head RISC-V Xuantie 910 CPU.

Hi,

thanks for some patch.

Some minor feedback follows.

Separately, I'll post a patch to add RISC-V builds to the github
workflow. If you could include that in V3 I'd be most grateful.

> 
> Tested-by: Yixun Lan <yixun.lan@gmail.com>
> Co-developed-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> Co-developed-by: Yixun Lan <yixun.lan@gmail.com>
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>

...

> +	ret = mem_regions_alloc_and_add(mem_ranges, start,
> +					end - start, type);

mem_regions_alloc_and_add isn't always available.
f.e. on mips this causes a build failure.

Ref: https://github.com/horms/kexec-tools/actions/runs/3298491143/jobs/5440677595

...

> +int dtb_get_memory_ranges(char *dtb, struct memory_ranges *mem_ranges, struct memory_ranges *extra_ranges)
> +{

...

> +	mem_regions_sort(mem_ranges);

Likewise, mem_regions_sort isn't always available.
f.e. on mips this causes a build failure.

...

> diff --git a/purgatory/arch/riscv/Makefile b/purgatory/arch/riscv/Makefile
> new file mode 100644
> index 0000000..8bded71
> --- /dev/null
> +++ b/purgatory/arch/riscv/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Purgatory riscv
> +#
> +
> +riscv_PURGATORY_SRCS =
> +
> +dist += purgatory/arch/sh/Makefile $(riscv_PURGATORY_SRCS)

s/sh/riscv/

Else the distribution tarball won't include this Makefile

You can exercise this using:
  make distcheck DISTCHECK_CONFIGURE_FLAGS="--host=riscv64-linux-gnu"

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
