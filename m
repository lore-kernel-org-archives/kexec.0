Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8937BEF36FB
	for <kexec@archiver.kernel.org>; Mon,  9 Mar 2026 08:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ztkm0hITzf6ZbNoQAJDZGB4V8cwJn/m51Rb+EUtCung=; b=jCXDKDfI8YBcEQepliy1ITpfI4
	5QbtPXMJUPVc1Tw9wRfJH0dqzVPTfg2wVOwdT6KPuUOmKjuwC+iFmwdRGYsVBy6o5nm5MRXrzEu7E
	pATNp2MxOIYIX7IHsLP00NCwi46Qyk/cK6aJ8Kwy9FItVf6FkJiJanuJct/Oh4UQTgOkTgsR9iHAo
	dZfdoy+fpO8fngbeKQFxBahtWJLDLQ301JoM9ZHoTDxZ3FisBzvumUgySJRI9J4r6SowpqfsKaaQN
	FmVkjpiIvgiEQ/2RORUTr4J3BhM4pHFixWn5G8i6GxP4PHn/AWDjIRmetSzBvbROyB2D3zpVDXfd6
	a3597hHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzVhA-00000006rpb-3zTD;
	Mon, 09 Mar 2026 08:10:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzVhA-00000006rpO-0DmG
	for kexec@lists.infradead.org;
	Mon, 09 Mar 2026 08:10:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7C688600AD;
	Mon,  9 Mar 2026 08:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A51C4CEF7;
	Mon,  9 Mar 2026 08:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773043831;
	bh=fY/+n+RAdnR1c6vjZfs9L8FV0Khh963E8lpMoY0hV2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnM2qHqasT/NaPrciH8kkYw8JAu8qcnplu9+opyxx2YjkC5c2b+JSNINNH+zI/gb3
	 6xU3RsHZ1/Kif26dvpJLN5dkEUwQkn+IcwiYy/n6+fK7spU/LYjgaUm3MyTQhSLGEd
	 86mUCx87RUEvBJDjZqBh+xo6mjmsl7qw89ZWMRfFQahe3XMPjMTEYnSrOWEJTOM4o2
	 s7GIpPPjaBJBhKaSWwErmqMxFzXD7x3nahE7k2tLK9fY88ERj6G+iGzl6VOgF8gUY6
	 Pj2La1JRQJhZGHbDNgfePpTQbByBb/K9XeoAVElxeRl9V6GiDiDblJBwJtr6/u9n9B
	 JTZHv6u284yVQ==
Date: Mon, 9 Mar 2026 10:10:24 +0200
From: Mike Rapoport <rppt@kernel.org>
To: ranxiaokai627@163.com
Cc: graf@amazon.com, akpm@linux-foundation.org, pratyush@kernel.org,
	pasha.tatashin@soleen.com, jasonmiu@google.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	ran.xiaokai@zte.com.cn
Subject: Re: [PATCH] kho: fix child node parsing for debugfs in/sub_fdts
Message-ID: <aa6AcCJJZ-NN0ea_@kernel.org>
References: <20260309033530.244508-1-ranxiaokai627@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309033530.244508-1-ranxiaokai627@163.com>
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

On Mon, Mar 09, 2026 at 03:35:30AM +0000, ranxiaokai627@163.com wrote:
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

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

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
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.

