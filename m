Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4E9CD6E4A
	for <kexec@archiver.kernel.org>; Thu,  4 Jun 2026 05:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Os6BChiKMmQET3OKPbwcH6PuboYuxn41oT3xzkui4Vk=; b=tbfGXpSQJzCOzAiL0vlm/m+WS1
	UcbMeRwxEPzTuoUUHvgIn0oVPk9nDMH0NAmHQKCi2hMfci++Xh8pUdnYtwXObf3fmgIw/Rz3GY/Lh
	ZeffmexuGVzqU5RBz1YC1XH888dlf/MBzg/Kfb4N3kDm9CwLQLrG+JwkeTXUMN20JowdfkGXOdeus
	15gyw7v1tmjPdZrZhCIjlowMXrmCSIjf3kdMR5XWncKYyH5hzdC8elUTlXK1mriR7zCHMnCWRShtU
	/Fd7VBth1LzjY7xZyFu1+4um6yhSmJ69W0UYCiAgx1W069JwVfPkWGIz1B6f6+SG84eOM6z3Jqf1m
	rPecBYFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV0df-0000000GAtI-2BP6;
	Thu, 04 Jun 2026 05:29:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV0dc-0000000GAsx-2VsH
	for kexec@lists.infradead.org;
	Thu, 04 Jun 2026 05:29:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DBC114058D;
	Thu,  4 Jun 2026 05:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E49E1F00893;
	Thu,  4 Jun 2026 05:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780550943;
	bh=Os6BChiKMmQET3OKPbwcH6PuboYuxn41oT3xzkui4Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hi4u3/zv/smM5I0QakpRwwmSwlJ9Vjgpw74YmySQaUaiHmTdeQc2DbCL2hY0n3Y/B
	 xc5Ku6Tr45wthcdg007u+mQs9qUa6KWprYb/3VbAE3Kl+hCnI685uvOAtkMx3t6/W3
	 ta7PG3wR62pF9XQRdAfgglEQZunMoXcKw6mp7CDKZBeVCRBai7Hf/iPf45pZ9L9a69
	 QUJQUJ6K8oWCgBFAwBq+uW7N4NFMtB2ZzrKJlb+bFWWWmwZO67jGBKNtwiByrq4cBG
	 leE/m7HrjT5g4Lj8Q/BTtVA4TODa1ENbgJXgHiVe0PIYuLPDSeo14kCFoGpuBQDa6T
	 6ucu5rFt+5BGg==
Date: Thu, 4 Jun 2026 08:28:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [PATCH 0/2] liveupdate: Small FLB fixes
Message-ID: <aiENGcp1UCq5XMme@kernel.org>
References: <20260528174140.1921129-1-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528174140.1921129-1-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_222904_665897_AD5038D3 
X-CRM114-Status: GOOD (  14.60  )
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

On Thu, May 28, 2026 at 05:41:38PM +0000, David Matlack wrote:
> This series has 2 small fixes to how FLBs are managed. First is to
> increase the outgoing FLB refcount during liveupdate_flb_get_outgoing()
> so it cannot be freed while the caller is using it, and to align with
> the semantics of liveupdate_flb_get_incoming(). The second is to prevent
> FLB retrieve() from being called multiple times if the first attempt
> fails.
> 
> Both of these changes are needed for the correctness of the PCI core
> support for Live Update:
> 
>   https://lore.kernel.org/linux-pci/20260522202410.3104264-1-dmatlack@google.com/

We are late in the release cycle and since there no in-tree flb users let's
postpone this after rc1.
 
> David Matlack (2):
>   liveupdate: Reference count outgoing FLB data
>   liveupdate: Remember FLB retrieve() status
> 
>  include/linux/liveupdate.h  | 11 +++++++++--
>  kernel/liveupdate/luo_flb.c | 20 ++++++++++++++------
>  2 files changed, 23 insertions(+), 8 deletions(-)
> 
> 
> base-commit: 5428435567cbe06c19914592fc22ca23c9ca1de5
> -- 
> 2.54.0.823.g6e5bcc1fc9-goog
> 

-- 
Sincerely yours,
Mike.

