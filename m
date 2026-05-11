Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E63CD37B5
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 10:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cAFuh1H5RPPmu8UUWalvHLGgDhvGmMyx0sup2Av9VXA=; b=Yu1QY73qVlMVXcsT9RWudfib0d
	DQVYAbbXME4VnjJt+zFyg4bmNRFcxG9evDJeFP2n/XZ+xiu/2J6YD5gJA8c/uvDf/uz+8HkKNv01a
	aM7qZsyysIGISh6zIxn+Hm1mC9ZVjDvOcmjKAZFu4+K9cY3WenPWfunO4nmCrCUnQ+nIc62FvHeLt
	Fvp1OIec3XclWM8xboOPGDJPala9EuBTaXJ4hZanLBi/UeMIvNrXVMlCRbx7tE1HUWUkHENgzLS+J
	now10FEiGojC6ZdMs9Tjvj6PeW6gEhC6Z7s2XEt9f5fxDyk8QohS2dgDWdyN/vbmMH84biqU1ZXhf
	SQF08fSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMO1j-0000000D7tv-3KPy;
	Mon, 11 May 2026 10:38:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMO1h-0000000D7tX-1FL8
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 10:38:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 09D0840909;
	Mon, 11 May 2026 10:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56287C2BCC9;
	Mon, 11 May 2026 10:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778495896;
	bh=/5HeHYtYR3X7G2/ltDcaDNYVkBv+5CDR/1dSY68hK6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQ6e9yFFbLBK9EIUuso90JtjHXZFN079j+U6DWcxrFgJWQ2PTwpzOgbyWXs4VFH16
	 wjjWxT61MuoHtWqV5F0O/ciED3sZNKoDUhwrP6oQ1oHkSyouJaeyBScU1D9lna8fIL
	 znfciRTpn9Ym+eEckaq67/uz0npM533hUDJe1y07jYx50kE01WnbaYAx2beT93Eco8
	 P4EKPz5MTMBB5Eg6DjsqZxaSTD+4EaQFfICdKWtEh8S2/ZKnEaXKfP2XpITvg/xY0t
	 mCmlO713v1JNcsETpFGkkeUooZ3jb+Endpu1Yd/zYugTuxsxYc+Hs5DjMQRyKY9hiS
	 ADScn2yX/660A==
Date: Mon, 11 May 2026 13:38:08 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: sourabhjain@linux.ibm.com, jbouron@amazon.com,
	akpm@linux-foundation.org, linux-mm@kvack.org, bhe@redhat.com,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	rafael.j.wysocki@intel.com, piliu@redhat.com,
	kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com,
	changyuanl@google.com, mario.limonciello@amd.com
Subject: Re: [PATCH v2 1/3] kho: skip KHO data for context-preserving kexec
Message-ID: <agGxkHPx7W7P5AUS@kernel.org>
References: <20260506182039.2623553-5-pasha.tatashin@soleen.com>
 <20260506182039.2623553-6-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506182039.2623553-6-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_033817_356586_6438BF62 
X-CRM114-Status: GOOD (  17.44  )
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

On Wed, May 06, 2026 at 02:20:41PM -0400, Pasha Tatashin wrote:
> A preserve_context kexec returns to the current kernel, which means the
> 2nd kernel does not use KHO data (and their memory spaces don't
> overlap). Passing KHO data to the 2nd kernel via setup_data or
> devicetree is unnecessary.
> 
> Add a check in kho_fill_kimage() and return early if preserve_context is
> set, to avoid passing KHO state during context-preserving kexecs.
> 
> Fixes: 3bdecc3c93f9 ("kexec: add KHO support to kexec file loads")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 4fde8325c49f..2eec2a169c83 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1702,7 +1702,8 @@ int kho_fill_kimage(struct kimage *image)
>  	int err = 0;
>  	struct kexec_buf scratch;
>  
> -	if (!kho_enable || image->type == KEXEC_TYPE_CRASH)
> +	if (!kho_enable || image->type == KEXEC_TYPE_CRASH ||
> +	    image->preserve_context)
>  		return 0;

Sashiko says it's unnecessary:

https://sashiko.dev/#/patchset/20260506182039.2623553-5-pasha.tatashin@soleen.com

I tend to agree :)
  
>  	image->kho.fdt = virt_to_phys(kho_out.fdt);
> -- 
> 2.54.0.545.g6539524ca2-goog
> 

-- 
Sincerely yours,
Mike.

