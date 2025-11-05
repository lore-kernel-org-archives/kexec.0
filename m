Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6A2CCFA0D
	for <kexec@archiver.kernel.org>; Wed,  5 Nov 2025 17:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4oRX6H93K+8sdo8cLCGPw0zH57ZwvITwM9e6I+WIaDs=; b=eSa7qSOR92SZLKwN+AGVeAP0Jj
	QkunzooCjDyy7FCdMybQIlP4W4HkA957uT/3Y8V7z4P79njVtNILlls4hjfruyKTh1NtsXDUXx87k
	7izl2UcjNF4Z+dEXBmh6/R7iJBzZAm4YArz20SbAwtmbtFgDMOq93CUkc+Y3/dYXAI/ycdpaR5BHr
	Qb50XcR2TVh5YgUAnxkJh5T3/f0KrHVa7xvYiei0DF+0C7mJxiJ+O09Yo9ny2w9aIEt+5vw2tTq2C
	sI1lz/OIlHyY7Sl3kIop0SZfXgihZAeZTbMRgGTJtTYcK6w1dfg33DRrnLGsuOzj3KWMJy00ovGFy
	Rxi3a6CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGhRk-0000000EBqf-0JX0;
	Wed, 05 Nov 2025 17:37:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGhRh-0000000EBqD-3dfv
	for kexec@lists.infradead.org;
	Wed, 05 Nov 2025 17:37:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0542440C4A;
	Wed,  5 Nov 2025 17:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C02C4CEF5;
	Wed,  5 Nov 2025 17:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762364238;
	bh=oikeBsTkXESg/zQM0VeX21fpP5BX4NjeQ4ImkTAOD5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FwssDAbz9953tgEm10JYoi4KJCfP6SA6HAnQavrw7zTCAAxZbffzhzNi1qIUHFtYB
	 wktfURi/o17LfLNLdryKQcTkeufo9Aa+Yt+Z1np3CrMVo321ZTgvxxCWVfmLki1ioB
	 ChNFrzDkmWVMpPJbteshSWo352Oe8lIzVbH+Q0ePF02kVWIzYfzquMgYJYdu88LS4k
	 +CXAY85sr37wiOCTIs8Uugg5lhkgSTPGGGIzyqgOSWZoqE1sbFC7xnD6zrTXKn6zxg
	 IHoTiDci/Ni/aU+QDZVvHJ71CB3OFl9+zb8hevZBjPFcpWNvWPXC4agZJQDi2Q9t2P
	 XLtb2qGWIgoQQ==
Date: Wed, 5 Nov 2025 19:37:12 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as a reviewer for KHO
Message-ID: <aQuLSAAy-hfxLVsJ@kernel.org>
References: <20251105102022.18798-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105102022.18798-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_093721_948991_8FE9B373 
X-CRM114-Status: GOOD (  15.23  )
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

On Wed, Nov 05, 2025 at 11:20:19AM +0100, Pratyush Yadav wrote:
> I have been reviewing most patches for KHO already, and it is easier to
> spot them if I am directly in Cc.
> 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8ee7cb5fe838f..3c85bb0e381fc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13789,6 +13789,7 @@ KEXEC HANDOVER (KHO)
>  M:	Alexander Graf <graf@amazon.com>
>  M:	Mike Rapoport <rppt@kernel.org>
>  M:	Pasha Tatashin <pasha.tatashin@soleen.com>
> +R:	Pratyush Yadav <pratyush@kernel.org>
>  L:	kexec@lists.infradead.org
>  L:	linux-mm@kvack.org
>  S:	Maintained
> 
> base-commit: d25eefc46daf21bd1ebbc699f0ffd7fe11d92296
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

