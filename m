Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B0BCD3440
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 14:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oQpUzOuM6UHL5MR8Yl9UG08QHq3QgEJ/816hCLFUfBw=; b=VVgJM3Z2VKE8k0x3xENJotbguX
	x7bd3XO4tbdKM081MsJ91thrvZWNbFqCttwX590TQYnPA1HLqHByvKsDD7RdVEav/FavAOnQtUNMA
	6BYjbuwPY9LSFbqf29/VMb59Vgl6W34iB8T2G5KlWdyK/xAAlc0RuP4Lf907UCI4JPk0mJznQ5WIb
	otrUcV6jqjpCwBL3RBGwlx5UlfgOz08dCjiWQmNwv7Til+SkdR0gJGwlsBlntPQ9M2xhDSE9zKy+O
	8/+KRhQI40Xy5JAvAPBbiiBDReDEd02vclWPOjrefZMlAsVxJdqQAxkBHG4MApqYnG/FzmLBfJRzb
	omz/ZDuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKdaT-00000001Ae5-1JjM;
	Wed, 06 May 2026 14:50:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKdaR-00000001AdE-1Tuu;
	Wed, 06 May 2026 14:50:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C95D360139;
	Wed,  6 May 2026 14:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0ADC2BCB0;
	Wed,  6 May 2026 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778079024;
	bh=CZrArw/oj5KuHDK0tXBG7dLbv82g9Q+f39sVJuaaXGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y6TUxV34XzI+ncRRf/mLg+KIaFrcYHGltCpfI6F9PLZtKGMDFzHlEA+6uzHO1W/Ff
	 PuipwjSYswUif3oyWQyRzZ985ozzFxYPVJAr7+dWyHDP2Am/kO0owTKxjP1hGgUlJ8
	 f5IfHPQOEbID0Ndb0UdMoS35ufyK8ucGEdz6QhylU9g+1Bhsc2ThDYKGw5ncod6vRB
	 5Mxxaqvg8h705i+G0A9OldBOWs/rtfAoxjWdFtOKLb21H8M+6dC1GP9zhEyFJoYOjS
	 4rImJsWyBPDPqBkbm22VTED8BEP8k8B/Ttl9xuhcH887xrMHSQ6OuJAZTqRv1rUxjh
	 tmx8iwFEkEJvA==
Date: Wed, 6 May 2026 09:50:22 -0500
From: Rob Herring <robh@kernel.org>
To: Chen Wandun <chenwandun1@gmail.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, akpm@linux-foundation.org,
	bhe@redhat.com, rppt@kernel.org, pasha.tatashin@soleen.com,
	pratyush@kernel.org, ruirui.yang@linux.dev, corbet@lwn.net,
	skhan@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org,
	chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, saravanak@kernel.org,
	chenwandun@lixiang.com, zhaomeijing@lixiang.com, everyzhao@126.com
Subject: Re: [PATCH 07/11] of: reserved_mem: add no-dump crash_mem exclusion
 helpers
Message-ID: <20260506145022.GA2084721-robh@kernel.org>
References: <20260429065831.1510858-1-chenwandun@lixiang.com>
 <20260429065831.1510858-8-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429065831.1510858-8-chenwandun@lixiang.com>
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

On Wed, Apr 29, 2026 at 02:58:27PM +0800, Chen Wandun wrote:
> Provide two kdump-oriented helpers so that arch kexec_file code does
> not have to open-code the no-dump filtering loop:
> 
>  - of_reserved_mem_no_dump_nr_ranges() returns the number of reserved
>    regions flagged with linux,no-dump. Each exclusion may split one
>    existing crash_mem range into two, so callers use this count to
>    pre-size their crash_mem allocation.
> 
>  - of_reserved_mem_exclude_no_dump() walks the reserved_mem[] array
>    and calls crash_exclude_mem_range() for each no-dump region.
> 
> Both helpers are guarded by CONFIG_KEXEC_FILE; empty inline stubs are
> provided for the !KEXEC_FILE case so architecture code can call them
> unconditionally.
> 
> The consumers are added in the following arm64, riscv and loongarch
> patches in this series.
> 
> Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
> Tested-by: Zhao Meijing <zhaomeijing@lixiang.com>
> ---
>  drivers/of/of_reserved_mem.c    | 54 +++++++++++++++++++++++++++++++++
>  include/linux/of_reserved_mem.h | 15 +++++++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 4b80420da2d2..038056a6408a 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -27,6 +27,10 @@
>  
>  #include "of_private.h"
>  
> +#ifdef CONFIG_KEXEC_FILE
> +#include <linux/crash_core.h>
> +#endif

You shouldn't need ifdef around includes.

> +
>  static struct reserved_mem reserved_mem_array[MAX_RESERVED_REGIONS] __initdata;
>  static struct reserved_mem *reserved_mem __refdata = reserved_mem_array;
>  static int total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
> @@ -916,6 +920,56 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
>  }
>  EXPORT_SYMBOL_GPL(of_reserved_mem_lookup);
>  
> +#ifdef CONFIG_KEXEC_FILE

Use 'if (IS_ENABLED())' within the function.

> +/**
> + * of_reserved_mem_no_dump_nr_ranges() - count reserved regions flagged
> + * with the linux,no-dump property.
> + *
> + * Each such region may split an existing crash_mem range into two when
> + * it is excluded, so callers can use this count to pre-size their
> + * crash_mem allocation.
> + */
> +unsigned int of_reserved_mem_no_dump_nr_ranges(void)
> +{
> +	unsigned int i, n = 0;
> +
> +	for (i = 0; i < reserved_mem_count; i++)
> +		if (reserved_mem[i].no_dump)
> +			n++;
> +	return n;
> +}
> +
> +/**
> + * of_reserved_mem_exclude_no_dump() - exclude no-dump reserved regions
> + * from a crash_mem list.
> + * @cmem: crash memory list to modify
> + *
> + * Walks the reserved_mem[] array and calls crash_exclude_mem_range() for
> + * every region with no_dump set. Intended to be called from arch kdump
> + * code when constructing the elfcorehdr.
> + *
> + * Returns 0 on success, or a negative error returned by
> + * crash_exclude_mem_range() on the first failure.
> + */
> +int of_reserved_mem_exclude_no_dump(struct crash_mem *cmem)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < reserved_mem_count; i++) {
> +		struct reserved_mem *r = &reserved_mem[i];
> +
> +		if (!r->no_dump || !r->size)
> +			continue;
> +		ret = crash_exclude_mem_range(cmem, r->base,
> +					      r->base + r->size - 1);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +#endif /* CONFIG_KEXEC_FILE */

