Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AE9105F786
	for <kexec@archiver.kernel.org>; Fri, 13 Mar 2026 10:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7QHhzA0uL9b71c0Fp7e654SsATZjVgweLR9VuKmaqyg=; b=cOAWnRYr9r6Jatw+dSIMfP6WGJ
	8OjAjO0Gg39KyOUciutMGCaX0hJR1ISSOC2rcHg25XNP0GOH2uQDL9kfxpNz23eH7180miORn9mK6
	s393I1YB83nAt4OgViiCTgzIhwaH1J2bxLgCq21HJ1WAr74f2ScPDuh5jnZHKGQnsA5KR1+1n2HLt
	As290HehD1ioeIO0daA5GtN9bjFvn49G7U7FCXe0kbIqnOFijH4U+fmmfZbxRllZYaGYSVc4C5mWm
	5v/FvL7wRHT0+6lzRIFe2rvgt3c0t6MZ3vch3afPoIZof3EBIWdga3WQeX41JYebiiKi1w7mh4xZH
	otNkH4cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0zLS-0000000HTGT-3NC2;
	Fri, 13 Mar 2026 10:02:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0zLP-0000000HTGE-1bgM
	for kexec@lists.infradead.org;
	Fri, 13 Mar 2026 10:02:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9C42D60130;
	Fri, 13 Mar 2026 10:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E20DC19421;
	Fri, 13 Mar 2026 10:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773396130;
	bh=8xebjfiBVxR3eAmwaXvUzEUUqxYWZT+mF9mD9gGzH+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=i4SxGu4+nLEFTuli1oHszcAtRfooGgHAuAJAdAdEgo9O0Fv5JEdfV7MCZT1J6oxCk
	 fFkBxlaZGVZ6BUK0hF6Z1NKTIoYyacqhmlCbPzZPRKNj18+s8JD70NmV6bW7G+apsR
	 g1N8A9P0nBLP/mU5sO9B9QbakkEj1oK3vBSEYj3Bcw2NLuGkjA7yAH812TMoIm9LAR
	 jpIHI+4NpI1PNiihendZX5e8GuSG/3cRoHOMCGW4GkMK3K/TvmeYK8daT/JHb+CBkC
	 YVo+0qe0lF+9/ulWgP6u6aiSjIDPyh2+aIoncaOgppfas5X0Aq31fyJK2+E/GmCjjY
	 abAFhwln3lmxQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: ranxiaokai627@163.com
Cc: graf@amazon.com,  akpm@linux-foundation.org,  rppt@kernel.org,
  pratyush@kernel.org,  pasha.tatashin@soleen.com,  jasonmiu@google.com,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  ran.xiaokai@zte.com.cn, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] kho: fix child node parsing for debugfs in/sub_fdts
In-Reply-To: <20260309033530.244508-1-ranxiaokai627@163.com> (ranxiaokai's
	message of "Mon, 9 Mar 2026 03:35:30 +0000")
References: <20260309033530.244508-1-ranxiaokai627@163.com>
Date: Fri, 13 Mar 2026 10:02:06 +0000
Message-ID: <2vxzpl58f3oh.fsf@kernel.org>
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

On Mon, Mar 09 2026, ranxiaokai627@163.com wrote:

> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> Commit e0c1731f5d57 ("kho: adopt radix tree for preserved memory tracking")
> changed KHO_FDT_SUB_TREE_PROP_NAME from "fdt" to "preserved-data". However,
> kho debugfs code still hard-coded the "fdt" string when parsing the
> device tree, causing the debugfs node /debugfs/kho/in/sub_fdts/
> fail to parse child nodes correctly.
>
> Fix this by including the header file and using KHO_FDT_SUB_TREE_PROP_NAME
> instead of the hard-coded string.
>
> Fixes: e0c1731f5d57 ("kho: adopt radix tree for preserved memory tracking")
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Breno's patch [0] also fixes this, but I'd rather have this go through
hotfixes and get backported to stable, and Breno's series to build on
top of this.

[0] https://lore.kernel.org/linux-mm/20260309-kho-v8-4-c3abcf4ac750@debian.org/

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

> ---
>  kernel/liveupdate/kexec_handover_debugfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
> index 3f395fbd978f..acf368222682 100644
> --- a/kernel/liveupdate/kexec_handover_debugfs.c
> +++ b/kernel/liveupdate/kexec_handover_debugfs.c
> @@ -13,6 +13,7 @@
>  #include <linux/io.h>
>  #include <linux/libfdt.h>
>  #include <linux/mm.h>
> +#include <linux/kho/abi/kexec_handover.h>
>  #include "kexec_handover_internal.h"
>  
>  static struct dentry *debugfs_root;
> @@ -121,7 +122,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
>  		const char *name = fdt_get_name(fdt, child, NULL);
>  		const u64 *fdt_phys;
>  
> -		fdt_phys = fdt_getprop(fdt, child, "fdt", &len);
> +		fdt_phys = fdt_getprop(fdt, child, KHO_FDT_SUB_TREE_PROP_NAME, &len);
>  		if (!fdt_phys)
>  			continue;
>  		if (len != sizeof(*fdt_phys)) {

-- 
Regards,
Pratyush Yadav

