Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0EBC5DF8C
	for <kexec@archiver.kernel.org>; Sun, 23 Aug 2026 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rB1jsGUuojkYKJwh0qxzHjSNA7rq8zyf57JSD5x6cWw=; b=OYE6oc+1ym4tKeCmDLefJXQ3mG
	gQ2rYbQF4a+4dtS328h5WQW05fV8M6cyeitH06RzxFptS5cVxS2e/CdRZCVioZ5NwYx6bU6tbCTlh
	Vcu51wKcv3+TtWzrtiyP48A+5bXiSxDTJkTIoQeAPUoApyyuVpcIBvSVJL7w3aSh7O/zWpKXZii8N
	GduuSh3t/RII+s8cLQUQlJ6vKJMgKdwWY/M2f4T9g7B2QCKzuZZ9q9UNqTs7eoAyFIn81R28W+E+P
	LJjCfOmLtuI9vlfyC99LKGPTkw4lPHwDKKWgHslJ5oJUpcUVIEZ/kLXMPN1ShM9f7Jh/oQYiw0MTn
	9onph7Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy2nm-0000000F9O2-0JR8;
	Sun, 23 Aug 2026 07:39:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy2ni-0000000F9Nw-1iQE
	for kexec@lists.infradead.org;
	Sun, 23 Aug 2026 07:39:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C05AE411A6;
	Sun, 23 Aug 2026 07:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D153B1F000E9;
	Sun, 23 Aug 2026 07:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787470769;
	bh=rB1jsGUuojkYKJwh0qxzHjSNA7rq8zyf57JSD5x6cWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L6f2iutOGFtzKX/8ZblKNBsANqnd1qU3V5YpH2wDSEsWH5BqFLyO4B8k8BAPvGqPQ
	 iz3MvD3068uGj13pWR7sry2GGrz/XslSwWhNA0xjWe9tZL5ta6M7PPKc9UUafjzeZx
	 MYvufbZV6GWEnzPctWCfg7Rxd3uhn3umK77Z1mWhyMzFCYVr3eY8pDOlOpPWwNX7Do
	 yc37a6mDloeb5J/1GfpBy764i4o255JbtM8Utnd2WQUsb7fK71vCQpc9S+mTC/lL6Z
	 9VkOkWdXLPlfXGp2LRywoFyd14TpU5OvO5fL1/1ndIji5etYlabWI9jqQ1R52+Obtc
	 IUitXeXLRcZ5Q==
Date: Sun, 23 Aug 2026 10:39:23 +0300
From: Mike Rapoport <rppt@kernel.org>
To: LongWei27 <longwei27@huawei.com>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	hewenliang4@huawei.com
Subject: Re: [PATCH] kho: Convert error handling to immediate return pattern
Message-ID: <aoqjq4kLCCSJtdP8@kernel.org>
References: <20260822064127.498411-1-longwei27@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822064127.498411-1-longwei27@huawei.com>
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

Hi,

On Sat, Aug 22, 2026 at 02:41:27PM +0800, LongWei27 wrote:
> From: Long Wei <longwei27@huawei.com>
> 
> Replace the chained error accumulation (err |= func()) with immediate
> per-step error checking and early return in kho_out_fdt_setup().

You didn't explain *why* are you doing it.
 
> Signed-off-by: Long Wei <longwei27@huawei.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 32 +++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)

-- 
Sincerely yours,
Mike.

