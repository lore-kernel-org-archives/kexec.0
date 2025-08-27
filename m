Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A384CA0EFF
	for <kexec@archiver.kernel.org>; Wed, 27 Aug 2025 05:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qlpP7YE/MqKuwxg9uA1aHnZFSu1mBt3hrTsCE0200RU=; b=MHGNRKoe945dsWooA5dStuGn/S
	3P4Rb8nWHMwXbRibdJY2KyD/RlJ9fb2TXDo5IkqhX/MaNWA1/zF41aQ3ZXbAh7xvx7Qscc6Z8S2yu
	HO8/+9pAildDVGOU50pCgucwmgUSxZFqXmSxWEZSQgQrpgiT1OwxE4FzGe31S1XlSPWuasfN5YZ53
	zzBF8UGsGyxcRKQZU2pRr/XUP3HRoOQxpx5XWVdtJOmjMq1wYsYs5xPP2hBkI4/jm77H6upunKhdG
	zbOo2AIXj/Ea9W50tHaftRWEaoRAey2SN45FcxllSyWDC09weD9iIuM348S6dMAVwwI4C4QKzT11h
	XiPBe2bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur904-0000000EAXj-3xDe;
	Wed, 27 Aug 2025 05:47:12 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur903-0000000EAXD-1f1m
	for kexec@lists.infradead.org;
	Wed, 27 Aug 2025 05:47:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 592AC444BB;
	Wed, 27 Aug 2025 05:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DC3C4CEEB;
	Wed, 27 Aug 2025 05:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756273630;
	bh=hoEQy2EMzAl/DWp425B78q++EJxcTbj/XEoxlK1JLgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pU97S1+EbF20aHx2YwKsA40Iv6lKwnnEYv+9jrBZ3Ds2AT7wiueBxdNvavyadX7PG
	 NqOX38GyyIcM+7jag8bTwO+v8zGWSfTmfWy4GOT5+Q0HqUK66pgh/Z3CAkehQRHD7N
	 0ETaa8miJK4GCSLLvZRuiEEkdn4L290ff5ndhE52We0JAUtC25nkt4IfII7MYVg3Db
	 7h8q2pq1N2QJqeoxQSWSmFrXJhWJi/398wMTZ/dtQUwQ5y/jUq/EGhkfGVX2zBfc+v
	 2As3XfN8VV+9K8vxBscut4Nez2H1HBDSZeISIhs/HzLz1Belx0dTrYFTX0XeA5Xtec
	 uABcGPypXjQ8g==
Date: Wed, 27 Aug 2025 08:47:03 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: make sure kho_scratch argument is fully consumed
Message-ID: <aK6b1_UI-xw2rtlZ@kernel.org>
References: <20250826123817.64681-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826123817.64681-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_224711_456652_70D91AEE 
X-CRM114-Status: GOOD (  21.84  )
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

On Tue, Aug 26, 2025 at 02:38:16PM +0200, Pratyush Yadav wrote:
> When specifying fixed sized scratch areas, the parser only parses the
> three scratch sizes and ignores the rest of the argument. This means the
> argument can have any bogus trailing characters.
> 
> For example, "kho_scratch=256M,512M,512Mfoobar" results in successful
> parsing:
> 
>     [    0.000000] KHO: scratch areas: lowmem: 256MiB global: 512MiB pernode: 512MiB
> 
> It is generally a good idea to parse arguments as strictly as possible.
> In addition, if bogus trailing characters are allowed in the kho_scratch
> argument, it is possible that some people might end up using them and
> later extensions to the argument format will cause unexpected breakages.
> 
> Make sure the argument is fully consumed after all three scratch sizes
> are parsed. With this change, the bogus argument
> "kho_scratch=256M,512M,512Mfoobar" results in:
> 
>     [    0.000000] Malformed early option 'kho_scratch'
> 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/kexec_handover.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index ecd1ac210dbd7..a90d55121a7a0 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -446,6 +446,10 @@ static int __init kho_parse_scratch_size(char *p)
>  		p = endp;
>  	}
>  
> +	/* The string should be fully consumed by now. */
> +	if (*p)
> +		return -EINVAL;
> +
>  	scratch_size_lowmem = sizes[0];
>  	scratch_size_global = sizes[1];
>  	scratch_size_pernode = sizes[2];
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

