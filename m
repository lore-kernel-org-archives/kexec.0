Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EABD3EE66
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 13:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gh4XtAj9AB3rY76cV8CWTGYjLU/b8KyOlaB0cJ3cxrw=; b=cL17/BCnHzhhw64tNX5ukCI9IH
	xBXqzANWMHCc5FdhVopn1Y9vJz0JJstctPaCxDryGNLVderSPaPpfZPi1i3sBHDn1M4vM2rM3s8Nu
	Uzhy5ux0iDysFd4kc8A9GGF4m9ttlwue8hzSVq1wizeMdDD45r14imY6wIiXj0+ihpcRthQ0wLIRS
	rV3YyJhyIXUNG5frceCl1tMxXKlCBcOqMpbXydWCwCX7eApeNdntqyFXVx99qeiVt0fuicEwHyS2C
	djajEtwAn7xVYN9TMFFavgxu11Gyi0UfaYBxdDhLV94mqM/UnqUEQ1IZpSeD89qM0zL3ll89Ryhv+
	0Ni55Isw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viuqh-00000007A4j-0qOT;
	Thu, 22 Jan 2026 13:35:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viuqg-00000007A4a-0H03
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 13:35:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5034B600C4;
	Thu, 22 Jan 2026 13:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CE5C116C6;
	Thu, 22 Jan 2026 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769088945;
	bh=wED3dXV0kHkiBnPWNUBgYlSUdtgP2fArJ/kzjZEMltI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mrM43KnIhyHDnc8ivUCX5HTrM9Pl42GBN8gXbejQ3Jl7OGoZ6s6TYv7Q9f+Ds41mV
	 +atyWBT9K1XOmZr0pF5xVDisRvZ3G+sA0qlf+8xqzuMhEvZp4UEln1+29gf3zF8UIM
	 hDr0aYGQEDqiPxMYnxspQa3y7BzZqMUsjuoGrP0jIAK+PgK0D2VLGCIn2k5S95TWLs
	 uieNDly2PL9lHs2HFOjsXJgRHIrcw5486a5jYlh+T2wfAUhDov1hXXSAUo6cTbh/uZ
	 yD8mWEN/VEDP5hyMTo/uckvNJclqUK7clMtEpzkS9kYenRw3CDQY2ZRB1Qh1ai61Ql
	 pXhD2DGjTqOBQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: ranxiaokai627@163.com
Cc: pratyush@kernel.org,  surenb@google.com,  akpm@linux-foundation.org,
  pasha.tatashin@soleen.com,  kent.overstreet@linux.dev,  rppt@kernel.org,
  graf@amazon.com,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  ran.xiaokai@zte.com.cn,
  stable@vger.kernel.org
Subject: Re: [PATCH RESEND v3] kho: init alloc tags when restoring pages
 from reserved memory
In-Reply-To: <20260122132740.176468-1-ranxiaokai627@163.com> (ranxiaokai's
	message of "Thu, 22 Jan 2026 13:27:40 +0000")
References: <20260122132740.176468-1-ranxiaokai627@163.com>
Date: Thu, 22 Jan 2026 14:35:41 +0100
Message-ID: <2vxzcy31bwia.fsf@kernel.org>
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

On Thu, Jan 22 2026, ranxiaokai627@163.com wrote:

> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> Memblock pages (including reserved memory) should have their allocation
> tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
> released to the page allocator. When kho restores pages through
> kho_restore_page(), missing this call causes mismatched
> allocation/deallocation tracking and below warning message:
>
> alloc_tag was not set
> WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CPU#1: swapper/0/1
> RIP: 0010:___free_pages+0xb8/0x260
>  kho_restore_vmalloc+0x187/0x2e0
>  kho_test_init+0x3c4/0xa30
>  do_one_initcall+0x62/0x2b0
>  kernel_init_freeable+0x25b/0x480
>  kernel_init+0x1a/0x1c0
>  ret_from_fork+0x2d1/0x360
>
> Add missing clear_page_tag_ref() annotation in kho_restore_page() to
> fix this.
>
> Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>
> v2 -> v3: 
>  - also call clear_page_tag_ref() for non-compound order-0 tail pages
>
>  kernel/liveupdate/kexec_handover.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index d4482b6e3cae..96767b106cac 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -255,6 +255,14 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>  	if (is_folio && info.order)
>  		prep_compound_page(page, info.order);
>  
> +	/* Always mark headpage's codetag as empty to avoid accounting mismatch */
> +	clear_page_tag_ref(page);
> +	if (!is_folio) {
> +		/* Also do that for the non-compound tail pages */
> +		for (unsigned int i = 1; i < nr_pages; i++)
> +			clear_page_tag_ref(page + i);
> +	}
> +

I think it would be a little bit better if we just did this in the loop
above instead of looping again. But I think it is fine for now. I can
fix it up in the next release.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

>  	adjust_managed_page_count(page, nr_pages);
>  	return page;
>  }

-- 
Regards,
Pratyush Yadav

