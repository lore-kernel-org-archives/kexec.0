Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E9DE63C9C
	for <kexec@archiver.kernel.org>; Sun, 25 Jan 2026 11:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lsJsCT1Ku+2oSFFgQjz13x5XOWTJSyM0K4XxyQtDjQ0=; b=rBB8DQW0ThcNcgfIdmyzwBNpXs
	MyMqHbqN4OWENySmFAiyUqpzbKlq4KoQ8htYM8KLvl2YA3b6cuJnHaT0U/uFdufZYbKwWl7BsjBWe
	ZSZoxgsCIjAYWRppFH3loiI1zfyIsQTEJD0/IeE8f263staagRZ0X+xmocuFXSAot49CFyMBJV9tU
	A3TovbQOhQ/yVpK6kJH/0tgbPI3USA6slcdY5/NQJlPsBzIkbbcQqvvS197jtJif+DZK/MgvgQ98R
	PwIn7S5yoz+d+DooEP1cU0BA4FWY7DmgiM9Ieph3hyAfAVIKnATgSlpGK1Uat8KDsU+FnA8BlIaF5
	2hDqyrbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjye4-0000000B8mU-01X4;
	Sun, 25 Jan 2026 11:51:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjye1-0000000B8lk-2ZZv
	for kexec@lists.infradead.org;
	Sun, 25 Jan 2026 11:51:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ABCF742BB2;
	Sun, 25 Jan 2026 11:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16513C4CEF1;
	Sun, 25 Jan 2026 11:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769341864;
	bh=6TAiQebVh1oHpaGV4OnDP/LH0lIQ9CGxw6VodtIwayY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q0ZMoQnoT6qLr0kWpr2fmisUihk0K+he89tFOWATBNMW0H+/p5iE0vjMW5LUKLuBY
	 a06+SfVmC8JYdAbJKa60U5rbi8DgEHGil9QfJD88bWZRIEzYyL4ysQxALbEc1Bkp3X
	 m8IvjGt6dOE8edZHeIJI849An14dyi/Hpe9AgYOS/oNKWODUAgtolCSeOMv6mWEaKV
	 Jy49n7cfaHoj7ifPB+YQAbxSfF++0gxnizvxkyQql5453LypHgWfY9n8FAhzuzuNzI
	 Hv+u8Yvicv/m+AxetAHAPRSiUCPP/sSR21D/lkRag1expC6f4l5FXi081y6E/o2e+b
	 EdJx0kPJ25/kQ==
Date: Sun, 25 Jan 2026 13:50:58 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Tycho Andersen <tycho@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: fix doc for kho_restore_pages()
Message-ID: <aXYDov8RruYZszaQ@kernel.org>
References: <20260123190506.1058669-1-tycho@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123190506.1058669-1-tycho@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260125_035105_723669_1714F237 
X-CRM114-Status: GOOD (  16.77  )
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

On Fri, Jan 23, 2026 at 12:05:06PM -0700, Tycho Andersen wrote:
> From: "Tycho Andersen (AMD)" <tycho@kernel.org>
> 
> This function returns NULL if kho_restore_page() returns NULL, which
> happens in a couple of corner cases. It never returns an error code.
> 
> Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/liveupdate/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index d4482b6e3cae..4c38ea7987c8 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -281,7 +281,7 @@ EXPORT_SYMBOL_GPL(kho_restore_folio);
>   * Restore a contiguous list of order 0 pages that was preserved with
>   * kho_preserve_pages().
>   *
> - * Return: 0 on success, error code on failure
> + * Return: the first page on success, NULL on failure.
>   */
>  struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages)
>  {
> 
> base-commit: c072629f05d7bca1148ab17690d7922a31423984
> -- 
> 2.52.0
> 

-- 
Sincerely yours,
Mike.

