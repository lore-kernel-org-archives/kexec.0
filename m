Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7CED2502F
	for <kexec@archiver.kernel.org>; Sun, 11 Jan 2026 09:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vL7gjUqvfCxhSt1TP11CCNuny296CJlfvFtlxrXBLKg=; b=G8EkZwXI7YpHEs13FiCZ9t4HmB
	7UCSYgn49PRZg3uqWq3irmtIw4jiCLg+yzlfSW435BS8GUuaGL83IHkzOZfkvUxT6BtfRXYak1V9q
	uyvzOQLdGfCiuyRjlTrAwbn2pv8RgZfOdZToYi7lRa007koooFAMSNnCYR7EIYDQHuPYcoXvSDhK4
	DTZAwzVo1p1pik8QNUj4c3VrJztUXP+T05HUTUPgNxpH47YvI7AqWrhEoNmmWA+B/5sPDTMxiArIN
	4KBBpqVi/OX335U5zlGlybHwb1oEZTnJdDJJKVH8KyN7gdniJ7ZEirj50D38NTYerMzFmi3/3/cWY
	HjUOQy/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1verRr-000000043FX-20z3;
	Sun, 11 Jan 2026 09:09:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1verRo-000000043FB-2hZq
	for kexec@lists.infradead.org;
	Sun, 11 Jan 2026 09:09:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F3A5640DC8;
	Sun, 11 Jan 2026 09:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C796C4CEF7;
	Sun, 11 Jan 2026 09:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768122559;
	bh=GKu46ZcISn2tp5RrNUF5UFQMSBQBVWLCndgFjMo1l2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDDXkkr98Nhx5GtCAFY7rD9krnI3oR+m+tM1lenZeIb7ueLcAlFcRX0LJeytZHDfR
	 H8Z84hnHqinsNLD1d9Zi/HdKhLZcSSAzaWl/ZcdmQA3iNp9oSVQi6E/2gVrSXYNW9b
	 xoK8QJkSfYjcuHXwOGIDLGgkzkd9NgjgdhykyYdlWaZrKRScl7ejptOjy6YJI1hhxy
	 OqZGUW+CBYo6y5CHHfWdlH1uI+lYW+Any5/uuHuaDcHeVSNwCzlwbxqJfFjPK1NiJD
	 G80e8pS0xF19hkJFwbgMG8QXobXZJEMLU0sVchmc+EEMGXU7KpFRFPO/B+iT6Phj8A
	 j0cnmXBTNKaBg==
Date: Sun, 11 Jan 2026 11:09:12 +0200
From: Mike Rapoport <rppt@kernel.org>
To: ranxiaokai627@163.com
Cc: graf@amazon.com, pasha.tatashin@soleen.com, pratyush@kernel.org,
	akpm@linux-foundation.org, surenb@google.com,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn
Subject: Re: [PATCH] kho: init alloc tags when restoring pages from reserved
 memory
Message-ID: <aWNouDKhjUzHGXks@kernel.org>
References: <20260109104251.157767-1-ranxiaokai627@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109104251.157767-1-ranxiaokai627@163.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260111_010920_741713_853FA2A2 
X-CRM114-Status: GOOD (  15.06  )
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

On Fri, Jan 09, 2026 at 10:42:51AM +0000, ranxiaokai627@163.com wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> Memblock pages (including reserved memory) should have their allocation
> tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
> released to the page allocator. When kho restores pages through
> kho_restore_page(), missing this call causes mismatched
> allocation/deallocation tracking and warning message:
> alloc_tag was not set.
> 
> Add missing clear_page_tag_ref() annotation in kho_restore_page() to
> fix this.
> 
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

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
>  	adjust_managed_page_count(page, nr_pages);
>  	return page;
>  }
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.

