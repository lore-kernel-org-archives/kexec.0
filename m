Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B44E9904A
	for <kexec@archiver.kernel.org>; Fri, 10 Apr 2026 08:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=joHTFbhY3Xpp9kkK3lQ0iapaVEXdYngH8K+Bki/pKZE=; b=xYHzl+QPxeuwXJrMpSfefYvxhH
	ip2+bG22jB8IK3amQf+lo/W84X7Y9BE9o8D4IqnqIvaayUVPCDo4NM+Udluj6uL/cnSpkNwbiU2KN
	kGcrLQKzYos/WUwor+66nGurCBpP0NAnr4BG0qYZZK4Yte4Y17k8zmplqoY3UGMtUDNr5UQp2POsC
	yrE/kyJVhG3QFzs56hDzwlxsGZFRlDDHF0hLN/ew3J3M2wmA7rjubLKDt9eitZN7XKuchbyCms0SA
	89jCkAes9ZVr+8SWbzUDa61KEw492+PLuXyDGftgKn3VQCxviZviYdZPbee+bgBcf985XtxPmA/E5
	CIhcrF1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6mV-0000000Bo9m-0qwp;
	Fri, 10 Apr 2026 07:59:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6mT-0000000Bo8C-09bN
	for kexec@lists.infradead.org;
	Fri, 10 Apr 2026 07:59:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A7E2641853;
	Fri, 10 Apr 2026 07:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E4BC19424;
	Fri, 10 Apr 2026 07:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775807996;
	bh=SxrLNnYLw7RM2+RAMFd5Z9aLlerg3Bl5esgirC0unYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bk0e4BNXD6Yt7f4mKRojtk8ruecTagIIEG5ZStNZDXOJpUmflQARjCnJhnRz+paso
	 roEnmnTZ/3YOwcWe24nYpk6kuNpdCBLakaiK6zYS+gzTDqq+QmsSOQ65c1vUMYn2/E
	 tCcBDdNjvnqRhAw2ZL2IpfCQ5+NnBVg9CogjjWTrHur7cL+kyD3ZDma3KswYbArbZI
	 zFuoEqE5eTB6wRIQI5VVRjH5zWbWsl/Yoy2UtK0na15HGAg0ukDR9WwlFRSKyB8Q5H
	 ncK6y9yjMjyAMKOjFOa4svGHzlTF37gjH09YIdRl2GFIuzKWmdirlkLYsXuRmpqj8x
	 lXfm1lzH96/Zg==
Date: Fri, 10 Apr 2026 10:59:49 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Subject: Re: [PATCH v2] kho: skip KHO for crash kernel
Message-ID: <adit9fCs2O6t3vd1@kernel.org>
References: <20260410011609.1103-1-epetron@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410011609.1103-1-epetron@amazon.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_005957_120037_97C9C67A 
X-CRM114-Status: GOOD (  25.49  )
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

On Fri, Apr 10, 2026 at 01:16:05AM +0000, Evangelos Petrongonas wrote:
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

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

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

Yes, this seems about right :) 
The only released kernel that has this issue is v6.19 and it will be EOL in
less than a week.
 
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
> -- 
> 2.47.3
> 
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
> 

-- 
Sincerely yours,
Mike.

