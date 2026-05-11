Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3F9CD37AC
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 11:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m7yW+M0YdTiadMZS1FEXwe1l52EjJ6BllUc8Ghq9wfw=; b=e4nSFM4uGFKM3mV6I36xcudNDB
	qXb+h6T0wntyMmV3nHLKDz24/J0WgXFX26ZrjsCLoafeveGvvQ7sVbGQU0Gg46DJiHiFqSE27Mbfz
	97Cfwr5pJm6Z7swxlU8Fv4Q0xreJzkMiYyFr03PjuPc/m3fxwxZwSR9UJvWIMM6gZdDUwz8hZuODu
	thJT1GJPFrFYAwYbJS0kxiaYKbFaHyB9J0qdVTTxsrmWcSKFgc1mTT7W+aOtiUCdPIeiWhjj3DmvI
	2zeGehsAzZSVmJf3tikw4nycEKyr3gHByupDAcs35rtcEKYOyWCUl1hS/yn6UKrXM+cnAr7rGu2r4
	cypQIqoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMP9L-0000000DOX5-1iVe;
	Mon, 11 May 2026 11:50:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMP9K-0000000DOWf-18t6
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 11:50:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7B77C60121;
	Mon, 11 May 2026 11:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F409EC2BCB0;
	Mon, 11 May 2026 11:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500213;
	bh=iB75dfhb4fu+7jIbarv8WN6kU3hlr/3nqfnDZ8XmCUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKrYqt5j1WNBcVraimWDifAMr/mJg+yvi6st6hSJMhpFMGulbasH1JAIHPmg22mLf
	 SfM4wHr9M6VThKarworHqrmfr2eQMvp4dB/1YVDhv8u7ruhqUpNAyVwj5hzRqQax5f
	 oABxKuiaJh5WjUm1V9yO5jWVBnDS9toYqIxQ5VivKVNipRlk1r4lPnteR7dtr6Eoe5
	 DLtaTOmVa6hVjcf66yKc+Kx7InRklF2sRSXKUHTabpwe24oY1X7pju19pdJPfBaF0H
	 P8h7UzZ3q3/S7uovgEFffVewlsQCQP5hSTZrxDRAououlkCxcGEcP5y/1CGbq9H0QX
	 HOODyoL/cQFaQ==
Date: Mon, 11 May 2026 14:50:06 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] kho: add callback for table pages
Message-ID: <agHCbpn5Hn3XsEWH@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-5-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429133928.850721-5-pratyush@kernel.org>
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

On Wed, Apr 29, 2026 at 03:39:06PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> The KHO memory preservation radix tree does not mark the table pages
> themselves as scratch. This is done to avoid a circular dependency where
> preserving a page can lead of allocating other preserved pages. This
> means any walker looking for free ranges of memory outside of scratch
> areas will ignore the table
> 
> Add a table callback that is invoked for each table page. The callback

A sentence why a table callback helps would be nice here :)

> is given the physical address of the table page.
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  include/linux/kho_radix_tree.h     |  3 +++
>  kernel/liveupdate/kexec_handover.c | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
> index 030da6399d28..fe7151d89361 100644
> --- a/include/linux/kho_radix_tree.h
> +++ b/include/linux/kho_radix_tree.h
> @@ -37,12 +37,15 @@ struct kho_radix_tree {
>  /**
>   * struct kho_radix_walk_cb - Callbacks for KHO radix tree walk.
>   * @key:      Called on each present key in the radix tree.
> + * @table:    Called on each table of the radix tree itself. Receives the
> + *            physical address of the page containing the table.
>   *
>   * For each callback, a return value of 0 continues the walk and a non-zero
>   * return value is directly returned to the caller.
>   */
>  struct kho_radix_walk_cb {
>  	int (*key)(unsigned long key);
> +	int (*table)(phys_addr_t phys);

Naming is hard ;-)

>  };
>  

-- 
Sincerely yours,
Mike.

