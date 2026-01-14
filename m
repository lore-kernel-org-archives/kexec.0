Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FE5D38FEC
	for <kexec@archiver.kernel.org>; Wed, 14 Jan 2026 16:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OR56xfz3n/ClMDrLNpxJLgxI1KhaD39Tup7yEi4XmY8=; b=2SKB1IFOc1QeBYDeuzEIlgzjul
	KAh02ga4xyYGASym7LYdjHH49g4GY7nHOdCNPoDC0I/GiZSTL3m3yiHoQnyLYLO3IOibs42mQ+s0Y
	v4ImMJ6VSizAyp0mmn66dDKtlNNH4Dt7EdRTHeIz2laA+jsFcOqgW0B8HQTLFXYayk+WC8UDgQNE6
	9j9+lyiulSVL0JNtmJaFkUqOJpmnkcCYHa+lC19hhmiTQHIsR4EAylFNnSZwM7I6K95FceidavVSN
	RG4u8rPv1tsU/OjTqeBqsiRA678QUTdwDqVt6SUNJhWGmzizi4JhpjXf9FqShCzLMhAQYv4BWgpjW
	PNJXE3TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg49s-0000000A0se-2RhP;
	Wed, 14 Jan 2026 16:55:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg49i-0000000A0px-2CQy
	for kexec@lists.infradead.org;
	Wed, 14 Jan 2026 16:55:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CB68B41A6C;
	Wed, 14 Jan 2026 16:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D462FC4CEF7;
	Wed, 14 Jan 2026 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768409734;
	bh=QejQhjBMM5h7AWsceCq9AC06bxVTWkjs0XH1r2FG920=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=l9cMh3NYa7Vune+62JflcUh/D6FsoXVcIncMsmx9m1uHAvsMOsJ0VBRtSWsQFkdKm
	 q0T25Zpz+3L4U/qdB52PuM4TlLl+mjHslNNC7rdsTvueMvj7IBx5xeELmQA887Kd5g
	 r/q9ZVcRQ0R+CN78HxplGXk6u4WGm9V78oge/WgY1Hfj5jHls+HGsSNf2zbxjeofIU
	 AObRipt1LcQligXXB7KD5EId1Uxf2f0HlyyrVCqRZ359G5WK9QXr8zkf8f2jsIAdp+
	 R1aioUFFtCTyNUDXeCUHpLv+sVv0QTbmluTuGvLNDU4qyXX2RDmwLe7uHgSjkMxJ4z
	 rn3xvM2v3P6ag==
From: Pratyush Yadav <pratyush@kernel.org>
To: ranxiaokai627@163.com
Cc: graf@amazon.com,  rppt@kernel.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  akpm@linux-foundation.org,  surenb@google.com,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  ran.xiaokai@zte.com.cn
Subject: Re: [PATCH v2] kho: init alloc tags when restoring pages from
 reserved memory
In-Reply-To: <20260113033403.161869-1-ranxiaokai627@163.com> (ranxiaokai's
	message of "Tue, 13 Jan 2026 03:34:03 +0000")
References: <20260113033403.161869-1-ranxiaokai627@163.com>
Date: Wed, 14 Jan 2026 16:55:31 +0000
Message-ID: <2vxztswoi16k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260114_085538_718880_98EAFFCD 
X-CRM114-Status: GOOD (  15.95  )
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

Hi Ran,

On Tue, Jan 13 2026, ranxiaokai627@163.com wrote:

> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> Memblock pages (including reserved memory) should have their allocation
> tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
> released to the page allocator. When kho restores pages through
> kho_restore_page(), missing this call causes mismatched
> allocation/deallocation tracking and below warning message:
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
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index cd6b3fb9dcae..2d47f2c50bd8 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -268,6 +268,7 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>  	else
>  		kho_init_pages(page, nr_pages);
>  
> +	clear_page_tag_ref(page);

You are only clearing the tag for the head page. The tail pages are
still un-initialized. Is that intentional?

What about non-compound pages (the ones you get from
kho_restore_pages(), aka when is_folio is false)? Do we need to clear
the tag on all pages in that case?

>  	adjust_managed_page_count(page, nr_pages);
>  	return page;
>  }

