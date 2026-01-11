Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CA7D2502D
	for <kexec@archiver.kernel.org>; Sun, 11 Jan 2026 00:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zqK3HOg0vNq9f3TZyYs6Ctlm/q7dF5v31DWjp/N6no0=; b=rzbfoXRe0WNjA4U8MUhWZM4hgp
	8rmhcpKogk5297x3V5g0QId/HyjuMlxZwSn/WtQx9sEOOh95yvJNCHZ3xft4C/s5NUVdS4PhMcbbi
	HgVqTyhEMfnozIuuGBkz5UI53u+TzOQKwlLBSZ2XB46tJT/cPV+/tH0ziw1eV45m6EfhNCScnqXth
	rkM2KnRfDsfkKsZeizack2QQZYN3erh9MOvmtubzH8mYNyoQxz/tXPzwChd8kgEsxW6o9wlhE2yIm
	bqHWR8xubCApxu7KQovBhsDpzP1U1309AVDbEmjbizNdtmgT6oILJp10j1aXJ0XlrRpgUn8WEB6De
	CyI5pO3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vejK7-00000003nDS-0gVj;
	Sun, 11 Jan 2026 00:28:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vejK3-00000003nDM-0kCR
	for kexec@lists.infradead.org;
	Sun, 11 Jan 2026 00:28:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E402560010;
	Sun, 11 Jan 2026 00:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E054DC4CEF1;
	Sun, 11 Jan 2026 00:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768091324;
	bh=MOScAOAfndrqdtTOZduWfCA2cVTB83JchOtZuxyo5fM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CpjTXcE3G/BfnjwGI+AlE5LJjHCT5gEInJ20H9uD2UP8SpQN+3xUghnmNVsLAyGJ0
	 GwbhCaddbPfDXRJIyQepD15l4iKgpc7/e1+jJJdbDQqhC8n/n4a7YEym3hVFQfm4lJ
	 vDrZYulVe+w1R/BuAaxiGCeCLDJgGOESbBkytWns=
Date: Sat, 10 Jan 2026 16:28:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: ranxiaokai627@163.com
Cc: graf@amazon.com, rppt@kernel.org, pasha.tatashin@soleen.com,
 pratyush@kernel.org, surenb@google.com, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn
Subject: Re: [PATCH] kho: init alloc tags when restoring pages from reserved
 memory
Message-Id: <20260110162843.ecd8e731bdc281f4cd8e4764@linux-foundation.org>
In-Reply-To: <20260109104251.157767-1-ranxiaokai627@163.com>
References: <20260109104251.157767-1-ranxiaokai627@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri,  9 Jan 2026 10:42:51 +0000 ranxiaokai627@163.com wrote:

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

Great, thanks.

It would be helpful to quote that warning message in the patch
changelog, please.

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

Warning splats are pretty bad and it's desirable to fix this in
previous kernel versions.

To do that it's best for us to identify which kernel version(s) should
be patched, via a Fixes: tag in the changelog.

From a quick look, it appears that Pratyush's 12b9a2c05d1b ("kho:
initialize tail pages for higher order folios properly") is a suitable
anchor, what do people think?

Meanwhile I'll queue this up for some testing while awaiting maintainer
feedback.

